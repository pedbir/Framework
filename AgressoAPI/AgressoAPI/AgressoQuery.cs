using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AgressoAPI.TSWS;
using System.Data;
using System.IO;
using System.Text.RegularExpressions;

namespace AgressoAPI
{
    class AgressoQuery
    {
        private static WSCredentials _credentials;
        private static QueryEngineV200606DotNetSoapClient _service;
        private static AgressoQueryParameterList _agressoQueryParameterList;
        private static string _outputFileName;


        public AgressoQuery(AgressoQueryParameterList agressoQueryParameterList, WSCredentials credentials, string outputFileName)
        {
            _credentials = credentials;
            _service = new QueryEngineV200606DotNetSoapClient();
            _agressoQueryParameterList = agressoQueryParameterList;
            _outputFileName = outputFileName;
        }
        public void ExportAgressoQueryToCsv()
        {
            DataSet ds = GetDataSetByAgressoQueryParameterList();

            if (ds.Tables[0].Rows.Count == 0)            
                return;            

            DataTable tblFiltered = ds.Tables[0].AsEnumerable()
                             .Where(r => r.Field<string>("_section") == "D")
                             .CopyToDataTable();

            string data = DataTableToCSV(tblFiltered, ";");
            if (ds.Tables[0].Rows.Count > 0)
            {
                string filename = _outputFileName.Length > 0 ? _outputFileName : _agressoQueryParameterList.TemplatefullDescription;
                string fullFilePath = FullfilePath(RemoveSpecialCharacters(filename), GetPeriodFromParameterList(), RootDirectory, FileVersion);
                writeToFile(data, fullFilePath);
            }
        }

        public void test()
        {
            TemplateList templates = _service.GetTemplateList(null, null, _credentials);

            
        }

        public long GetTemplateId(string fullDescription)
        // Returns one template id, meaning that it assumes that fullDescription
        // corresponds with a complete template description – with no wildcards.
        {
            TemplateList templates = _service.GetTemplateList(null, fullDescription, _credentials);
            if (templates != null && templates.TemplateHeaderList.Length == 1)
                return templates.TemplateHeaderList[0].TemplateId;
            else
                return 0;
        }

        private DataSet GetDataSetByAgressoQueryParameterList()
        {

            long id = GetTemplateId(_agressoQueryParameterList.TemplatefullDescription);

            if (id == 0)
                throw new IndexOutOfRangeException(String.Format("'{0}' Agresso browser template was not found. (Note: name is case sensitive)", _agressoQueryParameterList.TemplatefullDescription));

            SearchCriteria searchProp = _service.GetSearchCriteria(id, true, _credentials);
            foreach (var a in searchProp.SearchCriteriaPropertiesList)
            {
                AgressoQueryParameter retValue;
                if (_agressoQueryParameterList.QueryParameterList.TryGetValue(a.ColumnName, out retValue))
                {
                    a.FromValue = retValue.ParameterFromValue;
                    a.ToValue = retValue.ParameterToValue;
                    a.RestrictionType = retValue.ParameterType;
                }
            }

            InputForTemplateResult input = new InputForTemplateResult();
            TemplateResultOptions options = _service.GetTemplateResultOptions(_credentials);
            options.RemoveHiddenColumns = true;
            input.TemplateResultOptions = options;
            input.TemplateId = id;
            input.SearchCriteriaPropertiesList = searchProp.SearchCriteriaPropertiesList;

            TemplateResultAsDataSet result = _service.GetTemplateResultAsDataSet(input, _credentials);
            DataSet ds = result.TemplateResult;

            return ds;
        }
        public static string DataTableToCSV(DataTable datatable, string seperator)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < datatable.Columns.Count; i++)
            {
                sb.Append(datatable.Columns[i]);
                if (i < datatable.Columns.Count - 1)
                    sb.Append(seperator);
            }
            sb.AppendLine();

            int dataRows = 1;
            foreach (DataRow dr in datatable.Rows)
            {
                for (int i = 0; i < datatable.Columns.Count; i++)
                {
                    double myNum = 0;

                    if (Double.TryParse(dr[i].ToString(), out myNum))
                    {
                        sb.Append(dr[i].ToString().Replace(",", "."));
                    }
                    else
                        sb.Append(RemoveLineBreaks("\"" + dr[i].ToString().Replace("\"","") + "\""));

                    if (i < datatable.Columns.Count - 1)
                        sb.Append(seperator);
                }
                if (datatable.Rows.Count != dataRows)
                    sb.AppendLine();

                dataRows++;
            }
            return sb.ToString();
        }

        public static void writeToFile(string data, string fullFilePath)
        {
            using (StreamWriter writer = new StreamWriter(new FileStream(fullFilePath, FileMode.CreateNew, FileAccess.ReadWrite), Encoding.UTF8))
            {
                writer.WriteLine(data);
                writer.Close();
            }
        }

        private static string RemoveSpecialCharacters(string str)
        {
            return Regex.Replace(str, "[^a-zA-Z0-9_]+", "", RegexOptions.Compiled);
        }

        private static string RemoveLineBreaks(string str, string replacementString = "")
        {
            return Regex.Replace(str, @"\r\n?|\n", replacementString);

        }


        private static string FullfilePath(string objectName, string period, string rootDirectory, string fileVersion)
        {
            if (!Directory.Exists(rootDirectory))
                throw new DirectoryNotFoundException(String.Format("Path '{0}' does not exists.", rootDirectory));

            string fullFileName = Path.Combine(rootDirectory, String.Format("{0}_{1}_{2}_{3}.csv", objectName, fileVersion, period, DateTime.Now.ToString("yyyyMMddHHmmss")));
            return fullFileName;
        }

        private string GetPeriodFromParameterList()
        {
            string period = DateTime.Now.ToString("yyyyMM");
            AgressoQueryParameter periodValue;
            if (_agressoQueryParameterList.QueryParameterList.TryGetValue("period", out periodValue))
            {
                period = periodValue.ParameterFromValue;
            }

            return period;

        }

        public string FileVersion { get; set; } = "01";
        public string RootDirectory { get; set; } = "C:\\temp";


    }


}

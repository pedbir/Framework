using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Text.RegularExpressions;
using System.Globalization;

using System.IO;
using System.Data.OleDb;
using System.Data;

namespace ConvertExcelToCsv
{
    class Program
    {


        static void Main(string[] args)
        {            
            try
            {
                ConvertExcelToCsv(args[0], args[1]);
            }
            catch(Exception e)
            {
                Console.WriteLine(e.Message);
            }
        }


        static void ConvertExcelToCsv(string excelFilePath, string destinationPath)
        {
            if (!File.Exists(excelFilePath)) throw new FileNotFoundException(excelFilePath);            
                        
            // connection string            
            var cnnStr = String.Format("Provider = Microsoft.ACE.OLEDB.12.0; Data Source = {0}; Extended Properties = \"Excel 12.0 Xml;HDR=YES\";", excelFilePath);
            var cnn = new OleDbConnection(cnnStr);

            // get schema, then data
            var dt = new DataTable();
            try
            {
                cnn.Open();
                var schemaTable = cnn.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                //if (schemaTable.Rows.Count < worksheetNumber) throw new ArgumentException("The worksheet number provided cannot be found in the spreadsheet");
                for (int worksheetNumber = 1; worksheetNumber <= schemaTable.Rows.Count; worksheetNumber++)
                {
                    string worksheet = schemaTable.Rows[worksheetNumber - 1]["table_name"].ToString().Replace("'", "");
                    string csvOutputFile = Path.Combine(destinationPath, String.Format("{0}_{1}.csv", Path.GetFileNameWithoutExtension(excelFilePath), worksheet.Replace("$", "")));
                    if (File.Exists(csvOutputFile)) throw new ArgumentException("File exists: " + csvOutputFile);
                    
                    string sql = String.Format("select * from [{0}]", worksheet);
                    var da = new OleDbDataAdapter(sql, cnn);
                    da.Fill(dt);
                    WriteOutCsvData(dt, csvOutputFile);
                }
            }
            catch (Exception e)
            {
                // ???
                throw e;
            }
            finally
            {
                // free resources
                cnn.Close();
            }

        }
        static void WriteOutCsvData(DataTable dt, string csvOutputFile)
        {
            // write out CSV data
            using (var wtr = new StreamWriter(csvOutputFile))
            {
                foreach (DataRow row in dt.Rows)
                {
                    bool firstLine = true;
                    foreach (DataColumn col in dt.Columns)
                    {
                        if (!firstLine) { wtr.Write(","); } else { firstLine = false; }
                        string replaceWith = "<nl>";
                        var data = row[col.ColumnName].ToString().Replace("\"", "\"\"").Replace("\r\n", replaceWith).Replace("\n", replaceWith).Replace("\r", replaceWith);
                        wtr.Write(String.Format("\"{0}\"", data));
                    }
                    wtr.WriteLine();
                }
            }


        }
    }
}

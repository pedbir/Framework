using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AgressoAPI.TSWS;
using System.Data;
using System.Text.RegularExpressions;
using System.IO;

namespace AgressoAPI
{
    class Program
    {
        private WSCredentials _credentials;
        private string _rootDirectory;

        public Program(string rootDirectory)
        {

            _credentials = GetUserCredentials();
            _rootDirectory = rootDirectory;
        }

        static void Main(string[] args)
        {
            try
            {
                /*
                 arg0 = destination file path
                 arg1 = booked period
                 arg2 = lastUpdate
                 */
                Program p = new Program(args[0]);
                DateTime fromDate = DateTime.Now.AddMonths(-int.Parse(args[1])).Date;
                DateTime? lastUpdate = null;

                if (args.Length > 2) lastUpdate = DateTime.Now.AddDays(-int.Parse(args[2])).Date;

                p.RunMeasureApi("svc_huvudbok", fromDate, lastUpdate);
                p.RunDimensionApi("svc_dimensioner", new string[] { "C1", "N11", "N12", "GN", "XX01", "A11", "B0", "A11", "GN" }, new string[] { }, lastUpdate, "svc_dimensioner_costcenter"); // CostCenter                                                    
                p.RunDimensionApi("svc_dimrelationer", new string[] { }, new string[] { "KST", "LEVNR", "SEGDET" }, lastUpdate);
                p.RunDimensionApi("svc_dimensioner", new string[] { "RA11", "RA12", "RA13", "RA14", "RA15", "RA16", "RA17" }, new string[] { }, lastUpdate, "svc_dimensioner_reportstructure"); //ReportStructure
                p.RunDimensionApi("svc_kontoplan_v1", new string[] { }, new string[] { }, lastUpdate);
                p.RunDimensionApi("svc_dimensioner", new string[] { "F0", "N6", "ZZPR", "ZZSE", "A3", "A4", "A5", "ZZSE", "ZZSF" }, new string[] { }, lastUpdate, "svc_dimensioner_miscellaneous"); //Miscellaneous                
                p.RunDimensionApi("svc_rapportstruktur", new string[] { }, new string[] { }, lastUpdate);
                p.RunDimensionApi("svc_dimensioner", new string[] { "RS10", "RS11", "RS12"}, new string[] { }, lastUpdate, "svc_dimensioner_konto"); //ReportStructure
                p.RunDimensionApi("svc_dimrelationer", new string[] { }, new string[] { "KONTO", "RAPSEG1", "RAPSEG2" }, lastUpdate, "svc_dimrelationer_konto");
            }
            catch (Exception e)
            {
                //Write some debug messages
                string message = string.Format("Exception {0}\n\r {1}\n\r", e.Message, e.StackTrace);
                Console.Write(message);
                Environment.Exit(1);
            }

        }

        private void RunMeasureApi(string templateFullDescription, DateTime? fromDate, DateTime? lastUpdate)
        {
            DateTime toDate = DateTime.Now;
            foreach (DateTime i in GetAllMonths(toDate, fromDate ?? toDate))
            {
                AgressoQueryParameterList agressoQueryParameterList = new AgressoQueryParameterList(templateFullDescription);
                if (fromDate.HasValue) agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "period", ParameterType = "=", ParameterFromValue = i.ToString("yyyyMM") });
                if (lastUpdate.HasValue) agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "last_update", ParameterType = ">", ParameterFromValue = (lastUpdate ?? DateTime.MinValue).ToString("MMddyyyy") }); // MMddyyyy               

                AgressoQuery aq = new AgressoQuery(agressoQueryParameterList, _credentials, "");
                aq.RootDirectory = _rootDirectory;
                aq.ExportAgressoQueryToCsv();
            }

        }

        private void RunDimensionApi(string templateFullDescription, string[] attributeIdList, string[] attributeNameList, DateTime? lastUpdate)
        {
            RunDimensionApi(templateFullDescription, attributeIdList, attributeNameList, lastUpdate, "");
        }

        private void RunDimensionApi(string templateFullDescription, string[] attributeIdList, string[] attributeNameList, DateTime? lastUpdate, string outputFileName)
        {
            DateTime toDate = DateTime.Now;
            AgressoQueryParameterList agressoQueryParameterList = new AgressoQueryParameterList(templateFullDescription);
            if (lastUpdate.HasValue) agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "last_update", ParameterType = ">", ParameterFromValue = (lastUpdate ?? DateTime.MinValue).ToString("MMddyyyy") }); // MMddyyyy               
            if (attributeIdList.Length > 0) agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "attribute_id", ParameterType = "()", ParameterFromValue = string.Join(",", attributeIdList) });
            if (attributeNameList.Length > 0) agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "att_name", ParameterType = "()", ParameterFromValue = string.Join(",", attributeNameList) });

            AgressoQuery aq = new AgressoQuery(agressoQueryParameterList, _credentials, outputFileName);
            aq.RootDirectory = _rootDirectory;
            aq.ExportAgressoQueryToCsv();

        }

     





        private WSCredentials GetUserCredentials()
        {
            WSCredentials cred = new WSCredentials();
            cred.Username = "WEBSERVICE";
            cred.Password = "Webservice2018!";
            cred.Client = "BFAB";
            return cred;
        }

        public IEnumerable<DateTime> GetAllMonths(DateTime current, DateTime past)
        {
            var fromDate = new DateTime(past.Year, past.Month, DateTime.DaysInMonth(past.Year, past.Month));
            var toDate = new DateTime(current.Year, current.Month, DateTime.DaysInMonth(current.Year, current.Month));
            while (toDate >= fromDate)
            {

                yield return fromDate;
                fromDate = new DateTime(fromDate.AddMonths(1).Year, fromDate.AddMonths(1).Month, DateTime.DaysInMonth(fromDate.AddMonths(1).Year, fromDate.AddMonths(1).Month));
            }

        }

    }
}

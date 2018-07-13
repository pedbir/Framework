using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AgressoAPI.TSWS;
using System.Data;
using System.Text.RegularExpressions;

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

                string strRegEx = "(\\d{14})";
                
                Regex r = new Regex(strRegEx);
                Match m = r.Match("svc_huvudbok_01_201708_20180713165219.csv");
                DateTime dt = DateTime.ParseExact(m.Value, "yyyyMMddHHmmss", System.Globalization.CultureInfo.InvariantCulture);
                
                //Program p = new Program(args[0]);DateTime fromDate = DateTime.Now.AddMonths(-int.Parse(args[1]));
                //string[] dateFormat = new string[] { "yyyy-MM-dd HH:mm:ss.fff", "yyyy-MM-dd"};
                //DateTime lastUpdate = DateTime.ParseExact(args[2], dateFormat, System.lobalization.CultureInfo.InvariantCulture, System.Globalization.DateTimeStyles.None);                
                //p.RunApi(null, null, "svc_dimensioner");
                //p.RunApi(fromDate, lastUpdate, "svc_huvudbok");

            }
            catch (Exception e)
            {
                //Write some debug messages
                string message = string.Format("Exception {0}\n\r {1}\n\r", e.Message, e.StackTrace);
                Console.Write(message);
                Environment.Exit(1);
            }
            
        }

        private void RunApi(DateTime? fromDate, DateTime? lastUpdate, string templateFullDescription)
        {
            DateTime toDate = DateTime.Now;                        
            foreach (DateTime i in GetAllMonths(toDate, fromDate ?? toDate))
            {
                AgressoQueryParameterList agressoQueryParameterList = new AgressoQueryParameterList(templateFullDescription);

                if(fromDate.HasValue)
                    agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "period", ParameterType = "=", ParameterFromValue = i.ToString("yyyyMM") });
                if(lastUpdate.HasValue)
                    agressoQueryParameterList.AddAgressoQueryParameter(new AgressoQueryParameter { ParameterName = "last_update", ParameterType = ">", ParameterFromValue = (lastUpdate ?? DateTime.MinValue).ToString("MMddyyyy") }); // MMddyyyy               
                
                AgressoQuery aq = new AgressoQuery(agressoQueryParameterList, _credentials);
                aq.RootDirectory = _rootDirectory;
                aq.ExportAgressoQueryToCsv();
            }

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

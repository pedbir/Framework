using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AgressoAPI
{
    class AgressoQueryParameterList
    {

        private Dictionary<string, AgressoQueryParameter> _agressoQueryParameterList;
   
        public AgressoQueryParameterList(string templatefullDescription)
        {
            _agressoQueryParameterList = new Dictionary<string, AgressoQueryParameter>();
            TemplatefullDescription = templatefullDescription;
        }

        public void AddAgressoQueryParameter(AgressoQueryParameter aqp)
        {
            _agressoQueryParameterList.Add(aqp.ParameterName, aqp);
        }

        public string TemplatefullDescription { get; set; }
        public Dictionary<string, AgressoQueryParameter> QueryParameterList { get { return _agressoQueryParameterList; } }

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService
{
	// NOTE: You can use the "Rename" command on the "Refactor" menu to change the class name "RestTutorial" in code, svc and config file together.
	// NOTE: In order to launch WCF Test Client for testing this service, please select RestTutorial.svc or RestTutorial.svc.cs at the Solution Explorer and start debugging.
	public class RestTutorial : IRestTutorial
	{
		private const string ParameterRequired = "Parameter is required";
		public Temperature Celsius2Fahrenheit(Temperature temperature)
		{
			if (temperature == null || string.IsNullOrEmpty(temperature.Units))
			{
				throw new FaultException<ConversionFault>(new ConversionFault(ParameterRequired), new FaultReason(ParameterRequired));
			}

			var result = new Temperature();
			result.Value = temperature.Value * 9 / 5 + 32;
			result.Units = "F";
			return result;
		}

		public Temperature Fahrenheit2Celsius(Temperature temperature)
		{
			if (temperature == null)
			{
				throw new FaultException<ConversionFault>(new ConversionFault(ParameterRequired), new FaultReason(ParameterRequired));
			}

			var result = new Temperature();
			result.Value = (temperature.Value - 32) * 5 / 9;
			result.Units = "C";
			return result;
		}
	}
}

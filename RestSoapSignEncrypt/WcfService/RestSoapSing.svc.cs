using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService
{
	public class RestSoapSing : IRestSoapSing
	{
		private const string ParameterRequired = "Parameter is required";
		public Temperature1 Celsius2Fahrenheit(Temperature1 temperature)
		{
			if (temperature == null || string.IsNullOrEmpty(temperature.Units))
			{
				throw new FaultException<ConversionFault1>(new ConversionFault1(ParameterRequired), new FaultReason(ParameterRequired));
			}

			var result = new Temperature1();
			result.Value = temperature.Value * 9 / 5 + 32;
			result.Units = "F";
			return result;
		}

		public Temperature1 Fahrenheit2Celsius(Temperature1 temperature)
		{
			if (temperature == null)
			{
				throw new FaultException<ConversionFault1>(new ConversionFault1(ParameterRequired), new FaultReason(ParameterRequired));
			}

			var result = new Temperature1();
			result.Value = (temperature.Value - 32) * 5 / 9;
			result.Units = "C";
			return result;
		}

	}
}

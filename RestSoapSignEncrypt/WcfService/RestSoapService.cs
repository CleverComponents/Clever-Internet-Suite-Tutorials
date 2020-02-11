using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;
using System.ServiceModel;

namespace WcfService
{
	public class RestSoapService
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

	[DataContract]
	public class ConversionFault
	{
		public ConversionFault(string description)
		{
			Description = description;
		}

		public string Description { get; set; }
	}

	[DataContract]
	public class Temperature
	{
		[DataMember]
		public double Value { get; set; }

		[DataMember]
		public string Units { get; set; }
	}
}
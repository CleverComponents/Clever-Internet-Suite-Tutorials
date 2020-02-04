using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService
{
	[ServiceContract(ProtectionLevel = System.Net.Security.ProtectionLevel.Sign)]
	public interface IRestSoapSing
	{
		[OperationContract]
		[FaultContract(typeof(ConversionFault1), Name = "ConversionFault1")]
		Temperature1 Celsius2Fahrenheit(Temperature1 temperature);

		[OperationContract]
		Temperature1 Fahrenheit2Celsius(Temperature1 temperature);
	}

	[DataContract]
	public class ConversionFault1
	{
		public ConversionFault1(string description)
		{
			Description = description;
		}

		public string Description { get; set; }
	}

	[DataContract]
	public class Temperature1
	{
		[DataMember]
		public double Value { get; set; }

		[DataMember]
		public string Units { get; set; }
	}

}

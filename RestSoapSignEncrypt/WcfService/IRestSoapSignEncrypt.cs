using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService
{
	[ServiceContract(ProtectionLevel = System.Net.Security.ProtectionLevel.EncryptAndSign)]
	public interface IRestSoapSignEncrypt
	{
		[OperationContract]
		[FaultContract(typeof(ConversionFault), Name = "ConversionFault")]
		Temperature Celsius2Fahrenheit(Temperature temperature);

		[OperationContract]
		[FaultContract(typeof(ConversionFault), Name = "ConversionFault")]
		Temperature Fahrenheit2Celsius(Temperature temperature);
	}
}

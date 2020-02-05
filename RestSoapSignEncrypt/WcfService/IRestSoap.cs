using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Web;
using System.Text;

namespace WcfService
{
	[ServiceContract]
	public interface IRestSoap
	{
		[OperationContract]
		[FaultContract(typeof(ConversionFault), Name = "ConversionFault")]
		Temperature Celsius2Fahrenheit(Temperature temperature);

		[OperationContract]
		Temperature Fahrenheit2Celsius(Temperature temperature);
	}
}

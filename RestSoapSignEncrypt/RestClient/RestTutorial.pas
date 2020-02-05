// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc?wsdl
//  >Import : https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc?wsdl>0
//  >Import : https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc?xsd=xsd0
//  >Import : https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc?xsd=xsd2
//  >Import : https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc?xsd=xsd1
// Encoding : utf-8
// Version  : 1.0
// (14.01.2020 13:10:26 - - $Rev: 96726 $)
// ************************************************************************ //

unit RestTutorial;

interface

uses Soap.InvokeRegistry, Soap.SOAPHTTPClient, System.Types, Soap.XSBuiltIns;

const
  IS_OPTN = $0001;
  IS_NLBL = $0004;
  IS_REF  = $0080;


type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  Temperature2         = class;                 { "http://schemas.datacontract.org/2004/07/WcfService"[GblCplx] }
  ConversionFault3     = class;                 { "http://schemas.datacontract.org/2004/07/WcfService"[GblCplx] }
  ConversionFault      = class;                 { "http://tempuri.org/"[Flt][GblElm] }
  ConversionFault2     = class;                 { "http://schemas.datacontract.org/2004/07/WcfService"[GblElm] }
  Temperature          = class;                 { "http://schemas.datacontract.org/2004/07/WcfService"[GblElm] }



  // ************************************************************************ //
  // XML       : Temperature, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/WcfService
  // ************************************************************************ //
  Temperature2 = class(TRemotable)
  private
    FUnits: string;
    FUnits_Specified: boolean;
    FValue: Double;
    FValue_Specified: boolean;
    procedure SetUnits(Index: Integer; const Astring: string);
    function  Units_Specified(Index: Integer): boolean;
    procedure SetValue(Index: Integer; const ADouble: Double);
    function  Value_Specified(Index: Integer): boolean;
  published
    property Units: string  Index (IS_OPTN or IS_NLBL) read FUnits write SetUnits stored Units_Specified;
    property Value: Double  Index (IS_OPTN) read FValue write SetValue stored Value_Specified;
  end;



  // ************************************************************************ //
  // XML       : ConversionFault, global, <complexType>
  // Namespace : http://schemas.datacontract.org/2004/07/WcfService
  // ************************************************************************ //
  ConversionFault3 = class(TRemotable)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConversionFault, global, <element>
  // Namespace : http://tempuri.org/
  // Info      : Fault
  // Base Types: ConversionFault
  // ************************************************************************ //
  ConversionFault = class(ERemotableException)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : ConversionFault, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/WcfService
  // ************************************************************************ //
  ConversionFault2 = class(ConversionFault3)
  private
  published
  end;



  // ************************************************************************ //
  // XML       : Temperature, global, <element>
  // Namespace : http://schemas.datacontract.org/2004/07/WcfService
  // ************************************************************************ //
  Temperature = class(Temperature2)
  private
  published
  end;


  // ************************************************************************ //
  // Namespace : http://tempuri.org/
  // soapAction: http://tempuri.org/IRestTutorial/%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // use       : literal
  // binding   : BasicHttpBinding_IRestTutorial
  // service   : RestTutorial
  // port      : BasicHttpBinding_IRestTutorial
  // URL       : http://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc
  // ************************************************************************ //
  IRestTutorial = interface(IInvokable)
  ['{7D769CD6-A788-52A9-C80D-62C6E31C9CB9}']
    function  Celsius2Fahrenheit(const temperature: Temperature2): Temperature2; stdcall;
    function  Fahrenheit2Celsius(const temperature: Temperature2): Temperature2; stdcall;
  end;

function GetIRestTutorial(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IRestTutorial;


implementation
  uses System.SysUtils;

function GetIRestTutorial(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IRestTutorial;
const
  defWSDL = 'https://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc?wsdl';
  defURL  = 'http://clevercomponents.com/tutorials/wcfservice/RestTutorial.svc';
  defSvc  = 'RestTutorial';
  defPrt  = 'BasicHttpBinding_IRestTutorial';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IRestTutorial);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


procedure Temperature2.SetUnits(Index: Integer; const Astring: string);
begin
  FUnits := Astring;
  FUnits_Specified := True;
end;

function Temperature2.Units_Specified(Index: Integer): boolean;
begin
  Result := FUnits_Specified;
end;

procedure Temperature2.SetValue(Index: Integer; const ADouble: Double);
begin
  FValue := ADouble;
  FValue_Specified := True;
end;

function Temperature2.Value_Specified(Index: Integer): boolean;
begin
  Result := FValue_Specified;
end;

initialization
  { IRestTutorial }
  InvRegistry.RegisterInterface(TypeInfo(IRestTutorial), 'http://tempuri.org/', 'utf-8');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IRestTutorial), 'http://tempuri.org/IRestTutorial/%operationName%');
  InvRegistry.RegisterInvokeOptions(TypeInfo(IRestTutorial), ioDocument);
  { IRestTutorial.Celsius2Fahrenheit }
  InvRegistry.RegisterMethodInfo(TypeInfo(IRestTutorial), 'Celsius2Fahrenheit', '',
                                 '[ReturnName="Celsius2FahrenheitResult"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(IRestTutorial), 'Celsius2Fahrenheit', 'temperature', '',
                                '[Namespace="http://schemas.datacontract.org/2004/07/WcfService"]', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(IRestTutorial), 'Celsius2Fahrenheit', 'Celsius2FahrenheitResult', '',
                                '[Namespace="http://schemas.datacontract.org/2004/07/WcfService"]', IS_NLBL);
  { IRestTutorial.Fahrenheit2Celsius }
  InvRegistry.RegisterMethodInfo(TypeInfo(IRestTutorial), 'Fahrenheit2Celsius', '',
                                 '[ReturnName="Fahrenheit2CelsiusResult"]', IS_OPTN or IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(IRestTutorial), 'Fahrenheit2Celsius', 'temperature', '',
                                '[Namespace="http://schemas.datacontract.org/2004/07/WcfService"]', IS_NLBL);
  InvRegistry.RegisterParamInfo(TypeInfo(IRestTutorial), 'Fahrenheit2Celsius', 'Fahrenheit2CelsiusResult', '',
                                '[Namespace="http://schemas.datacontract.org/2004/07/WcfService"]', IS_NLBL);
  RemClassRegistry.RegisterXSClass(Temperature2, 'http://schemas.datacontract.org/2004/07/WcfService', 'Temperature2', 'Temperature');
  RemClassRegistry.RegisterXSClass(ConversionFault3, 'http://schemas.datacontract.org/2004/07/WcfService', 'ConversionFault3', 'ConversionFault');
  RemClassRegistry.RegisterXSClass(ConversionFault, 'http://tempuri.org/', 'ConversionFault');
  RemClassRegistry.RegisterXSClass(ConversionFault2, 'http://schemas.datacontract.org/2004/07/WcfService', 'ConversionFault2', 'ConversionFault');
  RemClassRegistry.RegisterXSClass(Temperature, 'http://schemas.datacontract.org/2004/07/WcfService', 'Temperature');

end.
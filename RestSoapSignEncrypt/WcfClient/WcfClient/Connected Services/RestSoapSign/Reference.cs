﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.42000
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace WcfClient.RestSoapSign {
    using System.Runtime.Serialization;
    using System;
    
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="Temperature", Namespace="http://schemas.datacontract.org/2004/07/WcfService")]
    [System.SerializableAttribute()]
    public partial class Temperature : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private string UnitsField;
        
        [System.Runtime.Serialization.OptionalFieldAttribute()]
        private double ValueField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public string Units {
            get {
                return this.UnitsField;
            }
            set {
                if ((object.ReferenceEquals(this.UnitsField, value) != true)) {
                    this.UnitsField = value;
                    this.RaisePropertyChanged("Units");
                }
            }
        }
        
        [System.Runtime.Serialization.DataMemberAttribute()]
        public double Value {
            get {
                return this.ValueField;
            }
            set {
                if ((this.ValueField.Equals(value) != true)) {
                    this.ValueField = value;
                    this.RaisePropertyChanged("Value");
                }
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Runtime.Serialization", "4.0.0.0")]
    [System.Runtime.Serialization.DataContractAttribute(Name="ConversionFault", Namespace="http://schemas.datacontract.org/2004/07/WcfService")]
    [System.SerializableAttribute()]
    public partial class ConversionFault : object, System.Runtime.Serialization.IExtensibleDataObject, System.ComponentModel.INotifyPropertyChanged {
        
        [System.NonSerializedAttribute()]
        private System.Runtime.Serialization.ExtensionDataObject extensionDataField;
        
        [global::System.ComponentModel.BrowsableAttribute(false)]
        public System.Runtime.Serialization.ExtensionDataObject ExtensionData {
            get {
                return this.extensionDataField;
            }
            set {
                this.extensionDataField = value;
            }
        }
        
        public event System.ComponentModel.PropertyChangedEventHandler PropertyChanged;
        
        protected void RaisePropertyChanged(string propertyName) {
            System.ComponentModel.PropertyChangedEventHandler propertyChanged = this.PropertyChanged;
            if ((propertyChanged != null)) {
                propertyChanged(this, new System.ComponentModel.PropertyChangedEventArgs(propertyName));
            }
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="RestSoapSign.IRestSoapSign")]
    public interface IRestSoapSign {
        
        [System.ServiceModel.OperationContractAttribute(ProtectionLevel=System.Net.Security.ProtectionLevel.Sign, Action="http://tempuri.org/IRestSoapSign/Celsius2Fahrenheit", ReplyAction="http://tempuri.org/IRestSoapSign/Celsius2FahrenheitResponse")]
        [System.ServiceModel.FaultContractAttribute(typeof(WcfClient.RestSoapSign.ConversionFault), Action="http://tempuri.org/IRestSoapSign/Celsius2FahrenheitConversionFault", ProtectionLevel=System.Net.Security.ProtectionLevel.Sign, Name="ConversionFault")]
        WcfClient.RestSoapSign.Temperature Celsius2Fahrenheit(WcfClient.RestSoapSign.Temperature temperature);
        
        [System.ServiceModel.OperationContractAttribute(ProtectionLevel=System.Net.Security.ProtectionLevel.Sign, Action="http://tempuri.org/IRestSoapSign/Celsius2Fahrenheit", ReplyAction="http://tempuri.org/IRestSoapSign/Celsius2FahrenheitResponse")]
        System.Threading.Tasks.Task<WcfClient.RestSoapSign.Temperature> Celsius2FahrenheitAsync(WcfClient.RestSoapSign.Temperature temperature);
        
        [System.ServiceModel.OperationContractAttribute(ProtectionLevel=System.Net.Security.ProtectionLevel.Sign, Action="http://tempuri.org/IRestSoapSign/Fahrenheit2Celsius", ReplyAction="http://tempuri.org/IRestSoapSign/Fahrenheit2CelsiusResponse")]
        [System.ServiceModel.FaultContractAttribute(typeof(WcfClient.RestSoapSign.ConversionFault), Action="http://tempuri.org/IRestSoapSign/Fahrenheit2CelsiusConversionFault", ProtectionLevel=System.Net.Security.ProtectionLevel.Sign, Name="ConversionFault")]
        WcfClient.RestSoapSign.Temperature Fahrenheit2Celsius(WcfClient.RestSoapSign.Temperature temperature);
        
        [System.ServiceModel.OperationContractAttribute(ProtectionLevel=System.Net.Security.ProtectionLevel.Sign, Action="http://tempuri.org/IRestSoapSign/Fahrenheit2Celsius", ReplyAction="http://tempuri.org/IRestSoapSign/Fahrenheit2CelsiusResponse")]
        System.Threading.Tasks.Task<WcfClient.RestSoapSign.Temperature> Fahrenheit2CelsiusAsync(WcfClient.RestSoapSign.Temperature temperature);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IRestSoapSignChannel : WcfClient.RestSoapSign.IRestSoapSign, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class RestSoapSignClient : System.ServiceModel.ClientBase<WcfClient.RestSoapSign.IRestSoapSign>, WcfClient.RestSoapSign.IRestSoapSign {
        
        public RestSoapSignClient() {
        }
        
        public RestSoapSignClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public RestSoapSignClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public RestSoapSignClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public RestSoapSignClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public WcfClient.RestSoapSign.Temperature Celsius2Fahrenheit(WcfClient.RestSoapSign.Temperature temperature) {
            return base.Channel.Celsius2Fahrenheit(temperature);
        }
        
        public System.Threading.Tasks.Task<WcfClient.RestSoapSign.Temperature> Celsius2FahrenheitAsync(WcfClient.RestSoapSign.Temperature temperature) {
            return base.Channel.Celsius2FahrenheitAsync(temperature);
        }
        
        public WcfClient.RestSoapSign.Temperature Fahrenheit2Celsius(WcfClient.RestSoapSign.Temperature temperature) {
            return base.Channel.Fahrenheit2Celsius(temperature);
        }
        
        public System.Threading.Tasks.Task<WcfClient.RestSoapSign.Temperature> Fahrenheit2CelsiusAsync(WcfClient.RestSoapSign.Temperature temperature) {
            return base.Channel.Fahrenheit2CelsiusAsync(temperature);
        }
    }
}

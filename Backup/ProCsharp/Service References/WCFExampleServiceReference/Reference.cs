﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.269
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace ProCsharp.WCFExampleServiceReference {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="WCFExampleServiceReference.IMathOperationsService")]
    public interface IMathOperationsService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IMathOperationsService/AddNumbers", ReplyAction="http://tempuri.org/IMathOperationsService/AddNumbersResponse")]
        int AddNumbers(int first, int second);
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IMathOperationsService/SubNumbers", ReplyAction="http://tempuri.org/IMathOperationsService/SubNumbersResponse")]
        int SubNumbers(int first, int second);
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IMathOperationsServiceChannel : ProCsharp.WCFExampleServiceReference.IMathOperationsService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class MathOperationsServiceClient : System.ServiceModel.ClientBase<ProCsharp.WCFExampleServiceReference.IMathOperationsService>, ProCsharp.WCFExampleServiceReference.IMathOperationsService {
        
        public MathOperationsServiceClient() {
        }
        
        public MathOperationsServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public MathOperationsServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public MathOperationsServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public MathOperationsServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public int AddNumbers(int first, int second) {
            return base.Channel.AddNumbers(first, second);
        }
        
        public int SubNumbers(int first, int second) {
            return base.Channel.SubNumbers(first, second);
        }
    }
}
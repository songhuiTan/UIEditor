//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {
    import flash.events.*;
    import flash.net.*;
    import tInspector.itamt.utils.*;
    import flash.utils.*;
    import flash.display.*;

    public class mConsole extends Shape {

        public static const VERSION:String = "mConsole 1.0 beta";

        private static var _instance:mConsole;

        private var _conn:LocalConnection;
        private var _inited:Boolean;
        private var _delegates:Array;
        private var _clientConnected:Boolean;
        private var _id:String;

        public function mConsole(se:SingletonEnforcer){
            super();
            if (se == null){
                throw (new Error("Singleton!!"));
            };
            this._id = new Date().getTime().toString();
        }
        public static function init(connectMonitor:Boolean=true):void{
            if (_instance == null){
                _instance = new mConsole(new SingletonEnforcer());
            };
            _instance.init(connectMonitor);
        }
        public static function connectMonitor():void{
            if (_instance){
                _instance.connectMonitor();
            };
        }
        public static function disconnectMonitor():void{
            if (_instance){
                _instance.disconnectMonitor();
            };
        }
        public static function callMonitorProxyFun(fun:String, ... _args):void{
            if (_instance){
                _instance.callMonitorProxyFun(fun, _args);
            };
        }
        public static function addDelegate(delegate:mIConsoleDelegate):void{
            _instance.addDelegate(delegate);
        }
        public static function trace(... _args):void{
            _instance.dispatchEvent(new mConsoleLogEvent(new mConsoleLog(_args.toString(), mConsoleLogType.TRACE)));
        }
        public static function error(... _args):void{
            _instance.dispatchEvent(new mConsoleLogEvent(new mConsoleLog(_args.toString(), mConsoleLogType.ERROR)));
        }

        public function get id():String{
            return (this._id);
        }
        private function onLogEvent(evt:mConsoleLogEvent):void{
            this._conn.send(mConsoleConnName.CLIENT, "addLogMessage", evt.log.msg, evt.log.type, this.id);
        }
        private function onSecurityError(evt:SecurityErrorEvent):void{
            dispatchEvent(new mConsoleLogEvent(new mConsoleLog(evt.text, mConsoleLogType.ERROR)));
        }
        private function onAsyncError(evt:AsyncErrorEvent):void{
            dispatchEvent(new mConsoleLogEvent(new mConsoleLog(evt.text, mConsoleLogType.ERROR)));
        }
        private function onStatus(event:StatusEvent):void{
            switch (event.level){
                case "status":
                    break;
                case "error":
                    break;
                case "warning":
                    break;
            };
        }
        public function init(connect2Monitor:Boolean=true):void{
            if (this._inited){
                return;
            };
            this._inited = true;
            if (connect2Monitor){
                this.connectMonitor();
            };
            this.addEventListener(mConsoleLogEvent.LOG, this.onLogEvent);
            var defaultDelegate:mDefaultConsoleCmdDelegate = new mDefaultConsoleCmdDelegate();
            defaultDelegate.setConsole(this);
            this.addDelegate(defaultDelegate);
        }
        public function connectMonitor():void{
            if (this._clientConnected){
                return;
            };
            this._clientConnected = true;
            this._conn = new LocalConnection();
            this._conn.allowInsecureDomain("*");
            this._conn.allowDomain("*");
            this._conn.client = this;
            this._conn.connect(mConsoleConnName.getConsoleConnName(this.id));
            Debug.trace(("[mConsole][connectMonitor]" + mConsoleConnName.getConsoleConnName(this.id)));
            try {
            } catch(e:Error) {
                return;
            };
            this._conn.addEventListener(StatusEvent.STATUS, this.onStatus);
            this._conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
            this._conn.send(mConsoleConnName.CLIENT, "buildConnection", this.id);
        }
        public function disconnectMonitor():void{
            if (!(this._clientConnected)){
                return;
            };
            Debug.trace(("[mConsole][disconnectMonitor]" + mConsoleConnName.getConsoleConnName(this.id)));
            this._conn.send(mConsoleConnName.CLIENT, "deconstructConnection", this.id);
        }
        public function callMonitorProxyFun(fun:String, ... _args):void{
            if (!(this._clientConnected)){
                return;
            };
            Debug.trace("[mConsole][callMonitorProxyFun]");
            this._conn.send(mConsoleConnName.CLIENT, "callProxyFun", fun, _args);
        }
        public function onBuildConnection():void{
            var delegate:mIConsoleDelegate;
            var xml:XML;
            var method:XML;
            Debug.trace(("[mConsole][onBuildConnection]" + mConsoleConnName.getConsoleConnName(this.id)));
            this._clientConnected = true;
            dispatchEvent(new mConsoleLogEvent(new mConsoleLog(VERSION, mConsoleLogType.CONSOLE)));
            for each (delegate in this._delegates) {
                xml = describeType(delegate);
                for each (method in xml.method) {
                    this._conn.send(mConsoleConnName.CLIENT, "addToCmdDictionary", String(method.@name), this.id);
                };
            };
        }
        public function onDeconstructConnection():void{
            this._clientConnected = false;
            dispatchEvent(new mConsoleLogEvent(new mConsoleLog(("deconstructConnection: " + this.id), mConsoleLogType.CONSOLE)));
            Debug.trace(("[mConsole][onDeconstructConnection]" + mConsoleConnName.getConsoleConnName(this.id)));
            this._conn.close();
            this._conn.removeEventListener(StatusEvent.STATUS, this.onStatus);
            this._conn.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._conn.removeEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
        }
        public function addDelegate(delegate:mIConsoleDelegate):void{
            var xml:XML;
            var method:XML;
            if (this._delegates == null){
                this._delegates = [];
            };
            if (this._delegates.indexOf(delegate) < 0){
                this._delegates.push(delegate);
                if (this._clientConnected){
                    xml = describeType(delegate);
                    for each (method in xml.method) {
                        this._conn.send(mConsoleConnName.CLIENT, "addToCmdDictionary", String(method.@name), this.id);
                    };
                };
            };
        }
        public function executeCmdLine(cmdLineStr:String):Boolean{
            var delegate:* = null;
            var cmdLineStr:* = cmdLineStr;
            var params:* = cmdLineStr.split(" ");
            var funName:* = params.shift();
            for each (delegate in this._delegates) {
                if (!(delegate["hasOwnProperty"](funName))){
                } else {
                    try {
                        (delegate[funName] as Function).apply(this, params);
                    } catch(e:Error) {
                        dispatchEvent(new mConsoleLogEvent(new mConsoleLog(e.message, mConsoleLogType.ERROR)));
                        return (false);
                    };
                    return (true);
                };
            };
            dispatchEvent(new mConsoleLogEvent(new mConsoleLog((("不存在" + funName) + "的方法"), mConsoleLogType.ERROR)));
            return (false);
        }
        public function getAllMethodsName():Array{
            var delegate:mIConsoleDelegate;
            var xml:XML;
            var method:XML;
            if (this._delegates == null){
                return (null);
            };
            var arr:Array = [];
            for each (delegate in this._delegates) {
                xml = describeType(delegate);
                for each (method in xml.method) {
                    arr.push(String(method.@name));
                };
            };
            return (arr);
        }
        public function destroy():void{
            if (!(this._inited)){
                return;
            };
            this._inited = false;
            this._conn.close();
            this._conn = null;
        }

    }
}//package msc.console 

class SingletonEnforcer {

    public function SingletonEnforcer(){
    }
}

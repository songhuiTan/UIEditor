//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import flash.events.*;
    import flash.utils.*;

    public class ErrorLog {

        protected var _type:String;
        protected var _date:Date;
        protected var _time:int;
        protected var _error;

        public function ErrorLog(evtError):void{
            this._type = ErrorLogType.UNKNOWN;
            super();
            if (evtError){
                if ((evtError is Error)){
                    this._type = ErrorLogType.ERROR;
                } else {
                    if ((evtError is ErrorEvent)){
                        this._type = ErrorLogType.ERROR_EVENT;
                    } else {
                        this._type = ErrorLogType.UNKNOWN;
                    };
                };
            } else {
                this._type = ErrorLogType.UNKNOWN;
            };
            this._date = new Date();
            this._time = getTimer();
            this._error = evtError;
        }
        public function get type():String{
            return (this._type);
        }
        public function get date():Date{
            return (this._date);
        }
        public function get time():int{
            return (this._time);
        }
        public function get error(){
            return (this._error);
        }
        public function get message():String{
            if (this._type == ErrorLogType.ERROR){
                return ((this._error as Error).message);
            };
            if (this._type == ErrorLogType.ERROR_EVENT){
                return ((this._error as ErrorEvent).text);
            };
            return (String(this._error));
        }
        public function get name():String{
            if (this._type == ErrorLogType.ERROR){
                return ((this._error as Error).name);
            };
            if (this._type == ErrorLogType.ERROR_EVENT){
                return ((this._error as ErrorEvent).type);
            };
            return (ErrorLogType.UNKNOWN);
        }
        public function toString():String{
            var err:Error;
            var evt:ErrorEvent;
            var t:String = ((((("[" + this._date.toLocaleTimeString()) + "]") + "[") + (this._time / 100)) + "]");
            if (this._type == ErrorLogType.ERROR){
                err = (this._error as Error);
                t = (t + err.toString());
            } else {
                if (this._type == ErrorLogType.ERROR_EVENT){
                    evt = (this._error as ErrorEvent);
                    t = (t + evt.toString());
                } else {
                    t = (t + String(this._error));
                };
            };
            return (t);
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {

    public class mConsoleLog {

        public var msg:String;
        public var type:uint;
        private var _time:Date;

        public function mConsoleLog(msg:String, type:uint=1):void{
            super();
            this.msg = msg;
            this.type = type;
            this._time = new Date();
        }
        public function get time():Date{
            return (this._time);
        }
        public function toString():String{
            return (this.msg);
        }

    }
}//package msc.console 

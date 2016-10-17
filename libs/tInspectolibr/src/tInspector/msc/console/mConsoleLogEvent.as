//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {
    import tInspector.msc.events.*;

    public class mConsoleLogEvent extends mConsoleEvent {

        public static const LOG:String = "mConsole_log";

        public var log:mConsoleLog;

        public function mConsoleLogEvent(log:mConsoleLog, bubbles:Boolean=false, cancelable:Boolean=false){
            super(LOG, bubbles, cancelable);
            this.log = log;
        }
    }
}//package msc.console 

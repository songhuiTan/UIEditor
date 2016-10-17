//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {

    public class mConsoleLogStyle {

        public static function buildLogStyleStr(log:mConsoleLog):String{
            var str:String = log.msg;
            var color:String = "#000000";
            switch (log.type){
                case mConsoleLogType.ERROR:
                    color = "#ff0000";
                    break;
                case mConsoleLogType.INFO:
                    color = "#99cc00";
                    break;
                case mConsoleLogType.CONSOLE:
                    color = "#ff9900";
                    break;
                case mConsoleLogType.TRACE:
                    color = "#00FFFF";
                    break;
            };
            str = ((((((("<font face='Verdana' color='#ffffff'>[" + log.time.toLocaleTimeString()) + "]</font>") + " <font face='Verdana' color='") + color) + "'>") + str) + "</font>");
            return (str);
        }

    }
}//package msc.console 

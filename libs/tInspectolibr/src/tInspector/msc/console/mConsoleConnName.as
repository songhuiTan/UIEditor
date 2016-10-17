//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {

    public class mConsoleConnName {

        public static const CONSOLE:String = "_mConsole_LocalConnection";
        public static const CLIENT:String = "_mConsole_Client_LocalConnection";

        public static function getConsoleConnName(id:String):String{
            return (((CONSOLE + "_") + id));
        }

    }
}//package msc.console 

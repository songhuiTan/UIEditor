//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils {

    public class TimeFormat {

        public static const ENGLISH_FULL_TIME:String = "English_Full_Time";
        public static const ENGILSH_SHORT_TIME:String = "English_Short_Time";
        public static const CHINESE_FULL_TIME:String = "Chinese_Time";
        public static const CHINESE_SHORT_TIME:String = "Chinese_Short_Time";
        public static const CHINESE_SIMPLE_FULL_TIME:String = "Chinese_Simple_Time";
        public static const CHINESE_SIMPLE_SHORT_TIME:String = "Chinese_Simple_Short_Time";

        public static function toTimeString(time:int, type:String):String{
            var hour:int = (time / 3600);
            time = (time % 3600);
            var minitue:int = (time / 60);
            var second:int = (time % 60);
            return (TimeFormat.toTimeFormat(hour, minitue, second, type));
        }
        public static function toTimeFormat(h:int, m:int, s:int, type:String="English_Full_Time"):String{
            var ret:String = "";
            switch (type){
                case ENGLISH_FULL_TIME:
                    ret = ((((getFull(h) + ":") + getFull(m)) + ":") + getFull(s));
                    break;
                case ENGILSH_SHORT_TIME:
                    ret = (ret + TimeFormat.getSimple(h, ":"));
                    ret = (ret + TimeFormat.getSimple(m, ":"));
                    ret = (ret + s);
                    break;
                case CHINESE_SIMPLE_FULL_TIME:
                    ret = (((((getFull(h) + "时") + getFull(m)) + "分") + getFull(s)) + "秒");
                    break;
                case CHINESE_SIMPLE_SHORT_TIME:
                    ret = (ret + TimeFormat.getSimple(h, "时"));
                    ret = (ret + TimeFormat.getSimple(m, "分"));
                    ret = (ret + (s + "秒"));
                    break;
                case CHINESE_FULL_TIME:
                    ret = (((((getFull(h) + "小时") + getFull(m)) + "分钟") + getFull(s)) + "秒");
                    break;
                case CHINESE_SHORT_TIME:
                    ret = (ret + getSimple(h, "小时"));
                    ret = (ret + getSimple(m, "分钟"));
                    ret = (ret + (s + "秒"));
                    break;
            };
            return (ret);
        }
        private static function getFull(num:int):String{
            var ret:String = "";
            if (num < 10){
                ret = "0";
            };
            ret = (ret + num.toString());
            return (ret);
        }
        private static function getSimple(num:int, format:String):String{
            if (num != 0){
                return ((num + format));
            };
            return ("");
        }

    }
}//package cn.itamt.utils 

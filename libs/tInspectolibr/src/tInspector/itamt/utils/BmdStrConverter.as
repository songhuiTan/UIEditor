//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils {
    import flash.utils.*;
    import flash.display.*;

    public class BmdStrConverter {

        public static function bmd2str(bmd:BitmapData):String{
            var str:String;
            var ba:ByteArray = new ByteArray();
            ba.writeUnsignedInt(bmd.width);
            ba.writeUnsignedInt(bmd.height);
            ba.writeBoolean(bmd.transparent);
            ba.writeBytes(bmd.getPixels(bmd.rect));
            str = Base64.encodeByteArray(ba);
            return (str);
        }
        public static function str2bmd(base64Str:String):BitmapData{
            var bmd:BitmapData;
            var ba:ByteArray = Base64.decodeToByteArray(base64Str);
            bmd = new BitmapData(ba.readUnsignedInt(), ba.readUnsignedInt(), ba.readBoolean(), 0);
            bmd.setPixels(bmd.rect, ba);
            return (bmd);
        }

    }
}//package cn.itamt.utils 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagStartSound2 extends Tag implements ITag {

        public static const TYPE:uint = 89;

        public var soundClassName:String;
        public var soundInfo:SWFSoundInfo;

        public function TagStartSound2(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.soundClassName = data.readString();
            this.soundInfo = data.readSOUNDINFO();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("StartSound2");
        }
        override public function get version():uint{
            return (9);
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "SoundClassName: ") + this.soundClassName) + ", ") + "SoundInfo: ") + this.soundInfo);
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

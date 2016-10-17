//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagStartSound extends Tag implements ITag {

        public static const TYPE:uint = 15;

        public var soundId:uint;
        public var soundInfo:SWFSoundInfo;

        public function TagStartSound(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.soundId = data.readUI16();
            this.soundInfo = data.readSOUNDINFO();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("StartSound");
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((toStringMain(indent) + "SoundID: ") + this.soundId) + ", ") + "SoundInfo: ") + this.soundInfo);
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

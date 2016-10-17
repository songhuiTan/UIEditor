//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;

    public class TagDefineVideoStream extends Tag implements ITag {

        public static const TYPE:uint = 60;

        public var characterId:uint;
        public var numFrames:uint;
        public var width:uint;
        public var height:uint;
        public var deblocking:uint;
        public var smoothing:Boolean;
        public var codecId:uint;

        public function TagDefineVideoStream(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.characterId = data.readUI16();
            this.numFrames = data.readUI16();
            this.width = data.readUI16();
            this.height = data.readUI16();
            data.readUB(4);
            this.deblocking = data.readUB(3);
            this.smoothing = (data.readUB(1) == 1);
            this.codecId = data.readUI8();
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineVideoStream");
        }
        override public function get version():uint{
            return (6);
        }
        public function toString(indent:uint=0):String{
            return (((((((((((((((((((((toStringMain(indent) + "ID: ") + this.characterId) + ", ") + "Frames: ") + this.numFrames) + ", ") + "Width: ") + this.width) + ", ") + "Height: ") + this.height) + ", ") + "Deblocking: ") + VideoDeblockingType.toString(this.deblocking)) + ", ") + "Smoothing: ") + this.smoothing) + ", ") + "Codec: ") + VideoCodecID.toString(this.codecId)));
        }

    }
}//package com.codeazur.as3swf.tags 

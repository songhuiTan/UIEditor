//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagVideoFrame extends Tag implements ITag {

        public static const TYPE:uint = 61;

        public var streamId:uint;
        public var frameNum:uint;
        protected var _videoData:ByteArray;

        public function TagVideoFrame(){
            super();
            this._videoData = new ByteArray();
        }
        public function get videoData():ByteArray{
            return (this._videoData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.streamId = data.readUI16();
            this.frameNum = data.readUI16();
            data.readBytes(this._videoData, 0, (length - 4));
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, (this._videoData.length + 4));
            data.writeUI16(this.streamId);
            data.writeUI16(this.frameNum);
            if (this._videoData.length > 0){
                data.writeBytes(this._videoData);
            };
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("VideoFrame");
        }
        override public function get version():uint{
            return (6);
        }
        public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "StreamID: ") + this.streamId) + ", ") + "Frame: ") + this.frameNum));
        }

    }
}//package com.codeazur.as3swf.tags 

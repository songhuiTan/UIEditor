//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.factories.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineSprite extends Tag implements ITag {

        public static const TYPE:uint = 39;

        public var spriteId:uint;
        public var frameCount:uint;
        protected var _controlTags:Vector.<ITag>;

        public function TagDefineSprite(){
            super();
            this._controlTags = new Vector.<ITag>();
        }
        public function get controlTags():Vector.<ITag>{
            return (this._controlTags);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var raw:ByteArray;
            var header:SWFRecordHeader;
            var tag:ITag;
            this.spriteId = data.readUI16();
            this.frameCount = data.readUI16();
            this._controlTags.length = 0;
            while (true) {
                raw = data.readRawTag();
                header = data.readTagHeader();
                tag = SWFTagFactory.create(header.type);
                tag.raw = raw;
                tag.parse(data, header.length, version);
                this._controlTags.push(tag);
                if (header.type == 0){
                    break;
                };
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var body:* = null;
            var i:* = 0;
            var tag:* = null;
            var data:* = data;
            var version:* = version;
            body = new SWFData();
            body.writeUI16(this.spriteId);
            body.writeUI16(this.frameCount);
            i = 0;
            while (i < this._controlTags.length) {
                try {
                    this._controlTags[i].publish(body, version);
                } catch(e:Error) {
                    tag = _controlTags[i];
                    if (tag.raw != null){
                        body.writeTagHeader(tag.type, tag.raw.length);
                        body.writeBytes(tag.raw);
                    } else {
                        throw (e);
                    };
                };
                i = (i + 1);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineSprite");
        }
        override public function get version():uint{
            return (3);
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = ((((((((toStringMain(indent) + "ID: ") + this.spriteId) + ", ") + "FrameCount: ") + this.frameCount) + ", ") + "Tags: ") + this._controlTags.length);
            if (this._controlTags.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "ControlTags:"));
                i = 0;
                while (i < this._controlTags.length) {
                    str = (str + ("\n" + this._controlTags[i].toString((indent + 4))));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

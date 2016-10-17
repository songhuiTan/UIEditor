//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.tags.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.factories.*;

    public class SWF {

        public var version:int = 10;
        public var fileLength:uint;
        public var fileLengthCompressed:uint;
        public var frameSize:SWFRectangle;
        public var frameRate:Number = 50;
        public var frameCount:uint = 1;
        public var compressed:Boolean;
        protected var _tags:Vector.<ITag>;

        public function SWF(data:ByteArray=null){
            super();
            this._tags = new Vector.<ITag>();
            if (data != null){
                this.loadBytes(data);
            } else {
                this.frameSize = new SWFRectangle();
            };
        }
        public function get tags():Vector.<ITag>{
            return (this._tags);
        }
        public function set tags(value:Vector.<ITag>):void{
            this._tags = value;
        }
        public function loadBytes(data:ByteArray):void{
            var swfData:SWFData = new SWFData();
            data.position = 0;
            data.readBytes(swfData, 0, data.length);
            swfData.position = 0;
            this.parse(swfData);
        }
        public function parse(data:SWFData):void{
            var raw:* = null;
            var header:* = null;
            var tag:* = null;
            var pos:* = 0;
            var data:* = data;
            this.compressed = false;
            var signatureByte:* = data.readUI8();
            if (signatureByte == 67){
                this.compressed = true;
            } else {
                if (signatureByte != 70){
                    throw (new Error((("Not a SWF. First signature byte is 0x" + signatureByte.toString(16)) + " (expected: 0x43 or 0x46)")));
                };
            };
            signatureByte = data.readUI8();
            if (signatureByte != 87){
                throw (new Error((("Not a SWF. Second signature byte is 0x" + signatureByte.toString(16)) + " (expected: 0x57)")));
            };
            signatureByte = data.readUI8();
            if (signatureByte != 83){
                throw (new Error((("Not a SWF. Third signature byte is 0x" + signatureByte.toString(16)) + " (expected: 0x53)")));
            };
            this.version = data.readUI8();
            this.fileLength = data.readUI32();
            this.fileLengthCompressed = data.length;
            if (this.compressed){
                data.swfUncompress();
            };
            this.frameSize = data.readRECT();
            this.frameRate = data.readFIXED8();
            this.frameCount = data.readUI16();
            this.tags.length = 0;
            while (true) {
                raw = data.readRawTag();
                header = data.readTagHeader();
                tag = SWFTagFactory.create(header.type);
                pos = data.position;
                tag.raw = raw;
                try {
                    tag.parse(data, header.length, this.version);
                } catch(e:Error) {
                    trace(((tag.name + ": ") + e));
                };
                this.tags.push(tag);
                if (header.type == 0){
                    break;
                };
                data.position = (data.position + ((header.length - data.position) + pos));
            };
        }
        public function publish(data:SWFData):void{
            var i:* = 0;
            var tag:* = null;
            var data:* = data;
            data.writeUI8((this.compressed) ? 67 : 70);
            data.writeUI8(87);
            data.writeUI8(83);
            data.writeUI8(this.version);
            var fileLengthPos:* = data.position;
            data.writeUI32(0);
            data.writeRECT(this.frameSize);
            data.writeFIXED8(this.frameRate);
            data.writeUI16(this.frameCount);
            i = 0;
            while (i < this.tags.length) {
                try {
                    this.tags[i].publish(data, this.version);
                } catch(e:Error) {
                    tag = tags[i];
                    if (tag.raw != null){
                        data.writeTagHeader(tag.type, tag.raw.length);
                        data.writeBytes(tag.raw);
                    } else {
                        throw (e);
                    };
                };
                i = (i + 1);
            };
            this.fileLength = (this.fileLengthCompressed = data.length);
            if (this.compressed){
                data.position = 8;
                data.swfCompress();
                this.fileLengthCompressed = data.length;
            };
            var endPos:* = data.position;
            data.position = fileLengthPos;
            data.writeUI32(this.fileLength);
            data.position = endPos;
        }
        public function toString():String{
            var i:uint;
            var str:String = (((((((((((((((((((("[SWF] " + "Version: ") + this.version) + ", ") + "FileLength: ") + this.fileLength) + ", ") + "FileLengthCompressed: ") + this.fileLengthCompressed) + ", ") + "FrameSize: ") + this.frameSize.toStringSize()) + ", ") + "FrameRate: ") + this.frameRate) + ", ") + "FrameCount: ") + this.frameCount) + ", ") + "Tags: ") + this.tags.length);
            if (this.tags.length > 0){
                str = (str + "\n  Tags:");
                i = 0;
                while (i < Math.min(100000, this.tags.length)) {
                    str = (str + ("\n" + this.tags[i].toString(4)));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf 

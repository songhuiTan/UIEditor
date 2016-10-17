//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagCSMTextSettings extends Tag implements ITag {

        public static const TYPE:uint = 74;

        public var textId:uint;
        public var useFlashType:uint;
        public var gridFit:uint;
        public var thickness:Number;
        public var sharpness:Number;

        public function TagCSMTextSettings(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.textId = data.readUI16();
            this.useFlashType = data.readUB(2);
            this.gridFit = data.readUB(3);
            data.readUB(3);
            this.thickness = data.readFIXED();
            this.sharpness = data.readFIXED();
            data.readUI8();
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 12);
            data.writeUI16(this.textId);
            data.writeUB(2, this.useFlashType);
            data.writeUB(3, this.gridFit);
            data.writeUB(3, 0);
            data.writeFIXED(this.thickness);
            data.writeFIXED(this.sharpness);
            data.writeUI8(0);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("CSMTextSettings");
        }
        override public function get version():uint{
            return (8);
        }
        public function toString(indent:uint=0):String{
            return (((((((((((((((toStringMain(indent) + "TextID: ") + this.textId) + ", ") + "UseFlashType: ") + this.useFlashType) + ", ") + "GridFit: ") + this.gridFit) + ", ") + "Thickness: ") + this.thickness) + ", ") + "Sharpness: ") + this.sharpness));
        }

    }
}//package com.codeazur.as3swf.tags 

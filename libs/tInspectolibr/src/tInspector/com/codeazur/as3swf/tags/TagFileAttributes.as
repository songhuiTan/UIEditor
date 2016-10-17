//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagFileAttributes extends Tag implements ITag {

        public static const TYPE:uint = 69;

        public var useDirectBlit:Boolean = false;
        public var useGPU:Boolean = false;
        public var hasMetadata:Boolean = false;
        public var actionscript3:Boolean = true;
        public var useNetwork:Boolean = false;

        public function TagFileAttributes(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var flags:uint = data.readUI8();
            this.useDirectBlit = !(((flags & 64) == 0));
            this.useGPU = !(((flags & 32) == 0));
            this.hasMetadata = !(((flags & 16) == 0));
            this.actionscript3 = !(((flags & 8) == 0));
            this.useNetwork = !(((flags & 1) == 0));
            data.skipBytes(3);
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 4);
            var flags:uint;
            if (this.useNetwork){
                flags = (flags | 1);
            };
            if (this.actionscript3){
                flags = (flags | 8);
            };
            if (this.hasMetadata){
                flags = (flags | 16);
            };
            if (this.useGPU){
                flags = (flags | 32);
            };
            if (this.useDirectBlit){
                flags = (flags | 64);
            };
            data.writeUI8(flags);
            data.writeUI8(0);
            data.writeUI8(0);
            data.writeUI8(0);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("FileAttributes");
        }
        override public function get version():uint{
            return (8);
        }
        public function toString(indent:uint=0):String{
            return (((((((((((((((toStringMain(indent) + "AS3: ") + this.actionscript3) + ", ") + "HasMetadata: ") + this.hasMetadata) + ", ") + "UseDirectBlit: ") + this.useDirectBlit) + ", ") + "UseGPU: ") + this.useGPU) + ", ") + "UseNetwork: ") + this.useNetwork));
        }

    }
}//package com.codeazur.as3swf.tags 

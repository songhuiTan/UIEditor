//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagProductInfo extends Tag implements ITag {

        public static const TYPE:uint = 41;

        public var productId:uint;
        public var edition:uint;
        public var majorVersion:uint;
        public var minorVersion:uint;
        public var majorBuild:uint;
        public var minorBuild:uint;
        public var compileDate:Date;

        public function TagProductInfo(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.productId = data.readUI32();
            this.edition = data.readUI32();
            this.majorVersion = data.readUI8();
            this.minorVersion = data.readUI8();
            this.minorBuild = data.readUI32();
            this.majorBuild = data.readUI32();
            var sec:Number = data.readUI32();
            sec = (sec + (data.readUI32() * 4294967296));
            this.compileDate = new Date(sec);
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("ProductInfo");
        }
        override public function get version():uint{
            return (3);
        }
        public function toString(indent:uint=0):String{
            return ((((((((((((((((((toStringMain(indent) + "ProductID: ") + this.productId) + ", ") + "Edition: ") + this.edition) + ", ") + "Version: ") + this.majorVersion) + ".") + this.minorVersion) + ".") + this.majorBuild) + ".") + this.minorBuild) + ", ") + "CompileDate: ") + this.compileDate.toString()));
        }

    }
}//package com.codeazur.as3swf.tags 

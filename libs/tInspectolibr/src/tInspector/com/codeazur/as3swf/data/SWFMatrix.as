//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;
    import flash.geom.*;

    public class SWFMatrix {

        public var scaleX:Number = 1;
        public var scaleY:Number = 1;
        public var rotateSkew0:Number = 0;
        public var rotateSkew1:Number = 0;
        public var translateX:int = 0;
        public var translateY:int = 0;

        public function SWFMatrix(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public function get matrix():Matrix{
            return (new Matrix(this.scaleX, this.rotateSkew0, this.rotateSkew1, this.scaleY, this.translateX, this.translateY));
        }
        public function parse(data:SWFData):void{
            var scaleBits:uint;
            var rotateBits:uint;
            data.resetBitsPending();
            this.scaleX = 1;
            this.scaleY = 1;
            if (data.readUB(1) == 1){
                scaleBits = data.readUB(5);
                this.scaleX = data.readFB(scaleBits);
                this.scaleY = data.readFB(scaleBits);
            };
            this.rotateSkew0 = 0;
            this.rotateSkew1 = 0;
            if (data.readUB(1) == 1){
                rotateBits = data.readUB(5);
                this.rotateSkew0 = data.readFB(rotateBits);
                this.rotateSkew1 = data.readFB(rotateBits);
            };
            var translateBits:uint = data.readUB(5);
            this.translateX = data.readSB(translateBits);
            this.translateY = data.readSB(translateBits);
        }
        public function toString():String{
            return ((((((((((((("(" + this.scaleX) + ",") + this.scaleY) + ",") + this.rotateSkew0) + ",") + this.rotateSkew1) + ",") + this.translateX) + ",") + this.translateY) + ")"));
        }

    }
}//package com.codeazur.as3swf.data 

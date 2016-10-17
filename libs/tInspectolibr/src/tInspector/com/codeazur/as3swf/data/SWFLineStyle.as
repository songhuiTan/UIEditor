//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFLineStyle {

        public var width:uint;
        public var color:uint;
        public var startCapsStyle:uint;
        public var endCapsStyle:uint;
        public var jointStyle:uint;
        public var hasFillFlag:Boolean = false;
        public var noHScaleFlag:Boolean = false;
        public var noVScaleFlag:Boolean = false;
        public var pixelHintingFlag:Boolean = false;
        public var noClose:Boolean = false;
        public var miterLimitFactor:Number = 3;
        public var fillType:SWFFillStyle;

        public function SWFLineStyle(data:SWFData=null, level:uint=1){
            this.startCapsStyle = LineCapsStyle.ROUND;
            this.endCapsStyle = LineCapsStyle.ROUND;
            this.jointStyle = LineJointStyle.ROUND;
            super();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function parse(data:SWFData, level:uint=1):void{
            this.width = data.readUI16();
            this.color = ((level)<=2) ? data.readRGB() : data.readRGBA();
        }
        public function toString():String{
            return (((("[SWFLineStyle] Width: " + this.width) + " Color: ") + this.color.toString(16)));
        }

    }
}//package com.codeazur.as3swf.data 

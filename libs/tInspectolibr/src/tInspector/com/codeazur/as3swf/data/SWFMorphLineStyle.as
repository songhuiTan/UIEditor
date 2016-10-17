//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFMorphLineStyle {

        public var startWidth:uint;
        public var endWidth:uint;
        public var startColor:uint;
        public var endColor:uint;
        public var startCapsStyle:uint;
        public var endCapsStyle:uint;
        public var jointStyle:uint;
        public var hasFillFlag:Boolean = false;
        public var noHScaleFlag:Boolean = false;
        public var noVScaleFlag:Boolean = false;
        public var pixelHintingFlag:Boolean = false;
        public var noClose:Boolean = false;
        public var miterLimitFactor:Number = 3;
        public var fillType:SWFMorphFillStyle;

        public function SWFMorphLineStyle(data:SWFData=null, level:uint=1){
            this.startCapsStyle = LineCapsStyle.ROUND;
            this.endCapsStyle = LineCapsStyle.ROUND;
            this.jointStyle = LineJointStyle.ROUND;
            super();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function parse(data:SWFData, level:uint=1):void{
            this.startWidth = data.readUI16();
            this.endWidth = data.readUI16();
            this.startColor = data.readRGBA();
            this.endColor = data.readRGBA();
        }
        public function toString():String{
            return (((((((((((("[SWFMorphLineStyle] " + "StartWidth: ") + this.startWidth) + ", ") + "EndWidth: ") + this.endWidth) + ", ") + "StartColor: ") + this.startColor.toString(16)) + ", ") + "EndColor: ") + this.endColor.toString(16)));
        }

    }
}//package com.codeazur.as3swf.data 

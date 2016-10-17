//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;

    public class SWFLineStyle2 extends SWFLineStyle {

        public function SWFLineStyle2(data:SWFData=null, level:uint=1){
            super(data, level);
        }
        override public function parse(data:SWFData, level:uint=1):void{
            width = data.readUI16();
            startCapsStyle = data.readUB(2);
            jointStyle = data.readUB(2);
            hasFillFlag = (data.readUB(1) == 1);
            noHScaleFlag = (data.readUB(1) == 1);
            noVScaleFlag = (data.readUB(1) == 1);
            pixelHintingFlag = (data.readUB(1) == 1);
            data.readUB(5);
            noClose = (data.readUB(1) == 1);
            endCapsStyle = data.readUB(2);
            if (jointStyle == LineJointStyle.MITER){
                miterLimitFactor = data.readFIXED8();
            };
            if (hasFillFlag){
                fillType = data.readFILLSTYLE(level);
            } else {
                color = data.readRGBA();
            };
        }
        override public function toString():String{
            var str:String = (((((((((("[SWFLineStyle2] Width: " + width) + ", ") + "StartCaps: ") + LineCapsStyle.toString(startCapsStyle)) + ", ") + "EndCaps: ") + LineCapsStyle.toString(endCapsStyle)) + ", ") + "Joint: ") + LineJointStyle.toString(jointStyle));
            if (hasFillFlag){
                str = (str + (", Fill: " + fillType.toString()));
            } else {
                str = (str + (", Color: " + color.toString(16)));
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 

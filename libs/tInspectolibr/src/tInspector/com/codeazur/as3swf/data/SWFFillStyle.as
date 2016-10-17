//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFFillStyle {

        public var type:uint;
        public var rgb:uint;
        public var gradient:SWFGradient;
        public var gradientMatrix:SWFMatrix;
        public var bitmapId:uint;
        public var bitmapMatrix:SWFMatrix;

        public function SWFFillStyle(data:SWFData=null, level:uint=1){
            super();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function parse(data:SWFData, level:uint=1):void{
            this.type = data.readUI8();
            switch (this.type){
                case 0:
                    this.rgb = ((level)<=2) ? data.readRGB() : data.readRGBA();
                    break;
                case 16:
                case 18:
                case 19:
                    this.gradientMatrix = data.readMATRIX();
                    this.gradient = ((this.type)==19) ? data.readFOCALGRADIENT(level) : data.readGRADIENT(level);
                    break;
                case 64:
                case 65:
                case 66:
                case 67:
                    this.bitmapId = data.readUI16();
                    this.bitmapMatrix = data.readMATRIX();
                    break;
                default:
                    throw (new Error(("Unknown fill style type: 0x" + this.type.toString(16))));
            };
        }
        public function toString():String{
            var str:String = ("[SWFFillStyle] Type: " + this.type.toString(16));
            switch (this.type){
                case 0:
                    str = (str + (" (solid), Color: " + this.rgb.toString(16)));
                    break;
                case 16:
                    str = (str + (((" (linear gradient), Gradient: " + this.gradient) + ", Matrix: ") + this.gradientMatrix));
                    break;
                case 18:
                    str = (str + (((" (radial gradient), Gradient: " + this.gradient) + ", Matrix: ") + this.gradientMatrix));
                    break;
                case 19:
                    str = (str + (((((" (focal radial gradient), Gradient: " + this.gradient) + ", Matrix: ") + this.gradientMatrix) + ", FocalPoint: ") + this.gradient.focalPoint));
                    break;
                case 64:
                    str = (str + (" (repeating bitmap), BitmapID: " + this.bitmapId));
                    break;
                case 65:
                    str = (str + (" (clipped bitmap), BitmapID: " + this.bitmapId));
                    break;
                case 66:
                    str = (str + (" (non-smoothed repeating bitmap), BitmapID: " + this.bitmapId));
                    break;
                case 67:
                    str = (str + (" (non-smoothed clipped bitmap), BitmapID: " + this.bitmapId));
                    break;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 

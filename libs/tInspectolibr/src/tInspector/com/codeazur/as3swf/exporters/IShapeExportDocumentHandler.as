//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.exporters {
    import flash.geom.*;

    public interface IShapeExportDocumentHandler {

        function beginShape():void;
        function endShape():void;
        function beginFills():void;
        function endFills():void;
        function beginFill(color:uint, alpha:Number=1):void;
        function beginGradientFill(type:String, colors:Array, alphas:Array, ratios:Array, matrix:Matrix=null, spreadMethod:String="pad", interpolationMethod:String="rgb", focalPointRatio:Number=0):void;
        function beginBitmapFill(bitmapId:uint, matrix:Matrix=null, repeat:Boolean=true, smooth:Boolean=false):void;
        function endFill():void;
        function beginLines():void;
        function endLines():void;
        function lineStyle(thickness:Number=NaN, color:uint=0, alpha:Number=1, pixelHinting:Boolean=false, scaleMode:String="normal", startCaps:String=null, endCaps:String=null, joints:String=null, miterLimit:Number=3):void;
        function moveTo(x:Number, y:Number):void;
        function lineTo(x:Number, y:Number):void;
        function curveTo(controlX:Number, controlY:Number, anchorX:Number, anchorY:Number):void;

    }
}//package com.codeazur.as3swf.exporters 

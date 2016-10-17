//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.utils.*;

    public class TagSetBackgroundColor extends Tag implements ITag {

        public static const TYPE:uint = 9;

        public var color:uint = 0xFFFFFF;

        public function TagSetBackgroundColor(){
            super();
        }
        public static function create(aColor:uint=0xFFFFFF):TagSetBackgroundColor{
            var setBackgroundColor:TagSetBackgroundColor = new (TagSetBackgroundColor)();
            setBackgroundColor.color = aColor;
            return (setBackgroundColor);
        }

        public function parse(data:SWFData, length:uint, version:uint):void{
            this.color = data.readRGB();
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 3);
            data.writeRGB(this.color);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("SetBackgroundColor");
        }
        override public function get version():uint{
            return (1);
        }
        public function toString(indent:uint=0):String{
            return (((toStringMain(indent) + "Color: ") + ColorUtils.rgbToString(this.color)));
        }

    }
}//package com.codeazur.as3swf.tags 

﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagShowFrame extends Tag implements ITag {

        public static const TYPE:uint = 1;

        public function TagShowFrame(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 0);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("ShowFrame");
        }
        override public function get version():uint{
            return (1);
        }
        public function toString(indent:uint=0):String{
            return (toStringMain(indent));
        }

    }
}//package com.codeazur.as3swf.tags 

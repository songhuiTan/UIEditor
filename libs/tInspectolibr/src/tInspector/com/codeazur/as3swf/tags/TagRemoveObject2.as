//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagRemoveObject2 extends Tag implements ITag {

        public static const TYPE:uint = 28;

        public var depth:uint;

        public function TagRemoveObject2(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.depth = data.readUI16();
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 2);
            data.writeUI16(this.depth);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("RemoveObject2");
        }
        override public function get version():uint{
            return (3);
        }
        public function toString(indent:uint=0):String{
            return (((toStringMain(indent) + "Depth: ") + this.depth));
        }

    }
}//package com.codeazur.as3swf.tags 

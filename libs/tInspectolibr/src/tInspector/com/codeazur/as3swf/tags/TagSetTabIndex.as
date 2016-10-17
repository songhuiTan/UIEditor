//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagSetTabIndex extends Tag implements ITag {

        public static const TYPE:uint = 66;

        public var depth:uint;
        public var tabIndex:uint;

        public function TagSetTabIndex(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.depth = data.readUI16();
            this.tabIndex = data.readUI16();
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 4);
            data.writeUI16(this.depth);
            data.writeUI16(this.tabIndex);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("SetTabIndex");
        }
        override public function get version():uint{
            return (7);
        }
        public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "Depth: ") + this.depth) + ", ") + "TabIndex: ") + this.tabIndex));
        }

    }
}//package com.codeazur.as3swf.tags 

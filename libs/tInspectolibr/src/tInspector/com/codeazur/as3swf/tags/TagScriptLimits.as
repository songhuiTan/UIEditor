//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagScriptLimits extends Tag implements ITag {

        public static const TYPE:uint = 65;

        public var maxRecursionDepth:uint;
        public var scriptTimeoutSeconds:uint;

        public function TagScriptLimits(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.maxRecursionDepth = data.readUI16();
            this.scriptTimeoutSeconds = data.readUI16();
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 4);
            data.writeUI16(this.maxRecursionDepth);
            data.writeUI16(this.scriptTimeoutSeconds);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("ScriptLimits");
        }
        override public function get version():uint{
            return (7);
        }
        public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "MaxRecursionDepth: ") + this.maxRecursionDepth) + ", ") + "ScriptTimeoutSeconds: ") + this.scriptTimeoutSeconds));
        }

    }
}//package com.codeazur.as3swf.tags 

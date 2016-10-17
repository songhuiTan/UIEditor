//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineScalingGrid extends Tag implements ITag {

        public static const TYPE:uint = 78;

        public var characterId:uint;
        public var splitter:SWFRectangle;

        public function TagDefineScalingGrid(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.characterId = data.readUI16();
            this.splitter = data.readRECT();
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.characterId);
            body.writeRECT(this.splitter);
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineScalingGrid");
        }
        public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "CharacterID: ") + this.characterId) + ", ") + "Splitter: ") + this.splitter));
        }

    }
}//package com.codeazur.as3swf.tags 

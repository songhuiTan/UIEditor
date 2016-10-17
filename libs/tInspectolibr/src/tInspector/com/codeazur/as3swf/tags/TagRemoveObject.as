﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;

    public class TagRemoveObject extends Tag implements ITag {

        public static const TYPE:uint = 5;

        public var characterId:uint;
        public var depth:uint;

        public function TagRemoveObject(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.characterId = data.readUI16();
            this.depth = data.readUI16();
        }
        public function publish(data:SWFData, version:uint):void{
            data.writeTagHeader(this.type, 4);
            data.writeUI16(this.characterId);
            data.writeUI16(this.depth);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("RemoveObject");
        }
        override public function get version():uint{
            return (1);
        }
        public function toString(indent:uint=0):String{
            return ((((((toStringMain(indent) + "CharacterID: ") + this.characterId) + ", ") + "Depth: ") + this.depth));
        }

    }
}//package com.codeazur.as3swf.tags 

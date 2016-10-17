//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {

    public class SWFScene {

        public var offset:uint;
        public var name:String;

        public function SWFScene(offset:uint, name:String){
            super();
            this.offset = offset;
            this.name = name;
        }
        public function toString():String{
            return (((("Offset: " + this.offset) + ", Name: ") + this.name));
        }

    }
}//package com.codeazur.as3swf.data 

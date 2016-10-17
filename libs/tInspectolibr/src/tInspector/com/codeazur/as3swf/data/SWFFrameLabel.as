//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {

    public class SWFFrameLabel {

        public var frameNumber:uint;
        public var name:String;

        public function SWFFrameLabel(frameNumber:uint, name:String){
            super();
            this.frameNumber = frameNumber;
            this.name = name;
        }
        public function toString():String{
            return (((("Frame: " + this.frameNumber) + ", Name: ") + this.name));
        }

    }
}//package com.codeazur.as3swf.data 

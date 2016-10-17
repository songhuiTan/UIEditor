//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {

    public class SWFShapeRecordEnd extends SWFShapeRecord {

        public function SWFShapeRecordEnd(){
            super();
        }
        override public function get type():uint{
            return (SWFShapeRecord.TYPE_END);
        }
        override public function toString(indent:uint=0):String{
            return ("[SWFShapeRecordEnd]");
        }

    }
}//package com.codeazur.as3swf.data 

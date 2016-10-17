//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFFocalGradient extends SWFGradient {

        public function SWFFocalGradient(data:SWFData=null, level:uint=1){
            super(data, level);
        }
        override public function parse(data:SWFData, level:uint):void{
            super.parse(data, level);
            focalPoint = data.readFIXED8();
        }
        override public function toString():String{
            return ((("(" + _records.join(",")) + ")"));
        }

    }
}//package com.codeazur.as3swf.data 

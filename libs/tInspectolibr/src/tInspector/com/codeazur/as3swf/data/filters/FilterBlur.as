//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.filters {
    import tInspector.com.codeazur.as3swf.*;

    public class FilterBlur extends Filter implements IFilter {

        public var blurX:Number;
        public var blurY:Number;
        public var passes:uint;

        public function FilterBlur(id:uint){
            super(id);
        }
        override public function parse(data:SWFData):void{
            this.blurX = data.readFIXED();
            this.blurY = data.readFIXED();
            this.passes = (data.readUI8() >> 3);
        }

    }
}//package com.codeazur.as3swf.data.filters 

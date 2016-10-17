//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFSymbol {

        public var tagId:uint;
        public var name:String;

        public function SWFSymbol(data:SWFData=null){
            super();
            if (data != null){
                this.parse(data);
            };
        }
        public static function create(aTagID:uint, aName:String):SWFSymbol{
            var swfSymbol:SWFSymbol = new (SWFSymbol)();
            swfSymbol.tagId = aTagID;
            swfSymbol.name = aName;
            return (swfSymbol);
        }

        public function parse(data:SWFData):void{
            this.tagId = data.readUI16();
            this.name = data.readString();
        }
        public function publish(data:SWFData):void{
            data.writeUI16(this.tagId);
            data.writeString(this.name);
        }
        public function toString():String{
            return (((("TagID: " + this.tagId) + ", Name: ") + this.name));
        }

    }
}//package com.codeazur.as3swf.data 

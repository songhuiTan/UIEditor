//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;

    public class SWFZoneRecord {

        public var maskX:Boolean;
        public var maskY:Boolean;
        protected var _zoneData:Vector.<SWFZoneData>;

        public function SWFZoneRecord(data:SWFData=null){
            super();
            this._zoneData = new Vector.<SWFZoneData>();
            if (data != null){
                this.parse(data);
            };
        }
        public function get zoneData():Vector.<SWFZoneData>{
            return (this._zoneData);
        }
        public function parse(data:SWFData):void{
            var numZoneData:uint = data.readUI8();
            var i:uint;
            while (i < numZoneData) {
                this._zoneData.push(data.readZONEDATA());
                i++;
            };
            var mask:uint = data.readUI8();
            this.maskX = !(((mask & 1) == 0));
            this.maskY = !(((mask & 2) == 0));
        }
        public function toString(indent:uint=0):String{
            var str:String = ((("MaskY: " + this.maskY) + ", MaskX: ") + this.maskX);
            var i:uint;
            while (i < this._zoneData.length) {
                str = (str + (((", " + i) + ": ") + this._zoneData[i].toString()));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 

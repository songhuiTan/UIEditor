//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFClipActions {

        public var eventFlags:SWFClipEventFlags;
        protected var _records:Vector.<SWFClipActionRecord>;

        public function SWFClipActions(data:SWFData=null, version:uint=0){
            super();
            this._records = new Vector.<SWFClipActionRecord>();
            if (data != null){
                this.parse(data, version);
            };
        }
        public function get records():Vector.<SWFClipActionRecord>{
            return (this._records);
        }
        public function parse(data:SWFData, version:uint):void{
            var record:SWFClipActionRecord;
            data.readUI16();
            this.eventFlags = data.readCLIPEVENTFLAGS(version);
            while ((record = data.readCLIPACTIONRECORD(version)) != null) {
                this._records.push(record);
            };
        }
        public function toString(indent:uint=0):String{
            var str:String = (("ClipActionRecords " + this.eventFlags.toString()) + ":");
            var i:uint;
            while (i < this._records.length) {
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + this._records[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineFontAlignZones extends Tag implements ITag {

        public static const TYPE:uint = 73;

        public var fontId:uint;
        public var csmTableHint:uint;
        protected var _zoneTable:Vector.<SWFZoneRecord>;

        public function TagDefineFontAlignZones(){
            super();
            this._zoneTable = new Vector.<SWFZoneRecord>();
        }
        public function get zoneTable():Vector.<SWFZoneRecord>{
            return (this._zoneTable);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.fontId = data.readUI16();
            this.csmTableHint = (data.readUI8() >> 6);
            var recordsEndPos:uint = ((data.position + length) - 3);
            while (data.position < recordsEndPos) {
                this._zoneTable.push(data.readZONERECORD());
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineFontAlignZones");
        }
        public function toString(indent:uint=0):String{
            var str:String = ((((((((toStringMain(indent) + "FontID: ") + this.fontId) + ", ") + "CSMTableHint: ") + CSMTableHint.toString(this.csmTableHint)) + ", ") + "Records: ") + this._zoneTable.length);
            var i:uint;
            while (i < this._zoneTable.length) {
                str = (str + ((((("\n" + StringUtils.repeat((indent + 2))) + "[") + i) + "] ") + this._zoneTable[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

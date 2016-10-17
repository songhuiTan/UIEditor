//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.exporters.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFShapeWithStyle extends SWFShape {

        protected var _fillStyles:Vector.<SWFFillStyle>;
        protected var _lineStyles:Vector.<SWFLineStyle>;

        public function SWFShapeWithStyle(data:SWFData=null, level:uint=1){
            this._fillStyles = new Vector.<SWFFillStyle>();
            this._lineStyles = new Vector.<SWFLineStyle>();
            super(data, level);
        }
        public function get fillStyles():Vector.<SWFFillStyle>{
            return (this._fillStyles);
        }
        public function get lineStyles():Vector.<SWFLineStyle>{
            return (this._lineStyles);
        }
        override public function parse(data:SWFData, level:uint=1):void{
            var i:uint;
            data.resetBitsPending();
            var fillStylesLen:uint = this.readStyleArrayLength(data, level);
            i = 0;
            while (i < fillStylesLen) {
                this._fillStyles.push(data.readFILLSTYLE(level));
                i++;
            };
            var lineStylesLen:uint = this.readStyleArrayLength(data, level);
            i = 0;
            while (i < lineStylesLen) {
                this._lineStyles.push(((level <= 3)) ? data.readLINESTYLE(level) : data.readLINESTYLE2(level));
                i++;
            };
            var numFillBits:uint = data.readUB(4);
            var numLineBits:uint = data.readUB(4);
            data.resetBitsPending();
            readShapeRecords(data, numFillBits, numLineBits, level);
        }
        override public function export(handler:IShapeExportDocumentHandler=null):void{
            tmpFillStyles = this._fillStyles.concat();
            tmpLineStyles = this._lineStyles.concat();
            super.export(handler);
            tmpFillStyles = null;
            tmpLineStyles = null;
        }
        override public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = "";
            if (this._fillStyles.length > 0){
                str = (str + (("\n" + StringUtils.repeat(indent)) + "FillStyles:"));
                i = 0;
                while (i < this._fillStyles.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 2))) + "[") + (i + 1)) + "] ") + this._fillStyles[i].toString()));
                    i++;
                };
            };
            if (this._lineStyles.length > 0){
                str = (str + (("\n" + StringUtils.repeat(indent)) + "LineStyles:"));
                i = 0;
                while (i < this._lineStyles.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 2))) + "[") + (i + 1)) + "] ") + this._lineStyles[i].toString()));
                    i++;
                };
            };
            return ((str + super.toString(indent)));
        }
        protected function readStyleArrayLength(data:SWFData, level:uint=1):uint{
            var len:uint = data.readUI8();
            if ((((level >= 2)) && ((len == 0xFF)))){
                len = data.readUI16();
            };
            return (len);
        }

    }
}//package com.codeazur.as3swf.data 

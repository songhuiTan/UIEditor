//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.factories.*;
    import tInspector.com.codeazur.as3swf.data.filters.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFData extends BitArray {

        public static const FLOAT16_EXPONENT_BASE:Number = 16;

        public function SWFData(){
            super();
            endian = Endian.LITTLE_ENDIAN;
        }
        public function readSI8():int{
            resetBitsPending();
            return (readByte());
        }
        public function writeSI8(value:int):void{
            resetBitsPending();
            writeByte(value);
        }
        public function readSI16():int{
            resetBitsPending();
            return (readShort());
        }
        public function writeSI16(value:int):void{
            resetBitsPending();
            writeShort(value);
        }
        public function readSI32():int{
            resetBitsPending();
            return (readInt());
        }
        public function writeSI32(value:int):void{
            resetBitsPending();
            writeInt(value);
        }
        public function readUI8():uint{
            resetBitsPending();
            return (readUnsignedByte());
        }
        public function writeUI8(value:uint):void{
            resetBitsPending();
            writeByte(value);
        }
        public function readUI16():uint{
            resetBitsPending();
            return (readUnsignedShort());
        }
        public function writeUI16(value:uint):void{
            resetBitsPending();
            writeShort(value);
        }
        public function readUI24():uint{
            resetBitsPending();
            var loWord:uint = readUnsignedShort();
            var hiByte:uint = readUnsignedByte();
            return (((hiByte << 16) | loWord));
        }
        public function writeUI24(value:uint):void{
            resetBitsPending();
            writeShort((value & 0xFFFF));
            writeByte((value >> 16));
        }
        public function readUI32():uint{
            resetBitsPending();
            return (readUnsignedInt());
        }
        public function writeUI32(value:uint):void{
            resetBitsPending();
            writeUnsignedInt(value);
        }
        public function readFIXED():Number{
            resetBitsPending();
            return ((readInt() / 65536));
        }
        public function writeFIXED(value:Number):void{
            resetBitsPending();
            writeInt(int((value * 65536)));
        }
        public function readFIXED8():Number{
            resetBitsPending();
            return ((readShort() / 0x0100));
        }
        public function writeFIXED8(value:Number):void{
            resetBitsPending();
            writeShort(int((value * 0x0100)));
        }
        public function readFLOAT():Number{
            resetBitsPending();
            return (readFloat());
        }
        public function writeFLOAT(value:Number):void{
            resetBitsPending();
            writeFloat(value);
        }
        public function readDOUBLE():Number{
            resetBitsPending();
            return (readDouble());
        }
        public function writeDOUBLE(value:Number):void{
            resetBitsPending();
            writeDouble(value);
        }
        public function readFLOAT16():Number{
            resetBitsPending();
            var word:uint = readUnsignedShort();
            var sign:int = (((word & 0x8000))!=0) ? -1 : 1;
            var exponent:uint = ((word >> 10) & 31);
            var significand:uint = (word & 1023);
            if (exponent == 0){
                if (significand == 0){
                    return (0);
                };
                return (((sign * Math.pow(2, (1 - FLOAT16_EXPONENT_BASE))) * (significand / 0x0400)));
            };
            if (exponent == 31){
                if (significand == 0){
                    return (((sign)<0) ? Number.NEGATIVE_INFINITY : Number.POSITIVE_INFINITY);
                };
                return (Number.NaN);
            };
            return (((sign * Math.pow(2, (exponent - FLOAT16_EXPONENT_BASE))) * (1 + (significand / 0x0400))));
        }
        public function writeFLOAT16(value:Number):void{
            throw (new Error("writeFLOAT16() not yet implemented"));
        }
        public function readEncodedU32():uint{
            resetBitsPending();
            var result:uint = readUnsignedByte();
            if ((result & 128)){
                result = ((result & 127) | (readUnsignedByte() << 7));
                if ((result & 0x4000)){
                    result = ((result & 16383) | (readUnsignedByte() << 14));
                    if ((result & 0x200000)){
                        result = ((result & 2097151) | (readUnsignedByte() << 21));
                        if ((result & 268435456)){
                            result = ((result & 268435455) | (readUnsignedByte() << 28));
                        };
                    };
                };
            };
            return (result);
        }
        public function writeEncodedU32(value:uint):void{
            var v:uint;
            while (true) {
                v = (value & 127);
                value = (value >> 7);
                if (value == 0){
                    this.writeUI8(v);
                    break;
                };
                this.writeUI8((v & 128));
            };
        }
        public function readUB(bits:uint):uint{
            return (readBits(bits));
        }
        public function writeUB(bits:uint, value:uint):void{
            writeBits(bits, value);
        }
        public function readSB(bits:uint):int{
            var shift:uint = (32 - bits);
            return ((int((readBits(bits) << shift)) >> shift));
        }
        public function writeSB(bits:uint, value:int):void{
            writeBits(bits, value);
        }
        public function readFB(bits:uint):Number{
            return ((Number(this.readSB(bits)) / 65536));
        }
        public function writeFB(bits:uint, value:Number):void{
            this.writeSB(bits, (value * 65536));
        }
        public function readString():String{
            var c:uint;
            var ba:ByteArray = new ByteArray();
            while ((c = readUnsignedByte()) != 0) {
                ba.writeByte(c);
            };
            ba.position = 0;
            resetBitsPending();
            return (ba.readUTFBytes(ba.length));
        }
        public function writeString(value:String):void{
            if (((value) && ((value.length > 0)))){
                writeUTFBytes(value);
            };
            writeByte(0);
        }
        public function readLANGCODE():uint{
            resetBitsPending();
            return (readUnsignedByte());
        }
        public function writeLANGCODE(value:uint):void{
            resetBitsPending();
            writeByte(value);
        }
        public function readRGB():uint{
            resetBitsPending();
            var r:uint = readUnsignedByte();
            var g:uint = readUnsignedByte();
            var b:uint = readUnsignedByte();
            return ((((4278190080 | (r << 16)) | (g << 8)) | b));
        }
        public function writeRGB(value:uint):void{
            resetBitsPending();
            writeByte(((value >> 16) & 0xFF));
            writeByte(((value >> 8) & 0xFF));
            writeByte((value & 0xFF));
        }
        public function readRGBA():uint{
            resetBitsPending();
            var rgb:uint = (this.readRGB() & 0xFFFFFF);
            var a:uint = readUnsignedByte();
            return (((a << 24) | rgb));
        }
        public function writeRGBA(value:uint):void{
            resetBitsPending();
            this.writeRGB(value);
            writeByte(((value >> 24) & 0xFF));
        }
        public function readARGB():uint{
            resetBitsPending();
            var a:uint = readUnsignedByte();
            var rgb:uint = (this.readRGB() & 0xFFFFFF);
            return (((a << 24) | rgb));
        }
        public function writeARGB(value:uint):void{
            resetBitsPending();
            writeByte(((value >> 24) & 0xFF));
            this.writeRGB(value);
        }
        public function readRECT():SWFRectangle{
            return (new SWFRectangle(this));
        }
        public function writeRECT(value:SWFRectangle):void{
            value.publish(this);
        }
        public function readMATRIX():SWFMatrix{
            return (new SWFMatrix(this));
        }
        public function writeMATRIX(value:SWFMatrix):void{
            var scaleBits:uint;
            var rotateBits:uint;
            this.resetBitsPending();
            var hasScale:uint = (((!((value.scaleX == 1))) || (!((value.scaleY == 1))))) ? 1 : 0;
            var hasRotate:uint = (((!((value.rotateSkew0 == 0))) || (!((value.rotateSkew1 == 0))))) ? 1 : 0;
            writeBits(1, hasScale);
            if (hasScale){
                scaleBits = getMinFBits(value.scaleX, value.scaleY);
                this.writeUB(5, scaleBits);
                this.writeFB(scaleBits, value.scaleX);
                this.writeFB(scaleBits, value.scaleY);
            };
            writeBits(1, hasRotate);
            if (hasRotate){
                rotateBits = getMinFBits(value.rotateSkew0, value.rotateSkew1);
                this.writeUB(5, rotateBits);
                this.writeFB(rotateBits, value.rotateSkew0);
                this.writeFB(rotateBits, value.rotateSkew1);
            };
            var translateBits:uint = getMinSBits(value.translateX, value.translateY);
            this.writeUB(5, translateBits);
            this.writeSB(translateBits, value.translateX);
            this.writeSB(translateBits, value.translateY);
        }
        public function readCXFORM():SWFColorTransform{
            return (new SWFColorTransform(this));
        }
        public function writeCXFORM(value:SWFColorTransform):void{
            throw (new Error("writeCXFORM() not yet implemented"));
        }
        public function readCXFORMWITHALPHA():SWFColorTransformWithAlpha{
            return (new SWFColorTransformWithAlpha(this));
        }
        public function writeCXFORMWITHALPHA(value:SWFColorTransformWithAlpha):void{
            throw (new Error("writeCXFORMWITHALPHA() not yet implemented"));
        }
        public function readSHAPE():SWFShape{
            return (new SWFShape(this));
        }
        public function writeSHAPE(value:SWFShape):void{
        }
        public function readSHAPEWITHSTYLE(level:uint=1):SWFShapeWithStyle{
            return (new SWFShapeWithStyle(this, level));
        }
        public function readSTRAIGHTEDGERECORD(numBits:uint):SWFShapeRecordStraightEdge{
            return (new SWFShapeRecordStraightEdge(this, numBits));
        }
        public function readCURVEDEDGERECORD(numBits:uint):SWFShapeRecordCurvedEdge{
            return (new SWFShapeRecordCurvedEdge(this, numBits));
        }
        public function readSTYLECHANGERECORD(states:uint, fillBits:uint, lineBits:uint, level:uint=1):SWFShapeRecordStyleChange{
            return (new SWFShapeRecordStyleChange(this, states, fillBits, lineBits, level));
        }
        public function readFILLSTYLE(level:uint=1):SWFFillStyle{
            return (new SWFFillStyle(this, level));
        }
        public function readLINESTYLE(level:uint=1):SWFLineStyle{
            return (new SWFLineStyle(this, level));
        }
        public function readLINESTYLE2(level:uint=1):SWFLineStyle2{
            return (new SWFLineStyle2(this, level));
        }
        public function readBUTTONRECORD(level:uint=1):SWFButtonRecord{
            if (this.readUI8() == 0){
                return (null);
            };
            position--;
            return (new SWFButtonRecord(this, level));
        }
        public function readBUTTONCONDACTION():SWFButtonCondAction{
            return (new SWFButtonCondAction(this));
        }
        public function readFILTER():IFilter{
            var filterId:uint = this.readUI8();
            var filter:IFilter = SWFFilterFactory.create(filterId);
            filter.parse(this);
            return (filter);
        }
        public function readTEXTRECORD(glyphBits:uint, advanceBits:uint, previousRecord:SWFTextRecord=null, level:uint=1):SWFTextRecord{
            if (this.readUI8() == 0){
                return (null);
            };
            position--;
            return (new SWFTextRecord(this, glyphBits, advanceBits, previousRecord, level));
        }
        public function readGLYPHENTRY(glyphBits:uint, advanceBits:uint):SWFGlyphEntry{
            return (new SWFGlyphEntry(this, glyphBits, advanceBits));
        }
        public function readZONERECORD():SWFZoneRecord{
            return (new SWFZoneRecord(this));
        }
        public function readZONEDATA():SWFZoneData{
            return (new SWFZoneData(this));
        }
        public function readKERNINGRECORD(wideCodes:Boolean):SWFKerningRecord{
            return (new SWFKerningRecord(this, wideCodes));
        }
        public function readGRADIENT(level:uint=1):SWFGradient{
            return (new SWFGradient(this, level));
        }
        public function readFOCALGRADIENT(level:uint=1):SWFFocalGradient{
            return (new SWFFocalGradient(this, level));
        }
        public function readGRADIENTRECORD(level:uint=1):SWFGradientRecord{
            return (new SWFGradientRecord(this, level));
        }
        public function readMORPHFILLSTYLE(level:uint=1):SWFMorphFillStyle{
            return (new SWFMorphFillStyle(this, level));
        }
        public function readMORPHLINESTYLE(level:uint=1):SWFMorphLineStyle{
            return (new SWFMorphLineStyle(this, level));
        }
        public function readMORPHLINESTYLE2(level:uint=1):SWFMorphLineStyle2{
            return (new SWFMorphLineStyle2(this, level));
        }
        public function readMORPHGRADIENT(level:uint=1):SWFMorphGradient{
            return (new SWFMorphGradient(this, level));
        }
        public function readMORPHGRADIENTRECORD(level:uint=1):SWFMorphGradientRecord{
            return (new SWFMorphGradientRecord(this, level));
        }
        public function readACTIONRECORD():IAction{
            var action:IAction;
            var actionLength:uint;
            var actionCode:uint = this.readUI8();
            if (actionCode != 0){
                actionLength = ((actionCode)>=128) ? this.readUI16() : 0;
                action = SWFActionFactory.create(actionCode, actionLength);
                action.parse(this);
            };
            return (action);
        }
        public function writeACTIONRECORD(action:IAction):void{
            action.publish(this);
        }
        public function readACTIONVALUE():SWFActionValue{
            return (new SWFActionValue(this));
        }
        public function writeACTIONVALUE(value:SWFActionValue):void{
            value.publish(this);
        }
        public function readREGISTERPARAM():SWFRegisterParam{
            return (new SWFRegisterParam(this));
        }
        public function writeREGISTERPARAM(value:SWFRegisterParam):void{
            value.publish(this);
        }
        public function readSYMBOL():SWFSymbol{
            return (new SWFSymbol(this));
        }
        public function writeSYMBOL(value:SWFSymbol):void{
            value.publish(this);
        }
        public function readSOUNDINFO():SWFSoundInfo{
            return (new SWFSoundInfo(this));
        }
        public function readSOUNDENVELOPE():SWFSoundEnvelope{
            return (new SWFSoundEnvelope(this));
        }
        public function readCLIPACTIONS(version:uint):SWFClipActions{
            return (new SWFClipActions(this, version));
        }
        public function readCLIPACTIONRECORD(version:uint):SWFClipActionRecord{
            var pos:uint = position;
            var flags:uint = ((version)>=6) ? this.readUI32() : this.readUI16();
            if (flags == 0){
                return (null);
            };
            position = pos;
            return (new SWFClipActionRecord(this, version));
        }
        public function readCLIPEVENTFLAGS(version:uint):SWFClipEventFlags{
            return (new SWFClipEventFlags(this, version));
        }
        public function readTagHeader():SWFRecordHeader{
            var tagTypeAndLength:uint = this.readUI16();
            var tagLength:uint = (tagTypeAndLength & 63);
            if (tagLength == 63){
                tagLength = this.readSI32();
            };
            return (new SWFRecordHeader((tagTypeAndLength >> 6), tagLength));
        }
        public function writeTagHeader(type:uint, length:uint):void{
            if (length < 63){
                this.writeUI16(((type << 6) | length));
            } else {
                this.writeUI16(((type << 6) | 63));
                this.writeSI32(length);
            };
        }
        public function swfUncompress():void{
            var pos:uint = position;
            var ba:ByteArray = new ByteArray();
            readBytes(ba);
            ba.position = 0;
            ba.uncompress();
            length = (position = pos);
            writeBytes(ba);
            position = pos;
        }
        public function swfCompress():void{
            var pos:uint = position;
            var ba:ByteArray = new ByteArray();
            readBytes(ba);
            ba.position = 0;
            ba.compress();
            length = (position = pos);
            writeBytes(ba);
        }
        public function readRawTag():ByteArray{
            var raw:ByteArray;
            var pos:uint = position;
            var header:SWFRecordHeader = this.readTagHeader();
            if (header.length > 0){
                raw = new ByteArray();
                readBytes(raw, 0, header.length);
            };
            position = pos;
            return (raw);
        }
        public function skipBytes(length:uint):void{
            position = (position + length);
        }
        public function dump(length:uint, offset:int=0):void{
            var b:String;
            var addr:String;
            var pos:uint = position;
            position = (position + offset);
            var str:String = ("bitsPending: " + bitsPending);
            var i:uint;
            while (i < length) {
                b = readUnsignedByte().toString(16);
                if (b.length == 1){
                    b = ("0" + b);
                };
                if ((i % 16) == 0){
                    addr = ((pos + offset) + i).toString(16);
                    addr = ("00000000".substr(0, (8 - addr.length)) + addr);
                    str = (str + (("\r" + addr) + ": "));
                };
                b = (b + " ");
                str = (str + b);
                i++;
            };
            position = pos;
            trace(str);
        }

    }
}//package com.codeazur.as3swf 

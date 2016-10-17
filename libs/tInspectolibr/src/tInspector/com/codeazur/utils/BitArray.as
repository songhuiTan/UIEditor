//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.utils {
    import flash.utils.*;

    public class BitArray extends ByteArray {

        protected var bitsPending:uint = 0;

        public function readBits(bits:uint, bitBuffer:uint=0):uint{
            var partial:uint;
            var bitsConsumed:uint;
            var byte:uint;
            if (bits == 0){
                return (bitBuffer);
            };
            if (this.bitsPending > 0){
                byte = (this[(position - 1)] & (0xFF >> (8 - this.bitsPending)));
                bitsConsumed = Math.min(this.bitsPending, bits);
                this.bitsPending = (this.bitsPending - bitsConsumed);
                partial = (byte >> this.bitsPending);
            } else {
                bitsConsumed = Math.min(8, bits);
                this.bitsPending = (8 - bitsConsumed);
                partial = (readUnsignedByte() >> this.bitsPending);
            };
            bits = (bits - bitsConsumed);
            bitBuffer = ((bitBuffer << bitsConsumed) | partial);
            return (((bits)>0) ? this.readBits(bits, bitBuffer) : bitBuffer);
        }
        public function writeBits(bits:uint, value:uint):void{
            var bitsConsumed:uint;
            if (bits == 0){
                return;
            };
            value = (value & (4294967295 >>> (32 - bits)));
            if (this.bitsPending > 0){
                if (this.bitsPending > bits){
                    this[(position - 1)] = (this[(position - 1)] | (value << (this.bitsPending - bits)));
                    bitsConsumed = bits;
                    this.bitsPending = (this.bitsPending - bits);
                } else {
                    if (this.bitsPending == bits){
                        this[(position - 1)] = (this[(position - 1)] | value);
                        bitsConsumed = bits;
                        this.bitsPending = 0;
                    } else {
                        this[(position - 1)] = (this[(position - 1)] | (value >> (bits - this.bitsPending)));
                        bitsConsumed = this.bitsPending;
                        this.bitsPending = 0;
                    };
                };
            } else {
                bitsConsumed = Math.min(8, bits);
                this.bitsPending = (8 - bitsConsumed);
                writeByte(((value >> (bits - bitsConsumed)) << this.bitsPending));
            };
            bits = (bits - bitsConsumed);
            if (bits > 0){
                this.writeBits(bits, value);
            };
        }
        public function resetBitsPending():void{
            this.bitsPending = 0;
        }
        public function getMinBits(a:uint, b:uint=0, c:uint=0, d:uint=0):uint{
            var val:uint = (((a | b) | c) | d);
            var bits:uint = 1;
            do  {
                val = (val >>> 1);
                bits++;
            } while (val != 0);
            return (bits);
        }
        public function getMinSBits(a:int, b:int=0, c:int=0, d:int=0):uint{
            return (this.getMinBits(Math.abs(a), Math.abs(b), Math.abs(c), Math.abs(d)));
        }
        public function getMinFBits(a:Number, b:Number=0, c:Number=0, d:Number=0):uint{
            return (this.getMinSBits((a * 65536), (b * 65536), (c * 65536), (d * 65536)));
        }
        public function calculateMaxBits(signed:Boolean, ... _args):uint{
            var b:uint;
            var vmax:int = int.MIN_VALUE;
            var i:uint;
            while (i < _args.length) {
                if (_args[i] >= 0){
                    b = (b | _args[i]);
                } else {
                    b = (b | (~(_args[i]) << 1));
                };
                if (((signed) && ((vmax < _args[i])))){
                    vmax = _args[i];
                };
                i++;
            };
            var bits:uint = b.toString(2).length;
            if (((((signed) && ((vmax > 0)))) && ((vmax.toString(2).length >= bits)))){
                bits++;
            };
            return (bits);
        }

    }
}//package com.codeazur.utils 

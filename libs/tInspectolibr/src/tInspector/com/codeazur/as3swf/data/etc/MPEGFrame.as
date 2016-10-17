//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.etc {
    import flash.utils.*;

    public class MPEGFrame {

        public static const MPEG_VERSION_1_0:uint = 0;
        public static const MPEG_VERSION_2_0:uint = 1;
        public static const MPEG_VERSION_2_5:uint = 2;
        public static const MPEG_LAYER_I:uint = 0;
        public static const MPEG_LAYER_II:uint = 1;
        public static const MPEG_LAYER_III:uint = 2;
        public static const CHANNEL_MODE_STEREO:uint = 0;
        public static const CHANNEL_MODE_JOINT_STEREO:uint = 1;
        public static const CHANNEL_MODE_DUAL:uint = 2;
        public static const CHANNEL_MODE_MONO:uint = 3;

        protected static var mpegBitrates:Array = [[[0, 32, 96, 128, 160, 192, 224, 0x0100, 288, 320, 352, 384, 416, 448, -1], [0, 32, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 0x0100, 320, 384, -1], [0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 0x0100, 320, -1]], [[0, 32, 48, 56, 64, 80, 96, 112, 128, 144, 160, 176, 192, 224, 0x0100, -1], [0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, -1], [0, 8, 16, 24, 32, 40, 48, 56, 64, 80, 96, 112, 128, 144, 160, -1]]];
        protected static var mpegSamplingRates:Array = [[44100, 48000, 0x7D00], [22050, 24000, 16000], [11025, 12000, 8000]];

        protected var _version:uint;
        protected var _layer:uint;
        protected var _bitrate:uint;
        protected var _samplingRate:uint;
        protected var _padding:Boolean;
        protected var _channelMode:uint;
        protected var _channelModeExt:uint;
        protected var _copyright:Boolean;
        protected var _original:Boolean;
        protected var _emphasis:uint;
        protected var _header:ByteArray;
        protected var _data:ByteArray;
        protected var _crc:ByteArray;
        protected var _hasCRC:Boolean;
        protected var _samples:uint = 1152;

        public function MPEGFrame(){
            super();
            this.init();
        }
        public function get version():uint{
            return (this._version);
        }
        public function get layer():uint{
            return (this._layer);
        }
        public function get bitrate():uint{
            return (this._bitrate);
        }
        public function get samplingrate():uint{
            return (this._samplingRate);
        }
        public function get padding():Boolean{
            return (this._padding);
        }
        public function get channelMode():uint{
            return (this._channelMode);
        }
        public function get channelModeExt():uint{
            return (this._channelModeExt);
        }
        public function get copyright():Boolean{
            return (this._copyright);
        }
        public function get original():Boolean{
            return (this._original);
        }
        public function get emphasis():uint{
            return (this._emphasis);
        }
        public function get hasCRC():Boolean{
            return (this._hasCRC);
        }
        public function get crc():uint{
            this._crc.position = 0;
            return (this._crc.readUnsignedShort());
        }
        public function get samples():uint{
            return (this._samples);
        }
        public function get data():ByteArray{
            return (this._data);
        }
        public function set data(value:ByteArray):void{
            this._data = value;
        }
        public function get size():uint{
            var ret:uint;
            if (this.layer == MPEG_LAYER_I){
                ret = Math.floor(((12000 * this.bitrate) / this.samplingrate));
                if (this.padding){
                    ret++;
                };
                ret = (ret << 2);
            } else {
                ret = Math.floor(((((this.version)==MPEG_VERSION_1_0) ? 144000 : 72000 * this.bitrate) / this.samplingrate));
                if (this.padding){
                    ret++;
                };
            };
			var rusult:uint=((ret - 4) - uint(this.hasCRC)) ? 2 : 0;
            return rusult;//(((ret - 4) - (this.hasCRC) ? 2 : 0));
        }
        public function setHeaderByteAt(index:uint, value:uint):void{
            var _local3:uint;
            var _local4:uint;
            var _local5:uint;
            var _local6:uint;
            switch (index){
                case 0:
                    if (value != 0xFF){
                        throw (new Error("Not a MPEG header."));
                    };
                    break;
                case 1:
                    if ((value & 224) != 224){
                        throw (new Error("Not a MPEG header."));
                    };
                    _local3 = ((value & 24) >> 3);
                    switch (_local3){
                        case 3:
                            this._version = MPEG_VERSION_1_0;
                            break;
                        case 2:
                            this._version = MPEG_VERSION_2_0;
                            break;
                        default:
                            throw (new Error("Unsupported MPEG version."));
                    };
                    _local4 = ((value & 6) >> 1);
                    switch (_local4){
                        case 1:
                            this._layer = MPEG_LAYER_III;
                            break;
                        default:
                            throw (new Error("Unsupported MPEG layer."));
                    };
                    this._hasCRC = !(!(((value & 1) == 0)));
                    break;
                case 2:
                    _local5 = ((value & 240) >> 4);
                    if ((((_local5 == 0)) || ((_local5 == 15)))){
                        throw (new Error("Unsupported bitrate index."));
                    };
                    this._bitrate = mpegBitrates[this._version][this._layer][_local5];
                    _local6 = ((value & 12) >> 2);
                    if (_local6 == 3){
                        throw (new Error("Unsupported samplingrate index."));
                    };
                    this._samplingRate = mpegSamplingRates[this._version][_local6];
                    this._padding = ((value & 2) == 2);
                    break;
                case 3:
                    this._channelMode = ((value & 192) >> 6);
                    this._channelModeExt = ((value & 48) >> 4);
                    this._copyright = ((value & 8) == 8);
                    this._original = ((value & 4) == 4);
                    this._emphasis = (value & 2);
                    break;
                default:
                    throw (new Error("Index out of bounds."));
            };
            this._header[index] = value;
        }
        public function setCRCByteAt(index:uint, value:uint):void{
            if (index > 1){
                throw (new Error("Index out of bounds."));
            };
            this._crc[index] = value;
        }
        protected function init():void{
            this._header = new ByteArray();
            this._header.writeByte(0);
            this._header.writeByte(0);
            this._header.writeByte(0);
            this._header.writeByte(0);
            this._crc = new ByteArray();
            this._crc.writeByte(0);
            this._crc.writeByte(0);
        }
        public function getFrame():ByteArray{
            var ba:ByteArray = new ByteArray();
            ba.writeBytes(this._header, 0, 4);
            if (this.hasCRC){
                ba.writeBytes(this._crc, 0, 2);
            };
            ba.writeBytes(this._data);
            return (ba);
        }
        public function toString():String{
            var encoding:String = "MPEG ";
            switch (this.version){
                case MPEGFrame.MPEG_VERSION_1_0:
                    encoding = (encoding + "1.0 ");
                    break;
                case MPEGFrame.MPEG_VERSION_2_0:
                    encoding = (encoding + "2.0 ");
                    break;
                case MPEGFrame.MPEG_VERSION_2_5:
                    encoding = (encoding + "2.5 ");
                    break;
                default:
                    encoding = (encoding + "?.? ");
            };
            switch (this.layer){
                case MPEGFrame.MPEG_LAYER_I:
                    encoding = (encoding + "Layer I");
                    break;
                case MPEGFrame.MPEG_LAYER_II:
                    encoding = (encoding + "Layer II");
                    break;
                case MPEGFrame.MPEG_LAYER_III:
                    encoding = (encoding + "Layer III");
                    break;
                default:
                    encoding = (encoding + "Layer ?");
            };
            var channel:String = "unknown";
            switch (this.channelMode){
                case 0:
                    channel = "Stereo";
                    break;
                case 1:
                    channel = "Joint stereo";
                    break;
                case 2:
                    channel = "Dual channel";
                    break;
                case 3:
                    channel = "Mono";
                    break;
            };
            return ((((((((((encoding + ", ") + this.bitrate) + " kbit/s, ") + this.samplingrate) + " Hz, ") + channel) + ", ") + this.size) + " bytes"));
        }

    }
}//package com.codeazur.as3swf.data.etc 

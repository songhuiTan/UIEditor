//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import flash.utils.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.data.etc.*;

    public class TagDefineSound extends Tag implements ITag {

        public static const TYPE:uint = 14;

        public var soundId:uint;
        public var soundFormat:uint;
        public var soundRate:uint;
        public var soundSize:uint;
        public var soundType:uint;
        public var soundSampleCount:uint;
        protected var _soundData:ByteArray;

        public function TagDefineSound(){
            super();
            this._soundData = new ByteArray();
        }
        public static function create(id:uint, format:uint=2, rate:uint=3, size:uint=1, type:uint=1, sampleCount:uint=0, aSoundData:ByteArray=null):TagDefineSound{
            var defineSound:TagDefineSound = new (TagDefineSound)();
            defineSound.soundId = id;
            defineSound.soundFormat = format;
            defineSound.soundRate = rate;
            defineSound.soundSize = size;
            defineSound.soundType = type;
            defineSound.soundSampleCount = sampleCount;
            if (((!((aSoundData == null))) && ((aSoundData.length > 0)))){
                defineSound.soundData.writeBytes(aSoundData);
            };
            return (defineSound);
        }
        public static function createWithMP3(id:uint, mp3:ByteArray):TagDefineSound{
            var defineSound:TagDefineSound;
            if (((!((mp3 == null))) && ((mp3.length > 0)))){
                defineSound = new (TagDefineSound)();
                defineSound.soundId = id;
                defineSound.processMP3(mp3);
                return (defineSound);
            };
            throw (new Error("No MP3 data."));
        }

        public function get soundData():ByteArray{
            return (this._soundData);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.soundId = data.readUI16();
            this.soundFormat = data.readUB(4);
            this.soundRate = data.readUB(2);
            this.soundSize = data.readUB(1);
            this.soundType = data.readUB(1);
            this.soundSampleCount = data.readUI32();
            data.readBytes(this._soundData, 0, (length - 7));
        }
        public function publish(data:SWFData, version:uint):void{
            var body:SWFData = new SWFData();
            body.writeUI16(this.soundId);
            body.writeUB(4, this.soundFormat);
            body.writeUB(2, this.soundRate);
            body.writeUB(1, this.soundSize);
            body.writeUB(1, this.soundType);
            body.writeUI32(this.soundSampleCount);
            if (this._soundData.length > 0){
                body.writeBytes(this._soundData);
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineSound");
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((((((((((((((toStringMain(indent) + "SoundID: ") + this.soundId) + ", ") + "Format: ") + this.soundFormat) + ", ") + "Rate: ") + SoundRate.toString(this.soundRate)) + ", ") + "Size: ") + SoundSize.toString(this.soundSize)) + ", ") + "Type: ") + SoundType.toString(this.soundType)) + ", ") + "Samples: ") + this.soundSampleCount);
            return (str);
        }
        function processMP3(mp3:ByteArray):void{
            var i:uint;
            var beginIdx:uint;
            var endIdx:uint = mp3.length;
            var samples:uint;
            var firstFrame:Boolean = true;
            var bitrate:uint;
            var samplingrate:uint;
            var channelmode:uint;
            var frame:MPEGFrame = new MPEGFrame();
            var state:String = "id3v2";
            while (i < mp3.length) {
                switch (state){
                    case "id3v2":
                        if ((((((mp3[i] == 73)) && ((mp3[(i + 1)] == 68)))) && ((mp3[(i + 2)] == 51)))){
                            i = (i + (10 + ((((mp3[(i + 6)] << 21) | (mp3[(i + 7)] << 14)) | (mp3[(i + 8)] << 7)) | mp3[(i + 9)])));
                        };
                        beginIdx = i;
                        state = "sync";
                        break;
                    case "sync":
                        if ((((mp3[i] == 0xFF)) && (((mp3[(i + 1)] & 224) == 224)))){
                            state = "frame";
                        } else {
                            if ((((((mp3[i] == 84)) && ((mp3[(i + 1)] == 65)))) && ((mp3[(i + 2)] == 71)))){
                                endIdx = i;
                                i = mp3.length;
                            } else {
                                i++;
                            };
                        };
                        break;
                    case "frame":
                        var _temp1 = i;
                        i = (i + 1);
                        frame.setHeaderByteAt(0, mp3[_temp1]);
                        var _temp2 = i;
                        i = (i + 1);
                        frame.setHeaderByteAt(1, mp3[_temp2]);
                        var _temp3 = i;
                        i = (i + 1);
                        frame.setHeaderByteAt(2, mp3[_temp3]);
                        var _temp4 = i;
                        i = (i + 1);
                        frame.setHeaderByteAt(3, mp3[_temp4]);
                        if (frame.hasCRC){
                            var _temp5 = i;
                            i = (i + 1);
                            frame.setCRCByteAt(0, mp3[_temp5]);
                            var _temp6 = i;
                            i = (i + 1);
                            frame.setCRCByteAt(1, mp3[_temp6]);
                        };
                        if (firstFrame){
                            samplingrate = frame.samplingrate;
                            bitrate = frame.bitrate;
                            channelmode = frame.channelMode;
                            firstFrame = false;
                        } else {
                            if (bitrate != frame.bitrate){
                                throw (new Error("This mp3 is encoded with variable bitrates. VBR is not allowed. Please use CBR mp3s."));
                            };
                        };
                        samples = (samples + frame.samples);
                        i = (i + frame.size);
                        state = "sync";
                        break;
                };
            };
            this.soundSampleCount = samples;
            this.soundFormat = SoundCompression.MP3;
            this.soundSize = SoundSize.BIT_16;
            this.soundType = ((channelmode)==MPEGFrame.CHANNEL_MODE_MONO) ? SoundType.MONO : SoundType.STEREO;
            switch (samplingrate){
                case 44100:
                    this.soundRate = SoundRate.KHZ_44;
                    break;
                case 22050:
                    this.soundRate = SoundRate.KHZ_22;
                    break;
                case 11025:
                    this.soundRate = SoundRate.KHZ_11;
                    break;
                default:
                    throw (new Error((("Unsupported sampling rate: " + samplingrate) + " Hz")));
            };
            this.soundData.length = 0;
            this.soundData.writeShort(0);
            this.soundData.writeBytes(mp3, beginIdx, (endIdx - beginIdx));
        }

    }
}//package com.codeazur.as3swf.tags 

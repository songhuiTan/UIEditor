//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.as3swf.*;

    public class TagSoundStreamHead extends Tag implements ITag {

        public static const TYPE:uint = 18;

        public var playbackSoundRate:uint;
        public var playbackSoundSize:uint;
        public var playbackSoundType:uint;
        public var streamSoundCompression:uint;
        public var streamSoundRate:uint;
        public var streamSoundSize:uint;
        public var streamSoundType:uint;
        public var streamSoundSampleCount:uint;
        public var latencySeek:uint;

        public function TagSoundStreamHead(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            data.readUB(4);
            this.playbackSoundRate = data.readUB(2);
            this.playbackSoundSize = data.readUB(1);
            this.playbackSoundType = data.readUB(1);
            this.streamSoundCompression = data.readUB(4);
            this.streamSoundRate = data.readUB(2);
            this.streamSoundSize = data.readUB(1);
            this.streamSoundType = data.readUB(1);
            this.streamSoundSampleCount = data.readUI16();
            if (this.streamSoundCompression == SoundCompression.MP3){
                this.latencySeek = data.readSI16();
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("SoundStreamHead");
        }
        public function toString(indent:uint=0):String{
            var str:String = toStringMain(indent);
            str = (str + "Playback: (");
            str = (str + (SoundRate.toString(this.playbackSoundRate) + ","));
            str = (str + (SoundSize.toString(this.playbackSoundSize) + ","));
            str = (str + (SoundType.toString(this.playbackSoundType) + "), "));
            str = (str + "Streaming: (");
            str = (str + (SoundCompression.toString(this.streamSoundCompression) + ","));
            str = (str + (SoundRate.toString(this.streamSoundRate) + ","));
            str = (str + (SoundSize.toString(this.streamSoundSize) + ","));
            str = (str + (SoundType.toString(this.streamSoundType) + "), "));
            str = (str + ("Samples: " + this.streamSoundSampleCount));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

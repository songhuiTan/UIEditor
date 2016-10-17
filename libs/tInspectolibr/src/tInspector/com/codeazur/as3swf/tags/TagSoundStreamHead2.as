//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.data.consts.*;

    public class TagSoundStreamHead2 extends TagSoundStreamHead implements ITag {

        public static const TYPE:uint = 45;

        public function TagSoundStreamHead2(){
            super();
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("SoundStreamHead2");
        }
        override public function toString(indent:uint=0):String{
            var str:String = toStringMain(indent);
            str = (str + "Playback: (");
            str = (str + (SoundRate.toString(playbackSoundRate) + ","));
            str = (str + (SoundSize.toString(playbackSoundSize) + ","));
            str = (str + (SoundType.toString(playbackSoundType) + "), "));
            str = (str + "Streaming: (");
            str = (str + (SoundCompression.toString(streamSoundCompression) + ","));
            str = (str + (SoundRate.toString(streamSoundRate) + ","));
            str = (str + (SoundSize.toString(streamSoundSize) + ","));
            str = (str + (SoundType.toString(streamSoundType) + "), "));
            str = (str + ("Samples: " + streamSoundSampleCount));
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

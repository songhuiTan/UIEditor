//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.utils.*;

    public class TagDefineSceneAndFrameLabelData extends Tag implements ITag {

        public static const TYPE:uint = 86;

        protected var _scenes:Vector.<SWFScene>;
        protected var _frameLabels:Vector.<SWFFrameLabel>;

        public function TagDefineSceneAndFrameLabelData(){
            super();
            this._scenes = new Vector.<SWFScene>();
            this._frameLabels = new Vector.<SWFFrameLabel>();
        }
        public function get scenes():Vector.<SWFScene>{
            return (this._scenes);
        }
        public function get frameLabels():Vector.<SWFFrameLabel>{
            return (this._frameLabels);
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            var i:uint;
            var sceneOffset:uint;
            var sceneName:String;
            var frameNumber:uint;
            var frameLabel:String;
            var sceneCount:uint = data.readEncodedU32();
            i = 0;
            while (i < sceneCount) {
                sceneOffset = data.readEncodedU32();
                sceneName = data.readString();
                this._scenes.push(new SWFScene(sceneOffset, sceneName));
                i++;
            };
            var frameLabelCount:uint = data.readEncodedU32();
            i = 0;
            while (i < frameLabelCount) {
                frameNumber = data.readEncodedU32();
                frameLabel = data.readString();
                this._frameLabels.push(new SWFFrameLabel(frameNumber, frameLabel));
                i++;
            };
        }
        public function publish(data:SWFData, version:uint):void{
            var i:uint;
            var scene:SWFScene;
            var label:SWFFrameLabel;
            var body:SWFData = new SWFData();
            body.writeEncodedU32(this.scenes.length);
            i = 0;
            while (i < this.scenes.length) {
                scene = this.scenes[i];
                body.writeEncodedU32(scene.offset);
                body.writeString(scene.name);
                i++;
            };
            body.writeEncodedU32(this.frameLabels.length);
            i = 0;
            while (i < this.frameLabels.length) {
                label = this.frameLabels[i];
                body.writeEncodedU32(label.frameNumber);
                body.writeString(label.name);
                i++;
            };
            data.writeTagHeader(this.type, body.length);
            data.writeBytes(body);
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineSceneAndFrameLabelData");
        }
        public function toString(indent:uint=0):String{
            var i:uint;
            var str:String = toStringMain(indent);
            if (this._scenes.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "Scenes:"));
                i = 0;
                while (i < this._scenes.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._scenes[i].toString()));
                    i++;
                };
            };
            if (this._frameLabels.length > 0){
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + "FrameLabels:"));
                i = 0;
                while (i < this._frameLabels.length) {
                    str = (str + ((((("\n" + StringUtils.repeat((indent + 4))) + "[") + i) + "] ") + this._frameLabels[i].toString()));
                    i++;
                };
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

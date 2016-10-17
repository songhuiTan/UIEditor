//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;

    public class TagDefineButtonSound extends Tag implements ITag {

        public static const TYPE:uint = 17;

        public var buttonId:uint;
        public var buttonSoundChar0:uint;
        public var buttonSoundChar1:uint;
        public var buttonSoundChar2:uint;
        public var buttonSoundChar3:uint;
        public var buttonSoundInfo0:SWFSoundInfo;
        public var buttonSoundInfo1:SWFSoundInfo;
        public var buttonSoundInfo2:SWFSoundInfo;
        public var buttonSoundInfo3:SWFSoundInfo;

        public function TagDefineButtonSound(){
            super();
        }
        public function parse(data:SWFData, length:uint, version:uint):void{
            this.buttonId = data.readUI16();
            this.buttonSoundChar0 = data.readUI16();
            if (this.buttonSoundChar0 != 0){
                this.buttonSoundInfo0 = data.readSOUNDINFO();
            };
            this.buttonSoundChar1 = data.readUI16();
            if (this.buttonSoundChar1 != 0){
                this.buttonSoundInfo1 = data.readSOUNDINFO();
            };
            this.buttonSoundChar2 = data.readUI16();
            if (this.buttonSoundChar2 != 0){
                this.buttonSoundInfo2 = data.readSOUNDINFO();
            };
            this.buttonSoundChar3 = data.readUI16();
            if (this.buttonSoundChar3 != 0){
                this.buttonSoundInfo3 = data.readSOUNDINFO();
            };
        }
        public function publish(data:SWFData, version:uint):void{
            throw (new Error("TODO: implement publish()"));
        }
        override public function get type():uint{
            return (TYPE);
        }
        override public function get name():String{
            return ("DefineButtonSound");
        }
        public function toString(indent:uint=0):String{
            var str:String = (((((((((((toStringMain(indent) + "ButtonID: ") + this.buttonId) + ", ") + "ButtonSoundChars: ") + this.buttonSoundChar0) + ",") + this.buttonSoundChar1) + ",") + this.buttonSoundChar2) + ",") + this.buttonSoundChar3);
            return (str);
        }

    }
}//package com.codeazur.as3swf.tags 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import tInspector.com.codeazur.as3swf.*;

    public class SWFClipEventFlags {

        public var keyUpEvent:Boolean;
        public var keyDownEvent:Boolean;
        public var mouseUpEvent:Boolean;
        public var mouseDownEvent:Boolean;
        public var mouseMoveEvent:Boolean;
        public var unloadEvent:Boolean;
        public var enterFrameEvent:Boolean;
        public var loadEvent:Boolean;
        public var dragOverEvent:Boolean;
        public var rollOutEvent:Boolean;
        public var rollOverEvent:Boolean;
        public var releaseOutsideEvent:Boolean;
        public var releaseEvent:Boolean;
        public var pressEvent:Boolean;
        public var initializeEvent:Boolean;
        public var dataEvent:Boolean;
        public var constructEvent:Boolean;
        public var keyPressEvent:Boolean;
        public var dragOutEvent:Boolean;

        public function SWFClipEventFlags(data:SWFData=null, version:uint=0){
            super();
            if (data != null){
                this.parse(data, version);
            };
        }
        public function parse(data:SWFData, version:uint):void{
            var flags3:uint;
            var flags1:uint = data.readUI8();
            this.keyUpEvent = !(((flags1 & 128) == 0));
            this.keyDownEvent = !(((flags1 & 64) == 0));
            this.mouseUpEvent = !(((flags1 & 32) == 0));
            this.mouseDownEvent = !(((flags1 & 16) == 0));
            this.mouseMoveEvent = !(((flags1 & 8) == 0));
            this.unloadEvent = !(((flags1 & 4) == 0));
            this.enterFrameEvent = !(((flags1 & 2) == 0));
            this.loadEvent = !(((flags1 & 1) == 0));
            var flags2:uint = data.readUI8();
            this.dragOverEvent = !(((flags2 & 128) == 0));
            this.rollOutEvent = !(((flags2 & 64) == 0));
            this.rollOverEvent = !(((flags2 & 32) == 0));
            this.releaseOutsideEvent = !(((flags2 & 16) == 0));
            this.releaseEvent = !(((flags2 & 8) == 0));
            this.pressEvent = !(((flags2 & 4) == 0));
            this.initializeEvent = !(((flags2 & 2) == 0));
            this.dataEvent = !(((flags2 & 1) == 0));
            if (version >= 6){
                flags3 = data.readUI8();
                this.constructEvent = !(((flags3 & 4) == 0));
                this.keyPressEvent = !(((flags3 & 2) == 0));
                this.dragOutEvent = !(((flags3 & 1) == 0));
                data.readUI8();
            };
        }
        public function toString():String{
            var a:Array = [];
            if (this.keyUpEvent){
                a.push("keyup");
            };
            if (this.keyDownEvent){
                a.push("keydown");
            };
            if (this.mouseUpEvent){
                a.push("mouseup");
            };
            if (this.mouseDownEvent){
                a.push("mousedown");
            };
            if (this.mouseMoveEvent){
                a.push("mousemove");
            };
            if (this.unloadEvent){
                a.push("unload");
            };
            if (this.enterFrameEvent){
                a.push("enterframe");
            };
            if (this.loadEvent){
                a.push("load");
            };
            if (this.dragOverEvent){
                a.push("dragover");
            };
            if (this.rollOutEvent){
                a.push("rollout");
            };
            if (this.rollOverEvent){
                a.push("rollover");
            };
            if (this.releaseOutsideEvent){
                a.push("releaseoutside");
            };
            if (this.releaseEvent){
                a.push("release");
            };
            if (this.pressEvent){
                a.push("press");
            };
            if (this.initializeEvent){
                a.push("initialize");
            };
            if (this.dataEvent){
                a.push("data");
            };
            if (this.constructEvent){
                a.push("construct");
            };
            if (this.keyPressEvent){
                a.push("keypress");
            };
            if (this.dragOutEvent){
                a.push("dragout");
            };
            return (a.join(","));
        }

    }
}//package com.codeazur.as3swf.data 

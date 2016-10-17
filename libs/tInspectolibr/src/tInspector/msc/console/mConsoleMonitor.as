//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.console {
    import flash.events.*;
    import tInspector.msc.events.*;
    import flash.text.*;
    import flash.display.*;
    import flash.net.*;
    import tInspector.itamt.utils.*;
    import tInspector.msc.input.*;
    import tInspector.msc.display.*;

    public class mConsoleMonitor extends mSprite {

        public static const VERSION:String = "mConsoleMonitor 1.0 beta";

        protected var _conn:LocalConnection;
        protected var _log:mConsoleHistoryView;
        protected var _cmd:mCmdTextInput;
        private var _initStageW:Number;
        private var _initStageH:Number;
        private var _ids:Array;
        public var proxy;

        public function mConsoleMonitor(){
            super();
            this._ids = [];
        }
        override protected function init():void{
            super.init();
            this._initStageW = this.stage.stageWidth;
            this._initStageH = this.stage.stageHeight;
            this._log = new mConsoleHistoryView();
            this._log.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
            addChild(this._log);
            this._cmd = new mCmdTextInput();
            this._cmd.addEventListener(mTextEvent.ENTER, this.onCmdEnter);
            addChild(this._cmd);
            var tfm:* = new TextFormat("Verdana", null, 0xFFFFFF);
            tfm.leftMargin = (tfm.rightMargin = 4);
            tfm.leading = 4;
            this._log.defaultTextFormat = (this._cmd.defaultTextFormat = tfm);
            this.stage.scaleMode = StageScaleMode.NO_SCALE;
            this.stage.align = StageAlign.TOP_LEFT;
            this.stage.addEventListener(Event.RESIZE, this.onStageResize);
            this._conn = new LocalConnection();
            this._conn.allowInsecureDomain("*");
            this._conn.allowDomain("*");
            this._conn.client = this;
            try {
                this._conn.connect(mConsoleConnName.CLIENT);
            } catch(e:Error) {
                return;
            };
            Debug.trace("[mConsoleMonitor][init]");
            this._conn.addEventListener(StatusEvent.STATUS, this.onStatus);
            this._conn.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onSecurityError);
            this._conn.addEventListener(AsyncErrorEvent.ASYNC_ERROR, this.onAsyncError);
            this.addLog(new mConsoleLog(VERSION, mConsoleLogType.CONSOLE));
            this.stage.focus = this._cmd.textField;
        }
        override public function relayout():void{
            this._log.setPos(5, 5);
            this._cmd.setPos(5, ((this.stage.stageHeight - this._cmd.height) - 5));
            this._log.setSize((this.stage.stageWidth - 10), ((this.stage.stageHeight - this._cmd.height) - 16));
            this._cmd.setSize((this.stage.stageWidth - 10));
        }
        override protected function destroy():void{
            this._log = null;
            this._cmd = null;
            this._conn = null;
            super.destroy();
        }
        private function onStatus(event:StatusEvent):void{
            switch (event.level){
                case "status":
                    break;
                case "error":
                    break;
            };
        }
        private function onSecurityError(evt:SecurityErrorEvent):void{
            this.addLog(new mConsoleLog(evt.text, mConsoleLogType.ERROR));
        }
        private function onAsyncError(evt:AsyncErrorEvent):void{
            this.addLog(new mConsoleLog(evt.text, mConsoleLogType.ERROR));
        }
        private function onStageResize(evt:Event):void{
            this.relayout();
        }
        private function onCmdEnter(evt:mTextEvent):void{
            if ((((evt.text == "")) || ((evt.text == null)))){
                return;
            };
            this.callFun(evt.text);
        }
        private function onKeyUp(evt:KeyboardEvent):void{
            if (evt.keyCode == KeyCode.DELETE){
                this._log.clear();
            };
        }
        public function buildConnection(id:String):void{
            if (this._ids.indexOf(id) < 0){
                this._ids.push(id);
                Debug.trace(("[mConsoleMonitor][buildConnection]" + mConsoleConnName.getConsoleConnName(id)));
                this._conn.send(mConsoleConnName.getConsoleConnName(id), "onBuildConnection");
            };
        }
        public function deconstructConnection(id:String):void{
            var t:int = this._ids.indexOf(id);
            if (t >= 0){
                this._ids.splice(t, 1);
                Debug.trace(("[mConsoleMonitor][deconstructConnection]" + mConsoleConnName.getConsoleConnName(id)));
                this._conn.send(mConsoleConnName.getConsoleConnName(id), "onDeconstructConnection");
            };
        }
        public function deconstructAllConnections():void{
            var id:String;
            for each (id in this._ids) {
                this.deconstructConnection(id);
            };
        }
        public function addToCmdDictionary(word:String, id:String):void{
            this._cmd.addToDictionary(word);
        }
        public function addLog(log:mConsoleLog):void{
            this._log.appendHtmlText(mConsoleLogStyle.buildLogStyleStr(log));
            this._log.fixDefaultTextFormat();
            this._log.scrollVBottom();
        }
        public function addLogMessage(msg:String, type:uint=1, id:String=null):void{
            this.addLog(new mConsoleLog(msg, type));
        }
        public function callFun(fun:String, id:String=null):void{
            this.addLog(new mConsoleLog(fun));
            var i:int;
            while (i < this._ids.length) {
                Debug.trace(((("[mConsoleMonitor][callFun]" + mConsoleConnName.getConsoleConnName(this._ids[i])) + ", ") + fun));
                this._conn.send(mConsoleConnName.getConsoleConnName(this._ids[i]), "executeCmdLine", fun);
                i++;
            };
        }
        public function callProxyFun(fun:String, ... _args):void{
            var fun:* = fun;
            var paras:* = _args;
            Debug.trace(("[mConsoleMonitor][callProxyFun]" + fun));
            if (this.proxy){
                if (!(this.proxy["hasOwnProperty"](fun))){
                    return;
                };
                try {
                    (this.proxy[fun] as Function).apply(this.proxy, paras);
                } catch(e:Error) {
                };
            };
        }

    }
}//package msc.console 

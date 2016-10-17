//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import tInspector.itamt.utils.*;
    import flash.text.*;

    public class ErrorInfoPanel extends InspectorViewPanel {

        public var info:TextField;
        public var errorLog:ErrorLog;

        public function ErrorInfoPanel(errorLog:ErrorLog, title:String="错误", w:Number=200, h:Number=200, autoDisposeWhenRemove:Boolean=true, resizeable:Boolean=true, closeable:Boolean=true){
            this.errorLog = errorLog;
            this.info = InspectorTextField.create(errorLog.toString(), 0xFF0000, 12, 0, 0);
            this.info.multiline = (this.info.wordWrap = true);
            this.info.htmlText = this.getErrorLogStr();
            this.info.width = 250;
            this.info.height = ((this.info.textHeight > 180)) ? 180 : (this.info.textHeight + 4);
            w = (this.info.width + 20);
            h = (this.info.height + 33);
            super(title, w, h, autoDisposeWhenRemove, resizeable, closeable);
            this.setContent(this.info);
        }
        override public function relayout():void{
            this.info.width = ((_width - _padding.left) - _padding.right);
            this.info.height = (this.info.textHeight + 4);
            if (this.needHScroller()){
                this.info.width = (((_width - _padding.left) - _padding.right) - 16);
                this.info.height = (this.info.textHeight + 4);
            };
            super.relayout();
        }
        public function getErrorLogStr():String{
            var err:Error;
            var evt:ErrorEvent;
            var str:String = "";
            str = (str + (((((((("<font color='#CC5200'>[" + this.errorLog.date.toLocaleTimeString()) + "]</font>") + "<font color='#CC5200'>[") + TimeFormat.toTimeString((this.errorLog.time / 1000), TimeFormat.ENGLISH_FULL_TIME)) + ",") + (this.errorLog.time % 1000)) + "]") + "</font><br>"));
            str = (str + "<font color='#ffcc00'>");
            if (this.errorLog.type == ErrorLogType.ERROR){
                err = (this.errorLog.error as Error);
                str = (str + (err.getStackTrace() + "<br>"));
            } else {
                if (this.errorLog.type == ErrorLogType.ERROR_EVENT){
                    evt = (this.errorLog.error as ErrorEvent);
                    str = (str + evt.toString());
                } else {
                    str = (str + String(this.errorLog.error));
                };
            };
            str = (str + "</font>");
            return (str);
        }
        override public function dispose():void{
            this.errorLog = null;
            super.dispose();
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import tInspector.itamt.utils.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.events.*;

    public class BugReportPanel extends InspectorViewPanel {

        public function BugReportPanel(w:Number=315, h:Number=150){
            super(("tInspector " + Inspector.VERSION), w, h);
            bg.filters = null;
            filters = [new GlowFilter(0, 1, 16, 16, 1)];
            var tf:TextField = InspectorTextField.create("", 0xFFFFFF, 12);
            var css:StyleSheet = new StyleSheet();
            css.setStyle("a:hover", {
                color:"#ff0000",
                textDecoration:"underline"
            });
            css.setStyle("a", {color:"#99cc00"});
            tf.styleSheet = css;
            tf.width = ((_width - _padding.left) - _padding.right);
            tf.wordWrap = (tf.multiline = true);
            tf.htmlText = "<br>authors: <font color=\"#99cc00\">itamt@qq.com  pethan@qq.vip.com</font><br><br>project: <a href=\"http://code.google.com/p/tinspector/\">tInspector on Google Code</a><br><br>more info: <a href=\"http://www.itamt.org/blog\">www.itamt.org</a>";
            tf.height = (tf.textHeight + 6);
            this.setContent(tf);
            this._title.mouseEnabled = (this._title.mouseWheelEnabled = false);
        }
        override protected function onClickClose(evt:Event):void{
            if (this.stage){
                this.parent.removeChild(this);
            };
        }

    }
}//package cn.itamt.utils.inspector.ui 

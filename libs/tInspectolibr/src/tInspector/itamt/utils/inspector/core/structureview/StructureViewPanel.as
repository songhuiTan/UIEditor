//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.structureview {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.text.*;
    import flash.events.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.output.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.events.*;

    public class StructureViewPanel extends InspectorViewPanel {

        public var statusOutputer:DisplayObjectInfoOutPuter;
        private var _statusInfo:TextField;
        private var bugBtn:InspectorViewBugButton;
        private var refreshBtn:InspectorViewRefreshButton;
        private var _inspectObject:DisplayObject;

        public function StructureViewPanel(w:Number=200, h:Number=200){
            super("Structure", w, h);
            _padding = new Padding(33, 10, 30, 10);
            this._statusInfo = InspectorTextField.create("", 0xCCCCCC, 12);
            this._statusInfo.selectable = false;
            this._statusInfo.height = 20;
            var styleSheet:StyleSheet = new StyleSheet();
            styleSheet.setStyle("a:hover", {textDecoration:"underline"});
            styleSheet.setStyle("a", {color:"#99cc00"});
            _title.styleSheet = styleSheet;
            addChild(this._statusInfo);
            this.bugBtn = new InspectorViewBugButton();
            this.bugBtn.addEventListener(MouseEvent.CLICK, this.onClickBug);
            addChild(this.bugBtn);
            this.refreshBtn = new InspectorViewRefreshButton();
            this.refreshBtn.addEventListener(MouseEvent.CLICK, this.onClickRefresh);
            addChild(this.refreshBtn);
        }
        override public function relayout():void{
            super.relayout();
            this.bugBtn.x = ((_width - this._padding.right) - this.bugBtn.width);
            this.bugBtn.y = ((_height - 5) - this.bugBtn.height);
            this.refreshBtn.x = ((this.resizeBtn.x - this.resizeBtn.width) - 2);
            this.refreshBtn.y = 5;
            this.drawStatus();
        }
        private function drawStatus():void{
            this._statusInfo.width = (this._statusInfo.textWidth + 4);
            if (this._statusInfo.width > ((_width - _padding.left) - _padding.right)){
                this._statusInfo.width = ((_width - _padding.left) - _padding.right);
            };
            this._statusInfo.x = _padding.left;
            this._statusInfo.y = ((_height - (_padding.bottom / 2)) - (this._statusInfo.height / 2));
        }
        override protected function drawTitle():void{
            _title.x = _padding.left;
            _title.y = 7;
            _title.width = (_title.textWidth + 4);
            if (_title.width > ((this.refreshBtn.x - _padding.left) - 3)){
                _title.width = ((this.refreshBtn.x - _padding.left) - 3);
            };
        }
        override public function open():void{
            super.open();
            this._statusInfo.visible = true;
            this.bugBtn.visible = true;
        }
        override public function hide():void{
            super.hide();
            this._statusInfo.visible = false;
            this.bugBtn.visible = false;
        }
        public function get inspectObject():DisplayObject{
            return (this._inspectObject);
        }
        public function onInspect(object:DisplayObject):void{
            this._inspectObject = object;
            _title.htmlText = this.getChainInfoStr(object);
            this.drawTitle();
            this.updateStatus();
        }
        public function onLiveInspect(object:DisplayObject):void{
            this._inspectObject = object;
            this.updateStatus();
        }
        private function updateStatus():void{
            if (this.statusOutputer == null){
                this.statusOutputer = new DisplayObjectChildrenInfoOutputer();
            };
            this._statusInfo.htmlText = this.statusOutputer.output(this._inspectObject);
            this.drawStatus();
        }
        private function getChainInfoStr(child:DisplayObject, level:uint=0):String{
            var str:String = (((("<a href=\"event:" + level) + "\">") + ClassTool.getShortClassName(child)) + "</a>");
            if (child.parent){
                var _temp1 = str;
                level = (level + 1);
                str = (_temp1 + ("<font color=\"#cccccc\">-></font>" + this.getChainInfoStr(child.parent, level)));
            };
            return (str);
        }
        private function onClickBug(evt:MouseEvent=null):void{
            var panel:BugReportPanel;
            if (this.stage){
                panel = new BugReportPanel();
                this.stage.addChild(panel);
                InspectorStageReference.centerOnStage(panel);
            };
        }
        private function onClickRefresh(evt:MouseEvent=null):void{
            evt.stopImmediatePropagation();
            dispatchEvent(new Event(InspectEvent.REFRESH));
        }

    }
}//package cn.itamt.utils.inspector.core.structureview 

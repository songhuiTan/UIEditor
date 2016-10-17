//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.swfinfo {
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.core.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.inspector.core.propertyview.accessors.*;
    import tInspector.itamt.utils.inspector.core.propertyview.*;

    public class SwfInfoView extends BaseInspectorPlugin {

        private var panels:Array;
        protected var panel:SwfInfoViewPanel;
        protected var swf:SWFInfo;

        public function SwfInfoView(){
            super();
        }
        override public function getPluginId():String{
            return (InspectorPluginId.SWFINFO_VIEW);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new SwfInfoButton();
        }
        override public function contains(child:DisplayObject):Boolean{
            var l:int;
            var i:int;
            if (this.panels){
                l = this.panels.length;
                i = 0;
                while (i < l) {
                    if ((((this.panels[i] == child)) || (this.panels[i].contains(child)))){
                        return (true);
                    };
                    i++;
                };
            };
            return (false);
        }
        override public function onActive():void{
            super.onActive();
            if (this.swf == null){
                this.swf = new SWFInfo(this._inspector.root);
            };
            if (this.panels == null){
                this.panels = [];
            };
            this.panel = new SwfInfoViewPanel(InspectorLanguageManager.getStr(InspectorPluginId.SWFINFO_VIEW));
            this.panel.addEventListener(Event.CLOSE, this.onClickClose, false, 0, true);
            this.panel.addEventListener(PropertyEvent.UPDATE, this.onPropertyUpdate);
            this._inspector.stage.addChild(this.panel);
            this.panel.onInspect(this.swf);
            this.panels.push(this.panel);
            InspectorStageReference.centerOnStage(this.panel);
            this._inspector.stage.addEventListener(PropertyEvent.INSPECT, this.onInspectProperty);
        }
        private function onInspectProperty(evt:PropertyEvent):void{
            var accessor:PropertyAccessorRender;
            var target:*;
            var panel:PropertyPanel;
            if ((evt.target is ObjectPropertyEditor)){
                accessor = ((evt.target as ObjectPropertyEditor).parent as PropertyAccessorRender);
                target = (evt.target as ObjectPropertyEditor).getValue();
                for each (panel in this.panels) {
                    if (!((panel is DisplayObjectPropertyPanel))){
                        if (panel.getSingleMode()){
                            panel.onInspect((evt.target as ObjectPropertyEditor).getValue());
                            return;
                        };
                    };
                };
                panel = new PropertyPanel(240, 170, accessor);
                this.panels.push(panel);
                panel.addEventListener(Event.CLOSE, this.onClickClose, false, 0, true);
                this._inspector.stage.addChild(panel);
                panel.onInspect(target);
                InspectorStageReference.centerOnStage(panel);
            };
        }
        private function onPropertyUpdate(event:PropertyEvent):void{
            this.panel.onInspect(this.swf);
        }
        override public function onUnActive():void{
            var panel:PropertyPanel;
            if (this.panels){
                for each (panel in this.panels) {
                    if (panel.stage){
                        panel.parent.removeChild(panel);
                    };
                };
            };
            this.panels = null;
            if (this.panel.stage){
                this.panel.parent.removeChild(this.panel);
            };
            this._inspector.stage.removeEventListener(PropertyEvent.INSPECT, this.onInspectProperty);
            this.panel = null;
            super.onUnActive();
        }
        private function onClickClose(evt:Event):void{
            var panel:PropertyPanel = (evt.target as PropertyPanel);
            var t:int = this.panels.indexOf(panel);
            if (t > -1){
                this.panels.splice(t, 1);
                this._inspector.stage.removeChild(panel);
            };
            if (this.panels.length == 0){
                this._inspector.pluginManager.unactivePlugin(InspectorPluginId.SWFINFO_VIEW);
            };
        }

    }
}//package cn.itamt.utils.inspector.plugins.swfinfo 

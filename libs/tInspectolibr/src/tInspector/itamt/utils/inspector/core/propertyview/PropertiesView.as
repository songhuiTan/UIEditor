//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview {
    import tInspector.itamt.utils.inspector.output.*;
    import tInspector.itamt.utils.inspector.plugins.*;
    import tInspector.itamt.utils.inspector.core.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.popup.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.core.propertyview.accessors.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class PropertiesView extends BaseInspectorPlugin {

        private var panels:Array;

        public function PropertiesView(){
            super();
        }
        override public function set outputerManager(value:InspectorOutPuterManager):void{
            trace("[PropertiesView][outputerManager]PropertiesView没有设计信息输出的接口，忽略该属性设置。");
        }
        override public function getPluginId():String{
            return (InspectorPluginId.PROPER_VIEW);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new PropertiesViewButton();
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
            if (this.panels == null){
                this.panels = [];
            };
            var panel:DisplayObjectPropertyPanel = new DisplayObjectPropertyPanel();
            this.panels.push(panel);
            InspectorPopupManager.popup(panel, PopupAlignMode.CENTER);
            panel.addEventListener(Event.CLOSE, this.onClickClose, false, 0, true);
            panel.addEventListener(PropertyEvent.UPDATE, this.onPropertyUpdate);
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
        override public function onUnActive():void{
            var panel:DisplayObjectPropertyPanel;
            super.onUnActive();
            if (this.panels){
                for each (panel in this.panels) {
                    InspectorPopupManager.remove(panel);
                };
            };
            this.panels = null;
            this._inspector.stage.removeEventListener(PropertyEvent.INSPECT, this.onInspectProperty);
        }
        override public function onInspect(target:InspectTarget):void{
            var panel:PropertyPanel;
            super.onInspect(target);
            for each (panel in this.panels) {
                if ((panel is DisplayObjectPropertyPanel)){
                    if (panel.getSingleMode()){
                        panel.onInspect(target.displayObject);
                        return;
                    };
                };
            };
            panel = new DisplayObjectPropertyPanel();
            this.panels.push(panel);
            this._inspector.stage.addChild(panel);
            panel.addEventListener(Event.CLOSE, this.onClickClose, false, 0, true);
            panel.addEventListener(PropertyEvent.UPDATE, this.onPropertyUpdate);
            panel.onInspect(target.displayObject);
        }
        override public function onLiveInspect(target:InspectTarget):void{
        }
        override public function onUpdate(target:InspectTarget=null):void{
            var panel:PropertyPanel;
            for each (panel in this.panels) {
                if (((panel.getSingleMode()) || ((panel.getCurTarget() == target.displayObject)))){
                    panel.onInspect(target.displayObject);
                };
            };
        }
        private function onPropertyUpdate(event:PropertyEvent):void{
            this._inspector.updateInsectorView();
        }
        private function onClickClose(evt:Event):void{
            var panel:PropertyPanel = (evt.target as PropertyPanel);
            var t:int = this.panels.indexOf(panel);
            if (t > -1){
                this.panels.splice(t, 1);
                InspectorPopupManager.remove(panel);
            };
            if (this.panels.length == 0){
                this._inspector.pluginManager.unactivePlugin(InspectorPluginId.PROPER_VIEW);
            };
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview 

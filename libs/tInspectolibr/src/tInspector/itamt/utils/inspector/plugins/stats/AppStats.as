//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.stats {
    import tInspector.itamt.utils.inspector.plugins.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.core.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.geom.*;

    public class AppStats extends BaseInspectorPlugin {

        private var panel:AppStatsViewPanel;

        public function AppStats(){
            super();
        }
        override public function getPluginId():String{
            return (InspectorPluginId.APPSTATS_VIEW);
        }
        override public function contains(child:DisplayObject):Boolean{
            if (this.panel){
                return ((((this.panel == child)) || (this.panel.contains(child))));
            };
            return (false);
        }
        override public function onRegister(inspector:IInspector):void{
            super.onRegister(inspector);
            _icon = new AppStatsButton();
        }
        override public function onActive():void{
            super.onActive();
            this.panel = new AppStatsViewPanel("");
            this.panel.addEventListener(Event.CLOSE, this.onClickClose, false, 0, true);
            this._inspector.stage.addChild(this.panel);
            var rect:Rectangle = InspectorStageReference.getStageBounds();
            this.panel.x = ((rect.right - this.panel.width) - 10);
            this.panel.y = (rect.top + 10);
        }
        override public function onUnActive():void{
            super.onUnActive();
            if (this.panel.stage){
                this.panel.parent.removeChild(this.panel);
            };
            this.panel = null;
        }
        private function onClickClose(evt:Event):void{
            this._inspector.pluginManager.unactivePlugin(InspectorPluginId.APPSTATS_VIEW);
        }

    }
}//package cn.itamt.utils.inspector.plugins.stats 

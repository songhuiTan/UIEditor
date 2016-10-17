//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.download {
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.core.propertyview.accessors.*;
    import flash.net.*;
    import flash.system.*;
    import tInspector.itamt.utils.inspector.core.propertyview.*;

    public class DownloadedStuffInfoPanel extends PropertyPanel {

        public function DownloadedStuffInfoPanel(w:Number=300, h:Number=200){
            super(w, h, null, false);
            this.title = InspectorLanguageManager.getStr("LoadedStuffInfo");
            this.removeChild(this.singletonBtn);
            this.removeChild(this.refreshBtn);
            this.search.visible = false;
            this.viewMethodBtn.active = (this.viewPropBtn.active = false);
            this.viewMethodBtn.label = InspectorLanguageManager.getStr("SaveAs");
            this.viewPropBtn.label = InspectorLanguageManager.getStr("CopyUrl");
            this.viewMethodBtn.tip = InspectorLanguageManager.getStr("SaveAsTip");
            this.viewPropBtn.tip = InspectorLanguageManager.getStr("CopyUrlTip");
        }
        override protected function onClickFull(evt:MouseEvent=null):void{
            if (evt){
                evt.stopImmediatePropagation();
            };
            this.drawList();
        }
        override protected function drawPropList():void{
            var l:int;
            var i:int;
            var render:PropertyAccessorRender;
            list.graphics.clear();
            list.graphics.lineTo(0, 0);
            while (list.numChildren) {
                list.removeChildAt(0);
            };
            if (propList){
                l = propList.length;
                i = 0;
                while (i < l) {
                    render = new PropertyAccessorRender(200, 20, false, this.owner, this.favoritable);
                    render.setXML(this.curTarget, propList[i]);
                    render.y = (list.height + 4);
                    list.addChild(render);
                    i++;
                };
            };
        }
        override protected function onViewMethod(event:MouseEvent):void{
            navigateToURL(new URLRequest((this.curTarget as LoadedStuffInfo).url), "_blank");
        }
        override protected function onViewProp(event:MouseEvent):void{
            System.setClipboard((this.curTarget as LoadedStuffInfo).url);
        }

    }
}//package cn.itamt.utils.inspector.firefox.download 

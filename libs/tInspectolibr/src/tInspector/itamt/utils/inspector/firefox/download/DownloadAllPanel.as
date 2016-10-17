//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.download {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.firefox.reloadapp.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class DownloadAllPanel extends InspectorViewPanel {

        private var _listContainer:Sprite;
        private var _data:Array;
        private var _itemRenderer:Class;
        private var _clearBtn:ReloadButton;
        private var _sortOnDomain:Boolean = true;

        public function DownloadAllPanel(title:String="resources list", w:Number=340, h:Number=200, autoDisposeWhenRemove:Boolean=true, resizeable:Boolean=true, closeable:Boolean=true){
            this._itemRenderer = LoadedStuffItemRenderer;
            super(title, w, h, autoDisposeWhenRemove, resizeable, closeable);
            this._listContainer = new Sprite();
            this.setContent(this._listContainer);
            this._clearBtn = new ReloadButton();
            this._clearBtn.tip = InspectorLanguageManager.getStr("Clear");
            this._clearBtn.addEventListener(MouseEvent.CLICK, this.onClickClear);
        }
        override public function relayout():void{
            super.relayout();
            this._clearBtn.x = ((this.resizeBtn.x - this.resizeBtn.width) - 2);
            this._clearBtn.y = 5;
        }
        override public function dispose():void{
            super.dispose();
            this._data = null;
            this._itemRenderer = null;
            while (this._listContainer.numChildren) {
                this._listContainer.removeChildAt(0);
            };
        }
        private function drawList():void{
            var list:Array;
            var lastDomainInfo:LoadedStuffInfo;
            var j:int;
            var info:LoadedStuffInfo;
            var level:int;
            var k:int;
            var tinfo:LoadedStuffInfo;
            var render:LoadedStuffItemRenderer;
            this._listContainer.graphics.clear();
            this._listContainer.graphics.lineTo(0, 0);
            while (this._listContainer.numChildren) {
                ObjectPool.disposeObject(this._listContainer.removeChildAt(0), this._itemRenderer);
            };
            var levels:Array = [];
            var domainRelativePaths:Array = [];
            if (this._data){
                list = this._data.slice();
                if (this._sortOnDomain){
                    list.sortOn("path");
                    if (list.length > 1){
                        list.splice(0, 0, new LoadedStuffInfo((list[0] as LoadedStuffInfo).path));
                        levels[0] = 0;
                        lastDomainInfo = list[0];
                        j = 1;
                        while (j < list.length) {
                            info = (list[j] as LoadedStuffInfo);
                            if (info.path != lastDomainInfo.path){
                                list.splice(j, 0, new LoadedStuffInfo(info.path));
                                level = 0;
                                k = j;
                                while (k >= 0) {
                                    if (list[k].contentType == null){
                                        if ((((info.path.indexOf(list[k].path) == 0)) && (!((info.path == list[k].path))))){
                                            level = (levels[k] + 1);
                                            domainRelativePaths[j] = info.path.slice(list[k].path.length, (info.path.length - 1));
                                            break;
                                        };
                                    };
                                    k--;
                                };
                                levels[j] = level;
                                lastDomainInfo = list[j];
                            } else {
                                levels[j] = levels[(j - 1)];
                            };
                            j++;
                        };
                    };
                };
            };
            var l:int = ((list)==null) ? 0 : list.length;
            var i:int;
            while (i < l) {
                tinfo = (list[i] as LoadedStuffInfo);
                render = ObjectPool.getObject(this._itemRenderer);
                render.x = 0;
                render.y = (this._listContainer.height + 2);
                render.data = list[i];
                render.label = tinfo.path;
                if (tinfo.contentType == null){
                    render.paddingLeft = (levels[i] * 20);
                    render.label = (domainRelativePaths[i]) ? domainRelativePaths[i] : tinfo.path;
                    render.color = 0x666666;
                    render.background = true;
                } else {
                    render.paddingLeft = ((levels[i] + 1) * 20);
                    render.label = tinfo.name;
                    render.color = 0xCCCCCC;
                    render.background = false;
                };
                this._listContainer.addChild(render);
                i++;
            };
            this.relayout();
        }
        private function onClickClear(event:MouseEvent):void{
            this.dispatchEvent(new Event("clear"));
        }
        public function setData(stuffList:Array):void{
            this._data = stuffList;
            this.drawList();
        }
        public function update():void{
            this.drawList();
        }

    }
}//package cn.itamt.utils.inspector.firefox.download 

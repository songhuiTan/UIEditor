//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.gerrorkeeper {
    import flash.display.*;
    import tInspector.itamt.utils.inspector.firefox.reloadapp.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import flash.events.*;
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class ErrorListPanel extends InspectorViewPanel {

        private var _listContainer:Sprite;
        private var _data:Array;
        private var _itemRenderer:Class;
        private var _clearBtn:ReloadButton;

        public function ErrorListPanel(title:String="错误列表", w:Number=200, h:Number=200, autoDisposeWhenRemove:Boolean=true, resizeable:Boolean=true, closeable:Boolean=true){
            this._itemRenderer = ErrorLogItemRenderer;
            super(title, w, h, autoDisposeWhenRemove, resizeable, closeable);
            this._listContainer = new Sprite();
            this.setContent(this._listContainer);
            this._clearBtn = new ReloadButton();
            this._clearBtn.tip = InspectorLanguageManager.getStr("GEK_ClearHistory");
            this._clearBtn.addEventListener(MouseEvent.CLICK, this.onClickClear);
            this.addChild(this._clearBtn);
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
            var render:ErrorLogItemRenderer;
            this._listContainer.graphics.clear();
            this._listContainer.graphics.lineTo(0, 0);
            while (this._listContainer.numChildren) {
                ObjectPool.disposeObject(this._listContainer.removeChildAt(0), this._itemRenderer);
            };
            var l:int = ((this._data)==null) ? 0 : this._data.length;
            var i:int;
            while (i < l) {
                render = ObjectPool.getObject(ErrorLogItemRenderer);
                render.x = 0;
                render.y = (this._listContainer.height + 2);
                render.data = this._data[i];
                this._listContainer.addChild(render);
                i++;
            };
            this.relayout();
        }
        private function onClickClear(event:MouseEvent):void{
            this.dispatchEvent(new Event("clear"));
        }
        public function setData(errorList:Array):void{
            this._data = errorList;
            this.drawList();
        }
        public function update():void{
            this.drawList();
        }

    }
}//package cn.itamt.utils.inspector.plugins.gerrorkeeper 

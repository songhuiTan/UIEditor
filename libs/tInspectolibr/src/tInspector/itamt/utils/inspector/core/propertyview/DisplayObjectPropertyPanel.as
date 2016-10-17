//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.core.propertyview.accessors.*;
    import tInspector.itamt.utils.*;
    import flash.geom.*;
    import flash.display.*;

    public class DisplayObjectPropertyPanel extends PropertyPanel {

        private static var favProps:Array = ["x", "y", "width", "height", "scaleX", "scaleY", "alpha", "rotation"];

        private var fullBtn:InspectorViewFullButton;

        public function DisplayObjectPropertyPanel(w:Number=240, h:Number=170, owner:PropertyAccessorRender=null){
            super(w, h, owner);
            singletonBtn.normalMode = true;
            this.fullBtn = new InspectorViewFullButton();
            this.fullBtn.addEventListener(MouseEvent.CLICK, this.onClickFull);
            addChild(this.fullBtn);
            this.addEventListener(PropertyEvent.FAV, this.onFavProperty);
            this.addEventListener(PropertyEvent.DEL_FAV, this.onDelFavProperty);
        }
        override public function relayout():void{
            super.relayout();
            this.fullBtn.x = (this.resizeBtn.x - this.fullBtn.width);
            this.fullBtn.y = 5;
            singletonBtn.x = ((this.fullBtn.x - this.singletonBtn.width) - 2);
            singletonBtn.y = 5;
            refreshBtn.x = ((this.singletonBtn.x - this.singletonBtn.width) - 2);
            refreshBtn.y = 5;
        }
        override protected function drawTitle():void{
            if (this.target){
                this._title.htmlText = ((((("<font color=\"#99cc00\">" + this.target.name) + "</font>") + "<font color=\"#cccccc\">(") + ClassTool.getShortClassName(this.target)) + ")</font>");
            };
            super.drawTitle();
        }
        override protected function compateAccessorName(a:XML, b:XML):Number{
            var aN:String = String(a.@name);
            var bN:String = String(b.@name);
            if (favProps.indexOf(aN) > favProps.indexOf(bN)){
                return (-1);
            };
            if (favProps.indexOf(aN) < favProps.indexOf(bN)){
                return (1);
            };
            if (aN > bN){
                return (1);
            };
            if (aN < bN){
                return (-1);
            };
            return (0);
        }
        private function onFavProperty(evt:PropertyEvent):void{
            var render:PropertyAccessorRender = (evt.target as PropertyAccessorRender);
            var prop:String = String(render.xml.@name);
            if (favProps.indexOf(prop) < 0){
                favProps.unshift(prop);
                this.propList.sort(this.compateAccessorName);
                drawList();
            };
        }
        private function onDelFavProperty(evt:PropertyEvent):void{
            var render:PropertyAccessorRender = (evt.target as PropertyAccessorRender);
            var prop:String = String(render.xml.@name);
            var t:int = favProps.indexOf(prop);
            if (t >= 0){
                favProps.splice(t, 1);
                this.propList.sort(this.compateAccessorName);
                drawList();
            };
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
                    if (i < favProps.length){
                        if (favProps.indexOf(String(propList[i].@name)) > -1){
                            render = new PropertyAccessorRender(200, 20, true, this.owner);
                        } else {
                            if (this.fullBtn.normalMode){
                                break;
                            };
                            render = new PropertyAccessorRender(200, 20, false, this.owner);
                        };
                    } else {
                        if (this.fullBtn.normalMode){
                            break;
                        };
                        render = new PropertyAccessorRender(200, 20, false, this.owner);
                    };
                    render.setXML(this.target, propList[i]);
                    render.y = (list.height + 2);
                    list.addChild(render);
                    i++;
                };
            };
        }
        override protected function onClickFull(evt:MouseEvent=null):void{
            if (evt){
                evt.stopImmediatePropagation();
            };
            this.drawList();
            if (!(this.fullBtn.normalMode)){
                if (this.resizeBtn.normalMode){
                    if (_mSavedSize == null){
                        _mSavedSize = new Point(this._width, 270);
                    } else {
                        _mSavedSize = new Point(this._width, this.height);
                    };
                    if (_fSavedSize == null){
                        _fSavedSize = new Point(this._width, 400);
                    };
                    this.addChild(this.search);
                    if (this.resizeBtn.normalMode){
                        this.resize(_fSavedSize.x, _fSavedSize.y);
                    };
                };
            } else {
                if (this.resizeBtn.normalMode){
                    if (_fSavedSize == null){
                        _fSavedSize = new Point(this._width, 400);
                    } else {
                        _fSavedSize = new Point(this._width, this.height);
                    };
                    if (_mSavedSize == null){
                        _mSavedSize = new Point(this._width, 270);
                    };
                    if (this.search.parent){
                        this.search.parent.removeChild(this.search);
                    };
                    if (this.resizeBtn.normalMode){
                        this.resize(_mSavedSize.x, _mSavedSize.y);
                    };
                };
            };
        }
        public function get target():DisplayObject{
            return ((this.curTarget as DisplayObject));
        }
        public function set target(t:DisplayObject):void{
            this.curTarget = t;
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview 

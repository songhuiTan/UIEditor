//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    
    import tInspector.itamt.utils.*;
    import tInspector.itamt.utils.inspector.core.InspectTarget;
    import tInspector.itamt.utils.inspector.core.propertyview.accessors.*;
    import tInspector.itamt.utils.inspector.events.*;
    import tInspector.itamt.utils.inspector.lang.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.msc.events.*;

    public class PropertyPanel extends InspectorViewPanel {

        public static const PROP_STATE:int = 1;
        public static const METHOD_STATE:int = 2;

        protected var list:Sprite;
        protected var listMethod:Sprite;
        protected var methodArray:Array;
        protected var curTarget:*;
        protected var propList:Array;
        protected var singletonBtn:InspectorViewSingletonButton;
        protected var search:InspectSearchBar;
        protected var renders:Array;
        protected var viewPropBtn:InspectorTabLabelButton;
        protected var viewMethodBtn:InspectorTabLabelButton;
        protected var propDict:String = "";
        protected var methDict:String = "";
        protected var state:int = 1;
        protected var refreshBtn:InspectorViewRefreshButton;
        protected var _owner:PropertyAccessorRender;
        protected var favoritable:Boolean = true;
        protected var lrender:*;
        protected var _mSavedSize:Point;
        protected var _fSavedSize:Point;

        public function PropertyPanel(w:Number=240, h:Number=170, owner:PropertyAccessorRender=null, favoritable:Boolean=true){
            super("Property", w, h);
            _title.mouseEnabled = (_title.mouseWheelEnabled = false);
            this._owner = owner;
            this._padding = new Padding(33, 10, 40, 10);
            this.favoritable = favoritable;
            this.renders = [];
            this._minW = 240;
            this._minH = 170;
            this.list = new Sprite();
            this.setContent(this.list);
            this.singletonBtn = new InspectorViewSingletonButton();
            this.singletonBtn.normalMode = false;
            this.singletonBtn.addEventListener(MouseEvent.CLICK, this.onClickSingleton);
            addChild(this.singletonBtn);
            this.viewPropBtn = new InspectorTabLabelButton(InspectorLanguageManager.getStr("Property"), true);
            this.viewPropBtn.tip = InspectorLanguageManager.getStr("ViewProperties");
            this.viewPropBtn.addEventListener(MouseEvent.CLICK, this.onViewProp);
            addChild(this.viewPropBtn);
            this.viewMethodBtn = new InspectorTabLabelButton(InspectorLanguageManager.getStr("Method"));
            this.viewMethodBtn.tip = InspectorLanguageManager.getStr("ViewMethods");
            this.viewMethodBtn.addEventListener(MouseEvent.CLICK, this.onViewMethod);
            addChild(this.viewMethodBtn);
            this.addEventListener(PropertyEvent.UPDATE, this.onPropertyUpdate);
            this.refreshBtn = new InspectorViewRefreshButton();
            this.refreshBtn.addEventListener(MouseEvent.CLICK, this.onClickRefresh);
            addChild(this.refreshBtn);
            this.search = new InspectSearchBar();
            this.search.addEventListener(mTextEvent.ENTER, this.onSearch);
            this.search.addEventListener(mTextEvent.SELECT, this.onSearch);
        }
        public function get owner():PropertyAccessorRender{
            return (this._owner);
        }
        protected function onSearch(evt:mTextEvent):void{
            var render:*;
            if (this.lrender){
                this.lrender.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT));
                this.lrender = null;
            };
            var i:int;
            if (evt.type == mTextEvent.SELECT){
                if (this.state == PROP_STATE){
                } else {
                    if (this.state == METHOD_STATE){
                    };
                };
            } else {
                if (evt.type == mTextEvent.ENTER){
                    if (this.state == PROP_STATE){
                        while (i < this.list.numChildren) {
                            var _temp1:int = i;
                            i = (i + 1);
                            render = (this.list.getChildAt(_temp1) as PropertyAccessorRender);
                            if (render.propName == evt.text){
                                this.showContentArea(render.getBounds(render.parent));
                                this.lrender = render;
                                render.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                                break;
                            };
                        };
                    } else {
                        if (this.state == METHOD_STATE){
                            while (i < this.listMethod.numChildren) {
                                var _temp2:int = i;
                                i = (i + 1);
                                render = (this.listMethod.getChildAt(_temp2) as MethodRender);
                                if (render.propName == evt.text){
                                    this.showContentArea(render.getBounds(render.parent));
                                    this.lrender = render;
                                    render.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER));
                                    break;
                                };
                            };
                        };
                    };
                };
            };
        }
        protected function onClickRefresh(event:MouseEvent):void{
            if (this.curTarget){
                this.onUpdate(this.curTarget);
            };
        }
        protected function onViewMethod(event:MouseEvent):void{
            this.state = METHOD_STATE;
            if (this.listMethod == null){
                this.listMethod = new Sprite();
            };
            this.setContent(this.listMethod);
//            this.onInspectMethod(new InspectTarget(this.curTarget));
			if(this.curTarget is InspectTarget){
				this.onInspectProp(this.curTarget);
			}else
			{
				this.onInspectProp(new InspectTarget(this.curTarget));
			}
            this.viewMethodBtn.active = true;
            this.viewPropBtn.active = false;
        }
        protected function onViewProp(event:MouseEvent):void{
            this.state = PROP_STATE;
            this.setContent(this.list);
			
			if(this.curTarget is InspectTarget){
				this.onInspectProp(this.curTarget);
			}else
			{
				this.onInspectProp(new InspectTarget(this.curTarget));
			}
            
            this.viewMethodBtn.active = false;
            this.viewPropBtn.active = true;
        }
        override public function relayout():void{
            super.relayout();
            this.singletonBtn.x = ((this.resizeBtn.x - this.singletonBtn.width) - 2);
            this.singletonBtn.y = 5;
            this.refreshBtn.x = ((this.singletonBtn.x - this.singletonBtn.width) - 2);
            this.refreshBtn.y = 5;
            this.viewMethodBtn.x = ((_width - this._padding.right) - this.viewMethodBtn.width);
            this.viewPropBtn.x = ((this.viewMethodBtn.x - 10) - this.viewPropBtn.width);
            this.viewPropBtn.y = (this.viewMethodBtn.y = ((this._height - this.viewPropBtn.height) - ((_padding.bottom - this.viewPropBtn.height) / 2)));
            this.search.x = _padding.left;
            this.search.y = (_height - 29);
            this.search.setSize(((this.viewPropBtn.x - _padding.left) - 10));
        }
        public function onInspectProp(object:InspectTarget):void{
            var xml:* = null;
            var tmp:* = null;
            var excludeList:* = null;
            var excludeArr:* = null;
            var exclude:* = null;
            var item:* = null;
            var object:* = object;
            xml = ClassTool.getDescribe(object.displayObject["constructor"]).factory[0];
            tmp = xml.accessor;
            this.propList = [];
            excludeList = xml..metadata.(@name == "Exclude");
            excludeArr = [];
            for each (exclude in excludeList) {
                excludeArr.push(exclude.arg.(@key == "name").@value.toString());
            };
            this.propDict = "";
            for each (item in tmp) {
                if (excludeArr.indexOf(item.@name.toString()) >= 0){
                    item.@exclude = true;
                };
                if ((object is Stage)){
                    if (item.@name == "textSnapshot"){
                        //unresolved jump
                    };
                    if ((((item.@name == "width")) || ((item.@name == "height")))){
                        item.@exclude = true;
                    };
                };
                this.propList.push(item);
                this.propDict = (this.propDict + (item.@name + " "));
            };
            this.propList.sort(this.compateAccessorName);
            this.onClickFull();
        }
        public function onInspect(object:*):void{
            if (this.curTarget != object){
                this.curTarget = object;
                if (this.state == PROP_STATE){
                    this.onInspectProp(new InspectTarget(object));
                } else {
                    this.onInspectMethod(this.curTarget);
                };
                this.drawTitle();
            } else {
                this.onUpdate(object);
            };
        }
        override protected function drawTitle():void{
            var str:String;
            var t:PropertyAccessorRender;
            if (this._owner){
                str = this._owner.propName;
                t = this._owner;
                while (t.owner) {
                    t = t.owner;
                    str = ((t.propName + ".") + str);
                };
                if ((t.target is DisplayObject)){
                    str = (((t.target as DisplayObject).name + ".") + str);
                };
                this._title.htmlText = (("<font color=\"#99cc00\">" + str) + "</font>");
            };
            _title.x = _padding.left;
            _title.y = 7;
            _title.width = (_title.textWidth + 4);
            if (_title.width > ((this.refreshBtn.x - _padding.left) - 3)){
                _title.width = ((this.refreshBtn.x - _padding.left) - 3);
            };
        }
        public function onInspectMethod(object:InspectTarget = null):void{
            var xml:XML;
            var methods:XMLList;
            var method:XML;
            if (object != null){
                if (this.curTarget != object){
                    this.curTarget = object;
                };
                xml = ClassTool.getDescribe(this.curTarget["constructor"]).factory[0];
                methods = xml.method;
                this.methodArray = [];
                this.methDict = "";
                for each (method in methods) {
                    this.methodArray.push(method);
                    this.methDict = (this.methDict + (method.@name + " "));
                };
                this.methodArray.sort(this.compateAccessorName);
                this.drawList();
            };
        }
        protected function compateAccessorName(a:XML, b:XML):Number{
            var aN:String = String(a.@name);
            var bN:String = String(b.@name);
            if (aN > bN){
                return (1);
            };
            if (aN < bN){
                return (-1);
            };
            return (0);
        }
        protected function onPropertyUpdate(evt:PropertyEvent):void{
            var editor:BasePropertyEditor = (evt.target as BasePropertyEditor);
            var accessor:PropertyAccessorRender = (editor.parent as PropertyAccessorRender);
            Debug.trace(((("[PropertyPanel][onPropertyUpdate]" + accessor.propName) + ":") + editor.getValue()));
            this.curTarget[accessor.propName] = editor.getValue();
            if (accessor.owner){
                accessor.owner.editor.dispatchEvent(new PropertyEvent(PropertyEvent.UPDATE, true, true));
            };
        }
        public function onUpdate(obj):void{
            var i:int;
            var render:PropertyAccessorRender;
            if (obj == this.curTarget){
                i = 0;
                while (i < this.list.numChildren) {
                    var _temp1 = i;
                    i = (i + 1);
                    render = (this.list.getChildAt(_temp1) as PropertyAccessorRender);
                    render.update();
                };
            };
        }
        protected function drawList():void{
            switch (this.state){
                case PROP_STATE:
                    this.drawPropList();
                    this.search.setWordDict(this.propDict);
                    break;
                case METHOD_STATE:
                    this.drawMethodList();
                    this.search.setWordDict(this.methDict);
                    break;
            };
            this.relayout();
        }
        protected function drawPropList():void{
            var l:int;
            var i:int;
            var render:PropertyAccessorRender;
            this.list.graphics.clear();
            this.list.graphics.lineTo(0, 0);
            while (this.list.numChildren) {
                this.list.removeChildAt(0);
            };
            if (this.propList){
                l = this.propList.length;
                i = 0;
                while (i < l) {
                    render = new PropertyAccessorRender(200, 20, false, this.owner, this.favoritable);
                    render.setXML(this.curTarget, this.propList[i]);
                    render.y = (this.list.height + 2);
                    this.list.addChild(render);
                    i++;
                };
            };
        }
        protected function drawMethodList():void{
            var render:MethodRender;
            this.listMethod.graphics.clear();
            this.listMethod.graphics.lineTo(0, 0);
            while (this.listMethod.numChildren) {
                this.listMethod.removeChildAt(0);
            };
            var length:int = this.methodArray.length;
            var i:int;
            while (i < length) {
                render = new MethodRender(210, 20);
                render.setXML(this.curTarget, this.methodArray[i]);
                render.y = (this.listMethod.height + 2);
                this.listMethod.addChild(render);
                i++;
            };
        }
        protected function onClickFull(evt:MouseEvent=null):void{
            if (evt){
                evt.stopImmediatePropagation();
            };
            this.drawList();
            if (this.resizeBtn.normalMode){
                if (this._fSavedSize == null){
                    this._fSavedSize = new Point(this._width, 400);
                } else {
                    this._fSavedSize = new Point(this._width, this.height);
                };
                if (this._mSavedSize == null){
                    this._mSavedSize = new Point(this._width, 270);
                };
                this.addChild(this.search);
                if (this.resizeBtn.normalMode){
                    this.resize(this._mSavedSize.x, this._mSavedSize.y);
                };
            };
        }
        public function getSingleMode():Boolean{
            return (this.singletonBtn.normalMode);
        }
        protected function onClickSingleton(evt:MouseEvent=null):void{
            if (evt){
                evt.stopImmediatePropagation();
            };
            this.drawList();
            if (this.singletonBtn.normalMode){
            };
        }
        public function getCurTarget(){
            return (this.curTarget);
        }
        override public function open():void{
            super.open();
            this.viewMethodBtn.visible = (this.viewPropBtn.visible = (this.search.visible = true));
        }
        override public function hide():void{
            super.hide();
            this.viewMethodBtn.visible = (this.viewPropBtn.visible = (this.search.visible = false));
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview 

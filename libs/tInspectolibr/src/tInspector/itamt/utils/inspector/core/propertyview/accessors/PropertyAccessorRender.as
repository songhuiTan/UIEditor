//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.propertyview.accessors {
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.events.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.text.*;
    import flash.display.*;

    public class PropertyAccessorRender extends Sprite {

        protected var name_tf:TextField;
        protected var valueEditor:BasePropertyEditor;
        protected var _width:Number;
        protected var _height:Number;
        protected var _owner:PropertyAccessorRender;
        protected var _target;
        protected var _xml:XML;
        protected var _favIconBtn:InspectorViewFavoriteButton;

        public function PropertyAccessorRender(w:Number=100, h:Number=20, isFavorite:Boolean=false, owner:PropertyAccessorRender=null, favoritable:Boolean=true):void{
            super();
            this._width = w;
            this._height = h;
            this._owner = owner;
            this.name_tf = InspectorTextField.create("property name", 0xCCCCCC, 12, 0, 0, "none", "right");
            this.name_tf.height = (this._height - 2);
            this.name_tf.mouseWheelEnabled = false;
            addChild(this.name_tf);
            this._favIconBtn = new InspectorViewFavoriteButton(!(isFavorite));
            this._favIconBtn.visible = false;
            this._favIconBtn.y = 1;
            if (favoritable){
                addChild(this._favIconBtn);
            };
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            this.addEventListener(MouseEvent.ROLL_OVER, this.onRollOver);
            this.addEventListener(MouseEvent.ROLL_OUT, this.onRollOut);
            if (favoritable){
                this._favIconBtn.addEventListener(MouseEvent.CLICK, this.onClickFavBtn);
            };
        }
        public function get editor():BasePropertyEditor{
            return (this.valueEditor);
        }
        public function get owner():PropertyAccessorRender{
            return (this._owner);
        }
        public function get target(){
            return (this._target);
        }
        public function get xml():XML{
            return (this._xml);
        }
        public function get propName():String{
            return (this.name_tf.text);
        }
        public function setFavorite(bool:Boolean):void{
            this._favIconBtn.normalMode = !(bool);
            this.drawBg();
        }
        private function onAdded(evt:Event):void{
            this.relayout();
        }
        private function onRollOver(evt:MouseEvent):void{
            this._favIconBtn.visible = true;
        }
        private function onRollOut(evt:MouseEvent):void{
            this._favIconBtn.visible = false;
        }
        private function onClickFavBtn(evt:MouseEvent):void{
            if (this._favIconBtn.normalMode){
                dispatchEvent(new PropertyEvent(PropertyEvent.DEL_FAV, true, true));
            } else {
                dispatchEvent(new PropertyEvent(PropertyEvent.FAV, true, true));
            };
        }
        public function relayout():void{
            this.name_tf.width = (this.name_tf.textWidth + 4);
            if (this.name_tf.width < 48){
                this.name_tf.width = 48;
            };
            this.name_tf.x = 12;
            if (this.valueEditor){
                if (this.valueEditor.height > this._height){
                    this._height = this.valueEditor.height;
                };
                this.valueEditor.setSize(((this._width - this.name_tf.width) - 15), this._height);
                this.valueEditor.x = ((this.name_tf.x + this.name_tf.width) + 8);
            };
            this.drawBg();
        }
        protected function drawBg():void{
            this.graphics.clear();
            this.graphics.beginFill((this._favIconBtn.normalMode) ? 0x282828 : 0x282828);
            this.graphics.drawRoundRect(0, 0, (this.name_tf.width + 16), this._height, 5, 5);
            this.graphics.endFill();
        }
        public function setXML(target, accessorXML:XML):void{
            var enums:* = null;
            var xml:* = null;
            var t:* = null;
            var v:* = null;
            var vs:* = null;
            var i:* = 0;
            var tname:* = null;
            var list:* = null;
            var enum:* = null;
            var editor:* = null;
            var target:* = target;
            var accessorXML:* = accessorXML;
            this._target = target;
            this._xml = accessorXML;
            this.name_tf.text = accessorXML.@name;
            var type:* = accessorXML.@type;
            if (accessorXML.metadata.(@name == "tinspector_enum").length()){
                for each (xml in accessorXML.metadata.(@name == "tinspector_enum")) {
                    t = xml.arg.(@key == "type").@value;
                    v = xml.arg.(@key == "value").@value;
                    vs = v.split(",");
                    if (enums == null){
                        enums = [];
                    };
                    i = 0;
                    while (i < vs.length) {
                        enums.push({
                            type:t,
                            value:vs[i]
                        });
                        i = (i + 1);
                    };
                };
            };
            if (this.valueEditor == null){
                if (enums == null){
                    tname = String(accessorXML.@name).toLowerCase();
                    if ((((type == "uint")) && ((tname.indexOf("color") >= 0)))){
                        if (tname.indexOf("color") == (tname.length - 5)){
                            this.valueEditor = this.createPropertyEditor("Color");
                        };
                    } else {
                        this.valueEditor = this.createPropertyEditor(type);
                    };
                } else {
                    list = new EnumValueListEditor();
                    for each (enum in enums) {
                        editor = this.createPropertyEditor(enum.type);
                        editor.setValue(enum.value);
                        list.addEnumValueEditor(editor);
                    };
                    this.valueEditor = list;
                };
				if(this.valueEditor){
					addChildAt(this.valueEditor, 0);
				}
            };
			if(valueEditor){
				this.valueEditor.setAccessType(this._xml.@access, (this._xml.@exclude == "true"));
				if (this.valueEditor.readable){
					this.valueEditor.setValue(this._target[this._xml.@name]);
				};
			}
            this.relayout();
        }
        public function update():void{
            if (this.valueEditor&&this.valueEditor.readable){
                this.valueEditor.setValue(this._target[this._xml.@name]);
            };
        }
        public function resize():void{
        }
        protected function createPropertyEditor(type:String):BasePropertyEditor{
            switch (type){
                case "Boolean":
                    return (new BooleanPropertyEditor());
                case "Function":
                    return (new FunctionPropertyEditor());
                case "int":
                    return (new NumberPropertyEditor());
                case "Number":
                    return (new NumberPropertyEditor());
                case "object":
                    return (new ObjectPropertyEditor());
                case "String":
                    return (new StringPropertyEditor());
                case "uint":
                    return (new UintPropertyEditor());
                case "XML":
                    return (new XMLPropertyEditor());
                case "XMLList":
                    return (new XMLPropertyEditor());
                case "Color":
                    return (new ColorPropertyEditor());
                default:
                    return (new ObjectPropertyEditor());
            };
        }

    }
}//package cn.itamt.utils.inspector.core.propertyview.accessors 

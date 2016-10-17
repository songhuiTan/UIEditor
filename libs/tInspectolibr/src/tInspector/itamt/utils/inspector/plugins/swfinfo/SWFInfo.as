//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.swfinfo {
    import tInspector.itamt.utils.inspector.firefox.*;
    import flash.geom.*;
    import tInspector.itamt.utils.*;
    import tInspector.com.codeazur.as3swf.tags.*;
    import tInspector.itamt.utils.inspector.ui.*;
    import flash.system.*;
    import tInspector.com.codeazur.as3swf.*;
    import tInspector.com.codeazur.as3swf.data.*;
    import flash.display.*;

    public class SWFInfo {

        private var _swfRoot:DisplayObject;
        private var _stage:Stage;
        private var _url:String;
        private var _version:uint;
        private var _playerVersion:String;
        private var _bgcolor:uint;
        protected var _size:SWFSize;
        protected var _compileDate:Date;

        public function SWFInfo(swfRoot:DisplayObject):void{
            var tag:ITag;
            var t:int;
            super();
            this._swfRoot = swfRoot;
            this._stage = InspectorStageReference.entity;
            this._url = this._swfRoot.loaderInfo.url;
            this._version = this._swfRoot.loaderInfo.swfVersion;
            this._playerVersion = Capabilities.version;
            var swf:SWF = new SWF(swfRoot.loaderInfo.bytes);
            var rect:SWFRectangle = swf.frameSize;
            this._size = new SWFSize(((Number(rect.xmax) / 20) - (Number(rect.xmin) / 20)), ((Number(rect.ymax) / 20) - (Number(rect.ymin) / 20)));
            for each (tag in swf.tags) {
                if ((tag is TagSetBackgroundColor)){
                    this._bgcolor = (tag as TagSetBackgroundColor).color;
                } else {
                    if ((tag is TagProductInfo)){
                        this._compileDate = (tag as TagProductInfo).compileDate;
                    };
                };
            };
            t = FlashPlayerEnvironment.getSwfBgColor();
            if (t >= 0){
                this._bgcolor = t;
            };
        }
        public function get url():String{
            return (this._url);
        }
        public function get version():uint{
            return (this._version);
        }
        public function get player():String{
            return (this._playerVersion);
        }
        public function set bgcolor(color:uint):void{
            this._bgcolor = color;
            FlashPlayerEnvironment.setSwfBgColor(this._bgcolor);
        }
        public function get bgcolor():uint{
            return (this._bgcolor);
        }
        public function set quality(val:String):void{
            this._stage.quality = val;
        }
        public function get quality():String{
            return (this._stage.quality);
        }
        public function get frameRate():uint{
            return (this._stage.frameRate);
        }
        public function set frameRate(num:uint):void{
            this._stage.frameRate = num;
        }
        public function set scaleMode(mode:String):void{
            this._stage.scaleMode = mode;
        }
        public function get scaleMode():String{
            return (this._stage.scaleMode);
        }
        public function set contextMenu(bool:Boolean):void{
            this._stage.showDefaultContextMenu = bool;
        }
        public function get contextMenu():Boolean{
            return (this._stage.showDefaultContextMenu);
        }
        public function set align(val:String):void{
            this._stage.align = val;
        }
        public function get align():String{
            return (this._stage.align);
        }
        public function get size():SWFSize{
            return (this._size);
        }
        public function get compileDate():Date{
            return (this._compileDate);
        }
        public function get playerSize():SWFSize{
            var rect:Rectangle = FlashPlayerEnvironment.getSwfSize();
            if (rect == null){
                return (null);
            };
            var size:SWFSize = new SWFSize(rect.width, rect.height);
            return (size);
        }
        public function set playerSize(size:SWFSize):void{
            Debug.trace(("[SWFInfo][playerSize]" + size.toString()));
            FlashPlayerEnvironment.setSwfSize(size.width, size.height);
        }

    }
}//package cn.itamt.utils.inspector.plugins.swfinfo 

class SWFSize {

    protected var _width:Number;
    protected var _height:Number;

    public function SWFSize(width:Number, height:Number):void{
        super();
        this._width = width;
        this._height = height;
    }
    public function toString():String{
        return (((this._width + ", ") + this._height));
    }
    public function get width():Number{
        return (this._width);
    }
    public function set width(width:Number):void{
        this._width = width;
    }
    public function get height():Number{
        return (this._height);
    }
    public function set height(height:Number):void{
        this._height = height;
    }

}

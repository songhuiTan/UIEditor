//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils {
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class DisplayObjectTool {

        private static var engine:MovieClip = new MovieClip();

        public static function getDisplayObjectLevel(object:DisplayObject):int{
            var i:int;
            if ((object is Stage)){
                return (0);
            };
            if (object.stage){
                i = 0;
                while (object.parent) {
                    object = object.parent;
                    i++;
                };
                return (i);
            };
            return (-1);
        }
        public static function removeAllChildren(container:DisplayObjectContainer):void{
            while (container.numChildren) {
                if ((container.getChildAt(0) is DisplayObjectContainer)){
                    removeAllChildren((container.getChildAt(0) as DisplayObjectContainer));
                };
                container.removeChildAt(0);
            };
        }
        public static function everyDisplayObject(container:DisplayObjectContainer, fun:Function):void{
            var num:int = container.numChildren;
            var i:int;
            while (i < num) {
                if ((container.getChildAt(i) is DisplayObjectContainer)){
                    everyDisplayObject((container.getChildAt(i) as DisplayObjectContainer), fun);
                };
                fun.call(null, container.getChildAt(i));
                i++;
            };
        }
        public static function swapToTop(obj:DisplayObject):void{
            var fun:* = null;
            var obj:* = obj;
            if (obj.stage){
                obj.stage.invalidate();
                var _local3 = function (evt:Event):void{
                    if (((((!((obj == null))) && (!((obj.stage == null))))) && (!((fun == null))))){
                        obj.stage.removeEventListener(Event.RENDER, fun);
                        obj.parent.setChildIndex(obj, (obj.parent.numChildren - 1));
                    };
                };
                fun = _local3;
                obj.stage.addEventListener(Event.RENDER, _local3);
            };
        }
        public static function getAllChildrenNum(container:DisplayObjectContainer):uint{
            var child:DisplayObject;
            var num:uint = container.numChildren;
            var i:int;
            while (i < container.numChildren) {
                child = container.getChildAt(i);
                if ((child is DisplayObjectContainer)){
                    num = (num + getAllChildrenNum((child as DisplayObjectContainer)));
                };
                i++;
            };
            return (num);
        }
        public static function localRotationToGlobal(child:DisplayObject):Number{
            var greed:Number = child.rotation;
            if (child.parent){
                greed = (greed + localRotationToGlobal(child.parent));
            };
            return (greed);
        }
        public static function global2LocalMath(child:DisplayObject, c:Number, mathFun:Function):Number{
            var num:Number;
            num = (c * mathFun.call(null, ((child.rotation * Math.PI) / 180)));
            if (child.parent){
                num = (num * global2LocalMath(child.parent, num, mathFun));
            };
            return (num);
        }
        public static function getConcatenatedMatrix(source:DisplayObject):Matrix{
            var m:Matrix = new Matrix();
            var scope:DisplayObject = source;
            while (scope) {
                if ((scope is Stage)){
                    m.concat(InspectorStageReference.getTransformMatrix());
                } else {
                    m.concat(scope.transform.matrix.clone());
                };
                scope = (scope.parent as DisplayObject);
            };
            return (m);
        }
        public static function getChildByNameFrom(scope:DisplayObjectContainer, val:String):DisplayObject{
            var n:String;
            var t:*;
            var trigger:* = scope;
            var names:Array = val.split(".");
            while (trigger) {
                n = names.shift();
                if (n){
                    t = trigger.getChildByName(n);
                    if (t){
                        trigger = t;
                    } else {
                        break;
                    };
                } else {
                    break;
                };
            };
            if (trigger == scope){
                trigger = null;
            };
            return (trigger);
        }
        public static function callLater(func:Function, args:Array=null, frame:int=1):void{
            var func:* = func;
            var args = args;
            var frame:int = frame;
            engine.addEventListener(Event.ENTER_FRAME, function (event:Event):void{
                if (--frame <= 0){
                    engine.removeEventListener(Event.ENTER_FRAME, arguments.callee);
                    func.apply(null, args);
                };
            });
        }

    }
}//package cn.itamt.utils 

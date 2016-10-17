//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import flash.events.*;
    import flash.geom.*;
    import flash.display.*;
    import tInspector.itamt.utils.inspector.ui.*;

    public class LiveTransformPointBtn extends InspectorButton {

        private var downHandler:Function;
        private var upHandler:Function;
        private var dragHandler:Function;
        public var lastMousePt:Point;
        private var inited:Boolean;

        public function LiveTransformPointBtn(onMouseDown:Function=null, onMouseUp:Function=null, onDrag:Function=null){
            super();
            this.downHandler = onMouseDown;
            this.upHandler = onMouseUp;
            this.dragHandler = onDrag;
            this.addEventListener(Event.ADDED_TO_STAGE, this.onAdded);
            this.addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved);
        }
        private function onAdded(evt:Event):void{
            if (this.inited){
                return;
            };
            this.inited = true;
            this.addEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.stage.addEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        private function onRemoved(evt:Event):void{
            this.inited = false;
            this.removeEventListener(MouseEvent.MOUSE_DOWN, this.onMouseDown);
            this.stage.removeEventListener(MouseEvent.MOUSE_UP, this.onMouseUp);
        }
        private function onMouseDown(evt:MouseEvent):void{
            this.lastMousePt = new Point(evt.stageX, evt.stageY);
            this.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            if (this.downHandler != null){
                this.downHandler.call(null, this);
            };
        }
        private function onMouseUp(evt:MouseEvent):void{
            this.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onMouseMove);
            if (this.downHandler != null){
                this.upHandler.call(null, this);
            };
        }
        private function onMouseMove(evt:MouseEvent):void{
            if (this.dragHandler != null){
                this.dragHandler.call(null, this);
            };
            this.lastMousePt.x = evt.stageX;
            this.lastMousePt.y = evt.stageY;
        }
        override protected function buildDownState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.lineStyle(1, 0xFFFFFF);
            g.beginFill(0xFF0000, 1);
            g.drawRect(-4, -4, 8, 8);
            g.endFill();
            return (sp);
        }
        override protected function buildUpState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.lineStyle(1, 0xFFFFFF);
            g.beginFill(0, 1);
            g.drawRect(-4, -4, 8, 8);
            g.endFill();
            return (sp);
        }
        override protected function buildOverState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.lineStyle(1, 0);
            g.beginFill(0x99CC00, 1);
            g.drawRect(-4, -4, 8, 8);
            g.endFill();
            return (sp);
        }
        override protected function buildHitState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.lineStyle(1, 0xFFFFFF);
            g.beginFill(0, 1);
            g.drawRect(-4, -4, 8, 8);
            g.endFill();
            return (sp);
        }
        override protected function buildUnenabledState():DisplayObject{
            var sp:Shape = new Shape();
            var g:Graphics = sp.graphics;
            g.lineStyle(1, 0xFFFFFF);
            g.beginFill(0, 1);
            g.drawRect(-4, -4, 8, 8);
            g.endFill();
            return (sp);
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 

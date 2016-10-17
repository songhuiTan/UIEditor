//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.senocular.display {
    import flash.geom.*;
    import flash.utils.*;
    import flash.display.*;
    import flash.events.*;

    public class TransformToolCursor extends TransformToolControl {

        protected var _mouseOffset:Point;
        protected var contact:Boolean = false;
        protected var active:Boolean = false;
        protected var references:Dictionary;

        public function TransformToolCursor(){
            this._mouseOffset = new Point(20, 20);
            this.references = new Dictionary(true);
            super();
            addEventListener(TransformTool.CONTROL_INIT, this.init);
        }
        public function get mouseOffset():Point{
            return (this._mouseOffset.clone());
        }
        public function set mouseOffset(p:Point):void{
            this._mouseOffset = p;
        }
        public function addReference(reference:DisplayObject):void{
            if (((reference) && (!(this.references[reference])))){
                this.references[reference] = true;
                this.addReferenceListeners(reference);
            };
        }
        public function removeReference(reference:DisplayObject):DisplayObject{
            if (((reference) && (this.references[reference]))){
                this.removeReferenceListeners(reference);
                delete this.references[reference];
                return (reference);
            };
            return (null);
        }
        public function updateVisible(event:Event=null):void{
            if (this.active){
                if (!(visible)){
                    visible = true;
                };
            } else {
                if (visible != this.contact){
                    visible = this.contact;
                };
            };
            this.position(event);
        }
        public function position(event:Event=null):void{
            if (parent){
                x = (parent.mouseX + this.mouseOffset.x);
                y = (parent.mouseY + this.mouseOffset.y);
            };
        }
        private function init(event:Event):void{
            _transformTool.addEventListener(TransformTool.TRANSFORM_TOOL, this.position, false, 0, true);
            _transformTool.addEventListener(TransformTool.NEW_TARGET, this.referenceUnset, false, 0, true);
            _transformTool.addEventListener(TransformTool.CONTROL_TRANSFORM_TOOL, this.position, false, 0, true);
            _transformTool.addEventListener(TransformTool.CONTROL_DOWN, this.controlMouseDown, false, 0, true);
            _transformTool.addEventListener(TransformTool.CONTROL_MOVE, this.controlMove, false, 0, true);
            _transformTool.addEventListener(TransformTool.CONTROL_UP, this.controlMouseUp, false, 0, true);
            this.updateVisible(event);
            this.position(event);
        }
        private function addReferenceListeners(reference:DisplayObject):void{
            reference.addEventListener(MouseEvent.MOUSE_MOVE, this.referenceMove, false, 0, true);
            reference.addEventListener(MouseEvent.MOUSE_DOWN, this.referenceSet, false, 0, true);
            reference.addEventListener(MouseEvent.ROLL_OVER, this.referenceSet, false, 0, true);
            reference.addEventListener(MouseEvent.ROLL_OUT, this.referenceUnset, false, 0, true);
        }
        private function removeReferenceListeners(reference:DisplayObject):void{
            reference.removeEventListener(MouseEvent.MOUSE_MOVE, this.referenceMove, false);
            reference.removeEventListener(MouseEvent.MOUSE_DOWN, this.referenceSet, false);
            reference.removeEventListener(MouseEvent.ROLL_OVER, this.referenceSet, false);
            reference.removeEventListener(MouseEvent.ROLL_OUT, this.referenceUnset, false);
        }
        protected function referenceMove(event:MouseEvent):void{
            this.position(event);
            event.updateAfterEvent();
        }
        protected function referenceSet(event:Event):void{
            this.contact = true;
            if (!(_transformTool.currentControl)){
                this.updateVisible(event);
            };
        }
        protected function referenceUnset(event:Event):void{
            this.contact = false;
            if (!(_transformTool.currentControl)){
                this.updateVisible(event);
            };
        }
        protected function controlMouseDown(event:Event):void{
            if (this.references[_transformTool.currentControl.relatedObject]){
                this.active = true;
            };
            this.updateVisible(event);
        }
        protected function controlMove(event:Event):void{
            if (this.references[_transformTool.currentControl.relatedObject]){
                this.position(event);
            };
        }
        protected function controlMouseUp(event:Event):void{
            if (this.references[_transformTool.currentControl.relatedObject]){
                this.active = false;
            };
            this.updateVisible(event);
        }

    }
}//package com.senocular.display 

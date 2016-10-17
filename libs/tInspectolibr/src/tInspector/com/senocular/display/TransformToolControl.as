//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.senocular.display {
    import flash.display.*;
    import flash.geom.*;

    public class TransformToolControl extends MovieClip {

        protected var _transformTool:TransformTool;
        protected var _referencePoint:Point;
        protected var _relatedObject:InteractiveObject;

        public function TransformToolControl(){
            super();
            this._relatedObject = this;
        }
        public function get transformTool():TransformTool{
            return (this._transformTool);
        }
        public function set transformTool(t:TransformTool):void{
            this._transformTool = t;
        }
        public function get relatedObject():InteractiveObject{
            return (this._relatedObject);
        }
        public function set relatedObject(i:InteractiveObject):void{
            this._relatedObject = (i) ? i : this;
        }
        public function get referencePoint():Point{
            return (this._referencePoint);
        }
        public function set referencePoint(p:Point):void{
            this._referencePoint = p;
        }
        public function counterTransform():void{
            transform.matrix = new Matrix();
            var concatMatrix:Matrix = transform.concatenatedMatrix;
            concatMatrix.invert();
            transform.matrix = concatMatrix;
        }

    }
}//package com.senocular.display 

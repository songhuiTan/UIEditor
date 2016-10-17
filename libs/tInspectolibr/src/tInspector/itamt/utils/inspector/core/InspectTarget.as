//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core {
    import flash.display.*;

    public class InspectTarget {

        private var _dp:DisplayObject;
        private var ox:Number;
        private var oy:Number;

        public function InspectTarget(dp:DisplayObject):void{
            super();
            this._dp = dp;
            this.ox = this._dp.x;
            this.oy = this._dp.y;
        }
        public function get displayObject():DisplayObject{
            return (this._dp);
        }
        public function isEqual(inspectTarget:InspectTarget):Boolean{
            return ((this._dp == inspectTarget.displayObject));
        }
        public function resetTarget():void{
            if (this._dp){
                this._dp.x = this.ox;
                this._dp.y = this.oy;
            };
        }
        public function dispose():void{
            this._dp = null;
        }

    }
}//package cn.itamt.utils.inspector.core 

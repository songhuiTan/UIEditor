//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.com.senocular.display.*;
    import flash.events.*;
    import flash.geom.*;

    public class ResetTransofrmControl extends TransformToolControl {

        public function ResetTransofrmControl(){
            super();
            var btn:LiveResetPointBtn = new LiveResetPointBtn();
            addChild(btn);
            addEventListener(TransformTool.CONTROL_INIT, this.init, false, 0, true);
        }
        private function init(event:Event):void{
            transformTool.addEventListener(TransformTool.NEW_TARGET, this.update, false, 0, true);
            transformTool.addEventListener(TransformTool.TRANSFORM_TOOL, this.update, false, 0, true);
            transformTool.addEventListener(TransformTool.CONTROL_TRANSFORM_TOOL, this.update, false, 0, true);
            addEventListener(MouseEvent.CLICK, this.resetClick);
            this.update();
        }
        private function update(event:Event=null):void{
            var maxX:Number;
            var maxY:Number;
            if (transformTool.target){
                maxX = Math.min(transformTool.boundsTopLeft.x, transformTool.boundsTopRight.x);
                maxX = Math.min(maxX, transformTool.boundsBottomRight.x);
                maxX = Math.min(maxX, transformTool.boundsBottomLeft.x);
                maxY = Math.max(transformTool.boundsTopLeft.y, transformTool.boundsTopRight.y);
                maxY = Math.max(maxY, transformTool.boundsBottomRight.y);
                maxY = Math.max(maxY, transformTool.boundsBottomLeft.y);
                x = maxX;
                y = maxY;
            };
        }
        private function resetClick(event:MouseEvent):void{
            var origReg:Point = transformTool.registration;
            transformTool.globalMatrix = new Matrix();
            var regDiff:Point = origReg.subtract(transformTool.registration);
            var toolMatrix:Matrix = transformTool.toolMatrix;
            toolMatrix.tx = (toolMatrix.tx + regDiff.x);
            toolMatrix.ty = (toolMatrix.ty + regDiff.y);
            transformTool.toolMatrix = toolMatrix;
            transformTool.apply();
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 

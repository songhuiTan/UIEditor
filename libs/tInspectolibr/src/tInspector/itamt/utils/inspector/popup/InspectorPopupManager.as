//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.popup {
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.geom.*;
    import flash.display.*;

    public class InspectorPopupManager {

        private static var _childs:Array;

        public static function init():void{
            InspectorStageReference.addEventListener(PopupEvent.ADD, onAddPopup);
            InspectorStageReference.addEventListener(PopupEvent.REMOVE, onRemovePopup);
        }
        public static function dispose():void{
            InspectorStageReference.removeEventListener(PopupEvent.ADD, onAddPopup);
            InspectorStageReference.removeEventListener(PopupEvent.REMOVE, onRemovePopup);
        }
        private static function onRemovePopup(event:PopupEvent):void{
            popup(event.popup);
        }
        private static function onAddPopup(event:PopupEvent):void{
            remove(event.popup);
        }
        private static function reviseTipPanelPos(dp:DisplayObject):void{
            var needRevise:Boolean;
            if (dp == null){
                return;
            };
            var gpt:Point = InspectorStageReference.getBounds(dp).topLeft;
            var rect:Rectangle = InspectorStageReference.getStageBounds();
            if (gpt.x > (rect.right - dp.width)){
                gpt.x = ((gpt.x - dp.width) - 16);
                needRevise = true;
            };
            if (gpt.x < rect.left){
                gpt.x = rect.left;
                needRevise = true;
            };
            if (gpt.y > (rect.bottom - dp.height)){
                gpt.y = (gpt.y - dp.height);
                needRevise = true;
            };
            if (gpt.y < rect.top){
                needRevise = true;
            };
            if (needRevise){
                gpt = dp.parent.globalToLocal(gpt);
                dp.x = gpt.x;
                dp.y = gpt.y;
            };
        }
        public static function popup(dp:DisplayObject, alignMode:int=1):void{
            if (_childs == null){
                _childs = [];
            };
            var t:int = _childs.indexOf(dp);
            if (t >= 0){
                _childs.splice(t, 1);
            };
            _childs.push(dp);
            InspectorStageReference.addChild(dp);
            switch (alignMode){
                case PopupAlignMode.SHOW_ALL:
                    reviseTipPanelPos(dp);
                    break;
                case PopupAlignMode.CENTER:
                    InspectorStageReference.centerOnStage(dp);
                    break;
                case PopupAlignMode.TL:
                    break;
            };
        }
        public static function remove(dp:DisplayObject):void{
            var t:int = _childs.indexOf(dp);
            if (t >= 0){
                _childs.splice(t, 1);
            };
            if (dp.stage){
                dp.parent.removeChild(dp);
            };
        }
        public static function contains(dp:DisplayObject):Boolean{
            if (dp == null){
                return (false);
            };
            return ((_childs.indexOf(dp) >= 0));
        }

    }
}//package cn.itamt.utils.inspector.popup 

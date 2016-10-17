//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.popup {
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.inspector.events.*;
    import flash.geom.*;
    import flash.display.*;
    import tInspector.itamt.utils.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.events.*;

    public class InspectorTipsManager {

        private static var _tip:Sprite;
        private static var _target:DisplayObject;

        public static function init():void{
            InspectorStageReference.addEventListener(TipEvent.EVT_SHOW_TIP, onShowTip);
            InspectorStageReference.addEventListener(TipEvent.EVT_REMOVE_TIP, onRemoveTip);
        }
        public static function dispose():void{
            InspectorStageReference.removeEventListener(TipEvent.EVT_SHOW_TIP, onShowTip);
            InspectorStageReference.removeEventListener(TipEvent.EVT_REMOVE_TIP, onRemoveTip);
        }
        private static function onShowTip(evt:TipEvent):void{
            var rect:Rectangle;
            _target = (evt.target as DisplayObject);
            if (_tip){
                _tip.graphics.clear();
                DisplayObjectTool.removeAllChildren(_tip);
                InspectorPopupManager.remove(_tip);
                _tip = null;
            };
            _tip = new Sprite();
            _tip.filters = [new GlowFilter(0, 1, 16, 16, 1)];
            _tip.mouseEnabled = (_tip.mouseChildren = false);
            var _tf:TextField = InspectorTextField.create(evt.tip, 0xFFFFFF, 15, 5, 0, "left");
            _tf.y = (26 - _tf.height);
            _tip.addChild(_tf);
            var tipBg:Shape = new Shape();
            tipBg.graphics.beginFill(0);
            tipBg.graphics.drawRoundRect(0, (26 - _tf.height), (_tf.width + 10), _tf.height, 10, 10);
            tipBg.graphics.endFill();
            _tip.addChildAt(tipBg, 0);
            if (_target == null){
                InspectorPopupManager.popup(_tip, PopupAlignMode.CENTER);
            } else {
                rect = InspectorStageReference.getBounds(_target);
                _tip.x = (rect.x - 5);
                _tip.y = (rect.y + 25);
                InspectorPopupManager.popup(_tip);
            };
            evt.stopImmediatePropagation();
        }
        private static function onRemoveTip(evt:Event):void{
            if (_tip){
                _tip.graphics.clear();
                DisplayObjectTool.removeAllChildren(_tip);
                InspectorPopupManager.remove(_tip);
                _tip = null;
            };
            evt.stopImmediatePropagation();
        }

    }
}//package cn.itamt.utils.inspector.popup 

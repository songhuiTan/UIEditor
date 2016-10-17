﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.lang.*;

    public class InspectorViewPrevButton extends InspectorViewBrotherButton {

        public function InspectorViewPrevButton():void{
            super();
            _tip = InspectorLanguageManager.getStr("InspectPrev");
            this.active = _active;
        }
        override public function set active(value:Boolean):void{
            super.active = value;
            this.downState.scaleX = (this.upState.scaleX = (this.overState.scaleX = -1));
            this.downState.x = (this.upState.x = (this.overState.x = 23));
        }
        override public function set enabled(val:Boolean):void{
            super.enabled = val;
            this.downState.scaleX = (this.upState.scaleX = (this.overState.scaleX = -1));
            this.downState.x = (this.upState.x = (this.overState.x = 23));
        }

    }
}//package cn.itamt.utils.inspector.core.liveinspect 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {

    public class InspectorTabLabelButton extends InspectorLabelButton {

        public function InspectorTabLabelButton(label:String="按钮", active:Boolean=false){
            super(label, active);
        }
        override public function set active(value:Boolean):void{
            if (value){
                this.enabled = false;
                this.mouseEnabled = false;
            } else {
                this.enabled = true;
                this.mouseEnabled = true;
            };
            super.active = value;
        }

    }
}//package cn.itamt.utils.inspector.ui 

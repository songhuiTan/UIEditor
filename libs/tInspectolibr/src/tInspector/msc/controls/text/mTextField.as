//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.msc.controls.text {
    import flash.events.*;
    import flash.text.*;

    public class mTextField extends TextField {

        private var inited:Boolean;

        public function mTextField(){
            super();
            addEventListener(Event.ADDED_TO_STAGE, this.onAdded, false, 0, true);
            addEventListener(Event.REMOVED_FROM_STAGE, this.onRemoved, false, 0, true);
        }
        protected function init():void{
        }
        protected function destroy():void{
        }
        private function onAdded(evt:Event):void{
            if (this.inited){
                return;
            };
            this.inited = true;
            this.init();
        }
        private function onRemoved(evt:Event):void{
            this.inited = false;
            this.destroy();
        }

    }
}//package msc.controls.text 

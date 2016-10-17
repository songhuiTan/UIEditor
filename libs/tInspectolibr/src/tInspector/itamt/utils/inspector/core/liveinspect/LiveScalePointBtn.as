//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.core.liveinspect {
    import tInspector.itamt.utils.inspector.lang.*;

    public class LiveScalePointBtn extends LiveTransformPointBtn {

        public function LiveScalePointBtn(onMouseDown:Function=null, onMouseUp:Function=null, onDrag:Function=null){
            super(onMouseDown, onMouseUp, onDrag);
            _tip = InspectorLanguageManager.getStr("LiveScale");
        }
    }
}//package cn.itamt.utils.inspector.core.liveinspect 

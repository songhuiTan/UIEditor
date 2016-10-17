//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.swfinfo {
    import tInspector.itamt.utils.inspector.core.propertyview.*;

    public class SwfInfoViewPanel extends PropertyPanel {

        public function SwfInfoViewPanel(title:String="���"){
            super(240, 170, null, false);
            this.title = title;
            this.removeChild(this.viewMethodBtn);
            this.removeChild(this.viewPropBtn);
            this.removeChild(this.singletonBtn);
            this.removeChild(this.refreshBtn);
        }
    }
}//package cn.itamt.utils.inspector.plugins.swfinfo 

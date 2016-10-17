//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.plugins.stats {
    import tInspector.itamt.utils.inspector.ui.*;

    public class AppStatsViewPanel extends InspectorViewPanel {

        private var stats:Stats;

        public function AppStatsViewPanel(title:String=null):void{
            this.stats = new Stats();
            this.stats.mouseChildren = (this.stats.mouseEnabled = false);
            super(title, this.stats.width, this.stats.height);
            _padding = new Padding(30, 5, 5, 5);
            _resizer.visible = false;
            _minW = 70;
            _minH = 100;
            this.setContent(this.stats);
            this.resize(((70 + _padding.left) + _padding.right), ((100 + _padding.top) + _padding.bottom));
        }
    }
}//package cn.itamt.utils.inspector.plugins.stats 

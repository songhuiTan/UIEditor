//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.output {
    import tInspector.itamt.utils.*;
    import flash.display.*;

    public class DisplayObjectInfoOutPuter extends OutPuter {

        public function DisplayObjectInfoOutPuter(){
            super();
        }
        public function output(source:DisplayObject):String{
            if (source == null){
                return (null);
            };
            return (((((((((((((("[" + ClassTool.getShortClassName(source)) + "]") + "<font color=\"#990000\">[x:") + source.x) + ", y: ") + source.y) + "]</font><font color=\"#0000FF\">[w: ") + source.width) + ", h: ") + source.height) + "]</font><font color=\"#FF9900\">[r: ") + int(source.rotation)) + "°]</font>"));
        }

    }
}//package cn.itamt.utils.inspector.output 

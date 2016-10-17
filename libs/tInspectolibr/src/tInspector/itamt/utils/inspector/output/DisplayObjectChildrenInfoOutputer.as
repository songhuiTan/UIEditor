//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.output {
    import flash.display.*;
    import tInspector.itamt.utils.*;

    public class DisplayObjectChildrenInfoOutputer extends DisplayObjectInfoOutPuter {

        public function DisplayObjectChildrenInfoOutputer():void{
            super();
        }
        override public function output(source:DisplayObject):String{
            var tmp:DisplayObjectContainer;
            if ((source is DisplayObjectContainer)){
                tmp = (source as DisplayObjectContainer);
                return ((((((("[<font color=\"#99cc00\">" + source.name) + "</font>]childs:<font color=\"#000000\">") + tmp.numChildren) + "/") + DisplayObjectTool.getAllChildrenNum(tmp)) + "</font>"));
            };
            return ((("[" + source.name) + "]"));
        }

    }
}//package cn.itamt.utils.inspector.output 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.output {
    import tInspector.itamt.utils.inspector.ui.*;
    import tInspector.itamt.utils.*;
    import flash.display.*;

    public class StructureTreeItemInfoOutputer extends DisplayObjectInfoOutPuter {

        public function StructureTreeItemInfoOutputer(){
            super();
        }
        override public function output(source:DisplayObject):String{
            var c:uint = InspectorColorStyle.getObjectColor(source);
            var className:String = ClassTool.getShortClassName(source);
            return ((((((("<font color=\"#" + c.toString(16)) + "\">") + className) + "</font>(") + source.name) + ")"));
        }

    }
}//package cn.itamt.utils.inspector.output 

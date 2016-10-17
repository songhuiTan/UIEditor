//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf5 {
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionToString extends Action implements IAction {

        public function ActionToString(code:uint, length:uint){
            super(code, length);
        }
        public function toString(indent:uint=0):String{
            return ("[ActionToString]");
        }

    }
}//package com.codeazur.as3swf.data.actions.swf5 

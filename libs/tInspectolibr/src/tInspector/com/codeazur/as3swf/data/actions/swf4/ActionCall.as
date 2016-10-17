//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions.swf4 {
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class ActionCall extends Action implements IAction {

        public function ActionCall(code:uint, length:uint){
            super(code, length);
        }
        public function toString(indent:uint=0):String{
            return ("[ActionCall]");
        }

    }
}//package com.codeazur.as3swf.data.actions.swf4 

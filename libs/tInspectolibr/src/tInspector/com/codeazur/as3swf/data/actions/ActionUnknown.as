﻿//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions {
    import tInspector.com.codeazur.as3swf.*;

    public class ActionUnknown extends Action implements IAction {

        public function ActionUnknown(code:uint, length:uint){
            super(code, length);
        }
        override public function parse(data:SWFData):void{
            if (_length > 0){
                data.skipBytes(_length);
            };
        }
        public function toString(indent:uint=0):String{
            return (((("[????] Code: " + _code.toString(16)) + ", Length: ") + _length));
        }

    }
}//package com.codeazur.as3swf.data.actions 
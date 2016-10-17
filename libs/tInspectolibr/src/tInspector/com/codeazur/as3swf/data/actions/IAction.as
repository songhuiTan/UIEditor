//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.actions {
    import tInspector.com.codeazur.as3swf.*;

    public interface IAction {

        function get code():uint;
        function get length():uint;
        function parse(data:SWFData):void;
        function publish(data:SWFData):void;
        function toString(indent:uint=0):String;

    }
}//package com.codeazur.as3swf.data.actions 

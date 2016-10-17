//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.tags {
    import tInspector.com.codeazur.as3swf.*;
    import flash.utils.*;

    public interface ITag {

        function get type():uint;
        function get name():String;
        function get version():uint;
        function parse(data:SWFData, length:uint, version:uint):void;
        function publish(data:SWFData, version:uint):void;
        function toString(indent:uint=0):String;
        function get raw():ByteArray;
        function set raw(value:ByteArray):void;

    }
}//package com.codeazur.as3swf.tags 

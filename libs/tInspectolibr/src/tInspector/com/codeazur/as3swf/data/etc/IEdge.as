//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data.etc {
    import flash.geom.*;

    public interface IEdge {

        function get from():Point;
        function get to():Point;
        function get lineStyleIdx():uint;
        function get fillStyleIdx():uint;
        function get isDuplicate():Boolean;
        function set isDuplicate(value:Boolean):void;
        function reverseWithNewFillStyle(newFillStyleIdx:uint):IEdge;

    }
}//package com.codeazur.as3swf.data.etc 

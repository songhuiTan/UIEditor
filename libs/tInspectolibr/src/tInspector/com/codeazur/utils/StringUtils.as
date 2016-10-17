//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.utils {
    import flash.events.*;

    public class StringUtils {

        private static const SIGN_UNDEF:int = 0;
        private static const SIGN_POS:int = -1;
        private static const SIGN_NEG:int = 1;

        private static var i:int = 0;

        public static function trim(input:String):String{
            return (StringUtils.ltrim(StringUtils.rtrim(input)));
        }
        public static function ltrim(input:String):String{
            var size:Number;
            var i:Number;
            if (input != null){
                size = input.length;
                i = 0;
                while (i < size) {
                    if (input.charCodeAt(i) > 32){
                        return (input.substring(i));
                    };
                    i++;
                };
            };
            return ("");
        }
        public static function rtrim(input:String):String{
            var size:Number;
            var i:Number;
            if (input != null){
                size = input.length;
                i = size;
                while (i > 0) {
                    if (input.charCodeAt((i - 1)) > 32){
                        return (input.substring(0, i));
                    };
                    i--;
                };
            };
            return ("");
        }
        public static function simpleEscape(input:String):String{
            input = input.split("\n").join("\\n");
            input = input.split("\r").join("\\r");
            input = input.split("\t").join("\\t");
            input = input.split("\f").join("\\f");
            input = input.split("\b").join("\\b");
            return (input);
        }
        public static function strictEscape(input:String, trim:Boolean=true):String{
            var a:Array;
            var i:uint;
            if (((!((input == null))) && ((input.length > 0)))){
                if (trim){
                    input = StringUtils.trim(input);
                };
                input = encodeURIComponent(input);
                a = input.split("");
                i = 0;
                while (i < a.length) {
                    switch (a[i]){
                        case "!":
                            a[i] = "%21";
                            break;
                        case "'":
                            a[i] = "%27";
                            break;
                        case "(":
                            a[i] = "%28";
                            break;
                        case ")":
                            a[i] = "%29";
                            break;
                        case "*":
                            a[i] = "%2A";
                            break;
                        case "-":
                            a[i] = "%2D";
                            break;
                        case ".":
                            a[i] = "%2E";
                            break;
                        case "_":
                            a[i] = "%5F";
                            break;
                        case "~":
                            a[i] = "%7E";
                            break;
                    };
                    i++;
                };
                return (a.join(""));
            };
            return ("");
        }
        public static function repeat(n:uint, str:String=" "):String{
            return (new Array((n + 1)).join(str));
        }
        public static function printf(format:String, ... _args):String{
            var c:String;
            var flagSign:Boolean;
            var flagLeftAlign:Boolean;
            var flagAlternate:Boolean;
            var flagLeftPad:Boolean;
            var flagZeroPad:Boolean;
            var width:int;
            var precision:int;
            var type:String;
            var value:*;
            var j:int;
            var idx:int;
            var valueStr:String;
            var valueFloat:Number;
            var valueInt:int;
            var sign:int;
            var hasSign:Boolean;
            var widthIndex:int;
            var hasWidth:Boolean;
            var precisionIndex:int;
            var _local27:String;
            var _local28:Number;
            var numZerosToAppend:int;
            var dotPos:int;
            var numFill:int;
            var fillChar:String;
            var result:String = "";
            var indexValue:int;
            var isIndexed:int = -1;
            var typeLookup:String = "diufFeEgGxXoscpn";
            i = 0;
            while (i < format.length) {
                c = format.charAt(i);
                if (c == "%"){
                    if (++i < format.length){
                        c = format.charAt(i);
                        if (c == "%"){
                            result = (result + c);
                        } else {
                            flagSign = false;
                            flagLeftAlign = false;
                            flagAlternate = false;
                            flagLeftPad = false;
                            flagZeroPad = false;
                            width = -1;
                            precision = -1;
                            type = "";
                            idx = getIndex(format);
                            if ((((idx < -1)) || ((idx == 0)))){
                                trace("ERR parsing index");
                                break;
                            };
                            if (idx == -1){
                                if (isIndexed == 1){
                                    trace("ERR: indexed placeholder expected");
                                    break;
                                };
                                if (isIndexed == -1){
                                    isIndexed = 0;
                                };
                                indexValue++;
                            } else {
                                if (isIndexed == 0){
                                    trace("ERR: non-indexed placeholder expected");
                                    break;
                                };
                                if (isIndexed == -1){
                                    isIndexed = 1;
                                };
                                indexValue = idx;
                            };
                            while (((((((((((c = format.charAt(i)) == "+")) || ((c == "-")))) || ((c == "#")))) || ((c == " ")))) || ((c == "0")))) {
                                switch (c){
                                    case "+":
                                        flagSign = true;
                                        break;
                                    case "-":
                                        flagLeftAlign = true;
                                        break;
                                    case "#":
                                        flagAlternate = true;
                                        break;
                                    case " ":
                                        flagLeftPad = true;
                                        break;
                                    case "0":
                                        flagZeroPad = true;
                                        break;
                                };
                                if (++i == format.length){
                                    break;
                                };
                                c = format.charAt(i);
                            };
                            if (i == format.length){
                                break;
                            };
                            if (c == "*"){
                                widthIndex = 0;
                                if (++i == format.length){
                                    break;
                                };
                                idx = getIndex(format);
                                if ((((idx < -1)) || ((idx == 0)))){
                                    trace("ERR parsing index for width");
                                    break;
                                };
                                if (idx == -1){
                                    if (isIndexed == 1){
                                        trace("ERR: indexed placeholder expected for width");
                                        break;
                                    };
                                    if (isIndexed == -1){
                                        isIndexed = 0;
                                    };
                                    var _temp1 = indexValue;
                                    indexValue = (indexValue + 1);
                                    widthIndex = _temp1;
                                } else {
                                    if (isIndexed == 0){
                                        trace("ERR: non-indexed placeholder expected for width");
                                        break;
                                    };
                                    if (isIndexed == -1){
                                        isIndexed = 1;
                                    };
                                    widthIndex = idx;
                                };
                                widthIndex--;
                                if ((((_args.length > widthIndex)) && ((widthIndex >= 0)))){
                                    width = parseInt(_args[widthIndex]);
                                    if (isNaN(width)){
                                        width = -1;
                                        trace("ERR NaN while parsing width");
                                        break;
                                    };
                                } else {
                                    trace("ERR index out of bounds while parsing width");
                                    break;
                                };
                                c = format.charAt(i);
                            } else {
                                hasWidth = false;
                                while ((((c >= "0")) && ((c <= "9")))) {
                                    if (width == -1){
                                        width = 0;
                                    };
                                    width = ((width * 10) + uint(c));
                                    if (++i == format.length){
                                        break;
                                    };
                                    c = format.charAt(i);
                                };
                                if (((!((width == -1))) && ((i == format.length)))){
                                    trace("ERR eof while parsing width");
                                    break;
                                };
                            };
                            if (c == "."){
                                if (++i == format.length){
                                    break;
                                };
                                c = format.charAt(i);
                                if (c == "*"){
                                    precisionIndex = 0;
                                    if (++i == format.length){
                                        break;
                                    };
                                    idx = getIndex(format);
                                    if ((((idx < -1)) || ((idx == 0)))){
                                        trace("ERR parsing index for precision");
                                        break;
                                    };
                                    if (idx == -1){
                                        if (isIndexed == 1){
                                            trace("ERR: indexed placeholder expected for precision");
                                            break;
                                        };
                                        if (isIndexed == -1){
                                            isIndexed = 0;
                                        };
                                        var _temp2 = indexValue;
                                        indexValue = (indexValue + 1);
                                        precisionIndex = _temp2;
                                    } else {
                                        if (isIndexed == 0){
                                            trace("ERR: non-indexed placeholder expected for precision");
                                            break;
                                        };
                                        if (isIndexed == -1){
                                            isIndexed = 1;
                                        };
                                        precisionIndex = idx;
                                    };
                                    precisionIndex--;
                                    if ((((_args.length > precisionIndex)) && ((precisionIndex >= 0)))){
                                        precision = parseInt(_args[precisionIndex]);
                                        if (isNaN(precision)){
                                            precision = -1;
                                            trace("ERR NaN while parsing precision");
                                            break;
                                        };
                                    } else {
                                        trace("ERR index out of bounds while parsing precision");
                                        break;
                                    };
                                    c = format.charAt(i);
                                } else {
                                    while ((((c >= "0")) && ((c <= "9")))) {
                                        if (precision == -1){
                                            precision = 0;
                                        };
                                        precision = ((precision * 10) + uint(c));
                                        if (++i == format.length){
                                            break;
                                        };
                                        c = format.charAt(i);
                                    };
                                    if (((!((precision == -1))) && ((i == format.length)))){
                                        trace("ERR eof while parsing precision");
                                        break;
                                    };
                                };
                            };
                            switch (c){
                                case "h":
                                case "l":
                                    if (++i == format.length){
                                        trace("ERR eof after length");
                                        break;
                                    };
                                    _local27 = format.charAt(i);
                                    if ((((((c == "h")) && ((_local27 == "h")))) || ((((c == "l")) && ((_local27 == "l")))))){
                                        if (++i == format.length){
                                            trace("ERR eof after length");
                                            break;
                                        };
                                        c = format.charAt(i);
                                    } else {
                                        c = _local27;
                                    };
                                    break;
                                case "L":
                                case "z":
                                case "j":
                                case "t":
                                    if (++i == format.length){
                                        trace("ERR eof after length");
                                        break;
                                    };
                                    c = format.charAt(i);
                                    break;
                            };
                            if (typeLookup.indexOf(c) >= 0){
                                type = c;
                            } else {
                                trace(("ERR unknown type: " + c));
                                break;
                            };
                            if ((((_args.length >= indexValue)) && ((indexValue > 0)))){
                                value = _args[(indexValue - 1)];
                            } else {
                                trace((("ERR value index out of bounds (" + indexValue) + ")"));
                                break;
                            };
                            sign = SIGN_UNDEF;
                            switch (type){
                                case "s":
                                    valueStr = value.toString();
                                    if (precision != -1){
                                        valueStr = valueStr.substr(0, precision);
                                    };
                                    break;
                                case "c":
                                    valueStr = value.toString().getAt(0);
                                    break;
                                case "d":
                                case "i":
                                    valueInt = ((typeof(value))=="number") ? int(value) : parseInt(value);
                                    valueStr = Math.abs(valueInt).toString();
                                    sign = ((valueInt)<0) ? SIGN_NEG : SIGN_POS;
                                    break;
                                case "u":
                                    valueStr = ((typeof(value))=="number") ? String(value) : uint(parseInt(value)).toString();
                                    break;
                                case "f":
                                case "F":
                                case "e":
                                case "E":
                                case "g":
                                case "G":
                                    if (precision == -1){
                                        precision = 6;
                                    };
                                    _local28 = Math.pow(10, precision);
                                    valueFloat = ((typeof(value))=="number") ? Number(value) : parseFloat(value);
                                    valueStr = (Math.round((Math.abs(valueFloat) * _local28)) / _local28).toString();
                                    if (precision > 0){
                                        dotPos = valueStr.indexOf(".");
                                        if (dotPos == -1){
                                            valueStr = (valueStr + ".");
                                            numZerosToAppend = precision;
                                        } else {
                                            numZerosToAppend = (precision - ((valueStr.length - dotPos) - 1));
                                        };
                                        j = 0;
                                        while (j < numZerosToAppend) {
                                            valueStr = (valueStr + "0");
                                            j++;
                                        };
                                    };
                                    sign = ((valueFloat)<0) ? SIGN_NEG : SIGN_POS;
                                    break;
                                case "x":
                                case "X":
                                case "p":
                                    valueStr = ((typeof(value))=="number") ? String(value) : parseInt(value).toString(16);
                                    if (type == "X"){
                                        valueStr = valueStr.toUpperCase();
                                    };
                                    break;
                                case "o":
                                    valueStr = ((typeof(value))=="number") ? String(value) : parseInt(value).toString(8);
                                    break;
                            };
                            hasSign = (((((sign == SIGN_NEG)) || (flagSign))) || (flagLeftPad));
                            if (width > -1){
                                numFill = (width - valueStr.length);
                                if (hasSign){
                                    numFill--;
                                };
                                if (numFill > 0){
                                    fillChar = (((flagZeroPad) && (!(flagLeftAlign)))) ? "0" : " ";
                                    if (flagLeftAlign){
                                        j = 0;
                                        while (j < numFill) {
                                            valueStr = (valueStr + fillChar);
                                            j++;
                                        };
                                    } else {
                                        j = 0;
                                        while (j < numFill) {
                                            valueStr = (fillChar + valueStr);
                                            j++;
                                        };
                                    };
                                };
                            };
                            if (hasSign){
                                if (sign == SIGN_POS){
                                    valueStr = ((flagLeftPad) ? " " : "0" + valueStr);
                                } else {
                                    valueStr = ("-" + valueStr);
                                };
                            };
                            result = (result + valueStr);
                        };
                    } else {
                        result = (result + c);
                    };
                } else {
                    result = (result + c);
                };
                i++;
            };
            return (result);
        }
        private static function getIndex(format:String):int{
            var result:int;
            var isIndexed:Boolean;
            var c:String = "";
            var iTmp:int = i;
            while (((((c = format.charAt(i)) >= "0")) && ((c <= "9")))) {
                isIndexed = true;
                result = ((result * 10) + uint(c));
                if (++i == format.length){
                    return (-2);
                };
            };
            if (isIndexed){
                if (c != "$"){
                    i = iTmp;
                    return (-1);
                };
                if (++i == format.length){
                    return (-2);
                };
                return (result);
            };
            return (-1);
        }

    }
}//package com.codeazur.utils 

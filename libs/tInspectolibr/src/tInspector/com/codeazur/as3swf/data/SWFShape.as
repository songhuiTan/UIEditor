//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.data {
    import __AS3__.vec.*;
    import tInspector.com.codeazur.as3swf.*;
    import flash.geom.*;
    import tInspector.com.codeazur.as3swf.data.etc.*;
    import tInspector.com.codeazur.as3swf.exporters.*;
    import tInspector.com.codeazur.as3swf.utils.*;
    import flash.display.*;
    import tInspector.com.codeazur.as3swf.data.consts.*;
    import tInspector.com.codeazur.utils.*;

    public class SWFShape {

        protected var _records:Vector.<SWFShapeRecord>;
        protected var tmpFillStyles:Vector.<SWFFillStyle>;
        protected var tmpLineStyles:Vector.<SWFLineStyle>;

        public function SWFShape(data:SWFData=null, level:uint=1){
            super();
            this._records = new Vector.<SWFShapeRecord>();
            if (data != null){
                this.parse(data, level);
            };
        }
        public function get records():Vector.<SWFShapeRecord>{
            return (this._records);
        }
        public function parse(data:SWFData, level:uint=1):void{
            data.resetBitsPending();
            var numFillBits:uint = data.readUB(4);
            var numLineBits:uint = data.readUB(4);
            this.readShapeRecords(data, numFillBits, numLineBits, level);
        }
        protected function readShapeRecords(data:SWFData, fillBits:uint, lineBits:uint, level:uint=1):void{
            var shapeRecord:SWFShapeRecord;
            var edgeRecord:Boolean;
            var straightFlag:Boolean;
            var numBits:uint;
            var states:uint;
            var styleChangeRecord:SWFShapeRecordStyleChange;
            while (!((shapeRecord is SWFShapeRecordEnd))) {
                edgeRecord = (data.readUB(1) == 1);
                if (edgeRecord){
                    straightFlag = (data.readUB(1) == 1);
                    numBits = (data.readUB(4) + 2);
                    if (straightFlag){
                        shapeRecord = data.readSTRAIGHTEDGERECORD(numBits);
                    } else {
                        shapeRecord = data.readCURVEDEDGERECORD(numBits);
                    };
                } else {
                    states = data.readUB(5);
                    if (states == 0){
                        shapeRecord = new SWFShapeRecordEnd();
                    } else {
                        styleChangeRecord = data.readSTYLECHANGERECORD(states, fillBits, lineBits, level);
                        if (styleChangeRecord.stateNewStyles){
                            fillBits = styleChangeRecord.numFillBits;
                            lineBits = styleChangeRecord.numLineBits;
                        };
                        shapeRecord = styleChangeRecord;
                    };
                };
                this._records.push(shapeRecord);
            };
        }
        public function export(handler:IShapeExportDocumentHandler=null):void{
            var xPos:Number;
            var yPos:Number;
            var from:Point;
            var to:Point;
            var control:Point;
            var shapeRecord:SWFShapeRecord;
            var _local16:SWFShapeRecordStyleChange;
            var _local17:SWFShapeRecordStraightEdge;
            var _local18:SWFShapeRecordCurvedEdge;
            var _local19:Number;
            var _local20:Number;
            xPos = 0;
            yPos = 0;
            var fillStyleIdxOffset:int;
            var lineStyleIdxOffset:int;
            var currentFillStyleIdx0:uint;
            var currentFillStyleIdx1:uint;
            var currentLineStyleIdx:uint;
            var path:Vector.<IEdge> = new Vector.<IEdge>();
            var subPath:Vector.<IEdge> = new Vector.<IEdge>();
            if (handler == null){
                handler = new DefaultShapeExportDocumentHandler();
            };
            var i:uint;
            while (i < this._records.length) {
                shapeRecord = this._records[i];
                switch (shapeRecord.type){
                    case SWFShapeRecord.TYPE_STYLECHANGE:
                        _local16 = (shapeRecord as SWFShapeRecordStyleChange);
                        if (((_local16.stateFillStyle0) || (_local16.stateFillStyle1))){
                            this.processSubPath(path, subPath, currentFillStyleIdx0, currentFillStyleIdx1);
                            subPath = new Vector.<IEdge>();
                        };
                        if (_local16.stateNewStyles){
                            fillStyleIdxOffset = this.tmpFillStyles.length;
                            lineStyleIdxOffset = this.tmpLineStyles.length;
                            this.appendFillStyles(this.tmpFillStyles, _local16.fillStyles);
                            this.appendLineStyles(this.tmpLineStyles, _local16.lineStyles);
                        };
                        if (_local16.stateLineStyle){
                            currentLineStyleIdx = _local16.lineStyle;
                            if (currentLineStyleIdx > 0){
                                currentLineStyleIdx = (currentLineStyleIdx + lineStyleIdxOffset);
                            };
                        };
                        if (_local16.stateFillStyle0){
                            currentFillStyleIdx0 = _local16.fillStyle0;
                            if (currentFillStyleIdx0 > 0){
                                currentFillStyleIdx0 = (currentFillStyleIdx0 + fillStyleIdxOffset);
                            };
                        };
                        if (_local16.stateFillStyle1){
                            currentFillStyleIdx1 = _local16.fillStyle1;
                            if (currentFillStyleIdx1 > 0){
                                currentFillStyleIdx1 = (currentFillStyleIdx1 + fillStyleIdxOffset);
                            };
                        };
                        if (_local16.stateMoveTo){
                            xPos = (_local16.moveDeltaX / 20);
                            yPos = (_local16.moveDeltaY / 20);
                        };
                        break;
                    case SWFShapeRecord.TYPE_STRAIGHTEDGE:
                        _local17 = (shapeRecord as SWFShapeRecordStraightEdge);
                        from = new Point(xPos, yPos);
                        if (_local17.generalLineFlag){
                            xPos = (xPos + (_local17.deltaX / 20));
                            yPos = (yPos + (_local17.deltaY / 20));
                        } else {
                            if (_local17.vertLineFlag){
                                yPos = (yPos + (_local17.deltaY / 20));
                            } else {
                                xPos = (xPos + (_local17.deltaX / 20));
                            };
                        };
                        to = new Point(xPos, yPos);
                        subPath.push(new StraightEdge(from, to, currentLineStyleIdx, currentFillStyleIdx1));
                        break;
                    case SWFShapeRecord.TYPE_CURVEDEDGE:
                        _local18 = (shapeRecord as SWFShapeRecordCurvedEdge);
                        from = new Point(xPos, yPos);
                        _local19 = (xPos + (_local18.controlDeltaX / 20));
                        _local20 = (yPos + (_local18.controlDeltaY / 20));
                        xPos = (_local19 + (_local18.anchorDeltaX / 20));
                        yPos = (_local20 + (_local18.anchorDeltaY / 20));
                        control = new Point(_local19, _local20);
                        to = new Point(xPos, yPos);
                        subPath.push(new CurvedEdge(from, control, to, currentLineStyleIdx, currentFillStyleIdx1));
                        break;
                    case SWFShapeRecord.TYPE_END:
                        this.processSubPath(path, subPath, currentFillStyleIdx0, currentFillStyleIdx1);
                        handler.beginShape();
                        this.exportFillPath(path, handler);
                        this.exportLinePath(path, handler);
                        handler.endShape();
                        break;
                };
                i++;
            };
        }
        protected function exportFillPath(fillPath:Vector.<IEdge>, handler:IShapeExportDocumentHandler):void{
            var e:* = null;
            var fillStyle:* = null;
            var colors:* = null;
            var alphas:* = null;
            var ratios:* = null;
            var gradientRecord:* = null;
            var gri:* = 0;
            var c:* = null;
            var fillPath:* = fillPath;
            var handler:* = handler;
            var path:* = this.sortFillPath(fillPath);
            var fillStyleIdx:* = uint.MAX_VALUE;
            var pos:* = new Point(Number.MAX_VALUE, Number.MAX_VALUE);
            var hasFills:* = false;
            var hasOpenFill:* = false;
            var i:* = 0;
            while (i < path.length) {
                e = path[i];
                if (fillStyleIdx != e.fillStyleIdx){
                    fillStyleIdx = e.fillStyleIdx;
                    if (fillStyleIdx == 0){
                        if (hasOpenFill){
                            handler.endFill();
                            hasOpenFill = false;
                        };
                    } else {
                        if (!(hasFills)){
                            handler.beginFills();
                            hasFills = true;
                        };
                        hasOpenFill = true;
                        try {
                            fillStyle = this.tmpFillStyles[(fillStyleIdx - 1)];
                            switch (fillStyle.type){
                                case 0:
                                    handler.beginFill(ColorUtils.rgb(fillStyle.rgb), ColorUtils.alpha(fillStyle.rgb));
                                    break;
                                case 16:
                                case 18:
                                case 19:
                                    colors = [];
                                    alphas = [];
                                    ratios = [];
                                    gri = 0;
                                    while (gri < fillStyle.gradient.records.length) {
                                        gradientRecord = fillStyle.gradient.records[gri];
                                        colors.push(ColorUtils.rgb(gradientRecord.color));
                                        alphas.push(ColorUtils.alpha(gradientRecord.color));
                                        ratios.push(gradientRecord.ratio);
                                        gri = (gri + 1);
                                    };
                                    handler.beginGradientFill(((fillStyle.type)==16) ? GradientType.LINEAR : GradientType.RADIAL, colors, alphas, ratios, fillStyle.gradientMatrix.matrix, GradientSpreadMode.toString(fillStyle.gradient.spreadMode), GradientInterpolationMode.toString(fillStyle.gradient.interpolationMode), fillStyle.gradient.focalPoint);
                                    break;
                                case 64:
                                case 65:
                                case 66:
                                case 67:
                                    handler.beginBitmapFill(fillStyle.bitmapId, fillStyle.bitmapMatrix.matrix, (((fillStyle.type == 64)) || ((fillStyle.type == 66))), (((fillStyle.type == 64)) || ((fillStyle.type == 65))));
                                    break;
                                default:
                                    hasOpenFill = false;
                            };
                        } catch(e:Error) {
                            handler.beginFill(0);
                        };
                    };
                };
                if (hasOpenFill){
                    if (!(pos.equals(e.from))){
                        handler.moveTo(e.from.x, e.from.y);
                    };
                    if ((e is CurvedEdge)){
                        c = CurvedEdge(e);
                        handler.curveTo(c.control.x, c.control.y, c.to.x, c.to.y);
                    } else {
                        handler.lineTo(e.to.x, e.to.y);
                    };
                };
                pos = e.to;
                i = (i + 1);
            };
            if (hasOpenFill){
                handler.endFill();
            };
            if (hasFills){
                handler.endFills();
            };
        }
        protected function exportLinePath(linePath:Vector.<IEdge>, handler:IShapeExportDocumentHandler):void{
            var lineStyle:* = null;
            var newLineStyle:* = false;
            var i:* = 0;
            var e:* = null;
            var scaleMode:* = null;
            var c:* = null;
            var linePath:* = linePath;
            var handler:* = handler;
            var path:* = new Vector.<IEdge>();
            var pos:* = new Point(Number.MAX_VALUE, Number.MAX_VALUE);
            var hasLines:* = false;
            var lineStyleIdx:* = 1;
            while (lineStyleIdx <= this.tmpLineStyles.length) {
                newLineStyle = true;
                try {
                    lineStyle = this.tmpLineStyles[(lineStyleIdx - 1)];
                } catch(e:Error) {
                    lineStyle = null;
                };
                i = 0;
                while (i < linePath.length) {
                    e = linePath[i];
                    if (!(e.isDuplicate)){
                        if (e.lineStyleIdx == lineStyleIdx){
                            if (!(hasLines)){
                                handler.beginLines();
                                hasLines = true;
                            };
                            if (newLineStyle){
                                if (lineStyle != null){
                                    scaleMode = LineScaleMode.NORMAL;
                                    if (((lineStyle.noHScaleFlag) && (lineStyle.noVScaleFlag))){
                                        scaleMode = LineScaleMode.NONE;
                                    } else {
                                        if (lineStyle.noHScaleFlag){
                                            scaleMode = LineScaleMode.HORIZONTAL;
                                        } else {
                                            if (lineStyle.noVScaleFlag){
                                                scaleMode = LineScaleMode.VERTICAL;
                                            };
                                        };
                                    };
                                    handler.lineStyle((lineStyle.width / 20), ColorUtils.rgb(lineStyle.color), ColorUtils.alpha(lineStyle.color), lineStyle.pixelHintingFlag, scaleMode, LineCapsStyle.toString(lineStyle.startCapsStyle), LineCapsStyle.toString(lineStyle.endCapsStyle), LineJointStyle.toString(lineStyle.jointStyle), lineStyle.miterLimitFactor);
                                } else {
                                    handler.lineStyle(0);
                                };
                                newLineStyle = false;
                            };
                            if (!(e.from.equals(pos))){
                                handler.moveTo(e.from.x, e.from.y);
                            };
                            if ((e is CurvedEdge)){
                                c = CurvedEdge(e);
                                handler.curveTo(c.control.x, c.control.y, c.to.x, c.to.y);
                            } else {
                                handler.lineTo(e.to.x, e.to.y);
                            };
                            pos = e.to;
                        };
                    };
                    i = (i + 1);
                };
                lineStyleIdx = (lineStyleIdx + 1);
            };
            if (hasLines){
                handler.endLines();
            };
        }
        protected function sortFillPath(path:Vector.<IEdge>):Vector.<IEdge>{
            var fillStyleIdx:uint;
            var posStart:Point;
            var i:uint;
            var e:IEdge;
            var oldPath:Vector.<IEdge> = path.concat();
            var newPath:Vector.<IEdge> = new Vector.<IEdge>();
            while (oldPath.length > 0) {
                i = 0;
                posStart = oldPath[0].from;
                fillStyleIdx = oldPath[0].fillStyleIdx;
                do  {
                    e = oldPath[i];
                    if (fillStyleIdx == e.fillStyleIdx){
                        newPath.push(e);
                        oldPath.splice(i, 1);
                        if (posStart.equals(e.to)){
                            break;
                        };
                    } else {
                        i++;
                    };
                } while (i < oldPath.length);
            };
            return (newPath);
        }
        protected function processSubPath(path:Vector.<IEdge>, subPath:Vector.<IEdge>, fillStyleIdx0:uint, fillStyleIdx1:uint):void{
            var j:int;
            var e:IEdge;
            var hasDuplicates:Boolean = ((!((fillStyleIdx0 == 0))) && (!((fillStyleIdx1 == 0))));
            if (((!((fillStyleIdx1 == 0))) || ((((fillStyleIdx0 == 0)) && ((fillStyleIdx1 == 0)))))){
                j = 0;
                while (j < subPath.length) {
                    path.push(subPath[j]);
                    j++;
                };
            };
            if (fillStyleIdx0 != 0){
                j = (subPath.length - 1);
                while (j >= 0) {
                    e = subPath[j].reverseWithNewFillStyle(fillStyleIdx0);
                    e.isDuplicate = hasDuplicates;
                    path.push(e);
                    j--;
                };
            };
        }
        protected function appendFillStyles(v1:Vector.<SWFFillStyle>, v2:Vector.<SWFFillStyle>):void{
            var i:uint;
            while (i < v2.length) {
                v1.push(v2[i]);
                i++;
            };
        }
        protected function appendLineStyles(v1:Vector.<SWFLineStyle>, v2:Vector.<SWFLineStyle>):void{
            var i:uint;
            while (i < v2.length) {
                v1.push(v2[i]);
                i++;
            };
        }
        public function toString(indent:uint=0):String{
            var str:String = (("\n" + StringUtils.repeat(indent)) + "Shapes:");
            var i:uint;
            while (i < this._records.length) {
                str = (str + (("\n" + StringUtils.repeat((indent + 2))) + this._records[i].toString((indent + 2))));
                i++;
            };
            return (str);
        }

    }
}//package com.codeazur.as3swf.data 

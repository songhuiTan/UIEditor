//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.com.codeazur.as3swf.factories {
    import tInspector.com.codeazur.as3swf.data.actions.swf3.*;
    import tInspector.com.codeazur.as3swf.data.actions.swf4.*;
    import tInspector.com.codeazur.as3swf.data.actions.swf7.*;
    import tInspector.com.codeazur.as3swf.data.actions.swf5.*;
    import tInspector.com.codeazur.as3swf.data.actions.swf6.*;
    import tInspector.com.codeazur.as3swf.data.actions.*;

    public class SWFActionFactory {

        public static function create(code:uint, length:uint):IAction{
            switch (code){
                case 4:
                    return (new ActionNextFrame(code, length));
                case 5:
                    return (new ActionPreviousFrame(code, length));
                case 6:
                    return (new ActionPlay(code, length));
                case 7:
                    return (new ActionStop(code, length));
                case 8:
                    return (new ActionToggleQuality(code, length));
                case 9:
                    return (new ActionStopSounds(code, length));
                case 10:
                    return (new ActionAdd(code, length));
                case 11:
                    return (new ActionSubtract(code, length));
                case 12:
                    return (new ActionMultiply(code, length));
                case 13:
                    return (new ActionDivide(code, length));
                case 14:
                    return (new ActionEquals(code, length));
                case 15:
                    return (new ActionLess(code, length));
                case 16:
                    return (new ActionAnd(code, length));
                case 17:
                    return (new ActionOr(code, length));
                case 18:
                    return (new ActionNot(code, length));
                case 19:
                    return (new ActionStringEquals(code, length));
                case 20:
                    return (new ActionStringLength(code, length));
                case 21:
                    return (new ActionStringExtract(code, length));
                case 23:
                    return (new ActionPop(code, length));
                case 24:
                    return (new ActionToInteger(code, length));
                case 28:
                    return (new ActionGetVariable(code, length));
                case 29:
                    return (new ActionSetVariable(code, length));
                case 32:
                    return (new ActionSetTarget2(code, length));
                case 33:
                    return (new ActionStringAdd(code, length));
                case 34:
                    return (new ActionGetProperty(code, length));
                case 35:
                    return (new ActionSetProperty(code, length));
                case 36:
                    return (new ActionCloneSprite(code, length));
                case 37:
                    return (new ActionRemoveSprite(code, length));
                case 38:
                    return (new ActionTrace(code, length));
                case 39:
                    return (new ActionStartDrag(code, length));
                case 40:
                    return (new ActionEndDrag(code, length));
                case 41:
                    return (new ActionStringLess(code, length));
                case 42:
                    return (new ActionThrow(code, length));
                case 43:
                    return (new ActionCastOp(code, length));
                case 44:
                    return (new ActionImplementsOp(code, length));
                case 48:
                    return (new ActionRandomNumber(code, length));
                case 49:
                    return (new ActionMBStringLength(code, length));
                case 50:
                    return (new ActionCharToAscii(code, length));
                case 51:
                    return (new ActionAsciiToChar(code, length));
                case 52:
                    return (new ActionGetTime(code, length));
                case 53:
                    return (new ActionMBStringExtract(code, length));
                case 54:
                    return (new ActionMBCharToAscii(code, length));
                case 55:
                    return (new ActionMBAsciiToChar(code, length));
                case 58:
                    return (new ActionDelete(code, length));
                case 59:
                    return (new ActionDelete2(code, length));
                case 60:
                    return (new ActionDefineLocal(code, length));
                case 61:
                    return (new ActionCallFunction(code, length));
                case 62:
                    return (new ActionReturn(code, length));
                case 63:
                    return (new ActionModulo(code, length));
                case 64:
                    return (new ActionNewObject(code, length));
                case 65:
                    return (new ActionDefineLocal2(code, length));
                case 66:
                    return (new ActionInitArray(code, length));
                case 67:
                    return (new ActionInitObject(code, length));
                case 68:
                    return (new ActionTypeOf(code, length));
                case 69:
                    return (new ActionTargetPath(code, length));
                case 70:
                    return (new ActionEnumerate(code, length));
                case 71:
                    return (new ActionAdd2(code, length));
                case 72:
                    return (new ActionLess2(code, length));
                case 73:
                    return (new ActionEquals2(code, length));
                case 74:
                    return (new ActionToNumber(code, length));
                case 75:
                    return (new ActionToString(code, length));
                case 76:
                    return (new ActionPushDuplicate(code, length));
                case 77:
                    return (new ActionStackSwap(code, length));
                case 78:
                    return (new ActionGetMember(code, length));
                case 79:
                    return (new ActionSetMember(code, length));
                case 80:
                    return (new ActionIncrement(code, length));
                case 81:
                    return (new ActionDecrement(code, length));
                case 82:
                    return (new ActionCallMethod(code, length));
                case 83:
                    return (new ActionNewMethod(code, length));
                case 84:
                    return (new ActionInstanceOf(code, length));
                case 85:
                    return (new ActionEnumerate2(code, length));
                case 96:
                    return (new ActionBitAnd(code, length));
                case 97:
                    return (new ActionBitOr(code, length));
                case 98:
                    return (new ActionBitXor(code, length));
                case 99:
                    return (new ActionBitLShift(code, length));
                case 100:
                    return (new ActionBitRShift(code, length));
                case 101:
                    return (new ActionBitURShift(code, length));
                case 102:
                    return (new ActionStrictEquals(code, length));
                case 103:
                    return (new ActionGreater(code, length));
                case 104:
                    return (new ActionStringGreater(code, length));
                case 105:
                    return (new ActionExtends(code, length));
                case 129:
                    return (new ActionGotoFrame(code, length));
                case 131:
                    return (new ActionGetURL(code, length));
                case 135:
                    return (new ActionStoreRegister(code, length));
                case 136:
                    return (new ActionConstantPool(code, length));
                case 138:
                    return (new ActionWaitForFrame(code, length));
                case 139:
                    return (new ActionSetTarget(code, length));
                case 140:
                    return (new ActionGotoLabel(code, length));
                case 141:
                    return (new ActionWaitForFrame2(code, length));
                case 142:
                    return (new ActionDefineFunction2(code, length));
                case 143:
                    return (new ActionTry(code, length));
                case 148:
                    return (new ActionWith(code, length));
                case 150:
                    return (new ActionPush(code, length));
                case 153:
                    return (new ActionJump(code, length));
                case 154:
                    return (new ActionGetURL2(code, length));
                case 155:
                    return (new ActionDefineFunction(code, length));
                case 157:
                    return (new ActionIf(code, length));
                case 158:
                    return (new ActionCall(code, length));
                case 159:
                    return (new ActionGotoFrame2(code, length));
                default:
                    return (new ActionUnknown(code, length));
            };
        }

    }
}//package com.codeazur.as3swf.factories 

//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils {
    import flash.utils.*;

    public class ObjectPool {

        private static var pools:Dictionary = new Dictionary();

        private static function getPool(type:Class):Array{
            return (((type in pools)) ? pools[type] : pools[type] = new Array());
        }
        public static function getObject(type:Class, ... _args){
            var pool:Array = getPool(type);
            if (pool.length > 0){
                return (pool.pop());
            };
            return (construct(type, _args));
        }
        public static function disposeObject(object, type:Class=null):void{
            var typeName:String;
            if (!(type)){
                typeName = getQualifiedClassName(object);
                type = (getDefinitionByName(typeName) as Class);
            };
            var pool:Array = getPool(type);
            pool.push(object);
        }
        public static function construct(type:Class, parameters:Array){
            switch (parameters.length){
                case 0:
                    return (new (type)());
                case 1:
                    return (new type(parameters[0]));
                case 2:
                    return (new type(parameters[0], parameters[1]));
                case 3:
                    return (new type(parameters[0], parameters[1], parameters[2]));
                case 4:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3]));
                case 5:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4]));
                case 6:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5]));
                case 7:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6]));
                case 8:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7]));
                case 9:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7], parameters[8]));
                case 10:
                    return (new type(parameters[0], parameters[1], parameters[2], parameters[3], parameters[4], parameters[5], parameters[6], parameters[7], parameters[8], parameters[9]));
                default:
                    return (null);
            };
        }

    }
}//package cn.itamt.utils 

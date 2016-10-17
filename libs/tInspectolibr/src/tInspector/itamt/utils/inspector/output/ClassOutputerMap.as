//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.output {
    import flash.utils.*;

    public class ClassOutputerMap {

        private var _map:Dictionary;

        public function ClassOutputerMap():void{
            super();
        }
        public function add(outputer:DisplayObjectInfoOutPuter, clazz:Class):void{
            if (this._map == null){
                this._map = new Dictionary(true);
            };
            this._map[clazz] = outputer;
        }
        public function getOutPuter(clazz:Class):DisplayObjectInfoOutPuter{
            return (this._map[clazz]);
        }

    }
}//package cn.itamt.utils.inspector.output 

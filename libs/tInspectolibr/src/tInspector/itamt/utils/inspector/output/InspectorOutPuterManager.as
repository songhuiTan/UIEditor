//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.output {

    public class InspectorOutPuterManager {

        private var _map:ClassOutputerMap;
        private var _defaultOutputer:DisplayObjectInfoOutPuter;

        public function InspectorOutPuterManager(defaultOutputer:DisplayObjectInfoOutPuter=null):void{
            super();
            this._defaultOutputer = ((defaultOutputer == null)) ? new DisplayObjectInfoOutPuter() : defaultOutputer;
        }
        public function setDefaultOutputer(outputer:DisplayObjectInfoOutPuter):void{
            this._defaultOutputer = outputer;
        }
        public function setClassOutputer(clazz:Class, outputer:DisplayObjectInfoOutPuter):void{
            if (this._map == null){
                this._map = new ClassOutputerMap();
            };
            this._map.add(outputer, clazz);
        }
        public function getOutputerByClass(clazz:Class):DisplayObjectInfoOutPuter{
            var outputer:DisplayObjectInfoOutPuter;
            if (this._map == null){
                outputer = this._defaultOutputer;
            } else {
                outputer = this._map.getOutPuter(clazz);
            };
            if (!(outputer)){
                outputer = this._defaultOutputer;
            };
            return (outputer);
        }
        public function getOutputerByInstance(instance:Object):DisplayObjectInfoOutPuter{
            return (this.getOutputerByClass((instance.constructor as Class)));
        }

    }
}//package cn.itamt.utils.inspector.output 

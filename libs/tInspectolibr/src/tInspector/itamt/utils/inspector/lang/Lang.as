//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.lang {

    public class Lang {

        public var file:XML;
        protected var _data:Object;
        protected var _builded:Boolean;

        protected function build():void{
            var item:String;
            var prop:String;
            var value:String;
            this._data = {};
            var str:String = this.file.toString();
            var rExp:RegExp = new RegExp("\\b\\S*\\s*=\\s*.*\\s", "g");
            var matches:Array = str.match(rExp);
            var i:int;
            while (i < matches.length) {
                item = matches[i];
                prop = this.trim(item.slice(0, item.indexOf("=")));
                value = this.trim(item.slice((item.indexOf("=") + 1)));
                this._data[prop] = value;
                i++;
            };
        }
        public function getTipValueString(tipStr:String):String{
            if (!(this._builded)){
                this.build();
            };
            var ret:String = this._data[tipStr];
            return ((Boolean(ret)) ? ret : tipStr);
        }
        private function trim(source:String, removeChars:String=" \n\t\r"):String{
            var pattern:RegExp = new RegExp((((("^[" + removeChars) + "]+|[") + removeChars) + "]+$"), "g");
            return (source.replace(pattern, ""));
        }

    }
}//package cn.itamt.utils.inspector.lang 

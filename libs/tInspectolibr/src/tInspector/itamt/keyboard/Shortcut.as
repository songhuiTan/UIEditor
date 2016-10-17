//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.keyboard {

    public class Shortcut {

        private var _keycodes:Array;

        public function Shortcut(keycodes:Array):void{
            super();
            this._keycodes = keycodes.sort();
        }
        public function get keycodes():Array{
            return (this.keycodes);
        }
        public function equalKeys(codes:Array):Boolean{
            var i:int;
            codes.sort();
            if (codes.length == this._keycodes.length){
                i = codes.length;
                while (i-- > 0) {
                    if (codes[i] != this._keycodes[i]){
                        return (false);
                    };
                };
                return (true);
            };
            return (false);
        }
        public function toString():String{
            return ((this._keycodes + ""));
        }

    }
}//package cn.itamt.keyboard 

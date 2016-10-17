//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.firefox.download {
    import flash.utils.*;

    public class LoadedStuffInfo {

        private var _url:String;
        private var _mime:String;
        private var _date:Date;
        private var _time:int;
        private var _name:String;
        private var _path:String;

        public function LoadedStuffInfo(url:String, mime:String=null):void{
            super();
            this._url = url;
            this._mime = mime;
            this._name = this.getFileNameFromUrl();
            this._path = this.getFilePathFromUrl();
            this._date = new Date();
            this._time = getTimer();
        }
        public function toString():String{
            return (((this._url + ", ") + this._mime));
        }
        public function get url():String{
            return (this._url);
        }
        public function get contentType():String{
            return (this._mime);
        }
        public function get name():String{
            return (this._name);
        }
        public function get path():String{
            return (this._path);
        }
        private function getFileNameFromUrl():String{
            var ret:String;
            var t:String = ((this._url.indexOf("?"))>=0) ? this._url.substring(0, this._url.indexOf("?")) : this._url;
            var start:int = ((t.lastIndexOf("/"))>=0) ? (t.lastIndexOf("/") + 1) : 0;
            var end:int = ((t.indexOf("?", start))>=0) ? t.indexOf("?", start) : t.length;
            ret = t.substring(start, end);
            return (ret);
        }
        private function getFilePathFromUrl():String{
            var ret:String;
            var t:String = ((this._url.indexOf("?"))>=0) ? this._url.substring(0, this._url.indexOf("?")) : this._url;
            ret = t.substring(0, (t.lastIndexOf("/") + 1));
            return (ret);
        }

    }
}//package cn.itamt.utils.inspector.firefox.download 

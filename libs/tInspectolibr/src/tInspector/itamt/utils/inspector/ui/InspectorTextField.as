//Created by Action Script Viewer - http://www.buraks.com/asv
package tInspector.itamt.utils.inspector.ui {
    import flash.text.*;

    public class InspectorTextField extends TextField {

        private static var fontName:String;
        public static var fonts:Array = ["Verdana", "Lucida Console", "Monaco", "Comic Sans MS"];

        private var defaultTfmHtmlStr:String;

        public function InspectorTextField(text:String="tInspector", color:uint=0xFFFFFF, size:uint=14, x:Number=0, y:Number=0, autoSize:String="none", align:String="left"){
            super();
            var tfm:TextFormat = new TextFormat();
            tfm.size = size;
            tfm.align = align;
            if (fontName == null){
                fontName = getNameOfFirstAvaliableFont(fonts);
                if (fontName == null){
                    fontName = "none";
                };
            };
            if (fontName != "none"){
                tfm.font = fontName;
            };
            this.setTextFormat(tfm);
            this.defaultTextFormat = tfm;
            this.text = text;
            this.textColor = color;
            this.autoSize = autoSize;
            this.x = x;
            this.y = y;
        }
        public static function create(text:String="tInspector", color:uint=0xFFFFFF, size:uint=14, x:Number=0, y:Number=0, autoSize:String="none", align:String="left"):InspectorTextField{
            return (new InspectorTextField(text, color, size, x, y, autoSize, align));
        }
        public static function getNameOfFirstAvaliableFont(arr:Array):String{
            var a:int;
            var allFonts:Array = Font.enumerateFonts(true);
            var i:int;
            while (i < arr.length) {
                a = 0;
                while (a < allFonts.length) {
                    if ((allFonts[a] as Font).fontName == arr[i]){
                        return (arr[i]);
                    };
                    a++;
                };
                i++;
            };
            return (null);
        }

        override public function set defaultTextFormat(tfm:TextFormat):void{
            super.defaultTextFormat = tfm;
            super.htmlText = "-";
            var t:int = this.htmlText.indexOf("-</");
            this.defaultTfmHtmlStr = (this.htmlText.slice(0, t) + this.htmlText.slice((t + 1)));
            super.htmlText = "";
        }
        override public function set htmlText(value:String):void{
            var t:int;
            if (this.defaultTextFormat){
                t = this.defaultTfmHtmlStr.indexOf("</");
                super.htmlText = ((this.defaultTfmHtmlStr.substring(0, t) + value) + this.defaultTfmHtmlStr.substring(t));
            } else {
                super.htmlText = value;
            };
        }

    }
}//package cn.itamt.utils.inspector.ui 

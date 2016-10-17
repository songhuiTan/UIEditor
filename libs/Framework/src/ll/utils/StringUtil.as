package ll.utils
{
	import flash.text.Font;
	import flash.text.StyleSheet;

	public class StringUtil
	{
		public function StringUtil()
		{
		}
		
		/**
		 * 给16进制字符串补零(格式:00010002)
		 * @param pNum	需要补零的字符串
		 * @param pSum	16进制一共几位
		 * @return
		 */		
		public static function addZero(pNum:String, pSum:int):String
		{
			var num:int = pSum - pNum.length;
			var addStr:String="";
			for(var i:int=0; i<num; i++)
			{
				addStr += "0";
			}
			return addStr+pNum;
		}
		
		
		
		private static var _linkcss:StyleSheet;
		
		public static function getLinkCss():StyleSheet
		{
			if(_linkcss==null){
				_linkcss = new StyleSheet();
				_linkcss.parseCSS("a {color: #7FFF00;text-decoration:underline;} a:hover {color: #ffff00;text-decoration:underline;}");
			}			
			return 	_linkcss;
		}
		
		public static function trim(input:String):String
		{
			return ltrim(rtrim(input));
		}
		
		/**
		 *  去掉回车符
		 * @param input
		 * @return 
		 * 
		 */		
		public static function cutInputEnter(input:String):String
		{
			return  input.replace(/\r/g,"");
		}
		/**
		 * 去掉开头的空格 
		 * @param input
		 * @return 
		 * 
		 */		
		public static function ltrim(input:String):String
		{
			var size:Number=input.length;
			for (var i:Number=0; i < size; i++)
			{
				if (input.charCodeAt(i) > 32)
				{
					return input.substring(i);
				}
			}
			return "";
		}
		/**
		 * 去掉尾端的空格
		 * @param input
		 * @return 
		 */		
		public static function rtrim(input:String):String
		{
			var size:Number=input.length;
			for (var i:Number=size; i > 0; i--)
			{
				if (input.charCodeAt(i - 1) > 32)
				{
					return input.substring(0, i);
				}
			}
			return "";
		}
		/**判断字符是否为字符串*/
		public static function isWhitespace(char:String):Boolean
		{
			if (char.indexOf("　") != -1)
				return true;
			if (char.indexOf("") != -1)
				return true;
			if (char.indexOf(" ") != -1)
				return true;
			switch (char.charAt(char.length - 1))
			{
				case "\t":
				case "\r":
				case "\n":
				case "\f":
					return true;
				default:
					return false;
			}
		}
		/**判断字符长度*/
		public static function getStrLen(source:String):uint
		{
			if (!source)
				return 0;
			return source.replace(/[^\x00-\xff]/g, "kk").length;
		}
		
		/**数字转化为千位符的字符串*/
		//		public static function uintToStrKb(num:uint):String
		//		{
		//			var unitStr:String=num.toString();
		//			var unitLen:int=unitStr.toString().length;
		//			var off:int=unitLen % 3;
		//			var gas:int=unitLen / 3;
		//			var kbStr:String;
		//			if (off != 0)
		//			{
		//				kbStr=unitStr.substr(0, off) + ",";
		//			}
		//			else
		//			{
		//				kbStr="";
		//			}
		//			var i:int=0;
		//			while (i < gas)
		//			{
		//				kbStr+=unitStr.substr(off + i * 3, 3) + ",";
		//				i++;
		//			}
		//			return kbStr.substr(0, kbStr.length - 1);
		//		}
		/**
		 * @param name			锚标签
		 * @param eventValue	事件类型
		 */		
		public static function getHtmlLink(name:String,eventValue:String="",isBlod:Boolean=false,fontSize:int=12):String
		{
			var returnStr:String;
			if(isBlod){
				returnStr="<b>"+"<font "+"size='"+fontSize+"'>"+"<a href='event:"+eventValue +"'>" + 
					name + 
					"</a>"+"</font>"+"</b>";
			}else
			{
				returnStr="<font "+"size='"+fontSize+"'>"+"<a href='event:"+eventValue +"'>" + 
					name + 
					"</a>"+"</font>";
			}
			return returnStr;
		}
		
		/**
		 * 替代字符串的颜色，返回html
		 * 		注意：使用回默认颜色的都要加回默认颜色值
		 */		
		public static function replaceStrColor(str:String,color:String = "#FFFFFF"):String
		{
			var txtColor:Array = str.match(/#[0-9,a-f,A-F]{6}/g);
			var arr:Array = [];
			for each(var clr:String in txtColor){
				if(arr[clr]) continue;
				arr[clr] = true;
				str = replaceGanN(str);
				str = str.split(clr).join("</font><font color='"+ clr + "'>");
			}
			str = str.split("#magenta").join("</font><font color='#ff00ff'>");
			str = str.split("#realgreen").join("</font><font color='#00ff00'>");
			str = str.split("#realblue").join("</font><font color='#4badeb'>");
			str = str.split("#yellow").join("</font><font color='#ffff00'>");
			str = str.split("#white").join("</font><font color='#ffffff'>");
			str = str.split("#green").join("</font><font color='#a5ff18'>");
			str = str.split("#black").join("</font><font color='#000000'>");
			str = str.split("#blue").join("</font><font color='#4BADEB'>");
			str = str.split("#purple").join("</font><font color='#C54FD7'>");
			str = str.split("#red").join("</font><font color='#ff0021'>");
			str = str.split("#pink").join("</font><font color='#FFCCFF'>");
			str = str.split("#CO3").join("</font><font color='#db4ec5'>");
			str = str.split("#orange").join("</font><font color='#FFCC00'>");
			return "<font color='"+color+"'>"+str+"</font>";
		}
		
		/**
		 * 匹配替换\\n(用于xml里的\n)
		 * @param str
		 * 
		 */		
		public static function replaceGanN(str:String):String
		{
			var newStr:String = str.replace(/\\n/g, "\n");
			return newStr;
		}
		
		/**
		 * @param content	文字描述
		 * @param color		文字颜色
		 * @param size		文字大小
		 * @param isBold	是否粗体
		 * @return			获取htmlText 
		 */		
		public static function getColorfont(content:String,color:String="#FFFFFF",size:int=12,isBold:Boolean=false):String
		{
			var reStr:String="<font color='"+color+"' "+"size='"+size+"'>";
			if(isBold){
				reStr+="<b>"+content+"</b>"+"</font>";
			}else
			{
				reStr+=content+"</font>";
			}
			return reStr;
		}
		
		/**
		 * @param value		阿拉伯数字
		 * @return			中文数字 
		 */		
		private static var chinaNumArr:Array=["零","一","二","三","四","五","六","七","八","九","十"];
		public static function getChinaNum(value:int):String
		{
			if(value>10){
				return "";
			}
			return chinaNumArr[value]
		}
		
		
		
		/**
		 * 获取相同显示宽度的字符串
		 * @param value	原字符串
		 * @param start	字符串前需要填充的空格数
		 * @param max	字符串最大长度，以一个空格长度为基准，一个汉字=两个英文字母=两个空格
		 * @return 	新字符串
		 */		
		public static function getSameLenStr(value:String, start:uint = 2, max:uint = 15):String
		{
			for(var i:int = 0; i < start; i++)	//在字符传前面插入空格
			{
				value = " " + value;
			}
			
			var len:int = 0;
			while (i < value.length)	//获取字符串总长度，一个中文字的宽度=两个英文字母、数字、空格的宽度
			{
				if (value.charCodeAt(i) > 192) len += 2;
				else len++;
				i++;
			}  
			len += start;	//将添加的空格数加入总长度中
			
			while(len < max)	//在字符串后插入空格，直到等于预设字符长度
			{
				value += " ";
				len++;
			}
			return value;
		}
		/**
		 *检测是否有该字体 
		 * @param fontName
		 * @return 
		 * 
		 */		
		public static  function checkFontFamily(fontName:String):Boolean
		{
			var localFonts:Array = Font.enumerateFonts(true);
			var f:Font;
			var fName:String;
			var hasFont:Boolean = false;
			for (var i:int = 0, len:int = localFonts.length; i < len; i++) 
			{
				f = localFonts[i] as Font;
				fName = f.fontName;
				if (fName == fontName)
				{
					hasFont = true;
					return hasFont;
				}
			}
			return hasFont;
		}
		
		
		/**
		 * 过滤输入的字符
		 * @param srcStr 源字符串
		 * @param maxLen 最大字符串长度
		 * @return 返回过滤失败信息
		 */
		public static  function tofilterStringErr(srcStr:String, maxLen:uint):String
		{
			if(trim(srcStr) == "")
			{
				return "输入的字符不能为空"
			}
				
			if(isWhitespace(srcStr) )	{
				return "输入字符不能包含空格字符";
			}
			if (getStrLen(srcStr) > maxLen * 2){
				return "输入的字符超过了" + maxLen + "个字";
			}
			if (srcStr.indexOf("*") != -1 
				|| srcStr.indexOf("<") != -1 
				|| srcStr.indexOf(">") != -1 
				|| srcStr.indexOf("{") != -1 
				|| srcStr.indexOf("}") != -1
				|| srcStr.indexOf("&") != -1
				|| srcStr.indexOf("\"") != -1
				|| srcStr.indexOf("'") != -1){
				return "输入字符非法！";
			}
			return "";
		}
	}
}
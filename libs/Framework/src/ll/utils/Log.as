package  ll.utils
{
	import flash.text.TextField;
	
	public class Log
	{
		private static var txt:TextField
		/**
		 *  初始化输出终端 
		 * @param value
		 * 
		 */		
		public static function initMsgTerm(value:TextField):void{
			txt = value;
		}
		/**
		 * 显示调试信息
		 * @param pStr				调试信息
		 * @param isUsedLocalConn	是否使用本地链接显示 信息
		 */		
		public static function log(...param):void
		{
			if(txt==null)
			{
				return;
			}
			var myStr:String = param.join(", ") + "\n";
			txt.appendText(myStr);
			txt.scrollV=txt.maxScrollV;
		}
	}
}
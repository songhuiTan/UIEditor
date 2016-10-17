package ll.res.parsers
{
	import flash.utils.ByteArray;

	/**
	 * 文本资源解析器 
	 * @author silenxiao
	 * 
	 */	
	public class TextResParser extends BaseResParser
	{
		public function TextResParser()
		{
			super();
		}
		
		protected override function startParse(byteData:ByteArray):void
		{
			super.startParse(byteData);
			//todo 解析二进制数据
			
			parseComplete();
		}
		
		public override function isAsync():Boolean
		{
			return true;
		}
	}
}
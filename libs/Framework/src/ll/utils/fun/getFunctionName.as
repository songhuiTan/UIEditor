package ll.utils.fun
{
	import flash.display.Sprite;

	/**
	 * 获取函数的函数名
	 * @param fun 函数
	 * @author xiaohui
	 * @date 2013-6-28
	 */
	public function getFunctionName(fun:Function):String{
		try{
			var k:Sprite = Sprite(fun);
		}catch(err:Error){
			var fn:String = err.message.replace(/.+::(\w+\/\w+)\(\)\}\@.+/,"$1");
			return fn==err.message?(err.message.replace(/.+ (function\-\d+) .+/i,"$1")):fn;
		}
		return null;
	}
}
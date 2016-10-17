package ll.utils.fun
{
	/**
	 * debug输出函数。 效果等同于trace<br>
	 * 1.增加了是否是debug运行环境<br>
	 * 2.增加输出当前函数名和类名
	 * @arguments 需要输出的内容
	 * @author xiaohui
	 * @date 2013-6-28
	 */
	public function myTrace(... args):void
	{
		try	{
			var err:Error = new Error();
			var stackMsg:String = err.getStackTrace();
			if(stackMsg.search(/:[0-9]+]$/m) > -1){
				var caller:String = "[" + stackMsg.match(/[\w\/$]*\(\)/g)[1] + "]";
				trace(caller, args);
			}
		}catch(err:Error){
			
		}
	}
}
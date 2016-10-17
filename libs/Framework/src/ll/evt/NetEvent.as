package ll.evt
{
	
	public class NetEvent extends BaseEvent
	{
		/** 协议返回错误 */
		public static const EVT_ERROR:String = "ERROR|"
		public function NetEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
			
		}

	}
}
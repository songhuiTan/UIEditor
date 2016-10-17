package ll.ui.events
{
	import ll.evt.BaseEvent;
	
	public class WindowEvent extends BaseEvent
	{
		/**窗口活动处理*/
		public static var ACTIVE:String = "active";
		/**窗口关闭处理*/
		public static var CLOSE:String = "close";
		/**窗口最大化*/
		public static var MAXIMIZE:String = "maximize";
		/**窗口最小化*/
		public static var MINIMIZE:String = "minimize";
		/**窗口最大化*/
		public static var FOCUS_IN:String = "focus_in";
		/**窗口最小化*/
		public static var FOCUS_OUT:String = "focus_out";
		/**需重排位置*/
		public static var NEED_RELAYER:String = "need_relayer";
		
		public function WindowEvent(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}
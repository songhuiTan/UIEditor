package ll.ui.events
{
	import ll.evt.BaseEvent;
	
	public class KeyEvent extends  BaseEvent
	{
		/**ENTER*/
		public static var KEY_ENTER:String = "key_enter";
		public static var KEY_ENTER_CTRL:String = "key_enter_ctrl";
		/**DOWN AND UP*/
		public static var KEY_DOWN_UP:String = "key_down_up";
		/**数字键*/
		public static var KEY_NUMERIC:String = "key_numeric";
		/**ESCAPE*/
//		public static var KEY_ESCAPE:String = "key_escape";
		/**ESCAPE*/
		public static var KEY_HIDE:String = "key_hide";
		/**MOUNT*/
		public static var KEY_MOUNT:String = "key_mount";
		/**挂机*/
		public static var KEY_HANG:String = "key_hang";
		/**扩展栏*/
		public static var KEY_KUOZHAN:String = "key_kuozhan";
		
		public static var PRESS_BUTTON:String = "press_button";
		
		public static var KEY_EXPAND:String = "key_expand";
		
		public static var KEY_SPACE:String = "KEY_SPACE";
		
		public static var KEY_TAB:String = "key_tab";
		
		public function KeyEvent( type : String,v:Object=null, bubbles : Boolean = false, cancelable : Boolean = false )
		{
			super( type,v,bubbles , cancelable );
		}
	}
}
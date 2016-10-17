package ll.ui.events
{
	import ll.ui.managers.drag.DataSource;
	
	import flash.events.DataEvent;
	import flash.events.Event;

	public class DragEvent extends Event
	{
		public static const ITEM_DOUBL_CLICK:String = "itemDoubleClick";
		/** 项呈现器移动 */
		public static const ITEM_MOVE:String = "itemMove";
		/** 不同项呈现器组件间的移动 */
		public static const ITEM_MOVE_TO:String = "itemMoveTo";
		/** 项呈现器交换 */
		public static const ITEM_SWITCH:String = "itemSwitch";
		/** 项呈现器拖拽去除 */
		public static const ITEM_DROP:String = "itemDrop";
		
		public var dataSource:DataSource;
		public var dropTarget:Object;
		public function DragEvent(type:String, dataSource:DataSource, dropTarget:Object)
		{
			super(type);
			this.dataSource = dataSource;
			this.dropTarget = dropTarget;
		}
		
		override public function clone():Event
		{
			var cloneEvent:DragEvent = new DragEvent(type, dataSource, currentTarget);
			
			return cloneEvent;
		}
	}
}
package ll.ui.events
{
	import flash.events.Event;
	
	/**
	 * 集合类型数据改变事件
	 * @author DOM
	 */
	public class CollectionEvent extends Event
	{
		/**
		 * 指示集合添加了一个或多个项目。 
		 */		
		public static const ADD:String = "add";
		/**
		 * 指示项目已从 CollectionEvent.oldLocation确定的位置移动到 location确定的位置。 
		 */		
		public static const MOVE:String = "move";
		/**
		 * 指示集合应用了排序或/和筛选。
		 */		
		public static const REFRESH:String = "refresh";
		/**
		 * 指示集合删除了一个或多个项目。 
		 */		
		public static const REMOVE:String = "remove";
		/**
		 * 指示已替换由 CollectionEvent.location 属性确定的位置处的项目。 
		 */		
		public static const REPLACE:String = "replace";
		/**
		 * 指示已替换由 CollectionEvent.location 属性确定的位置处的项目。 
		 */		
		public static const SWITCH:String = "switch";
		/**
		 * 指示集合已彻底更改，需要进行重置。 
		 */		
		public static const RESET:String = "reset";
		/**
		 * 指示集合中一个或多个项目进行了更新。受影响的项目将存储在  CollectionEvent.items 属性中。 
		 */		
		public static const UPDATE:String = "update";
		/**
		 * 集合类数据发生改变 
		 */		
		public static const COLLECTION_CHANGE:String = "collectionChange";
		
		public function CollectionEvent(type:String, bubbles:Boolean = false,
										cancelable:Boolean = false,
										kind:String = null, location:int = -1,
										oldLocation:int = -1, items:Array = null,oldItems:Array=null)
		{
			super(type, bubbles, cancelable);
			
			this.kind = kind;
			this.location = location;
			this.oldLocation = oldLocation;
			this.items = items ? items : [];
			this.oldItems = oldItems?oldItems:[];
		}
		/**
		 * 指示发生的事件类型。此属性值可以是 CollectionEventKind 类中的一个值，也可以是 null，用于指示类型未知。 
		 */		
		public var kind:String;
		/**
		 * 受事件影响的项目的列表
		 */		
		public var items:Array;
		/**
		 * 仅当kind的值为CollectionEventKind.REPLACE时，表示替换前的项目列表
		 */		
		public var oldItems:Array;
		/**
		 * 如果 kind 值为 CollectionEventKind.ADD、 CollectionEventKind.MOVE、
		 * CollectionEventKind.REMOVE 或 CollectionEventKind.REPLACE，
		 * CollectionEventKind.UPDATE
		 * 则此属性为 items 属性中指定的项目集合中零号元素的的索引。 
		 */		
		public var location:int;
		/**
		 * 如果 kind 的值为 CollectionEventKind.MOVE，
		 * 则此属性为 items 属性中指定的项目在目标集合中原来位置的从零开始的索引。 
		 */		
		public var oldLocation:int;
		
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return formatToString("CollectionEvent", "kind", "location",
				"oldLocation", "type", "bubbles",
				"cancelable", "eventPhase");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone():Event
		{
			return new CollectionEvent(type, bubbles, cancelable, kind, location, oldLocation, items,oldItems);
		}
	}
}
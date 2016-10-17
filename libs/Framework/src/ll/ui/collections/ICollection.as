package ll.ui.collections
{
	import flash.events.IEventDispatcher;
	
	
	/**
	 * 列表的集合类数据源对象接口
	 * @author DOM
	 */
	public interface ICollection extends IEventDispatcher
	{
		
		/**
		 * 数据源
		 * 通常情况下请不要直接调用Array的方法操作数据源，否则对应的视图无法收到数据改变的通知。
		 * 若对数据源进行了排序或过滤等操作，请手动调用refresh()方法刷新数据。<br/>
		 */
		function get source():Array;
		
		function set source(value:Array):void;			
		/**
		 * 此集合中的项目数。0 表示不包含项目，而 -1 表示长度未知。
		 */		
		function get length():int;
		/**
		 * 向列表末尾添加指定项目。等效于 addItemAt(item, length)。
		 */		
		function addItem(item:Object):void;
		/**
		 * 在指定的索引处添加项目。
		 * 任何大于已添加项目的索引的项目索引都会增加 1。
		 * @throws RangeError 如果索引小于 0 或大于长度。
		 */		
		function addItemAt(item:Object, index:int):void;
		/**
		 * 获取指定索引处的项目。
		 * @throws RangeError 如果索引小于 0 或大于长度。
		 */		
		function getItemAt(index:int):Object;
		/**
		 * 如果项目位于列表中,返回该项目的索引。否则返回-1。
		 */		
		function getItemIndex(item:Object):int;
		/**
		 * 通知视图，某个项目的属性已更新。
		 */		
		function itemUpdated(item:Object):void;
		/**
		 * 删除列表中的所有项目。
		 */		
		function removeAll():void;
		/**
		 * 删除指定索引处的项目并返回该项目。原先位于此索引之后的所有项目的索引现在都向前移动一个位置。
		 * @throws RangeError 如果索引小于 0 或大于长度。
		 */		
		function removeItemAt(index:int):Object;
		/**
		 * 替换在指定索引处的项目，并返回该项目。
		 * @throws RangeError 如果索引小于 0 或大于长度。
		 */		
		function replaceItemAt(item:Object, index:int):Object;
		
		/**
		 * 交换指定索引处的项目 
		 * @param sourceItem
		 * @param sourceIndex
		 * @param targetItem
		 * @param targetIndex
		 * 
		 */		
		function switchItem(sourceIndex:int, targetIndex:int):void;
		/**
		 * 移动一个项目
		 * 在oldIndex和newIndex之间的项目，
		 * 若oldIndex小于newIndex,索引会减1
		 * 若oldIndex大于newIndex,索引会加1
		 * @return 被移动的项目
		 * @throws RangeError 如果索引小于 0 或大于长度。
		 */		
		function moveItemAt(oldIndex:int,newIndex:int):Object;
		
	}
}
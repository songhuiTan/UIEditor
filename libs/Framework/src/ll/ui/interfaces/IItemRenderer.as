package ll.ui.interfaces
{
	import flash.display.DisplayObject;
	
	import ll.ui.core.DataGroup;
	import ll.ui.core.UISprite;
	import ll.ui.renderer.ItemRenderer;

	public interface IItemRenderer extends IUISprite
	{
		/**
		 * 要呈示或编辑的数据。
		 */		
		function get data():Object;
		function set data(value:Object):void;
		/**
		 * 如果项呈示器可以将其自身显示为已选中，则包含 true。
		 */		
		function get selected():Boolean;
		function set selected(value:Boolean):void;
		/**
		 * 项呈示器的主机组件的数据提供程序中的项目索引。
		 */		
		function get itemIndex():int;
		function set itemIndex(value:int):void;
		
		/**
		 * 项呈现器被拖拽时，跟随鼠标的对象
		 */
		function  get dragTarget():DisplayObject;
		
		/**
		 * 项呈现器是否有效
		 */
		function get validated():Boolean;
		function set validated(value:Boolean):void;
		
		function set owner(value:DataGroup):void;
		function get owner():DataGroup;
	}
}
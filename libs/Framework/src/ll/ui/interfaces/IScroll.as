package ll.ui.interfaces
{
	public interface IScroll extends IUIComponent
	{
		/** 
		 * 滚动面板，鼠标滚轮滚动一次，移动多少行
		 * 默认3行
		 *  */
		function get mouseWheelLine():int;
		function set mouseWheelLine(value:int):void;
		
		function get lineWidth():int;
		function get lineHeight():int;
	}
}
package ll.ui.interfaces
{
	public interface IToolTip extends IUISprite,  IDispose
	{
		/**
		 * 工具提示的数据对象，通常为一个字符串。
		 */		
		function get toolTipData():Object;
		
		function set toolTipData(value:Object):void;
	}
}
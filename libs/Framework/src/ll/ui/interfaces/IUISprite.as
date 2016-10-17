package ll.ui.interfaces
{
	import flash.events.IEventDispatcher;

	/**
	 * 基础ui控件接口
	 * @author SilenXiao
	 * @date 2013-9-26
	 */
	public interface IUISprite extends IEventDispatcher
	{
		/** set/get创建UI组件的xml文档 */
		function set viewXml(xml:XML):void;
		function get viewXml():XML;
		
		function removeAllUIEvent():void;

		function set enable(value:Boolean):void;
		function get enable():Boolean;
		
		function set x(x:Number):void;
		function get x():Number;
		
		function set y(value:Number):void;
		function get y():Number;
		
		function set visible(value:Boolean):void;
		function get visible():Boolean;
		
//		function get displayObject():UISprite;
	}
}
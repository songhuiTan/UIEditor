package ll.ui.interfaces
{
	public interface IUIComponent extends IUISprite
	{
		function set width(value:Number):void;
		function get width():Number;
		function set height(value:Number):void;
		function get height():Number;
			
		function set size(value:String):void;
		
		function setsize(width:uint, height:uint):void
		
		/**
		* 设置当前组件为焦点对象
		*/		
		function setFocus():void;
		
		/**
		 * 当鼠标在组件上按下时，是否能够自动获得焦点的标志。注意：UIComponent的此属性默认值为false。
		 
		 function get focusEnabled():Boolean;
		 function set focusEnabled(value:Boolean):void;*/
	}
}
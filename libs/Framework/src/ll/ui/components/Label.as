package ll.ui.components
{
	import flash.events.TextEvent;
	import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.core.UITextField;

	
	public class Label extends UITextField
	{
		public function Label()
		{
			super();
			this.enable = false;
			this.defaultTextFormat = DefaultUIComponent.TEXT_FORMAT;
			this.autoSize = TextFieldAutoSize.LEFT;
		}
		
		/**
		 * 增加文本链接的回调函数 
		 * @param onLinkCallbackFn
		 * 
		 */		
		public function addLinkCallbackFn(ponLinkCallbackFn:Function):void
		{
			//加入默认的css效果
			if(!styleSheet)
			{
				this.styleSheet = DefaultUIComponent.styleSheet;
			}
			
			this.onLinkCallBackFn = ponLinkCallbackFn;
			if(!this.hasEventListener(TextEvent.LINK))
				this.addEventListener(TextEvent.LINK, onTextLink)
		}
		
		private function onTextLink(evt:TextEvent):void
		{
			if(onLinkCallBackFn!=null){
				onLinkCallBackFn.call(null,evt.text);	
			}
		}
	}
}
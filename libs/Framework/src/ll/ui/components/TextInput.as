package ll.ui.components
{
	import ll.ui.UIGlobals;
	
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import ll.ui.core.UITextField;

	public class TextInput extends UITextField
	{
		public function TextInput()
		{
			super();
			
			this.type = TextFieldType.INPUT;
			initTextFiledEvent();
		}
		
		protected function initTextFiledEvent():void
		{
			this.addEventListener(MouseEvent.CLICK, onFocusClick);
			this.addEventListener(FocusEvent.FOCUS_IN,onFocusIn);
			this.addEventListener(FocusEvent.FOCUS_OUT,onFocusOut);
		}
		
		/**
		 *焦点放到组件时变为输入状态 
		 * @param evt
		 * 
		 */		
		private function onFocusClick(evt:MouseEvent):void{
			setFocus();
		}
		
		protected var _focus:Boolean;
		/**
		 *焦点放到组件时变为输入状态 
		 * @param evt
		 * 
		 */	
		private function onFocusIn(evt:FocusEvent):void
		{
			setFocus();
		}
		
		/**
		 * 失去焦点 
		 * @param evt
		 * 
		 */		
		private function onFocusOut(evt:FocusEvent):void
		{
			_focus = false;
			if(this.text == "")
			{
				this.text = this._defaultValue;
			}
		}
		
		protected var _defaultValue:String="";
		public function set defaultValue(value:String):void
		{
			this._defaultValue = value;
			this.text = this._defaultValue;
		}
		
		public function get defaultValue():String
		{
			return _defaultValue;
		}
		
		/**
		 * 设置当前场景的焦点为当前对象 
		 * 
		 */		
		public override function setFocus():void
		{
			if(UIGlobals.stage)
			{
				UIGlobals.stage.focus = this;
				
				if(this._defaultValue == this.text)
					this.text = "";
				if(!_focus)
				{
					this.setSelection(0, this.text.length);
					_focus = true;
				}
			}
		}
		
		/**
		 *设置组件是否可编辑 
		 * @param value true为可编辑false为不可编辑
		 * 
		 */		
		public function set edit(value:Boolean):void{
			if(value){
				this.type = TextFieldType.INPUT;
				this.autoSize = TextFieldAutoSize.NONE
			} else {
				this.type = TextFieldType.DYNAMIC;
			}
		}
	}
}
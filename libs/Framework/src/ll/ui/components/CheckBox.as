package ll.ui.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class CheckBox extends Button
	{
		[Event(name="change", type="flash.events.Event")]
		
		public function CheckBox()
		{
			super();
		}
		
		/**
		 * 文字布局 
		 * 
		 */		
		protected override function relayoutTextField():void
		{
			if(_btnSkin && _textFiled)
			{
				if(_layoutType == 0)
				{
					_textFiled.x = _btnSkin.width;
				}else{
					_textFiled.x = 0
				}
				_textFiled.y = (this._btnSkin.height - this._textFiled.height) >> 1;
			}
		}
		
		/**
		 * 文字图片布局 
		 * 
		 */		
		protected override function relayoutTxtImg():void
		{
			if(_btnSkin && _txtImg && _txtImg.width > 0)
			{
				if(_layoutType == 0)
				{
					_txtImg.x = _btnSkin.width;
				}else{
					_txtImg.x = 0
				}
				_txtImg.y = (this._btnSkin.height - this._txtImg.height) >> 1;
			}
		}
		
		protected var _layoutType:uint;
		/**
		 * 设置文字的布局类型 
		 * @param value 0为文字在图片右边，1为文字在图片的左边, 2居中
		 * 
		 */		
		public function set layoutType(value:uint):void
		{
			_layoutType = value;
		}
		
		public function get layoutType():uint
		{
			return _layoutType;
		}
		
		protected var _checked:Boolean;
		
		/**
		 * 当前状态是否选中 
		 * @return 
		 * 
		 */		
		public function get checked():Boolean
		{
			return this._checked;
		}
		
		public function set checked(value:Boolean):void
		{
			if(this._checked == value)
				return;
			this._checked = value;
			if(value)
				this.toStatus(SELECT)
			else
				this.toStatus(NORMAL)
		}
		
		protected override function onClick(evt:MouseEvent):void
		{
			this.checked = !this._checked;
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected override function onMouseOver(evt:MouseEvent):void
		{
			if(_checked)
				return;
			super.onMouseOver(evt);
		}
		
		protected override function onMouseOut(evt:MouseEvent):void
		{
			if(_checked)
				return;
			super.onMouseOut(evt);
		}
	}
}
package ll.ui.components
{
	import flash.events.MouseEvent;
	
	import ll.ui.core.dx_internal;
	import ll.utils.HashMap;

	use namespace dx_internal;
	public class RadioButton extends CheckBox
	{
		private static var radioBtnGroups:HashMap
		
		public function RadioButton()
		{
			super();
		}
		
		protected var _groupName:String = "radioGroup";
		public function set groupName(value:String):void
		{
			this._groupName = value;
			if(!_radioBtnGroup)
			{
				addToGroup()
			}
		}
			
		public function get groupName():String
		{
			return this._groupName;
		}
		
		protected override function onClick(evt:MouseEvent):void
		{
			super.onClick(evt);
			
			refreshRadionGroupStatus();
		}
		
		/**
		 * 所属的RadioButtonGroup
		 */		
		dx_internal var _radioBtnGroup:Vector.<RadioButton> = null;
		
		/**
		 * 添此单选按钮加到组
		 */	
		private function addToGroup():void
		{
			if(!radioBtnGroups)
			{
				radioBtnGroups = new HashMap();
			}
			_radioBtnGroup = radioBtnGroups.get(_groupName);
			if(!_radioBtnGroup)
			{
				_radioBtnGroup = new Vector.<RadioButton>();
			}
			radioBtnGroups.put(_groupName, _radioBtnGroup);
			_radioBtnGroup.push(this);
		}
		
		protected function refreshRadionGroupStatus():void
		{
			for each(var radionBtn:RadioButton in _radioBtnGroup)
			{
				if(radionBtn != this)
				{
					radionBtn.checked = false;
				}
			}
		}
		
		/**
		 *刷新本文位置 
		 * 
		 */		
		protected override function relayoutTextField():void
		{
			if(_btnSkin && _textFiled)
			{
				if(_layoutType == 0)
				{
					_textFiled.x = _btnSkin.width;
				}else if(_layoutType == 1){
					_textFiled.x = 0
				}else{
					_textFiled.x = (this._btnSkin.width-this._textFiled.width) >> 1;
				}
				_textFiled.y = (this._btnSkin.height - this._textFiled.height) >> 1;
			}
		}
	}
}
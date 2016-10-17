package ll.ui.renderer
{
	import flash.events.MouseEvent;
	
	import ll.ui.components.Label;

	public dynamic class ListRenderer extends ItemRenderer
	{
		public var label:Label
		public function ListRenderer()
		{
			super();
			
			this.label = new Label();
			this.addChild(label);
			this.label.setLocation(2, 2);
		}
		
		protected override function dataUpdateHandle(value:Object):void
		{
			if(value is String )
				this.label.text = value.toString();
			else
			{
				if(_owner.labelField){
					this.label.text = value[this._owner.labelField];
				}
			}
		}
		
		
		/**
		 * @鼠标在格子上面
		 */
		protected override function onRollOver(evt:MouseEvent):void
		{
			if(this.label.text!=""){
				this.label.textColor=0X2DBB26;
			}
		}
		
		/**
		 * @鼠标移开格子
		 */
		protected override function onRollOut(evt:MouseEvent):void
		{
			if(this.label.text!=""){
				this.label.textColor=0x000000;
			}
		}
			
	}
}
package ll.ui.components
{
	import ll.ui.core.UIComponent;
	import ll.ui.interfaces.IToolTip;

	public class ToolTip extends Panel implements IToolTip 
	{
		protected var label:Label;
		public function ToolTip()
		{
			super();
		}
		
		private var _toolTipData:Object;
		public function get toolTipData():Object
		{
			return _toolTipData;
		}
		public function set toolTipData(value:Object):void
		{
			if(value is String)
			{
				if(!label)
				{
					label = new Label();
					label.textColor=0xFF0000;
					this.addChild(label);
				}
				label.text = String(value);
			}
		}
		
	}
}
package ll.ui.renderer
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIType;
	import ll.ui.components.RadioButton;

	public class TabBarRenderer extends ItemRenderer
	{
		private var radionBtn:RadioButton;
		public function TabBarRenderer()
		{
			super();
			
			radionBtn = DefaultUIComponent.createRadioButton(this,UIType.RADIOBTN_TAB);
			radionBtn.layoutType=2//0,1,分别是靠左和靠右			
//			radionBtn.groupName = "TabBar";
		}
		
		public override function set data(value:Object):void
		{
			if(value){
				radionBtn.label = value.lable;
				radionBtn.groupName =value.group;
			}
		}
		
		public override function set selected(value:Boolean):void
		{
			super.selected = value;
			if(value)
			{
				radionBtn.checked = true;
			}
		}
		
		
		public override function validateNow():void
		{
			super.validateNow();
			radionBtn.validateNow();
		}

		public function updeteBtnSkin(assetName:String):void
		{
			radionBtn.assetName=assetName;
		}
		
		public override  function setsize(width:uint, height:uint):void
		{
			radionBtn.setsize(width,height);
		}
		
		/**
		 * 选中更新处理
		 */
		protected override function selectedUpdateHandle(value:Boolean):void
		{
			if(value){
				radionBtn.checked=true;
			}else
			{
				radionBtn.checked=false;
			}
		}
		
	}
}
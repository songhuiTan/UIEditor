package ll.ui.components
{
	import ll.ui.collections.ICollection;
	import ll.ui.core.UIComponent;
	import ll.ui.renderer.ListRenderer;

	public class ComboBox extends UIComponent
	{
		private var list:List;
		private var scroller:Scroller
		
		public function ComboBox()
		{
			super();
		}
		
		public function set dataProvider(value:ICollection):void
		{
			this.list.dataProvider = value;
		}
		
		private function dataHandler(render:ListRenderer, data:Object):void
		{
			render.data = data[_labelField]
		}
		
		
		protected var _scrollshow:Boolean = true;
		/**
		 * 设置显示滚动条，默认显示
		 */
		public function set scrollshow(value:Boolean):void
		{
			if(this._scrollshow == value)
				return;
			this._scrollshow = value;
			intialDisplayList();
		}
		
		private function intialDisplayList():void
		{
			if(!list)
			{
				list = new List();
				list.itemRenderer = ListRenderer;
				list.dataHandler = dataHandler;
			}
			if(_scrollshow)
			{
				
				if(list.parent == this)
				{
					this.removeChild(list);
				}
				if(scroller == null)
				{
					scroller = new Scroller();
					this.addChild(scroller);
					scroller.visible = false;
					scroller.viewport = list;
				}
			}else{
				if(list.parent == scroller)
				{
					scroller.viewport = null; 
				}
				if(scroller)
				{
					this.removeChild(scroller);
					scroller.dispose();
					scroller = null;
				}
				this.addChild(list);
				list.visible = false;
			}
		}
		
		private var _labelField:String;
		
		public function set labelField(value:String):void
		{
			this._labelField = value;
		}
		
		
	}
}
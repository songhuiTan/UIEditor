package ll.ui.components
{
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIType;

	public class TitleWindow extends WindowModel
	{
		/** 关闭按钮 */
		protected var _btnClose:Button;
		/** 标题头 */
		protected var _imgTitle:Image;
		public function TitleWindow()
		{
			super();
			initialDisplayList();
		}
		
		protected function initialDisplayList():void
		{
			_btnClose = DefaultUIComponent.createButton(this, UIType.BTN_CLOSE);
			_btnClose.y = 5;
			
			_btnClose.addEventListener(MouseEvent.CLICK,onBtnClose);
				
			_imgTitle = DefaultUIComponent.createImg(this);
			_imgTitle.y = 5;
		}
		
		protected function onBtnClose(evt:MouseEvent):void
		{
			this.close();
		}
		
		public function set titleName(value:String):void
		{
			_imgTitle.setAssetName(onTitleImgLoaded, value);
		}
		
		private function onTitleImgLoaded():void
		{
			_imgTitle.x = (this.width - _imgTitle.width) >> 1;
		}
		
		protected override function commitSize():void
		{
			super.commitSize();
			
			_btnClose.x = this.width - _btnClose.width - 10;
			_imgTitle.x = (this.width - _imgTitle.width) >> 1;
			
			dragRect=new Rectangle(0,0,_btnClose.x,30);
		}
		
		
	}
}
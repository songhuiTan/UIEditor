package ll.ui.components
{
	import ll.ui.core.UIComponent;

	/**
	 * 进度条组件 
	 * @author silenxiao
	 * 
	 */	
	public class ProgressBar extends Panel 
	{
		public function ProgressBar()
		{
			super();
		}
		
		private var _proSkin:Image;
		
		/** 设置进度条资源 */
		public function setProAssetName(value:String):void
		{
			if(!_proSkin)
			{
				_proSkin = new Image();
				addChild(_proSkin);
			}
			_proSkin.assetName = value;
			if(_proSize)
			{
				this._proSkin.setsize(_proSize[0], _proSize[1]);
			}
		}
		
		/** 设置进度条的偏移位置 */
		public function setProOffsetPos(x:uint, y:uint):void
		{
			this._proSkin.x = x;
			this._proSkin.y = y;
		}
		
		private var _proSize:Array;;
		/** 设置进度条的大小 */
		public function setProSize(width:uint, height:uint):void
		{
			if(_proSkin)
				this._proSkin.setsize(width, height);
			else
			{
				_proSize = [width, height]
			}
		}
	}
}
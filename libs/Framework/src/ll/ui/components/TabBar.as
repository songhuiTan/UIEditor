package ll.ui.components
{
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIType;
	import ll.ui.collections.ArrayCollection;
	import ll.ui.collections.ICollection;
	import ll.ui.core.DataGroup;
	import ll.ui.renderer.ItemRenderer;
	import ll.ui.renderer.TabBarRenderer;
	/**
	 * 需要加click才能看到选中效果
	 * @author 
	 */	
	public class TabBar extends DataGroup
	{
		
		private  static  var instanceCounter:int;
		
		/** 垂直排版 */
		public const LAYOUT_VERTICAL:uint = 0;
		/** 水平排版 */
		public const LAYOUT_HORIZON:uint = 1;
		public function TabBar()
		{
			this.itemRenderer = TabBarRenderer;//super的时候会先用到render
			super();
			_assetName=DefaultUIComponent.uiTypeDic[UIType.RADIOBTN_TAB]
			_layoutType=LAYOUT_HORIZON;
			
		}
		
		override protected function commitDisplayList():void
		{
			const length:uint = indexToRenderer.length;
			var renderer:ItemRenderer 
			if(_assetName!=""){
				for(i= 0; i < length; i++)
				{
					renderer = indexToRenderer[i];
					if(renderer is TabBarRenderer){
						renderer.updeteBtnSkin(_assetName);
					}
				}
			}
			if(_renderSize!=""){
				var newWidth:int=_renderSize.split(",")[0];
				var newHeight:int=_renderSize.split(",")[1];
				for(i= 0; i < length; i++)
				{
					renderer = indexToRenderer[i];
					if(renderer is TabBarRenderer){
						renderer.setsize(newWidth,newHeight);
					}
				}
			}
			
			if(_layoutType == LAYOUT_VERTICAL)
			{
				for(var i:uint = 0; i < length; i++)
				{
					renderer= indexToRenderer[i];
					renderer.y = i * renderer.height;
				}
				if(renderer){
					setsize(renderer.width * i, renderer.height);
				}
			}else{
				for(i= 0; i < length; i++)
				{
					renderer = indexToRenderer[i];
					renderer.validateNow();
					renderer.x = i * renderer.width;
				}
				if(renderer){
					setsize(renderer.width * i, renderer.height);
				}
			}
		}
		
		protected var _layoutType:uint;
		/**
		 * 设置List的排版类型 
		 * @param value LAYOUT_VERTICAL垂直排版，LAYOUT_HORIZON水平排版
		 */		
		public function set layoutType(value:uint):void
		{
			_layoutType = value;	
		}
		
		public function get layoutType():uint
		{
			return _layoutType;
		}
		
		/**
		 * 设置图片资源的名字
		 * @param value [value为图片文字，从域中加载资源； 为路径是，动态加载资源]
		 */
		public function set assetName(value:String):void
		{
			_assetName=value;
			if(_assetName!=""){
				_dataProviderChanged=true;
				this.validateNow();
			}
		}
		protected  var _assetName:String="";
		public function get assetName():String
		{
			return _assetName;
		}
		
//		/**
//		 *  tabbar的源数据对象
//		 */		
//		private var _tabBarArray:ArrayCollection;
		
		/**
		 * 设置tab选项卡文本内容
		 */
		public function set lableStr(value:String):void
		{
			_lableStr=value;
			var dataArr:Array=_lableStr.split(",");
			var groupName:String="TabBar"+instanceCounter;
			instanceCounter++;
			for(var i:int=0;i<dataArr.length; i++){//需要相同的groupname
				dataArr[i]={lable:dataArr[i],group:groupName}
			}
			this.dataProvider.source=dataArr;
		}
		protected  var _lableStr:String="";
		public function get lableStr():String
		{
			return _lableStr;
		}
		
		
		/**
		 * 设置tab选项按钮宽高
		 */
		public function set renderSize(value:String):void
		{
			_renderSize=value;
			if(_renderSize!=""){
				_dataProviderChanged=true;
				this.validateNow();
			}
		}
		protected  var _renderSize:String="";
		public function get renderSize():String
		{
			return _renderSize;
		}
		
		
		
	}
}
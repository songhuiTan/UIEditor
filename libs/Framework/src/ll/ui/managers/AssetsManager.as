package ll.ui.managers
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	
	import ll.res.LoadManager;
	import ll.res.data.ResData;
	import ll.ui.core.ScaleBitmap;
	
	public class AssetsManager
	{
		/** 资源池 */
		private var assetPool:Array;
		/** 按钮资源池 */
		private var btnAssetPool:Array;
		/** 图片资源的九宫格配置 */
		private var scale9GridPool:Array;
		
		public function AssetsManager()
		{
			assetPool = [];
			scale9GridPool = [];
			btnAssetPool = [];
			this.init();
		}
		
		private function init():void
		{
			scale9GridPool["win_bg_11"]=new Rectangle(5,5,10,10);
			scale9GridPool["win_bg_14"]=new Rectangle(5,5,10,10);
			scale9GridPool["btn_common_21"]=new Rectangle(22,11,1,1);
			scale9GridPool["win_bg_12"]=new Rectangle(10,10,30,30);
			scale9GridPool["tab_up_1"]=new Rectangle(23,12,1,1);
			scale9GridPool["tab_up_2"]=new Rectangle(10,12,40,1);
			scale9GridPool["scroll_drag_1"]=new Rectangle(5,10,9,4);
//			scale9GridPool["scroll_down_1"]=new Rectangle(0,0,0,0);
//			scale9GridPool["scroll_up_1"]=new Rectangle(0,0,0,0);
			scale9GridPool["win_bg_1"]=new Rectangle(5,5,10,10);
			scale9GridPool["chat_info_bg"] = new Rectangle(5, 5, 319, 184);
			scale9GridPool["hchat_face_over"] = new Rectangle(1, 1, 24, 24);
			scale9GridPool["grid_select_4"] = new Rectangle(3, 3, 41, 41);
			scale9GridPool["mall_zi"] = new Rectangle(3, 3, 42, 42);
			scale9GridPool["bg_bandA"] = new Rectangle(30, 0, 259, 12);
		}
		
		
		
		private static var _instance:AssetsManager;
		public static function getInstance():AssetsManager
		{
			if(!_instance)
				_instance = new AssetsManager();
			return _instance;
		}
		
		/**
		 * 设置图片资源的名字
		 * @param assetName [assetName为图片文字，从域中加载资源； 为路径是，动态加载资源]
		 * @param callBack 资源加载完毕，执行回调函数，并将BitmapData作为回调函数的参数
		 */
		public function loadBmpData(assetName:String, callBack:Function):BitmapData
		{
			if(assetPool[assetName])
			{
				callBack(assetPool[assetName]);
				return assetPool[assetName];
			}
			
			if(assetName.indexOf("/") != -1)
			{//动态加载资源
				LoadManager.load(assetName, 
					function(data:*):void
					{
						if(data is Bitmap){
							assetPool[assetName] = Bitmap(data).bitmapData; 
						}
						callBack(assetPool[assetName]);
					}
				);
				return null;
			}else{
				//从域内获取资源
				var bmpdata:BitmapData = this.loadBmpDataFromDomain(assetName);
				assetPool[assetName] = bmpdata;
				callBack(bmpdata);
				return bmpdata;
			}
		}
		
		public function loadSwf(assetName:String, callBack:Function):ResData
		{
			if(assetPool[assetName])
			{
				callBack && callBack.apply(null, assetPool[assetName]);
				return null;
			}
			return LoadManager.load(assetName, 
				function(data:*):void
				{
					assetPool[assetName] = data; 
					callBack && callBack.apply(null, data);
				});
		}
		
		/**
		 * 获取切割的组件的皮肤
		 * @param assetName	按钮的名字
		 * @param isSinglet 是否为单态
		 * @return
		 */		
		public function getButtonSkin(assetName:String, bmpdata:BitmapData = null, isSinglet:Boolean=false):Array
		{
			if(!this.btnAssetPool[assetName])
			{
				var bmpdata:BitmapData = this.loadBmpDataFromDomain(assetName);
				if(!bmpdata)
				{
					return null;
				}
				this.btnAssetPool[assetName] = this.generateBtnArray(assetName, bmpdata, isSinglet);
			}
			
			if(this.btnAssetPool[assetName])
			{
				var scaleBmp:ScaleBitmap;
				if(this.btnAssetPool[assetName] is Array){
					var skins:Array = [];
					for(var i:int=0; i<this.btnAssetPool[assetName].length; i++)
					{
						scaleBmp= new ScaleBitmap(this.btnAssetPool[assetName][i].clone());
						scaleBmp.scale9Grid = scale9GridPool[assetName];
						skins[i] =scaleBmp;
					}
					return skins;
				}
			}
			return null;
		}
		
		/**
		 * 产生按钮三台图
		 * @param assetName		按钮资源的名字
		 * @param bmpData		按钮资源的图片
		 * @param isSinglet		该按钮是否单态图
		 * @return 
		 */		
		private function generateBtnArray(assetName:String, bmpdata:BitmapData, isSinglet:Boolean):Array
		{
			var btnAsset:Array = [];
			var scaleBmp:ScaleBitmap;
			var tmpBmpdata:BitmapData
			if(isSinglet)
			{
				var wid:int= bmpdata.width;
				var hei:int= bmpdata.height;
				var rect:Rectangle = new Rectangle(0,0,wid,hei);
				var po:Point =new Point(0,0)
				
				tmpBmpdata= new BitmapData(wid,hei, true, 0x000000);
				tmpBmpdata.copyPixels(bmpdata,rect,po);
				tmpBmpdata.colorTransform(rect,new ColorTransform(1, 1, 1, 1, -20, -20, -20, -5));
//				scaleBmp = new ScaleBitmap(tmpBmpdata);
//				scaleBmp.scale9Grid = scale9GridPool[assetName];
				btnAsset.push(tmpBmpdata);
				
				tmpBmpdata= new BitmapData(wid,hei, true, 0x000000);
				tmpBmpdata.copyPixels(bmpdata,rect,po);
				tmpBmpdata.colorTransform(rect,new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0));
//				scaleBmp = new ScaleBitmap(tmpBmpdata);
//				scaleBmp.scale9Grid = scale9GridPool[assetName];
				btnAsset.push(tmpBmpdata);
				
				tmpBmpdata= new BitmapData(wid,hei, true, 0x000000);
				tmpBmpdata.copyPixels(bmpdata,rect,po);
				tmpBmpdata.colorTransform(rect,new ColorTransform(1, 1, 1, 1, -50, -50, -50, -25));
//				scaleBmp = new ScaleBitmap(tmpBmpdata);
//				scaleBmp.scale9Grid = scale9GridPool[assetName];
				btnAsset.push(tmpBmpdata);
				this.assetPool[assetName] = btnAsset;
				bmpdata.dispose();
			}
			else
			{
				var w:int = bmpdata.width;
				var h:int = bmpdata.height / 3;
				for(var i:int=0; i < 3; i++){
					tmpBmpdata = new BitmapData(w,h, true, 0x000000);
					tmpBmpdata.copyPixels(bmpdata,new Rectangle(0,i * h,w,h),new Point(0,0));
//					scaleBmp = new ScaleBitmap(tmpBmpdata);
//					scaleBmp.scale9Grid = scale9GridPool[assetName];
					btnAsset.push(tmpBmpdata);
				}
				this.assetPool[assetName] = btnAsset;
				bmpdata.dispose();
			}
			return btnAsset;
		}
		
		
		
		/**
		 *  从当前域中获取bitmapdata 
		 * @param assetName
		 * @return 
		 * 
		 */		
		protected function loadBmpDataFromDomain(assetName:String):BitmapData
		{
			if(!assetPool[assetName])
			{
				var _class:Class=null;
				try	{
					_class = ApplicationDomain.currentDomain.getDefinition(assetName) as Class;
				}catch (e:Error){
					return null;
				}
				var bmpData :BitmapData= new _class(0,0) as BitmapData;
				return bmpData;
			}
			return null;
		}
		
		public function putImgScale9Grid(asssetName:String, rect:Rectangle):void
		{
			scale9GridPool[asssetName] = rect;
		}
		
		public function getImgScale9Grid(asssetName:String):Rectangle
		{
			return scale9GridPool[asssetName];
		}
		
	}
}
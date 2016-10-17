package ll.ui.components
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import ll.timer.FrameManager;
	import ll.ui.DefaultUIComponent;
	import ll.ui.core.ScaleBitmap;
	import ll.ui.core.UIComponent;
	import ll.ui.managers.AssetsManager;
	
	/**
	 * 按钮组件
	 * @author SilenXiao
	 * @date 2013-10-22
	 */
	public class Button extends UIComponent
	{
		public static var NORMAL:uint=0;
		public static var OVER:uint=1;
		public static var SELECT:uint=2;
		
		/** 当前的图片 */
		protected var _btnSkin:Bitmap;
		
		public function Button()
		{
			super();
			
			this.buttonMode = true;
			initMouseEvent();
		}
		
		/**
		 * 监听鼠标事件 
		 * 
		 */		
		protected function initMouseEvent():void
		{
			this.addEventListener(MouseEvent.CLICK, onClick);
			this.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		private var _continueClickFlag:Boolean;
		
		/**
		 * 点击事件 
		 * @param evt
		 * 
		 */		
		protected function onClick(evt:MouseEvent):void
		{
//			if(this.doubleClickEnabled)
//				return;
//			if(_continueClickFlag)
//			{
//				evt.stopImmediatePropagation();
//			}else{
//				_continueClickFlag = true;
//				FrameManager.getInstance().add(refreshContinueClickFlag, 15);
//			}
		}
		
		/**
		 * 增加反复点击的标记点 
		 * 
		 */		
		private function refreshContinueClickFlag(...param):void
		{
			_continueClickFlag = false;
		}
		
		
		protected function onMouseOver(evt:MouseEvent):void
		{
			this.toStatus(OVER);
		}
		
		protected function onMouseUp(evt:MouseEvent):void
		{
			this.toStatus(OVER);
		}
		
		protected function onMouseOut(evt:MouseEvent):void
		{
			this.toStatus(NORMAL);
		}
		
		
		protected function onMouseDown(evt:MouseEvent):void
		{
			this.toStatus(SELECT);
		}
		
		
		/** 设置按钮皮肤状态 
		 * 
		 * @param value 存放 资源名:是否为单态（assetName:true);
		 * */
		public function set assetName(value:String):void
		{
			var param:Array = value.split(":");
			setAssetName(param[0], param[1]);
		}
		
		public function get assetName():String
		{
			return _assetName;
		}
		
		protected var _assetName:String="";
		protected var _validateSkinFlag:Boolean
		protected var _skinArr:Array;
		/**
		 * 设置按钮皮肤 
		 * @param value 皮肤资源名字
		 * @param isSinglet 是否为单态
		 * 
		 */
		public function setAssetName(value:String, isSinglet:Boolean = true):void
		{
			if(!_btnSkin)
			{
				_btnSkin = new Bitmap();
				this.addChild(_btnSkin);
			}
			_assetName=value;
			_skinArr = AssetsManager.getInstance().getButtonSkin(value,null,isSinglet);
			if(!_skinArr)
			{
				AssetsManager.getInstance().loadBmpData(value, onAssetLoaded);
				
				function onAssetLoaded(bmp:*):void
				{
					if(_isDipose)
						return;
					_skinArr = AssetsManager.getInstance().getButtonSkin(value, null, isSinglet);
					if(!_validateSkinFlag)
					{
						_validateSkinFlag = true;
						invalidateProperties();
					}
				}
			}else{
				if(!_validateSkinFlag)
				{
					_validateSkinFlag = true;
					invalidateProperties();
				}
			}
		}
		
		/**
		 * 处理应用变更属性
		 * 
		 */		
		protected override function commitProperties():void
		{
			if(_validateSkinFlag || _validateSizeFlag)
			{
				commitSize();
				_validateSkinFlag = false;
				_validateSizeFlag = false;
			}
			
		}
		
		override protected function commitSize():void
		{
			if(this._skinArr)
			{
				for(var i :int= 0; i < this._skinArr.length; i++){
					this._skinArr[i].setsize(_width, _height);
				}	
				ScaleBitmap(this._skinArr[_status]).validateNow();
				_btnSkin.bitmapData = this._skinArr[_status].bitmapData;
			}
			
			relayoutTextField();
			relayoutTxtImg()
		}
		
		protected var _status:int;
		
		/**
		 * 设置显示对象 
		 * @param value
		 * 
		 */		
		protected function toStatus(value:int):void
		{
			if(this._status == value)
			{
				return
			}
			this._status = value;
			if(this._skinArr)
			{
				_btnSkin.bitmapData = this._skinArr[value].bitmapData;
			}
			
			if(this._textFiled)
			{
				if(value == NORMAL && _labelColorNormal)
				{
					this._textFiled.textColor = this._labelColorNormal;	
				}else if(value == SELECT && _labelColorMDown)
				{
					this._textFiled.textColor = this._labelColorMDown;
				}else if(_labelColorMOver){
					this._textFiled.textColor = this._labelColorMOver;
				}
			}
		}
		
		protected var _txtImg:Image;
		/** 按钮的图片文字 */
		public function set textImgName(value:String):void
		{
			if(!_txtImg)
			{
				_txtImg = new Image();
				addChild(_txtImg);
			}
			_txtImg.setAssetName(onTxtImgLoaded, value);
		}
		
		private var _textImgName:String="";
		public function get textImgName():String
		{
			return _textImgName;
		}
		
		/**
		 * 文字图片加载完毕 
		 * 
		 */		
		private function onTxtImgLoaded():void
		{
			if(this._isDipose)
			{
				return;
			}
			relayoutTxtImg();
		}
		
		protected var _textFiled:TextField;
		/** 设置按钮文本 */
		public function set label(value:String):void
		{
			if(!_textFiled)
			{
				_textFiled = new TextField();
				_textFiled.defaultTextFormat = DefaultUIComponent.BTN_TEXT_FORMAT;
				_textFiled.filters = DefaultUIComponent.TEXT_FILTER;
				_textFiled.selectable = false;
				_textFiled.mouseEnabled=false;///textFile接收时间会导致按钮事件中target不是button
				_textFiled.autoSize = TextFieldAutoSize.LEFT;
				this.addChild(_textFiled);
			}
			if(!value)
				value = "";
			_textFiled.text = value;
			relayoutTextField()
		}
		public function set htmlText(value:String):void
		{
			if(!_textFiled)
			{
				_textFiled = new TextField();
				_textFiled.defaultTextFormat = DefaultUIComponent.BTN_TEXT_FORMAT;
				_textFiled.filters = DefaultUIComponent.TEXT_FILTER;
				_textFiled.selectable = false;
				_textFiled.mouseEnabled=false;///textFile接收时间会导致按钮事件中target不是button
				_textFiled.autoSize = TextFieldAutoSize.LEFT;
				this.addChild(_textFiled);
			}
			if(!value)
				value = "";
			_textFiled.htmlText = value;
			relayoutTextField()
		}
		
		
		/**
		 * 获取按钮文本文字 
		 * @return 
		 * 
		 */		
		public function get label():String
		{	
			var retValue:String;
			if(_textFiled)
				retValue =  _textFiled.text;
			if(!retValue)
				retValue = ""
			return retValue;
		}
		
		/**
		 * 获取按钮的文本 
		 * @return 
		 * 
		 */		
		public function get textField():TextField
		{
			return this._textFiled;
		}
		
		protected var _labelColorMOver:uint;
		/**
		 * 设置鼠标移上去，文字的颜色 
		 * @param color
		 * 
		 */		
		public function set labelColorMouseOver(color:uint):void
		{
			this._labelColorMOver = color;	
		}
		public function get labelColorMouseOver():uint
		{
			return this._labelColorMOver; 
		}
		
		protected var _labelColorMDown:uint;
		/**
		 * 设置鼠标按下去，文字的颜色 
		 * @param color
		 * 
		 */		
		public function set labelColorMouseDown(color:uint):void
		{
			this._labelColorMDown = color;
		}
		public function get labelColorMouseDown():uint
		{
			return this._labelColorMDown; 
		}
		
		protected var _labelColorNormal:uint;
		/**
		 * 设置文字普通颜色 
		 * @param color
		 * 
		 */		
		public function set labelColorNormal(color:uint):void
		{
			this._labelColorNormal = color;
			this._textFiled.textColor = color;	
		}
		public function get labelColorNormal():uint
		{
			return this._labelColorNormal; 
		}
		
		/**
		 * 文字位置重现布局 
		 * 
		 */		
		protected function relayoutTextField():void
		{
			if(_textFiled)
			{
				_textFiled.x = (this._width - this._textFiled.width) >> 1;
				_textFiled.y = (this._height - this._textFiled.height) >> 1;
			}
		}
		
		/**
		 * 文字图片重现布局 
		 * 
		 */		
		protected function relayoutTxtImg():void
		{
			if(_txtImg && _txtImg.width > 0)
			{
				_txtImg.x =  (this._width - this._txtImg.width) >> 1;
				_txtImg.y = (this._height - this._txtImg.height) >> 1;
			}
		}
		
		public override function get width():Number
		{
			if(!_width && _validateSkinFlag)
				validateNow();
			return super.width;
		}
		
		public override function get height():Number
		{
			if(!_height && _validateSkinFlag)
				validateNow();
			return super.height
		}
		
		
		/**
		 * set/get 当前组件是否具有交互性 
		 * @param value
		 * 
		 */		
		public override function set enable(value:Boolean):void
		{
			super.enable=value;
			this.mouseEnabled=value;
			this.mouseChildren=value
		}
		
		public override function dispose():void
		{
			super.dispose();
			if(_continueClickFlag)
				FrameManager.getInstance().remove(refreshContinueClickFlag);
		}
	}
}
package ll.ui.core
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	
	import ll.ui.interfaces.IDispose;
	import ll.ui.interfaces.IUIComponent;
	
	use namespace dx_internal;
	
	[ExcludeClass]
	/**
	 * 扩展性位图，可以设置九宫格，对纯色位图进行拉伸
	 * @author SilenXiao
	 * @date 2013-9-26
	 */
	public class ScaleBitmap extends Bitmap implements IDispose, IUIComponent
	{
		/** 原始位图的bitmapdata */
		protected var _orignBmpdata:BitmapData;
		protected var _scale9Grid:Rectangle;
		protected var _validateSizeFlag:Boolean;
		public function ScaleBitmap(bitmapData:BitmapData=null, pixelSnapping:String="auto", smoothing:Boolean=false)
		{
			super(bitmapData, pixelSnapping, smoothing);
			this._orignBmpdata = bitmapData;
		}
		
		/**
		 * 重写 scale9Grid set/get方法 
		 * @param value
		 * 
		 */		
		public function set scale9GridStr(value:String):void
		{
			var param:Array = value.split(":");
			var rect:Rectangle = new Rectangle(param[0], param[1], param[2], param[3]);
			scale9Grid = rect;
		}
		
		public override function set scale9Grid(rect:Rectangle):void
		{
			if(_scale9Grid == rect || rect == null)
				return;
			if(!_scale9Grid || (_scale9Grid && !_scale9Grid.equals(rect)))
			{
				if(_orignBmpdata)
				{
					if(!validGrid(rect))
					{
						throw new Error("九宫格的大小大于原始位图大小")
						return;
					}
				}
				_scale9Grid = rect;
				validateSize();
			}
		}
		
		public override function get scale9Grid():Rectangle
		{
			return this._scale9Grid;
		}
		
		/**
		 * 重写设置位图信息 
		 * @param value
		 * 
		 */		
		override public function set bitmapData(value:BitmapData):void
		{
			if(this.bitmapData&&this.bitmapData != this._orignBmpdata)
			{
				this.bitmapData.dispose();
			}
			this._orignBmpdata = value;
			validateSize();
		}
		
		protected var _width:Number = 0;
		override public function set width(value:Number):void
		{
			if(_width == value)
				return;
			this._width = value;
			validateSize();
		}
		
		override public function get width():Number
		{
			if(_width > 0)
				return _width
			if(_validateSizeFlag)
				validateNow();
			return super.width;
		}
		
		protected var _height:Number = 0;
		override public function set height(value:Number):void
		{
			if(_height == value)
				return;
			this._height = value;
			validateSize();
		}
		
		override public function get height():Number
		{
			if(this._height > 0)
				return this._height;
			if(_validateSizeFlag)
				validateNow();
			return super.height;
		}
		
		/**
		 * 设置位图的大小 
		 * @param value 用字符串表示: 宽:高
		 * 
		 */		
		public function set size(value:String):void
		{
			var param:Array = value.split(":");
			setsize(param[0], param[1]);
		}
		
		public function setsize(width:uint, height:uint):void
		{
			if(this._width == width && this._height == height)
			{
				return;
			}
			this._width = width;
			this._height = height;
			validateSize();
		}
		
		/**
		 * 标记有属性变化需要延迟应用
		 */		
		protected function validateSize():void
		{
			if(!_validateSizeFlag && _orignBmpdata)
			{
				_validateSizeFlag = true;
				/*if(stage)
				{
					addEventListener(Event.RENDER,validateProperties);
					if(stage) 
						stage.invalidate();
				}
				else
				{*/
					addEventListener(Event.ENTER_FRAME,validateProperties);
//				}
			}
		}
		
		/**
		 * 延迟应用属性事件
		 * 
		 */		
		protected function validateProperties(evt:Event = null):void
		{
			removeEventListener(Event.ENTER_FRAME,validateProperties);
			removeEventListener(Event.RENDER,validateProperties);
			commitProperties();
			_validateSizeFlag = false;
		}
		
		/**
		 * 处理应用变更属性
		 * 
		 */		
		private function commitProperties():void
		{
			if (_scale9Grid != null) 
			{
				redrawBitmapData();
			} 
			else 
			{
				super.bitmapData = _orignBmpdata;
			}
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		/**
		 * 标记父类需要大小变更
		 */
		public function validateParentSizeChange():void
		{
			if(this.parent && this.parent is UIComponent)
			{
				UIComponent(this.parent).validateChildSizeChange();
			}
		}
		
		/**
		 * 立即应用标记为延迟验证的属性 
		 * 
		 */		
		public function validateNow():void
		{
			if(_validateSizeFlag)
				validateProperties();
		}
		
		/**
		 * 根据属性重绘bitmapdata
		 * 
		 */		
		private function redrawBitmapData():void
		{
			var tmp:uint = _orignBmpdata.width - _scale9Grid.width;
			//最大的宽度
			var _maxW:uint = _width > tmp ? _width : tmp;
			tmp = _orignBmpdata.height - _scale9Grid.height;
			//最大的高度
			var _maxH:uint = _height > tmp ? _height : tmp;
			
			var bmpData : BitmapData = new BitmapData(_maxW, _maxH, true, 0x00000000);
			
			var rows : Array = [0, _scale9Grid.top, _scale9Grid.bottom, _orignBmpdata.height];
			var cols : Array = [0, _scale9Grid.left, _scale9Grid.right, _orignBmpdata.width];
			
			var dRows : Array = [0, _scale9Grid.top, _maxH - (_orignBmpdata.height - _scale9Grid.bottom), _maxH];
			var dCols : Array = [0, _scale9Grid.left, _maxW - (_orignBmpdata.width - _scale9Grid.right), _maxW];
			
			var origin : Rectangle; 
			var draw : Rectangle;
			var mat : Matrix = new Matrix();
			
			
			for (var cx : int = 0;cx < 3;cx++) 
			{
				for (var cy : int = 0 ;cy < 3;cy++) 
				{
					origin = new Rectangle(cols[cx], rows[cy], cols[cx + 1] - cols[cx], rows[cy + 1] - rows[cy]);
					draw = new Rectangle(dCols[cx], dRows[cy], dCols[cx + 1] - dCols[cx], dRows[cy + 1] - dRows[cy]);
					mat.identity();
					mat.a = draw.width / origin.width;
					mat.d = draw.height / origin.height;
					mat.tx = draw.x - origin.x * mat.a;
					mat.ty = draw.y - origin.y * mat.d;
					bmpData.draw(_orignBmpdata, mat, null, null, draw, true);
				}
			}
			super.bitmapData = bmpData;
		}
		
		/**
		 * 九宫格是否合法 
		 * @param rect
		 * @return 
		 * 
		 */		
		private function validGrid(rect : Rectangle) : Boolean 
		{
			return rect.right <= _orignBmpdata.width && rect.bottom <= _orignBmpdata.height;
		}
		
		public function setFocus():void{}
		
		public function clear():void
		{
			
		}
		
		public function set enable(value:Boolean):void{}
		
		public function get enable():Boolean{	return false;}
		public function removeAllUIEvent():void{};
		
		private var _viewXml:XML;
		public function set viewXml(xml:XML):void
		{
			this._viewXml = xml;
		}
		
		public function get viewXml():XML
		{
			return this._viewXml;
		}
		
		
		
		protected var _isDipose:Boolean;
		
		public function isDispose():Boolean
		{
			return this._isDipose;
		}
		
		public function dispose():void
		{
			this._isDipose = true;
			if(hasEventListener(Event.ENTER_FRAME))
				removeEventListener(Event.ENTER_FRAME,validateProperties);
			if(hasEventListener(Event.RENDER))
				removeEventListener(Event.RENDER,validateProperties);
			if(_scale9Grid && bitmapData)
				this.bitmapData.dispose();
			this._scale9Grid = null;
		}
	}
}
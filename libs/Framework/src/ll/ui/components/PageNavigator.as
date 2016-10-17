package ll.ui.components
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.engine.BreakOpportunity;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIType;
	import ll.ui.core.UIComponent;
	

	/**
	 * 分页组件 
	 * @author silenxiao
	 * 
	 */	
	public class PageNavigator extends UIComponent
	{
		//分页改变事件
//		public static const pagingChange:String = "PageNavigator_pagingChange";
		/** 上一页，下一页 */
		private var _btnPrevious:Button, _btnNext:Button;
		
		/**第一页，最后一页 */
		private var _btnFirst:Button, _btnLast:Button;
		
		/** 页码显示文本 */
		private var _lblPageNum:Label;
		public function PageNavigator()
		{
			super();
			this.mouseChildren=true;
			this.mouseEnabled=true;
			initialDisplayList();
			
			initialEvent();
		}
		
		private function initialDisplayList():void
		{
			_btnFirst = DefaultUIComponent.createButton(this, UIType.BTN_FIRST);
			_btnFirst.setsize(20,20);
			_btnPrevious = DefaultUIComponent.createButton(this, UIType.BTN_PRE);
			_btnPrevious.setsize(20,20);
			
			_btnPrevious.x = _btnFirst.width;
			
			_btnNext = DefaultUIComponent.createButton(this, UIType.BTN_NEXT);
			_btnNext.setsize(20,20);
			_btnLast = DefaultUIComponent.createButton(this, UIType.BTN_LAST);
			_btnLast.setsize(20,20);
			
			_lblPageNum = new Label();
			this.addChild(_lblPageNum);
			_lblPageNum.text = this._curValue + "/" + this._maxValue;
			_lblPageNum.y = (_btnFirst.height - _lblPageNum.height) >> 1 + 5;
			relayout();
		}
		
		private function initialEvent():void
		{
			_btnPrevious.addEventListener(MouseEvent.CLICK, onPageChange);
			_btnNext.addEventListener(MouseEvent.CLICK, onPageChange);
			_btnFirst.addEventListener(MouseEvent.CLICK, onPageChange);
			_btnLast.addEventListener(MouseEvent.CLICK, onPageChange);
		}
		
		/**
		 *	翻页时发送Event.CHANGE事件 
		 * @param evt
		 * 
		 */		
		private function onPageChange(evt:Event):void
		{
			var tmp:Button = evt.currentTarget as Button;
			var oldValue:int  = _curValue;
			switch(tmp)
			{
				case _btnPrevious:
					if(this._curValue > 1) 
						this.curValue=this._curValue -1;
					break;
				case _btnNext:
					if(this._curValue < this._maxValue)
						this.curValue=this._curValue +1;
					break;
				case _btnFirst:
					this.curValue = 1;
					break;
				default:
					this.curValue = this._maxValue;
					break;
			}
			
			if(oldValue == _curValue)
				return;
//			curValue = _curValue;
		}
		
		
		private var _curValue:int = 1;
		/** 当前页码 */
		public function set curValue(value:int):void
		{
			if(value <= 0)
			{
				value = 1;
			}
			if(_curValue != value && value <= this._maxValue){
				this._curValue = value;
				_lblPageNum.text = this._curValue + "/" + this._maxValue;
				dispatchEvent( new Event(Event.CHANGE));
			}
		}
		
		public function get curValue():int
		{
			return _curValue;
		}
		
		
		private var _maxValue:uint = 1;
		/** 最大页码 */
		public function set maxValue(value:uint):void
		{
			if(_maxValue == value)
				return;
			if(value > 1)
			{
				_maxValue = value;
				this.enable = true;
			}else
			{
				_maxValue = 1;
				this.enable = false;
			}
			
			if(_curValue > _maxValue)
			{
				curValue = _maxValue;	
			}
			
			this._lblPageNum.text = this._curValue + "/" + this._maxValue;
			relayout();
		}
		
		public function get maxValue():uint
		{
			return _maxValue;
		}
		
		
		/**
		 *设置鼠标事件 
		 * @param value true为可点击，false为不可点击
		 * 
		 */		
		public override function set enable(value:Boolean):void
		{
			super.enable = value;
			if(value)
			{
				this.mouseChildren = true;
			}else
			{
				this.mouseChildren = false;
			}
		}
		
		/**
		 * 组件内的显示列表重新位置布局 
		 * 
		 */		
		private function relayout():void
		{
			var tmp:String = _lblPageNum.text;
			//获取页码文本的最大宽度
			_lblPageNum.text = this._maxValue + "/"+this._maxValue;
			var maxlblWidth:int = _lblPageNum.textWidth;
			
			_btnPrevious.x = _lblPageNum.x - _btnPrevious.width -5;
			_btnFirst.x = _btnPrevious.x - _btnPrevious.width;
			
			_btnNext.x = _lblPageNum.x + _lblPageNum.width + 5;
			_btnLast.x = _btnNext.x + _btnNext.width;
			
			_lblPageNum.text = tmp;
		}
	}
}
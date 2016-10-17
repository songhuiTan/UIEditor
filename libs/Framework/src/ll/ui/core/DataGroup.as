package ll.ui.core
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import ll.ui.ViewCreate;
	import ll.ui.collections.ArrayCollection;
	import ll.ui.collections.ICollection;
	import ll.ui.core.UIComponent;
	import ll.ui.events.CollectionEvent;
	import ll.ui.events.DragEvent;
	import ll.ui.events.ListEvent;
	import ll.ui.interfaces.IDispose;
	import ll.ui.interfaces.IItemRenderer;
	import ll.ui.managers.drag.DataSource;
	import ll.ui.managers.drag.DragManager;
	import ll.ui.renderer.ItemRenderer;
	
	/**
	 *  需要显示数组数据的基础组件 
	 * @author silenxiao
	 * 
	 */	
	public class DataGroup extends UIComponent
	{
		/**
		 * 未选中任何项时的索引值 
		 */		
		public static const NO_SELECTION:int = -1;
		
		public function DataGroup()
		{
			super();
			_dataProvider=new ArrayCollection();//默认给绑定数据对象
			dataProvider=_dataProvider;
		}
		
		protected var _dataProvider:ICollection;
		protected var _dataProviderChanged:Boolean;
		/**
		 * 设置绑定数据源
		 */
		public function set dataProvider(value:ICollection):void
		{
			if(_dataProvider)
			{
				_dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange);
				
			}
			if (value)
				value.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange);
			this._dataProvider = value;
			itemAddedHandler(_dataProvider.source, 0);
			
			_dataProviderChanged = true;
			invalidateProperties();
		}
		
		public function get dataProvider():ICollection
		{
			return _dataProvider;
		}
		
		protected var _dataHandler:Function;
		/**
		 * 设置数据回调(提供外部设置数据)
		 * @param func
		 * 
		 */		
		public function set dataHandler(func:Function):void
		{
			_dataHandler = func;
		}
		
		protected var _layoutCallFn:Function;
		/**
		 * 设置布局的外部回调函数 
		 * @param callFn
		 * 
		 */		
		public function set layoutCallFn(callFn:Function):void
		{
			this._layoutCallFn = callFn;	
		}
		
		protected var _itemRendererXml:XML;
		/**
		 *渲染条目的xml 
		 * @param xml
		 * 
		 */		
		public function set itemRendererXml(xml:XML):void
		{
			_itemRendererXml = xml;
		}
		
		protected var _itemRenderer:Class;
		/**
		 * 设置List子项显示UI 
		 * @param lrClass 子项的ui
		 * 
		 */		
		public function set itemRenderer(value:Class):void
		{
			_itemRenderer = value;
		}
		
		protected var _dataType:uint;
		/**
		 * 当前DataGroup的数据类型 
		 * 
		 **/
		public function set dataType(value:uint):void
		{
			this._dataType = value;			
		}
		
		public function get dataType():uint
		{
			return this._dataType;
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			if(_dataProviderChanged)
			{
				if(_layoutCallFn != null)
				{
					_layoutCallFn(indexToRenderer);
				}else{
					commitDisplayList();
				}
				_dataProviderChanged = false;
			}
		}
		
		override protected function refreshRender():void
		{
			if(_layoutCallFn != null)
			{
				_layoutCallFn(indexToRenderer);
			}else{
				commitDisplayList();
			}
		}
		
		protected function commitDisplayList():void
		{
			
		}
		/**
		 * 数据源改变事件处理
		 */		
		private function onCollectionChange(event:CollectionEvent):void
		{
			switch(event.kind)
			{
				case CollectionEvent.ADD:
					itemAddedHandler(event.items,event.location);
					_dataProviderChanged = true;
					break;
				case CollectionEvent.MOVE:
					itemMovedHandler(event.items[0],event.location,event.oldLocation);
					break;
				case CollectionEvent.REMOVE:
					itemRemovedHandler(event.items,event.location);
					_dataProviderChanged = true;
					break;
				case CollectionEvent.UPDATE:
					itemUpdatedHandler(event.items[0],event.location);
					break;
				case CollectionEvent.REPLACE:
					itemRemoved(event.location);
					itemAdded(event.items[0], event.location);
					resetRenderersIndices();
					_dataProviderChanged = true;
					break;
				case CollectionEvent.SWITCH:
					itemUpdatedHandler(event.items[0],event.oldLocation);
					itemUpdatedHandler(event.oldItems[0],event.location);
					break;
				case CollectionEvent.RESET:
					var newLength:uint = _dataProvider.length;
					var oldLength:uint = indexToRenderer.length;
					//新数据长度小于旧数据长度，删除旧数据多余长度的呈现项
					if(newLength < oldLength)
					{
						for(var i:int = oldLength-1; i >=newLength; i--)
						{
							itemRemoved(i);
						}
						_dataProviderChanged = true;
					}else if(newLength > oldLength)
					{
						var tmpArr:Array = _dataProvider.source.slice(oldLength, newLength);
						itemAddedHandler(tmpArr, oldLength);
						_dataProviderChanged = true;
					}
					resetRenderersIndices();
					//更新所有项
					for(var index:* in indexToRenderer)
					{
						itemUpdatedHandler(_dataProvider.getItemAt(index), index);
					}
					break;
				case CollectionEvent.REFRESH:
					for(index in indexToRenderer)
					{
						itemUpdatedHandler(_dataProvider.getItemAt(index), index);
					}
					break;
			}
			if(_dataProviderChanged)
				invalidateProperties();
		}
		
		/**
		 * 索引到项呈示器的转换数组 
		 */		
		public var indexToRenderer:Array = [];
		
		/**
		 * 数据项增加
		 * @param index
		 * 
		 */		
		protected function itemAddedHandler(items:Array, index:int):void
		{
			var length:int = items.length;
			for (var i:int = 0; i < length; i++)
			{
				itemAdded(items[i], index + i);
			}
			resetRenderersIndices();
		}
		
		/**
		 * 更新当前所有项的索引
		 */		
		private function resetRenderersIndices():void
		{
			if (indexToRenderer.length == 0)
				return;
			const indexToRendererLength:int = indexToRenderer.length;
			for (var index:uint = 0; index < indexToRendererLength; index++)
				resetRendererItemIndex(index);
		}
		
		/**
		 * 数据源更新或替换项目事件处理
		 */	
		private function itemUpdatedHandler(item:Object,location:int):void
		{
			var renderer:IItemRenderer = indexToRenderer[location];
			if(renderer!=null)
				updateRenderer(renderer,location,item);
		}
		/**
		 * 调整指定项呈示器的索引值
		 */		
		private function resetRendererItemIndex(index:int):void
		{
			var renderer:IItemRenderer = indexToRenderer[index] as IItemRenderer;
			if (renderer)
				renderer.itemIndex = index;    
		}
		
		/**
		 * 添加一项
		 */		
		private function itemAdded(item:Object,index:int):void
		{
			var renderer:IItemRenderer = createOneRenderer();
			indexToRenderer.splice(index,0,renderer);
			if(!renderer)
				return;
			renderer.addEventListener(MouseEvent.ROLL_OVER, item_mouseEventHandler);
			renderer.addEventListener(MouseEvent.ROLL_OUT, item_mouseEventHandler);
			renderer.addEventListener(MouseEvent.CLICK, item_mouseEventHandler, false, -50);
			renderer.addEventListener(MouseEvent.DOUBLE_CLICK, item_mouseEventHandler);
			renderer.addEventListener(MouseEvent.MOUSE_DOWN, itemDragHandler);
			renderer.addEventListener(MouseEvent.MOUSE_UP, itemDragHandler);
			updateRenderer(renderer,index,item);
		}
		
		private static const TYPE_MAP:Object = {rollOver:"itemRollOver", rollOut:"itemRollOut",
			mouseDown:"itemDown", mouseUp:"itemUp",
			click:"itemClick", doubleClick:"itemDoubleClick"};
		/**
		 * 项呈示器鼠标事件
		 */		
		private function item_mouseEventHandler(event:MouseEvent):void
		{
			var type:String = event.type;
			type = TYPE_MAP[type];
			if (hasEventListener(type))
			{
				var itemRenderer:IItemRenderer = event.currentTarget as IItemRenderer;
				
				var itemIndex:int = itemRenderer.itemIndex;
				
				if(type == "itemClick" || type == "itemDoubleClick")
				{
					selectedIndex = itemIndex;
				}
				
				var listEvent:ListEvent = new ListEvent(type, false, false,
					event.localX,
					event.localY,
					event.relatedObject,
					event.ctrlKey,
					event.altKey,
					event.shiftKey,
					event.buttonDown,
					event.delta,
					itemIndex,
					_dataProvider.getItemAt(itemIndex),
					itemRenderer);
				dispatchEvent(listEvent);
			}
		}
		
		/**
		 * 更新项呈示器
		 */		
		protected function updateRenderer(renderer:IItemRenderer, itemIndex:int, data:Object):IItemRenderer
		{
			renderer.itemIndex = itemIndex;
			renderer.data = data;
			if(_dataHandler != null)
			{
				_dataHandler.call(null, renderer, data);
			}
			return renderer;
		}
		
		/**
		 * 创建一个Renderer,并添加到显示列表
		 */		
		private function createOneRenderer():IItemRenderer
		{
			var rendererClass:Class;
			// 为特定的数据项返回项呈示器类定义
			if(_itemRenderer)
			{
				rendererClass = _itemRenderer;
			}else{
				rendererClass = ItemRenderer;
			}
			var renderer:IItemRenderer = new rendererClass() as IItemRenderer;
			if(renderer==null||!(renderer is DisplayObject))
				return null;
			
			if(_itemRendererXml != null)
			{
				ViewCreate.createView(_itemRendererXml, renderer as UISprite, this);
			}
			renderer.owner = this;
			this.addChild(renderer as DisplayObject);
			return renderer;
		}
		
		/**
		 * 数据源移动项目事件处理
		 */		
		private function itemMovedHandler(item:Object,location:int,oldLocation:int):void
		{
			itemRemoved(oldLocation);
			itemAdded(item,location);
			resetRenderersIndices();
		}
		
		/**
		 * 数据源移除项目事件处理
		 */		
		private function itemRemovedHandler(items:Array,location:int):void
		{
			var length:int = items.length;
			for (var i:int = length-1; i >= 0; i--)
			{
				itemRemoved(location + i);
			}
			
			resetRenderersIndices();
		}
		/**
		 * 移除一项
		 */		
		private function itemRemoved(index:int):void
		{
			const oldRenderer:IItemRenderer = indexToRenderer[index];
			
			if (indexToRenderer.length > index)
				indexToRenderer.splice(index, 1);
			
			if(oldRenderer != null && oldRenderer is DisplayObject)
			{
				this.removeChild(oldRenderer as DisplayObject);
				
				oldRenderer.removeEventListener(MouseEvent.ROLL_OVER, item_mouseEventHandler);
				oldRenderer.removeEventListener(MouseEvent.ROLL_OUT, item_mouseEventHandler);
				oldRenderer.removeEventListener(MouseEvent.CLICK, item_mouseEventHandler);
				oldRenderer.removeEventListener(MouseEvent.DOUBLE_CLICK, item_mouseEventHandler);
				oldRenderer.removeEventListener(MouseEvent.MOUSE_DOWN, itemDragHandler);
				oldRenderer.removeEventListener(MouseEvent.MOUSE_UP, itemDragHandler);
				IDispose(oldRenderer).dispose();
			}
		}
		
		protected var _oldSelectedIndex:int = -1;
		protected var _selectedIndex:int = -1;
		/**
		 * 设置选中的索引
		 */
		public function set selectedIndex(value:int):void
		{
			if(value >= _dataProvider.length)
				value = _dataProvider.length - 1;
			
			if(this._selectedIndex == value)
				return;
			this._oldSelectedIndex = this._selectedIndex;
			this._selectedIndex = value;
			if(value == NO_SELECTION)
				this._selectedItem = undefined;
			else{
				this._selectedItem = indexToRenderer[value].data;
			}
			selectedChangeHandle();
		}
		
		public function get selectedIndex():int
		{
			if(!_dataProvider || _dataProvider.length == 0)
				return NO_SELECTION;
			return this._selectedIndex;
		}
		
		protected var _selectedItem:*;
		/**
		 * 设置选中项  
		 * 
		 */		
		public function set selectedItem(value:*):void
		{
			if(this._selectedItem === value)
				return;
			this._selectedItem = value;
			this._oldSelectedIndex = this._selectedIndex;
			if(value)
			{
				this._selectedIndex = _dataProvider.getItemIndex(value);
			}else{
				this._selectedIndex = NO_SELECTION;
			}
			selectedChangeHandle();
		}
		
		public function get selectedItem():*
		{
			if(!_dataProvider || _dataProvider.length == 0)
				return undefined;
			return this._selectedItem;
		}
		
		
		private function selectedChangeHandle():void
		{
			var itemRender:ItemRenderer;
			if(this._oldSelectedIndex != NO_SELECTION)
			{
				itemRender = indexToRenderer[this._oldSelectedIndex];
				if(itemRender){
					itemRender.selected = false;
				}
			}
			
			if(this._selectedIndex != NO_SELECTION)
			{
				itemRender = indexToRenderer[this._selectedIndex];
				itemRender.selected = true;
			}
		}
		
		private var _canDrag:Boolean;
		/**
		 * 设置呈现项是否能拖拽
		 */
		public function  set canDrag(value:Boolean):void
		{
			if(value == _canDrag)
				return;
			
			this._canDrag = value;
		}
		
		protected function itemDragHandler(event:MouseEvent):void
		{
			var itemRenderer:IItemRenderer = event.currentTarget as IItemRenderer;
			if(!itemRenderer)
				return;
			if(event.type == MouseEvent.MOUSE_DOWN)
			{
				if(!_canDrag || !itemRenderer.dragTarget)
					return;
				
				var dataSource:DataSource = new DataSource();
				dataSource.dataType = _dataType;
				dataSource.data = itemRenderer;
				dataSource.dragTarget = itemRenderer.dragTarget;
				
				DragManager.startDrag(this,
					dataSource,
					function():void
					{
						dispatchDrapEvent(DragEvent.ITEM_DROP, dataSource, itemRenderer);
					});
			}else if(event.type == MouseEvent.MOUSE_UP)
			{
				if(_canDrag && DragManager.isDraging)
				{//是否拖拽中
					if(itemRenderer.validated)
					{//当前的itemrender是否有效
						dataSource = DragManager.dataSource;
						var dragItemRenderer:IItemRenderer = dataSource.data as IItemRenderer;
						
						if(dataSource.dataType == _dataType)
						{
							if(dragItemRenderer.itemIndex != itemRenderer.itemIndex)
							{
								if(itemRenderer.data)
								{
									dispatchDrapEvent(DragEvent.ITEM_SWITCH, dataSource, itemRenderer);
								}else
								{
									dispatchDrapEvent(DragEvent.ITEM_MOVE, dataSource, itemRenderer);
								}
							}
						}else{
							//拖拽到其他组件上
							dispatchDrapEvent(DragEvent.ITEM_MOVE_TO, dataSource, itemRenderer);
						}
					}else{
					}
				}
				DragManager.endDrag();
			}
		}
		
		private function dispatchDrapEvent(type:String, dataSource:DataSource, dropTarget:Object):void
		{
			var dragEvent:DragEvent = new DragEvent(type, dataSource, dropTarget)
			dispatchEvent(dragEvent);
		}
		
		private var _labelField:String;
		
		public function set labelField(value:String):void
		{
			this._labelField = value;
		}

		/**
		 * 呈现器显示的数据字段 
		 * @return 
		 * 
		 */		
		public function get labelField():String
		{
			return this._labelField;
		}
		
		protected var _hSpace:uint;
		/** 设置水平呈现器的间距 */
		public function set hSpace(value:uint):void
		{
			this._hSpace = value;	
		}
		
		protected var _vSpace:uint;
		/** 设置垂直呈现器的间距 */
		public function set vSpace(value:uint):void
		{
			this._vSpace = value;
		}
		override public function dispose():void
		{
			super.dispose();
			if(_dataProvider)
			{
				_dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChange);
				_dataProvider.removeAll();
			}
		}
	}
}
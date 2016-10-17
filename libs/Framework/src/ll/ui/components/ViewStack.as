package ll.ui.components
{
	import ll.ui.core.UIComponent;

	public class ViewStack extends UIComponent
	{
		/**
		 * 元素容器 
		 */
		private var _panelsContent:Array = [];
		public function ViewStack()
		{
			super();
		}
		
		
		/**
		 *  增加元素 
		 * @param panel
		 * 
		 */		
		public function addPanel(panel:Panel):Panel
		{
			var index:int = _panelsContent.length;
			
			if(_panelsContent.indexOf(panel) != -1)
				index -= 1;
			if(index < 0)
				index = 0 ;
			return addPanelAt(panel, index);
		}
		
		/**
		 * 指定位置增加面板 
		 * @param panel
		 * @param index
		 * 
		 */		
		public function addPanelAt(panel:Panel, index:int):Panel
		{
			var oldIndex:int = getPanelIndex(panel);
			if(oldIndex == index)
				return panel;
			checkForRangeError(index, true);
			if(oldIndex != -1)
				setPanelIndex(panel, index);
			else
				_panelsContent.splice(index, 0, panel);
			return panel;
		}
		
		/**
		 * 删除面板 
		 * @param panel
		 * @param dispose 是否释放资源 
		 */			
		public function removePanel(panel:Panel, dispose:Boolean = true):Panel
		{
			return removePanelAt(getPanelIndex(panel), dispose);
		}
		
		/**
		 *  删除指定索引的面板 
		 * @param index
		 * @param dispose 是否释放资源 
		 */		
		public function removePanelAt(index:int, dispose:Boolean =  true):Panel
		{
			checkForRangeError(index);
			
			var panel:Panel = _panelsContent[index];
			
			_panelsContent.splice(index, 1);
			
			if(panel.parent)
			{
				this.removeChild(panel);
			}
			if(dispose)
			{
				panel.dispose();
			}
			
			return panel;
		}
		
		/**
		 * 交换两个面板
		 * @param panel1
		 * @param panel2
		 * 
		 */		
		public function swapPanels(panel1:Panel, panel2:Panel):void
		{
			swapPanelsAt(getPanelIndex(panel1), getPanelIndex(panel2));
		}
		
		/**
		 * 根据索引交换两个面板 
		 * @param index1 
		 * @param index2
		 * 
		 */		
		public function swapPanelsAt(index1:int, index2:int):void
		{
			checkForRangeError(index1);
			checkForRangeError(index2);
			
			if (index1 > index2)
			{
				var temp:int = index2;
				index2 = index1;
				index1 = temp; 
			}
			else if (index1 == index2)
				return;
			
			var element1:Panel = _panelsContent[index1];
			var element2:Panel = _panelsContent[index2];
			
			_panelsContent.splice(index1, 0, element2);
			_panelsContent.splice(index2, 0, element1);
		}
		
		/**
		 * 获取面板的索引
		 * @param panel
		 */
		public function getPanelIndex(panel:Panel):int
		{
			return _panelsContent.indexOf(panel);
		}
		
		/**
		 * 根据索引获取面板 
		 * @param index
		 * @return 
		 * 
		 */		
		public function getPanelAt(index:int):Panel
		{
			checkForRangeError(index);
			return _panelsContent[index];
		}
		
		public function setPanelIndex(panel:Panel, index:int):void
		{
			checkForRangeError(index);
			
			var oldIndex:int = getPanelIndex(panel);
			if (oldIndex == -1 || oldIndex == index)
				return;
			
			_panelsContent.splice(oldIndex, 1);
			_panelsContent.splice(index, 0, panel);
		}
		
		/**
		 * 检查索引是否超出范围 
		 * @param index
		 * @param addingElement
		 * 
		 */		
		private function checkForRangeError(index:int, addingPanel:Boolean = false):void
		{
			var maxIndex:int = _panelsContent.length - 1;
			
			if (addingPanel)
				maxIndex++;
			
			if (index < 0 || index > maxIndex)
				throw new RangeError("索引:\""+index+"\"超出可视元素索引范围");
		}
		
		private var _selectedIndex:int = -1;
		private var _oldSelectedIndex:int = -1;
		
		/**
		 *  设置可见子容器的索引
		 * @param value
		 * 
		 */		
		public function set selectedIndex(value:int):void
		{
			if(value >= _panelsContent.length)
				value = _panelsContent.length - 1;
			if(value < 0)
				value = 0;
			
			if(this._selectedIndex == value)
				return;
			this._oldSelectedIndex = this._selectedIndex;
			this._selectedIndex = value;
			this._selectedChild = getPanelAt(value);
			
			selectedChangeHandle()
		}
		
		/**
		 * 当前可见子容器的索引
		 */
		public function get selectedIndex():int
		{
			return this._selectedIndex;
		}
		
		private var _selectedChild:Panel;
		/**
		 * 当前可见的子容器。
		 */		
		public function get selectedChild():Panel
		{
			return _selectedChild;
		}
		public function set selectedChild(value:Panel):void
		{
			if(_selectedChild == value)
				return;
			
			this._selectedIndex = getPanelIndex(value);
			this._selectedChild = value;
			
			selectedChangeHandle()
		}
		
		/**
		 * 选中改变时，处理显示对象 
		 * 
		 */		
		protected function selectedChangeHandle():void
		{
			var panel:Panel;
			if(this._oldSelectedIndex != -1)
			{
				panel = _panelsContent[this._oldSelectedIndex];
				this.removeChild(panel);
				panel.clear();
			}
			this.addChild(this._selectedChild);
		}
	}
}
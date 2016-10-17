package ll.ui.components
{
	import ll.ui.events.ListEvent;
	import ll.ui.renderer.ItemRenderer;

	public class GridList extends List
	{
		public function GridList()
		{
			super();
		}
		
		protected var _rows:uint=1;//默认一行1个，否则无法呈现数据

		public function get rows():uint
		{
			return _rows;
		}

		/** 设置一行有多少个呈现项 */
		public function set rows(value:uint):void
		{
			if(_rows == value)
				return;
			this._rows = value;
			
			_dataProviderChanged = true;
			invalidateProperties();
		}
		
		
		override protected function commitDisplayList():void
		{
			const length:uint = indexToRenderer.length;
			
			var line:uint = length / _rows;
			if(length % _rows == 0&&_rows!=1)//row=1的时候不需要++
				line++;
			var renderer:ItemRenderer
			for(var i:uint = 0; i < line; i++)
			{
				for(var j:uint = 0; j < _rows; j++)
				{
					renderer = indexToRenderer[i * _rows + j];
					if(renderer){
						renderer.x = j * (renderer.width + this._hSpace);
						renderer.y = i * (renderer.height + this._vSpace);
					}
				}
			}
			if(renderer){
				setsize((renderer.width + this._hSpace) * _rows, line * (renderer.height + this._vSpace));
			}
		}
		
		
	}
}
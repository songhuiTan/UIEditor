package ll.utils
{
	public class ArrayedQueue
	{
		private var _que:Array;
		private var _size:int;
		private var _divisor:int;
		
		private var _count:int;
		private var _front:int;
		public function ArrayedQueue(size:int)
		{
			init(size);
		}
		public function get maxSize():int
		{
			return _size;
		}
		public function peek():*
		{
			return _que[_front];
		}
		public function back():*
		{
			return _que[int((_count - 1 + _front) & _divisor)];
		}
		public function enqueue(obj:*):Boolean
		{
			if (_size != _count)
			{
				_que[int((_count++ + _front) & _divisor)] = obj;
				return true;
			}
			return false;
		}
		
		public function dequeue():*
		{
			if (_count > 0)
			{
				var data:* = _que[int(_front++)];
				if (_front == _size) _front = 0;
				_count--;
				return data;
			}
			return null;
		}
		public function dispose():void
		{
			if (!_front) _que[int(_size  - 1)] = null;
			else 		 _que[int(_front - 1)] = null;
		}
		
		public function getAt(i:int):*
		{
			if (i >= _count) return null;
			return _que[int((i + _front) & _divisor)];
		}
		
		public function setAt(i:int, obj:*):void
		{
			if (i >= _count) return;
			_que[int((i + _front) & _divisor)] = obj;
		}
		
		public function contains(obj:*):Boolean
		{
			for (var i:int = 0; i < _count; i++)
			{
				if (_que[int((i + _front) & _divisor)] === obj)
					return true;
			}
			return false;
		}
		
		public function clear():void
		{
			_que = new Array(_size);
			_front = _count = 0;
			
			for (var i:int = 0; i < _size; i++) _que[i] = null;	
		}
		
		public function getIterator():ArrayedQueueIterator
		{
			return new ArrayedQueueIterator(this);
		}
		
		public function get size():int
		{
			return _count;
		}
		public function isEmpty():Boolean
		{
			return _count == 0;
		}
		public function toArray():Array
		{
			var a:Array = new Array(_count);
			for (var i:int = 0; i < _count; i++)
				a[i] = _que[int((i + _front) & _divisor)];
			return a;
		}
		
		public function toString():String
		{
			return "[ArrayedQueue, size=" + size + "]";
		}
		
		public function dump():String
		{
			var s:String = "[ArrayedQueue]\n";
			
			s += "\t" + getAt(i) + " -> front\n";
			for (var i:int = 1; i < _count; i++)
				s += "\t" + getAt(i) + "\n";
			
			return s;
		}
		
		/**
		 * @private
		 */
		private function init(size:int):void
		{
			if (!(size > 0 && ((size & (size - 1)) == 0)))
			{
				size |= (size >> 1);
				size |= (size >> 2);
				size |= (size >> 4);
				size |= (size >> 8);
				size |= (size >> 16);
				size++;
			}
			
			_size = size;
			_divisor = size - 1;
			clear();
		}
	}
}
import ll.utils.ArrayedQueue;

internal class ArrayedQueueIterator
{
	private var _que:ArrayedQueue;
	private var _cursor:int;
	
	public function ArrayedQueueIterator(que:ArrayedQueue)
	{
		_que = que;
		_cursor = 0;
	}
	
	public function get data():*
	{
		return _que.getAt(_cursor);
	}
	
	public function set data(obj:*):void
	{
		_que.setAt(_cursor, obj);
	}
	
	public function start():void
	{
		_cursor = 0;
	}
	
	public function hasNext():Boolean
	{
		return _cursor < _que.size;
	}
	
	public function next():*
	{
		if (_cursor < _que.size)
			return _que.getAt(_cursor++);
		return null;
	}
}
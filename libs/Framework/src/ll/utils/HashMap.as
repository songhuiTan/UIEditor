/**
 * @AbstractMap.as
 * 
 * @author sodaChen mail:asframe#163.com
 * @version 1.0
 * <br>Copyright (C), 2012 ASFrame.com
 * <br>This program is protected by copyright laws.
 * <br>Program Name:Collections
 * <br>Date:2012-1-7
 */
package ll.utils
{
	import flash.utils.Dictionary;
	
	/**
	 *
	 * @author sodaChen
	 * Date:2012-1-7
	 */
	public class HashMap
	{
		/** 长度 **/
		public var length:Number = 0;
		private var obj:Dictionary;
		
		public function HashMap(useWeakReference:Boolean = false)
		{
			obj = new Dictionary(useWeakReference);
			length = 0;
		}
		
		/**
		 * 将指定的值与此映射中的指定键相关联.
		 * @param key 与指定值相关联的键.
		 * @param value 与指定键相关联的值.
		 */
		public function put(key:*,value:*):void
		{
			if(obj[key]!= null)
			{
				length--;
			}
			obj[key] = value;
			length++;
		}
		
		/**
		 * 返回此映射中映射到指定键的值.
		 * @param key 与指定值相关联的键.
		 * @return 此映射中映射到指定值的键，如果此映射不包含该键的映射关系，则返回 null.
		 */
		public function get(key:*):*
		{
			return obj[key];
		}
		
		/**
		 * 从此映射中移除所有映射关系
		 */
		public function clear():void
		{
			for(var temp:* in obj)
			{
				delete obj[temp];
			}
			length = 0;
		}
		
		/**
		 * 如果存在此键的映射关系，则将其从映射中移除
		 * @param key 从映射中移除其映射关系的键
		 * @return 以前与指定键相关联的值，如果没有该键的映射关系，则返回 null
		 */
		public function remove(key:*):*
		{
			var temp:* = obj[key];
			if(temp != null)
			{
				delete obj[key];
				length--;
			}
			return temp;
		}
		
		/**
		 * 返回此映射中的键-值映射关系数.
		 * @return 此映射中的键-值映射关系的个数.
		 */
		public function size():int
		{
			return length;
		}
		
		/**
		 * 如果此映射未包含键-值映射关系，则返回 true.
		 * @return 如果此映射未包含键-值映射关系，则返回 true.
		 */
		public function isEmpty():Boolean
		{
			return length == 0;
		}
		
		/**
		 * 如果此映射包含指定键的映射关系，则返回 true.
		 * @param key  测试在此映射中是否存在的键.
		 * @return 如果此映射包含指定键的映射关系，则返回 true.
		 */
		public function hasKey(key:*):Boolean
		{
			return obj[key] != null;
		}
		
		/**
		 * 如果该映射将一个或多个键映射到指定值，则返回 true.
		 * @param key 测试在该映射中是否存在的值
		 * @return 如果该映射将一个或多个键映射到指定值，则返回 true.
		 */
		public function hasValue(value:*):Boolean
		{
			for(var temp:* in obj)
			{
				if(obj[temp] == value)
				{
					return true;
				}
			}
			return false;
		}	
		
		/**
		 * 返回此映射中包含的所有值.
		 * @return 包含所有值的数组
		 */
		public function valuesToArray():Array
		{
			var ary:Array = [];
			if(length != 0)
			{
				for(var temp:* in obj)
				{
					ary.push(obj[temp]);
				}
				return ary;
			}
			return ary;
		}
		
		/**
		 * 返回此映射中包含的所有key值.
		 * @return 包含所有key的数组
		 */
		public function keysToArray():Array
		{
			var ary:Array = [];
			if(length != 0)
			{
				for(var temp:* in obj)
				{
					ary.push(temp);
				}
				return ary;
			}
			return ary;
		}
		
		/**
		 * @inheritDoc
		 */		
		public function getContainer():Dictionary
		{
			return obj;
		}
		public function forEach(fun:Function):void
		{
			for each (var key:* in obj) 
			{
				fun(key);
			}
		}
		protected function changeSize(length:int):void
		{
			this.length = length;
		}
	}
}

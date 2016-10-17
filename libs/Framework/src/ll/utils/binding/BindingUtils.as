package  ll.utils.binding
{
	import flash.events.IEventDispatcher;

	public class BindingUtils
	{
		/**
		 * 绑定到属性
		 */ 
		public static function bindProperty(
			site:Object, 
			prop:String,
			host:IEventDispatcher, 
			chain:String,
			commitOnly:Boolean = false,
			useWeakReference:Boolean = false):ChangeWatcher
		{
			var w:ChangeWatcher = ChangeWatcher.watch(host, chain, null, commitOnly, useWeakReference);
			if (w != null)
			{
				var assign:Function = function(event:*):void
				{
					site[prop] = w.getValue();
				};
				w.setHandler(assign);
				assign(null);
			}
			return w;
		}
		
		/**
		 * 绑定到函数 
		 */ 
		public static function bindSetter(
			setter:Function, 
			host:IEventDispatcher,
			chain:String,
			commitOnly:Boolean = false,
			useWeakReference:Boolean = false):ChangeWatcher
		{
			var w:ChangeWatcher = ChangeWatcher.watch(host, chain, null, commitOnly, useWeakReference);
			if (w != null)
			{
				var invoke:Function = function(event:*):void
				{
					setter(w.getValue());
				};
				w.setHandler(invoke);
				invoke(null);
			}
			
			return w;
		}
		
		/** 
		 * 广播数据更新事件 
		 */
		public static function propertyChangeEvent(
			host:IEventDispatcher, 
			chain:String,
			bubbles:Boolean = false,
			cancelable:Boolean = false):Boolean
		{
			return host.dispatchEvent(
						new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE, 
						bubbles, 
						cancelable, 
						PropertyChangeEvent.UPDATE, 
						chain)
					);
		}
	}
}
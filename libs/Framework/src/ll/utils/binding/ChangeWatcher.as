package ll.utils.binding
{
	import flash.events.IEventDispatcher;

	public class ChangeWatcher
	{
		public function ChangeWatcher(
			access:Object, 
			handler:Function,
			commitOnly:Boolean = false)
		{
			super();
			
			if(access is String)
			{
				this.getter = null;
				this.name = access as String;
			}
			else
			{
				this.getter = access.getter;
				this.name = access.name;
			}
			
			this.host = null;
			this.handler = handler;
			this.commitOnly = commitOnly;
			this.useWeakReference = false;
		}
		
		/** 帧听变化 */
		public static function watch(
			host:IEventDispatcher, 
			chain:String,
			handler:Function,
			commitOnly:Boolean = false,
			useWeakReference:Boolean = false):ChangeWatcher
		{
			var w:ChangeWatcher = 
				new ChangeWatcher(
					chain, 
					handler, 
					commitOnly 
				);
			w.useWeakReference = useWeakReference;
			w.reset(host);
			return w;
		}
		
		private var host:IEventDispatcher;
		private var name:String;
		private var getter:Function;
		private var handler:Function;
		private var commitOnly:Boolean;
		public var useWeakReference:Boolean;
		
		/**
		 *  Detaches this ChangeWatcher instance, and its handler function,
		 *  from the current host.
		 *  You can use the <code>reset()</code> method to reattach
		 *  the ChangeWatcher instance, or watch the same property
		 *  or chain on a different host object.
		 */
		public function unwatch():void
		{
			reset(null);
		}
		
		/**
		 *  Retrieves the current value of the watched property or property chain,
		 *  or null if the host object is null.
		 *  For example:
		 *  <pre>
		 *  watch(obj, "a", ...).getValue() === obj.a
		 *  </pre>
		 *
		 *  @return The current value of the watched property or property chain.
		 */
		public function getValue():Object
		{
			return host == null ? null : getHostPropertyValue();
		}
		
		/**
		 *  Sets the handler function.
		 *
		 *  @param handler The handler function. This argument must not be null.
		 */
		public function setHandler(handler:Function):void
		{
			this.handler = handler;
		}
		
		/**
		 *  Resets this ChangeWatcher instance to use a new host object.
		 *  You can call this method to reuse a watcher instance
		 *  on a different host.
		 *
		 *  @param newHost The new host of the property.
		 *  See the <code>watch()</code> method for more information.
		 */
		public function reset(newHost:IEventDispatcher):void
		{
			//无改变
			if(host == newHost)
			{
				return;
			}
			//移除旧的
			if (host != null)
			{
				host.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE, wrapHandler);
			}
			//添加新的
			host = newHost;
			if (host != null)
			{
				host.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, wrapHandler, false, 100, useWeakReference);
			}
		}
		
		/**
		 *  @private
		 *  Retrieves the current value of the root watched property,
		 *  or null if host is null.
		 *  I.e. watch(obj, "a", ...).getHostPropertyValue() === obj.a
		 */
		private function getHostPropertyValue():Object
		{
			return host == null ? null : getter != null ? getter(host) : host[name];
		}
		
		/**
		 *  @private
		 *  Listener for change events.
		 *  Resets chained watchers and calls user-supplied handler.
		 */
		private function wrapHandler(event:PropertyChangeEvent):void
		{
			if (event.property == name)
			{
				handler(event as PropertyChangeEvent);
			}
		}
	}
}
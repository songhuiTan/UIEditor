package ll.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.profiler.profile;
	
	public class NetEvtTrigger extends EventDispatcher
	{
		private static var instance:NetEvtTrigger = new NetEvtTrigger();
		
		public function NetEvtTrigger(target:IEventDispatcher=null)
		{
			super(target);
		}
		
		public static function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public static function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			instance.removeEventListener(type, listener, useCapture);
		}
		
		public static function hasEventListener(type:String):Boolean
		{
			return	instance.hasEventListener(type);
		}
		
		public static function dispatchEvent(event:Event):Boolean
		{
			return instance.dispatchEvent(event)
		}
	}
}
package ll.evt
{
	import flash.events.Event;

	public class BaseEvent extends Event
	{
		public var data:*;
		public function BaseEvent(type:String, data:* = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		override public function clone():Event
		{
			return new BaseEvent(type,data);
		}
	}
}
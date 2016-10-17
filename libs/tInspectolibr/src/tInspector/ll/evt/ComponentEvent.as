package  tInspector.ll.evt
{
	import flash.events.Event;
	
	public class ComponentEvent extends Event
	{
		public static const LAYER_CHANG:String = "layer_chang";
		public static const COMPONENT_ACTIVE:String = "component_active";
		public static const COMPONENT_ADD:String = "component_add";
		public static const COMPONENT_SELECT:String = "component_select";
		public static const COMPONENT_DELETE:String = "component_delete";
		public static const UPDATE_PROPERTY:String = "update_property";
		
		public var data:Object;
		public function ComponentEvent(type:String, data:Object = null,  bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			this.data = data;
		}
		
		public override function clone():Event
		{
			return new ComponentEvent(this.type, this.data);
		}
	}
}
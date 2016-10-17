package ll
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import ll.util.ViewXmlUtil;
	
	import mx.utils.object_proxy;
	
	import panel.DesignPanel;
	import panel.HierarchyPanel;
	import panel.PropertyPanel;
	
	import tInspector.itamt.utils.inspector.core.propertyview.PropertiesView;
	import tInspector.ll.evt.ComponentEvent;

	public class GlobalControl
	{
		public function GlobalControl()
		{
		}
		
		private static var instance:GlobalControl;
		public static function getInstance():GlobalControl
		{
			if(!instance)
			{
				instance = new GlobalControl();
			}
			return instance;
		}
		
		public var designPanel:DesignPanel;
		public var hieraPanel:HierarchyPanel;
		private var propertyPanel:PropertyPanel;
		public function registView(designPanel:DesignPanel, 
								   hieraPanel:HierarchyPanel,
								   propertyPanel:PropertyPanel):void
		{
			this.designPanel = designPanel;
			this.hieraPanel = hieraPanel;
			this.propertyPanel = propertyPanel;
			
			addEvent();
		}
		
		protected function addEvent():void
		{
			this.hieraPanel.addEventListener(ComponentEvent.LAYER_CHANG, onLayerChange);
			this.hieraPanel.addEventListener(ComponentEvent.COMPONENT_ACTIVE, onComponentActive);
			this.designPanel.addEventListener(ComponentEvent.COMPONENT_ADD, onComponentAdded);
			this.designPanel.addEventListener(ComponentEvent.COMPONENT_SELECT, onComponentSelect);
			this.hieraPanel.addEventListener(ComponentEvent.COMPONENT_SELECT, onComponentSelect);
			this.designPanel.addEventListener(ComponentEvent.UPDATE_PROPERTY, onComponentSelect);
			this.designPanel.addEventListener(ComponentEvent.COMPONENT_DELETE, onComponentDelete);
		}
		
		/**
		 * 大纲内的组件层级发生改变
		 */
		protected function onLayerChange(evt:ComponentEvent):void
		{
			this.designPanel.updateLayer(evt.data[0], evt.data[1], evt.data[2]);
		}
		
		protected function onComponentActive(evt:ComponentEvent):void
		{
			this.designPanel.activeComponent(evt.data as String);
		}
		
		protected function onComponentAdded(evt:tInspector.ll.evt.ComponentEvent):void
		{
			var target:DisplayObject = evt.data as DisplayObject;
			(target as Object).viewXml=ViewXmlUtil.upDateConXml(target);
			this.hieraPanel.addComponent(target);
		}
		
		protected function onComponentDelete(evt:ComponentEvent):void
		{
			var target:DisplayObject = evt.data as DisplayObject;
			
			this.hieraPanel.delComponent(target);
		}
		
		protected function onComponentSelect(evt:ComponentEvent):void
		{
			var  target:DisplayObject = evt.data as DisplayObject;
			this.propertyPanel.setActiveTarget(target);
		}
		
	}
}
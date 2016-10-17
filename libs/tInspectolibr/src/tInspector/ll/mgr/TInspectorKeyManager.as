package tInspector.ll.mgr
{
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	
	import tInspector.itamt.utils.Inspector;
	import tInspector.itamt.utils.inspector.core.InspectTarget;
	import tInspector.itamt.utils.inspector.plugins.InspectorPluginId;
	import tInspector.ll.evt.ComponentEvent;
	import tInspector.msc.input.KeyCode;

	public class TInspectorKeyManager extends EventDispatcher
	{
		private static var _instance:TInspectorKeyManager;
		private var _root:DisplayObjectContainer;
		public function TInspectorKeyManager()
		{
			
		}
		
		public function init(root:DisplayObjectContainer):void
		{
			_root = root;
			Inspector.getInstance().init(_root);
			_root.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);
		}
		
		public static function getInstance():TInspectorKeyManager
		{
			if(!_instance){
				_instance = new TInspectorKeyManager();
			}
			return _instance;
		}
		
		protected function onKeyUp(event:KeyboardEvent):void
		{
			var keyCode:uint = event.keyCode;
			switch(keyCode)
			{
				case KeyCode.F2://显示、关闭编辑窗口
					if(Inspector.getInstance().isOn)
					{
						Inspector.getInstance().turnOff();
					}else{
						Inspector.getInstance().turnOn(InspectorPluginId.LIVE_VIEW);
					}
					break;
//				case KeyCode.DELETE://删除
//					var target:InspectTarget = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject && target.displayObject.parent){
//						target.displayObject.parent.removeChild(target.displayObject);
//						Inspector.getInstance().updateInsectorView();
//						Inspector.getInstance().turnOff();
//						
//						dispatchEvent(new ComponentEvent(ComponentEvent.COMPONENT_DELETE, target.displayObject));
//					}
//					break;
//				case KeyCode.LEFT://左移
//					target = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject){
//						target.displayObject.x--;
//						Inspector.getInstance().updateInsectorView();
//					}
//					break;
//				case KeyCode.RIGHT://右移
//					target = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject){
//						target.displayObject.x++;
//						Inspector.getInstance().updateInsectorView();
//					}
//					break;
//				case KeyCode.UP://上移
//					target = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject){
//						target.displayObject.y--;
//						Inspector.getInstance().updateInsectorView();
//					}
//					break;
//				case KeyCode.DOWN://下移
//					target = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject){
//						target.displayObject.y++;
//						Inspector.getInstance().updateInsectorView();
//					}
//					break;
//				case KeyCode.F3://置底
//					target = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject && target.displayObject.parent){
//						target.displayObject.parent.setChildIndex(target.displayObject,0);
//					}
//					break;
//				case KeyCode.F4://置顶
//					target = Inspector.getInstance().getCurInspectTarget();
//					if(target && target.displayObject && target.displayObject.parent){
//						target.displayObject.parent.setChildIndex(target.displayObject,target.displayObject.parent.numChildren-1);
//					}
					break;
			}
		}
	}
}
package ll.ui
{
	import flash.display.Stage;
	import flash.net.drm.AddToDeviceGroupSetting;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import ll.ui.core.UISprite;
	import ll.ui.core.dx_internal;
	import ll.ui.managers.FocusManager;
	import ll.ui.managers.KeyboardManager;
	
	
	use namespace dx_internal;
	
	public class UIGlobals
	{
		public static var path:String = "";
		public static var STAGEW:uint;
		public static var STAGEH:uint;
		
		public static var focus:FocusManager;
		public static var keyboard:KeyboardManager;
		public function UIGlobals()
		{
		}
		
		private static var _stage:Stage;
		public static function get stage():Stage
		{
			return _stage;
		}
		
		public static function init(stage:Stage):void
		{
			_stage = stage;
			STAGEW = _stage.stageWidth;
			STAGEH = _stage.stageHeight;
			
			focus = FocusManager.getInstance();
			focus.init(_stage);
			
			keyboard = KeyboardManager.getInstance();
			keyboard.init(_stage);
			keyboard.toLockKey(false);
		}
		
		private static var _loadContext:LoaderContext;
		public static function get loaderContext():LoaderContext//LoaderContext 类提供多种选项，以使用 Loader 类来加载 SWF 文件和其它媒体
		{
			if(!_loadContext)
			{
				_loadContext = new LoaderContext();
				_loadContext.applicationDomain = ApplicationDomain.currentDomain;
				_loadContext.allowCodeImport = true;
			}
			return _loadContext;
		}
	}
}
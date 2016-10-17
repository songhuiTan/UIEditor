package app.update.event
{
	import app.config.AppConfig;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class AppUpdateEvent extends Event
	{
		public static const CHECK_UPDATE_COMPLETE:String = "CheckUpdateComplete";
		public static const DOWNLOAD_APP_PACKAGE_COMPLETE:String = "DownloadAppPackageComplete";
		
		public var checkXML:XML;
		public var airFile:File;
		public var updateConfig:AppConfig;
		
		public function AppUpdateEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}
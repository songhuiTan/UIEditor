package ll.res.parsers
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import ll.ui.UIGlobals;

	/**
	 * 图片资源解析器 
	 * @author silenxiao
	 * 
	 */	
	public class LoadResParser extends BaseResParser
	{
		protected var loader:Loader;
		public function LoadResParser()
		{
			super();
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		protected override function startParse(byteData:ByteArray):void
		{
			super.startParse(byteData);
			
			loader.loadBytes(byteData, UIGlobals.loaderContext);
		}
		
		protected function onComplete(evt:Event):void
		{
			this._data = this.loader.content;
			
			parseComplete();
		}
		
	}
}
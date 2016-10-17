package ll.res
{
	import ll.res.data.ResData;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	
	public class ResLoader extends URLLoader
	{
		private var _timeoutTimer:Timer;  
		private var _timeout:Number = 4000; // default timeout value  
		private var isClosed:Boolean;
		
		public static const TIMEOUT:String = 'loaderTimeout';  
		
		public var resData:ResData;
		
		[Event(name="loaderTimeout", type="flash.events.Event")] 
		public function ResLoader(request:URLRequest=null)
		{
			super(request);
			_timeoutTimer = new Timer(_timeout);  
		}  
		
		/**
		 * 加载资源数据
		 * @param resData
		 * 
		 */		
		public function loadResData(resData:ResData):void
		{
			this.resData = resData;
			load(new URLRequest(resData.url));
		}
		
		/**
		 * 重现加载资源数据
		 * 
		 */		
		public function reload():void
		{
			load(new URLRequest(resData.url));
		}
		
		/**
		 *  重写URLLoader的load，外部不调用
		 * @param request
		 * 
		 */		
		override public function load(request:URLRequest):void  
		{
			_timeoutTimer.addEventListener(TimerEvent.TIMER, handleTimeout);  
			_timeoutTimer.delay = _timeout;  
			addEventListener(IOErrorEvent.IO_ERROR, handleLoadActivity);  
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadActivity);  
			addEventListener(Event.COMPLETE, handleLoadActivity);  
			addEventListener(ProgressEvent.PROGRESS, handleLoadActivity);
			isClosed = false;
			super.load(request);  
			_timeoutTimer.start();  
		}  
		
		/**
		 * 设置加载超时的时间
		 */
		public function set timeout(value:Number):void{
			this._timeout = value;
		}
		
		override public function close():void  
		{  
			if(isClosed) return;
			isClosed = true;
			killTimer(); 
			try{
				super.close();
			}catch(e:Error){
				trace(e.getStackTrace());
			};
		}  
		
		private function handleLoadActivity(event:Event):void  
		{  
			killTimer();  
		}  
		
		private function killTimer(event:Event = null):void  
		{  
			removeEventListener(IOErrorEvent.IO_ERROR, handleLoadActivity);  
			removeEventListener(SecurityErrorEvent.SECURITY_ERROR, handleLoadActivity);  
			removeEventListener(Event.COMPLETE, handleLoadActivity);  
			removeEventListener(ProgressEvent.PROGRESS, handleLoadActivity); 
			
			_timeoutTimer.stop();  
			_timeoutTimer.removeEventListener(TimerEvent.TIMER, handleTimeout);  
		}  
		
		private function handleTimeout(event:TimerEvent):void  
		{  
			killTimer();  
			dispatchEvent(new Event(TIMEOUT));  
		} 
	}
}
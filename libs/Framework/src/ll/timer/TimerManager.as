package ll.timer
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	/** 计时器管理类 */
	public class TimerManager
	{
		private var funcToTimerDic:Dictionary;
		private var timerDic:Dictionary;
		private var funcListDic:Dictionary;
		
		private static var _instance:TimerManager = new TimerManager();
		
		public function TimerManager()
		{
			timerDic = new Dictionary();
			funcToTimerDic = new Dictionary();
			funcListDic = new Dictionary();
		}
		
		/**
		 * 延时指定时间调用函数 
		 */ 
		public static function add(delay:int, func:Function) : void
		{
			_instance.add(delay, func);
		}
		
		/**
		 * 延时指定时间调用函数 
		 */ 
		protected function add(delay:int, func:Function) : void
		{
			if (funcToTimerDic[func] != null){
				//此函数已存在，需先移除才能再添加
				return;
			}
			
			createTimer(delay);
			funcToTimerDic[func] = delay;
			funcListDic[delay].push(func);
		}
		
		/**
		 * 延时指定时间调用函数 
		 */ 
		public static function remove(func:Function) : void
		{
			_instance.remove(func);
		}
		
		/**
		 * 是否已经监听调用函数 
		 * @param func
		 * @return 
		 * 
		 */		
		public static function hasFunc(func:Function):Boolean
		{
			if (_instance.funcToTimerDic[func] == null){
				return false;
			}else{
				return true;
			}
		}
			
		/**
		 * 延时指定时间调用函数 
		 */
		protected function remove(func:Function) : void
		{
			if (funcToTimerDic[func] == null){
				return;
			}
			
			var ttimer:Timer = null;
			var tdelay:int = funcToTimerDic[func];
			delete funcToTimerDic[func];
			
			var tlist:Array = funcListDic[tdelay];
			while (tlist.indexOf(func) > -1){
				tlist.splice(tlist.indexOf(func), 1);
			}
			
			if(tlist.length == 0){
				ttimer = timerDic[tdelay] as Timer;
				ttimer.stop();
				ttimer.removeEventListener(TimerEvent.TIMER, timerHandler);
				
				delete funcListDic[tdelay];
				delete timerDic[tdelay];
			}
		}
		
		/** 时间监听处理函数 */
		protected function timerHandler(event:TimerEvent) : void
		{
			var tlist:Array = funcListDic[Timer(event.target).delay];
			for each(var e:Function in tlist){
				if(e.length == 1){
					e(event);
				}
				else{
					e();
				}
			}
		}
		
		/** 创建Timer实例 */
		private function createTimer(delay:int) : Timer
		{
			if(timerDic[delay] == null){
				var ttimer:Timer = timerDic[delay] = new Timer(delay);
				ttimer.addEventListener(TimerEvent.TIMER, timerHandler);
				ttimer.start();
				
				if(funcListDic[delay] == null){
					funcListDic[delay] = [];
				}
			}
			
			return timerDic[delay];
		}
	}
}
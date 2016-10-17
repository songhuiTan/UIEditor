package ll.timer
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * 帧频触发器，每一帧检测回调函数集，回调注册在当前帧的回调函数<br>
	 * 本类是单例类，不允许外部实例化
	 * @author SilenXiao
	 * @date 2013-8-7
	 */	
	public class FrameTimer
	{
		/** 默认执行帧频 */
		public static var DEFAULT_FRAME_RATE:int = 30;
		
		/** 当前真实帧频 */
		public static var STAGE_FRAME_RATE:int = 30;
		
		//时钟进程对象集合
		private var _thread_dict:Dictionary;
		private var _shape:Shape;
		//进程数
		private var _threadNum:uint;
		public function FrameTimer()
		{
			_thread_dict = new Dictionary();
			_shape = new Shape();
		}
		
		/**
		 * 在指定的时间间隔内（已帧为单位）运行指定的函数
		 *	@param closure 要执行的函数的名称
		 *	@param delay_fp 执行函数之前的延迟时间（以帧为单位）。
		 *  @frameRate 运行的帧率
		 *  @repeat  
		 *	@param arguments 传递给 closure 函数的可选参数列表
		 *	@return 时钟进程的唯一数字标识符。使用此标识符可通过调用 clearTime() 方法取消进程。 
		 * 
		 */		
		public function add(closure:Function, delay_fp:uint, repeat:uint = 0, frameRate:int = -1, ...parameters):void
		{
			//进程数+1
			if(!_thread_dict[closure])
				_threadNum++;
			_thread_dict[closure] = new FrameThread(delay_fp,repeat, closure, frameRate, parameters);
			
			if(_threadNum == 1)
			{
				_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		//上一帧的时间
		private var lastFrameTime:uint;
		private function onEnterFrame(evt:Event):void
		{
			//当前帧的时间
			var curFrameTime:uint = getTimer();
			//当前帧与上一帧的时间间隔
			var intervalTime:uint = curFrameTime - lastFrameTime;
			lastFrameTime = curFrameTime;
			for each(var FrameThread:FrameThread in _thread_dict)
			{
				if(FrameThread.exec(curFrameTime, intervalTime))
				{
					if(FrameThread.repeat > 0)
					{
						FrameThread.repeat--;
						if(FrameThread.repeat < 1)
						{
							remove(FrameThread.closure);
						}
					}
				}
			}
		}
		
		/**
		 * 判断时钟的调度中是否包含了指定的函数
		 * @param closure
		 * @return 
		 * 
		 */		
		public function hasFunction(closure:Function):Boolean
		{
			return _thread_dict[closure];			
		}
		
		/**
		 * 取消指定的时钟回调函数
		 * @param clockId 时钟进程的唯一标示符
		 * 
		 */		
		public function remove(closure:Function):void
		{
			if(_thread_dict[closure])
			{
				_thread_dict[closure] = null;
				delete _thread_dict[closure];
				//进程数-1
				_threadNum--;
			}
			if(_threadNum == 0)
			{
				_shape.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			}
		}
		
		/** 销毁 */
		public function dispose():void
		{
			_threadNum = 0;
			_shape.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			for each (var frameThread:FrameThread in _thread_dict)
			{
				delete _thread_dict[frameThread.closure];
			}
			_thread_dict = null;
		}
	}
}


import ll.timer.FrameTimer;

import flash.utils.getTimer;

/**
 * 帧进程
 * @author SilenXiao
 * @date 2013-8-8
 */
class FrameThread
{
	/** 速度，等待多少帧执行一次 */
	public var delay:int;
	/** 等待计数 */
	public var counter:int;
	/** 重复次数，0为无限次 */
	public var repeat:int;
	/** 回调函数 */
	public var closure:Function;
	/** 回传参数 */
	public var parameters:*;
	/** 帧频 */
	public var frameRate:int;
	/** 上次调用时间 */
	public var lastTime:int;
	
	public function FrameThread(delay:int, repeat:int, callback:Function, frameRate:int = -1, ...parameters)
	{
		this.delay = delay;
		this.counter = delay * FrameTimer.STAGE_FRAME_RATE / (frameRate == -1 ? FrameTimer.DEFAULT_FRAME_RATE : frameRate);
		this.repeat = repeat;
		this.closure = callback;
		this.parameters = parameters;
		this.frameRate = frameRate;
		this.lastTime = getTimer();
	}
	
	/** 
	 * 执行
	 * @param	time	当前时间（getTimer）
	 * @param	d_t		与上次执行的间隔
	 * @return	Boolean	true表示有执行，false表示没有达到执行条件
	 */ 
	public function exec(time:int, d_t:int):Boolean
	{
		var trate:int = frameRate == -1 ? FrameTimer.DEFAULT_FRAME_RATE : frameRate;
		var tinv:int = 1000 / trate;
		var tdelay:int = delay * FrameTimer.STAGE_FRAME_RATE / trate;
		var td_t:int = time - lastTime;
		if(td_t >= tinv * tdelay || (--counter < 1))
		{
			lastTime = time;
			counter = tdelay;
			closure.call(null, parameters);
			return true;
		}
		
		return false;
	}
}

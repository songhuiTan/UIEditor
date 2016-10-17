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
	public class FrameManager
	{
		private static var dic:Dictionary = new Dictionary();
		
		public static function freeInstance(name:String = "default") : void
		{
			if(dic[name] != null){
				dic[name].dispose();
			}
			delete dic[name];
		}
		
		public static function getInstance(name:String = "default") : FrameTimer
		{
			if (dic[name] == null){
				dic[name] = new FrameTimer();
			}
			return dic[name];
		}
	}
}

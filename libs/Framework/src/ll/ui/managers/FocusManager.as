package ll.ui.managers
{
	import flash.display.InteractiveObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	/**
	 * 
	 * @author vincent
	 * 焦点管理,注意内存泄漏
	 */	
	public class FocusManager
	{
		private var _focusTarget:InteractiveObject;
		private var _stage:Stage; 
		private static var _instance:FocusManager;
		
		
		public function FocusManager(){
			
		}
		
		public static function getInstance():FocusManager
		{
			if(!_instance)
				_instance = new FocusManager();
			return _instance;
		}
		
		public function init(stage:Stage):void{
			_stage = stage;
		}

		/**
		 * 
		 * @param target InteractiveObject
		 * 设置默认触发焦点
		 * 
		 */		
		public function setFocus(target:InteractiveObject=null):void{
			_focusTarget = target;
			_stage.focus = _focusTarget;
			var e:Error=new Error;
		}
		public function getFocus():InteractiveObject{
			return _focusTarget;
		}
		/**
		 * 
		 * @param hasFocus
		 * 设置默认触发焦点
		 * 
		 */	
		public function hasFocus():Boolean{
			if(_focusTarget){
				return true;
			}
			return false;
		}
		/**
		 * doFocus
		 * if has focused InteractiveObject,return true
		 * otherwise return false
		 * @return Boolean
		 * 
		 */		
		public function doFocus():Boolean{
//			if(_focusTarget){
//				if(_focusTarget is ImgButton){
//					_focusTarget.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
//					_focusTarget = null;
//					return true;
//				}
//			}
			return false;
		}
	}
}
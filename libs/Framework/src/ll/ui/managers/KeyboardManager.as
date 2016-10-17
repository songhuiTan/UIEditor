package ll.ui.managers
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.system.Capabilities;
	import flash.system.IME;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	import flash.utils.getTimer;
	
	import ll.ui.UIGlobals;
	import ll.ui.events.KeyEvent;
	import ll.utils.KeyType;
	import ll.utils.Log;

	public class KeyboardManager extends EventDispatcher
	{
		private var stage:Stage; 
		private var lockState:Boolean = true;
		private var keySequence:Object;
		private var _ctrlKey:Boolean;
		private var _altKey:Boolean;
		private var _shiftKey:Boolean;
		private static var _instance:KeyboardManager;
		public function KeyboardManager()
		{
			keySequence = {};
		}
		
		public static function getInstance():KeyboardManager
		{
			if(!_instance)
				_instance = new KeyboardManager();
			return _instance;
		}
		
		/**
		 * init stage 
		 * @param theStage
		 */
		public function init(theStage:Stage):void
		{
			stage = theStage;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onStageKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP,onStageKeyUp);
			stage.addEventListener(Event.ACTIVATE, onStageActivate);
			stage.addEventListener(Event.DEACTIVATE, onStageDeactivate);
		}
		/**
		 * to stop the key Event continuation
		 */
		private function onStageKeyDown(evt:KeyboardEvent):void 
		{
			if(lockState)return;
			var code:uint = evt.keyCode;
			if(keySequence[code])return;
			keySequence[code] = true;
			if(code==KeyType.VK_ENTER.getCode()&&evt.ctrlKey){
				dispatchEvent(new KeyEvent(KeyEvent.KEY_ENTER_CTRL));
				_ctrlKey=false;
				delete keySequence[code];
				return;
			}

		}
		
		private function onStageKeyUp(evt:KeyboardEvent):void{
			if(lockState)return;
			_ctrlKey = evt.ctrlKey;
			_altKey = evt.altKey;
			_shiftKey=evt.shiftKey;
			var code:uint = evt.keyCode;
			if(!_ctrlKey && !keySequence[code])return;
			delete keySequence[code];
			if(code==KeyType.VK_ENTER.getCode()){
//				if(SystemManger.focus.doFocus())return;
				dispatchEvent(new KeyEvent(KeyEvent.KEY_ENTER));
				return;					
			}
			this.proccessKey(code);
			delete keySequence[Keyboard.CONTROL];
			delete keySequence[Keyboard.SHIFT];
		}
		
		private function proccessKey(code:uint):void{
//			/**存在文本焦点,也可处理下面操作*/
//			if(code==KeyType.VK_UP.getCode()||code==KeyType.VK_DOWN.getCode()){
//				UIEventTrigger.getInstance().dispatchEvent(new KeyEvent(KeyEvent.KEY_DOWN_UP,code));
//				return;
//			}
//			if(code==KeyType.VK_ESCAPE.getCode()){
//				if(!SystemManger.popup.closeActiviWin()){
//					//					UIEventTrigger.getInstance().dispatchEvent(new KeyEvent(KeyEvent.KEY_ESCAPE));
//					SystemManger.popup.addWindow(WindowType.SYSTEM)
//				}
//				return;
//			}
			if(UIGlobals.focus.getFocus() is TextField)return;//编辑文本中不响应功能
			
			/**存在文本焦点,不予处理下面操作*/
			proccessHotKey(code);
		}
		/**
		 * 响应热键
		 * @param code
		 */		
		private function proccessHotKey(code:uint):void{
		}
		
		public function isKeyDown(keyType:KeyType):Boolean{
			return keySequence[keyType.getCode()];
		}
		
		private function onStageDeactivate(evt:Event):void{
			keySequence = {};
		}
		
		private function onStageActivate(evt:Event):void{
			UIGlobals.focus.setFocus(null);
			if(Capabilities.hasIME){
				IME.enabled = false;
			}
		}
		
		public function toLockKey(b:Boolean=false):void{
			lockState = b;
		}
		
	}
}
package ll.ui.managers.drag
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import ll.ui.UIGlobals;
	import ll.ui.core.UIComponent;
	import ll.ui.core.UISprite;
	import ll.ui.interfaces.IDispose;
	
	public class DragManager
	{
		/** 正在拖动 */
		public static var isDraging:Boolean;
		/** 拖拽目标的组件 */
		public static var target:UIComponent;
		/** 拖动的目标 */
		public static var dragTarget:DisplayObject;
		/** 拖动目标的数据源 */
		public static var dataSource:DataSource;
		/**拖动后的处理函数*/
		public static var dropFunc:Function;
		/** 场景stage */
		public static var stage:Stage;
		
		/**
		 * 
		 * @param dragTarget	拖动的目标
		 * @param dragTarget	拖动目标的显示对象
		 * @param dataSource	拖动目标的数据源
		 * @param dropFun 移除拖拽目标的回调函数
		 */		
		public static function startDrag(mtarget:UIComponent, mdataSource:DataSource, mdropFun:Function = null):void
		{
			if(isDraging)
				return;
			isDraging = true;
			
			target = mtarget;
			dataSource = mdataSource;
			dragTarget = mdataSource.dragTarget;
			dropFunc = mdropFun;
			dragTarget.visible = false;
			if(!stage)
			{
				stage = UIGlobals.stage;
			}
			if(!stage.hasEventListener(MouseEvent.MOUSE_MOVE))
			{
				stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
			}
			stage.addChild(dragTarget);
		}
		/**
		 * 
		 * @正在移动
		 * 
		 */		
		private static function onMouseMove(event:MouseEvent):void{
			dragTarget.visible = true;
			dragTarget.x = stage.mouseX-15;
			dragTarget.y = stage.mouseY-15;
			if(!stage.hasEventListener(MouseEvent.MOUSE_UP))
				stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
		}
		/**抛出多个onDropToStage---待完善*/
		private static function onMouseUp(e:MouseEvent):void{
			dropFunc && dropFunc(dataSource);
			endDrag();
			e.stopPropagation();
		}
		
		
		/**
		 * endDrag
		 * @param remove The target,listener,and set to null 
		 */
		public static function endDrag():void{
			if(!isDraging)
				return;
			if(dragTarget != null){
				stage.removeChild(dragTarget);
				if(dragTarget is IDispose){
					(dragTarget as IDispose).dispose();
				}else if(dragTarget is Bitmap)
				{
					Bitmap(dragTarget).bitmapData.dispose();
				}
			}
			if(stage){
				stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseUp);
			}
			isDraging = false;
			dragTarget = null;
//			dataSource = null;
			dropFunc = null;
		}
	}
}
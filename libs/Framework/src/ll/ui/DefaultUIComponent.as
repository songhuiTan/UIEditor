package ll.ui
{
	import flash.display.BitmapData;
	import flash.display.DisplayObjectContainer;
	import flash.filters.GlowFilter;
	import flash.text.StyleSheet;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;
	
	import ll.ui.components.Button;
	import ll.ui.components.Image;
	import ll.ui.components.Label;
	import ll.ui.components.RadioButton;
	import ll.ui.core.UIComponent;
	
	/**
	 * UI的组件
	 * @author SilenXiao
	 * 
	 */	
	public class DefaultUIComponent
	{
		public function DefaultUIComponent()
		{
		}
		
		
		/** 默认的按钮文字颜色 */
		public static const BTN_TEXT_COLOR:uint = 0xF2D0A0;
		public static const BTN_TEXT_FORMAT:TextFormat = new TextFormat(TEXT_FONT, 12, BTN_TEXT_COLOR);
		
		/** 默认文字颜色 */
		public static const TEXT_COLOR:uint = 0xD4D4D4;
		
		/** 默认的字体 */
		public static const TEXT_FONT:String = "SimSun";// 微软雅黑：Microsoft YaHei， 隶书: LiSu
		
		/** 默认的文字样式 */
		public static const TEXT_FORMAT:TextFormat = new TextFormat(TEXT_FONT, 12, TEXT_COLOR, null, null, null, null, null, null, null, null, null, 4);
		
		/** 默认的文字描边 */
		public static const TEXT_FILTER:Array = [new GlowFilter(0x130000,1, 1, 1, 1)];
		
		private static var _styleSheet:StyleSheet;
		
		/**
		 * 资源字典映射 
		 */		
		public static var _uiTypeDic:Dictionary;
		public static function get uiTypeDic():Dictionary
		{
			if(_uiTypeDic==null){
				inituiTypeDic();
			}
			return _uiTypeDic;
		}
		
		private static function inituiTypeDic():void
		{
			if(_uiTypeDic!=null){
				return;
			}
			_uiTypeDic=new Dictionary();
			_uiTypeDic[UIType.BTN_CLOSE]="";
			_uiTypeDic[UIType.BTN_NORMAL]="btn_common_21";
			_uiTypeDic[UIType.BTN_SCROLL_UP]="scroll_up_1:true";
			_uiTypeDic[UIType.BTN_SCROLL_DOWN]="scroll_down_1:true";
			_uiTypeDic[UIType.BTN_SCROLL_TRACK]="scroll_drag_1:true";
			
			
			_uiTypeDic[UIType.BTN_PRE]="btn_page_pre:true";
			_uiTypeDic[UIType.BTN_NEXT]="btn_page_next:true";
			_uiTypeDic[UIType.BTN_FIRST]="btn_page_first:true";
			_uiTypeDic[UIType.BTN_LAST]="btn_page_last:true";
			_uiTypeDic[UIType.BTN_CLOSE]="btn_close";
			
			_uiTypeDic[UIType.RADIOBTN_TAB]="tab_up_2";
			_uiTypeDic[UIType.RADIOBTN_NORMAL]="btn_check2";
			_uiTypeDic[UIType.RADIOBTN_NORMAL]="btn_check2";
			
			
		}
		
		
		/** 获取默认的CSS样式 */
		public static function get styleSheet():StyleSheet
		{
			if(!_styleSheet)
			{
				_styleSheet = new StyleSheet();
				_styleSheet.parseCSS(
					"a {color: #76EB35;text-decoration:underline;} " +
					"a:hover {color: #ff0000;text-decoration:none;}");
			}
			return _styleSheet;
		}
		public static function creatLabel(parent:DisplayObjectContainer, text:String, isHtml:Boolean = false):Label
		{
			var lbl:Label = new Label();
			if(parent){
				parent.addChild(lbl);
			}
			lbl.defaultTextFormat = TEXT_FORMAT;
			if(isHtml)
			{
				lbl.htmlText = text;
			}else{
				lbl.text = text;
			}
			return lbl;
		}
		
		public static function createButton(parent:UIComponent,type:uint, funCreated:Function = null, ...param):Button
		{
			inituiTypeDic();
			if(funCreated != null)
			{
				return funCreated.call(null, param)
			}
			var btn:Button = new Button();
			if(parent){
				parent.addChild(btn);
			}
			btn.assetName=uiTypeDic[type];
			
			switch(type)
			{
				case UIType.BTN_NORMAL:
					btn.label = param[0];
					break;
//				case UIType.BTN_SCROLL_DOWN:
//					btn.assetName="scroll_down_1:true";
//					btn.setsize(19,19);
//					break;
//				case UIType.BTN_SCROLL_UP:
//					btn.assetName="scroll_up_1:true";
//					btn.setsize(19,19);
//					break;
				case UIType.BTN_SCROLL_TRACK:
//					btn.assetName="scroll_drag_1:true";
					btn.setsize(19,24);
					break;
			}
			return btn;
		}
		
		public static function createImg(parent:UIComponent, imgname:String = "", callBackFnOnloaded:Function = null):Image
		{
			var img:Image = new Image();
			if(parent){
				parent.addChild(img);
			}
			img.setAssetName(callBackFnOnloaded, imgname);
			return img;
		}
		
		
		public static function createRadioButton(parent:UIComponent,type:uint, funCreated:Function = null, ...param):RadioButton
		{
			inituiTypeDic();
			var rbtn:RadioButton = new RadioButton();
			if(parent){
				parent.addChild(rbtn);
			}
			rbtn.assetName=uiTypeDic[type];
//			switch(type)
//			{
//				case UIType.RADIOBTN_NORMAL:
//					rbtn.assetName="btn_check2";
//					break;
//				case UIType.RADIOBTN_TAB:
//					rbtn.assetName="tab_up_2";
//					break;
//			}
			return rbtn;
		}
		
		public static function creaLinktLabel(parent:DisplayObjectContainer, text:String):Label
		{
			var lingLbl:Label=creatLabel(parent,text,true);
			lingLbl.styleSheet=DefaultUIComponent.styleSheet;
			lingLbl.mouseEnabled=true;
			return lingLbl
		}
		
		/**
		 * @param name			锚标签
		 * @param eventValue	事件类型
		 */		
		public static function getHtmlLink(name:String,eventValue:String="",isBlod:Boolean=false,fontSize:int=12):String
		{
			var returnStr:String;
			if(isBlod){
				returnStr="<b>"+"<font "+"size='"+fontSize+"'>"+"<a href='event:"+eventValue +"'>" + 
					name + 
					"</a>"+"</font>"+"</b>";
			}else
			{
				returnStr="<font "+"size='"+fontSize+"'>"+"<a href='event:"+eventValue +"'>" + 
					name + 
					"</a>"+"</font>";
			}
			return returnStr;
		}
		
	}
}

package ll.util
{
	import flash.display.DisplayObject;
	
	import flashx.textLayout.elements.BreakElement;
	
	import ll.ui.DefaultUIComponent;
	import ll.ui.UIType;
	import ll.ui.collections.ArrayCollection;
	import ll.ui.components.Button;
	import ll.ui.components.CheckBox;
	import ll.ui.components.GridList;
	import ll.ui.components.Image;
	import ll.ui.components.Label;
	import ll.ui.components.List;
	import ll.ui.components.PageNavigator;
	import ll.ui.components.Panel;
	import ll.ui.components.RadioButton;
	import ll.ui.components.Scroller;
	import ll.ui.components.TabBar;
	import ll.ui.components.TextInput;
	import ll.ui.components.TitleWindow;
	import ll.ui.core.ScrollBar;
	import ll.ui.core.UISprite;

	public class CreateFactory
	{
		public static var panelId:uint;
		public static function getPanel():Panel
		{
			var panel:Panel = new Panel();
			panel.assetName = "win_bg_12";
			panel.setsize(80, 60);
			panel.id="Panel"+ (panelId++);
			return panel;
		}
		
		public static var btnId:uint;
		public static function getButton():Button
		{
			var btn:Button = DefaultUIComponent.createButton(null,UIType.BTN_NORMAL,null,'按钮');
			btn.setsize(60, 25);
			btn.id="Button"+ (btnId++);
			return btn;
		}
		
		public static var imgId:uint;
		public static function getImage():Image
		{
			var img:Image = DefaultUIComponent.createImg(null,'win_bg_12',null);
//				new Image();
//			img.assetName = 'win_bg_12';
			img.setsize(80, 25);
			img.id="Image"+ (imgId++);
			return img;
		}
		
		public static var lblId:uint;
		public static function getLabel():Label
		{
			var label:Label = DefaultUIComponent.creatLabel(null,"这是个文本",false);
//				new Label();
//			label.text = "这是个文本";
			label.textColor=0x000000;
			label.id="Label"+ (lblId++);
			return label;
		}
		
		public static var chkBoxId:uint;
		public static function getCheckBoxl():CheckBox
		{
			var check:CheckBox = new CheckBox();
			check.label="多选框";
			check.assetName = 'btn_check';
			check.id="CheckBox"+ (chkBoxId++);
			return check;
		}
		
		public static var titleWinId:uint;
		public static function getTitleWindow():TitleWindow
		{
			var titleWin:TitleWindow = new TitleWindow();
			titleWin.assetName = "win_bg_12";
			titleWin.setsize(80, 60);
			titleWin.id="TitleWindow"+ (titleWinId++);
			return titleWin;
		}
		
		public static var listId:uint;
		public static function getList():List
		{
			var list:List = new List();
//			var dataArr:ArrayCollection=new ArrayCollection([1,2,3]);
//			list.itemRendererXml= <ItemRenderer></ItemRenderer>;
//			list.dataProvider=dataArr;
			list.id="List"+ (listId++);
			return list;
		}
		public static var gridlistId:uint;
		public static function getGridList():GridList
		{
			var gridList:GridList = new GridList();
//			var dataArr:ArrayCollection=new ArrayCollection([1,2,3]);
//			list.itemRendererXml= <ItemRenderer></ItemRenderer>;
//			list.dataProvider=dataArr;
			gridList.id="GridList"+ (gridlistId++);
			return gridList;
		}
		
//		public static function getGridList():GridList
//		{
//			var gridlist:GridList = new GridList();
//			gridlist.id="GridList"+int(Math.random()*500);
//			return gridlist;
//		}
		
		public static var radioId:uint;
		public static function getRadioButton():RadioButton
		{
			var radioBtn:RadioButton =DefaultUIComponent.createRadioButton(null,UIType.RADIOBTN_NORMAL);
//				new RadioButton();
//			radioBtn.assetName = "btn_check2";
			radioBtn.label="单选框";
			radioBtn.id="RadioButton"+ (radioId++);
			return radioBtn;
		}
		
		public static var scrollId:uint;
		public static function getScroller():UISprite
		{
			var scroller:Scroller = new Scroller();
//			scroller.setsize(30,100);
//			var pa:Panel=new Panel();
//			pa.assetName = "win_bg_12";
//			scroller.viewport=pa;
//			pa.setsize(60, 400);
//			pa.visible=false;
			scroller.id="Scroller"+ (scrollId++)
			return scroller;
		}
		
		public static var tabBarId:uint;
		public static function getTabBar():TabBar
		{
			var tabbar:TabBar = new TabBar();
//			var dataArr:ArrayCollection=new ArrayCollection([1,2,3])
//			tabbar.dataProvider=dataArr;
			tabbar.lableStr="1,2,3"
			tabbar.id="TabBar"+ (tabBarId++);
			return tabbar;
		}
		
		public static var txtInputId:int;
		public static function getTextInput():TextInput
		{
			var textInput:TextInput = new TextInput();
			textInput.defaultValue="输入框";
			textInput.id="TextInput"+ (chkBoxId++);
			return textInput;
		}
		
		public static var pageNavId:int;
		public static function getPageNavigator():PageNavigator
		{
			var pageNav:PageNavigator = new PageNavigator();
			pageNav.id = "PageNavigator" + (pageNavId++);
			return pageNav;
		}
		
		public static function resetId():void
		{
			panelId = 0;
			btnId = 0;
			imgId = 0;
			lblId = 0;
			chkBoxId = 0;
			titleWinId = 0;
			listId = 0;
			radioId = 0;
			scrollId = 0;
			tabBarId = 0;
			txtInputId = 0;
		}
		
		public static function resetComponentId(id:String):void
		{
			var componentName:Array = ["Button", "Panel", "Image","PageNavigator", "Label", "CheckBox", "TitleWindow", "List","GridList", "RadioButton", "Scroller", "TabBar", "TextInput"];
			for each(var className:String in componentName)
			{
				var pos:int = id.indexOf(className);
				if(pos != -1)
				{
					var index:uint = uint(id.substr(className.length));
					switch(className)
					{
						case "Button":
							if(btnId < index)
								btnId = index + 1;
							break;
						case "Panel":
							if(panelId < index)
								panelId = index + 1;
							break;
						case "Image":
							if(imgId < index)
								imgId = index + 1;
							break;
						case "Label":
							if(lblId < index)
								lblId = index + 1;
							break;
						case "CheckBox":
							if(chkBoxId < index)
								chkBoxId = index + 1;
							break;
						case "TitleWindow":
							if(titleWinId < index)
								titleWinId = index + 1;
							break;
						case "List":
							if(listId < index)
								listId = index + 1;
							break;
						case "RadioButton":
							if(radioId < index)
								radioId = index + 1;
							break;
						case "Scroller":
							if(scrollId < index)
								scrollId = index + 1;
							break;
						case "TabBar":
							if(tabBarId < index)
								tabBarId = index + 1;
							break;
						case "TextInput":
							if(txtInputId < index)
								txtInputId = index + 1;
							break;
						case "PageNavigator":
							if(pageNavId < index)
								pageNavId = index + 1;
							break;
						case "GridList":
							if(gridlistId < index)
								gridlistId = index + 1;
							break;
							
					}
					break;
				}
			}
		}
		
		public static function getUIComponent(value:String):DisplayObject
		{
			switch(value)
			{
				case "Button":
					return getButton();
					break;
				case "Panel":
					return getPanel();
					break;
				case "Image":
					return getImage();
					break;
				case "Label":
					return getLabel();
					break;
				case "CheckBox":
					return getCheckBoxl();
					break;
				case "TitleWindow":
					return getTitleWindow();
					break;
				case "List":
					return getList();
					break;
				case "GridList":
					return getGridList();
					break;
				case "RadioButton":
					return getRadioButton();
					break;
				case "Scroller":
					return getScroller();
					break;
				case "TabBar":
					return getTabBar();
					break;
				case "TextInput":
					return getTextInput();
					break;
				case "GridList":
					return getGridList();
					break;
				case "PageNavigator":
					return getPageNavigator();
					break;
			}
			return null;
		}
	}
}
package ll.util
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import flashx.textLayout.elements.BreakElement;
	
	import ll.ui.components.*;
	import ll.ui.components.Button;
	import ll.ui.core.DataGroup;
	import ll.ui.core.ScrollBar;
	import ll.ui.core.UISprite;
	
	import spark.components.gridClasses.GridLayer;

	/**
	 * 生成与翻译组件xml
	 * @author tansonghui
	 */
	public class ViewXmlUtil
	{
		public function ViewXmlUtil()
		{
		}
		
		private var retXml:XML;
		public static function getViewXml(container:DisplayObjectContainer,rootXml:XML=null):XML
		{
			if(!container)
				return null;
			var retXml:XML = rootXml ? rootXml : new XML(<root></root>);
			analysisXml(retXml, container);
			return retXml;
		}
		
		public static function analysisXml(root:XML, container:DisplayObjectContainer):void
		{
			var length:int = container.numChildren;
			var child:DisplayObject;
			var childXml:XML;
			for (var i:int = 0; i < length; i++) 
			{
				childXml=null;
				child = container.getChildAt(i);
				if(!child.hasOwnProperty("id"))
				{
					continue;
				}
				
				if(child.hasOwnProperty("id") && child["id"].indexOf("ll.ui.components") != -1)
				{
					continue;
				}
				childXml=analysisToXml(child);
				if(!childXml)
				{
					continue;
				}
				root.appendChild(childXml);
				if(child is Panel)
				{
					analysisXml(childXml, child as DisplayObjectContainer);
				}
			}
		}
		
		public static  function  analysisToXml(dis:DisplayObject):XML
		{
			var curDisXml:XML;
			if(dis.hasOwnProperty("viewXml")){
				if((dis as Object).viewXml != null){
					curDisXml = (dis as Object).viewXml.copy();
				}
			}
			if(curDisXml){
				var length:int = curDisXml.children().length();
				if(dis is List && length == 0){
					var renderXml:XML = new XML(<ItemRenderer></ItemRenderer>)
					var numChild:int=(dis as List).numChildren;
					analysisXml(renderXml, dis as DisplayObjectContainer);
					curDisXml.appendChild(renderXml);
				}
			}
			return curDisXml;
		}
		
		/**
		 **  初始化/更新 组件的xml数据
		 */		
		public static function upDateConXml(dis:DisplayObject):XML
		{
			if(!dis.hasOwnProperty("viewXml")){
				trace("初始化组件xml失败，组件没有viewXml数据可设置");
				return null;
			}
			var settingXml:XML;
			if((dis as Object).viewXml==null){//第一次拖进来的时候赋值xml
				settingXml=initCompontXml(dis);
			}else
			{
				settingXml=(dis as Object).viewXml;
			}
			for each(var att:XML in settingXml.attributes())
			{
				trace( att.name());
				if(dis[String(att.name())] != "")
					settingXml[att.name()]=dis[String(att.name())]+"" ;
			}
			
///////公告属性xml设置			
//			var id:String = dis["id"];
//			var pox:int = dis.x;
//			var poy:int = dis.y;
//			var disWidth:int = dis.width;
//			var disHeight:int = dis.height;
//			settingXml.@id=id;
//			settingXml.@x=pox;
//			settingXml.@y=poy;
//			settingXml.@width=disWidth;
//			settingXml.@height=disHeight;
////特点属性xml设置
//			switch(displayObjectToString(dis))
//			{
//				case "Button":
////					settingXml.@label=(dis as Button).label;
////					settingXml.@assetName=(dis as Button).assetName;
////					settingXml.@assetName=(dis as Button).assetName;
//					
//					
//					<Button id='' x='' y='' width='' height='' label='' assetName='' textImgName='' labelColorMouseOver='' labelColorMouseDown='' labelColorNormal='' toolTip=''/>;
//					break;
//				case "Panel":
//					resualtXml=<Panel id='' x='' y='' width='' height='' assetName='' lineWidth='' lineHeight='' mouseWheelLine=''/>;
//					break;
//				case "Image":
//					resualtXml=<Image id='' x='' y=''  width='' height='' assetName='' toolTip=''/>;
//					break;
//				case "Label":
//					resualtXml= <Label id='' x='' y='' text='' autoSize='left' />;					
//					break;
//				case "CheckBox":
//					resualtXml= <CheckBox id='' x='' y='' width='' height='' label='' layoutType='' checked=''/>;	
//					break;
//				case "TitleWindow":
//					resualtXml= <TitleWindow id='' x='' y='' width='' height=''/>;	
//					break;
//				case "List":
//					resualtXml= <List id='' x='' y ='' layoutType='' mouseWheelLine=''/>;
//					break;
//				case "RadioButton":
//					resualtXml= <RadioButton id='' x='' y='' width='' height='' label='' groupName=''/>;
//					break;
//				case "Scroller":
//					resualtXml= <Scroller  id='' x='' y='' width='' height='' assetName='' titleName=''/>;
//					break;
//				case "TabBar":
//					resualtXml= <TabBar id='' x='' y=''> </TabBar>;
//					break;
//				case "TextInput":
//					resualtXml= <TextInput id='' x='' y='' defaultValue='' width='' height=''/>;
//					break;
//			}
			
			
			
			
			
			
			
			
			
			return settingXml;
		}
		
		
		public static function initCompontXml(dis:DisplayObject):XML
		{
			
			var resualtXml:XML;			
			switch(displayObjectToString(dis))
			{
				case "Button":
					resualtXml= <Button id='' x='' y='' width='' height=''  assetName=''  textImgName='' label=''  labelColorMouseOver='' labelColorMouseDown='' labelColorNormal='' toolTip=''/>;
					break;
				case "Panel":
					resualtXml=<Panel id='' x='' y='' width='' height='' assetName='' lineWidth='' lineHeight='' mouseWheelLine=''/>;
					break;
				case "Image":
					resualtXml=<Image id='' x='' y=''  width='' height='' assetName='' />;
					break;
				case "Label":
					resualtXml= <Label id='' x='' y='' text='' autoSize='left' />;					
					break;
				case "CheckBox":
					resualtXml= <CheckBox id='' x='' y='' width='' height='' assetName=''  label='' layoutType=''/>;	
					break;
				case "TitleWindow":
					resualtXml= <TitleWindow id='' x='' y='' width='' height=''/>;	
					break;
				case "List":
					resualtXml= <List id='' x='' y =''  />;
					break;
				case "GridList":
					resualtXml= <GridList id='' x='' y ='' defaultDataStr="" rows="" />;
					break;
				case "RadioButton":
					resualtXml= <RadioButton id='' x='' y='' width='' height='' label='' groupName=''/>;
					break;
				case "Scroller":
					resualtXml= <Scroller  id='' x='' y='' width='' height=''/>;
					break;
				case "TabBar":
					resualtXml= <TabBar id='' x='' y='' assetName='' lableStr="" renderSize="" > </TabBar>;
					break;
				case "TextInput":
					resualtXml= <TextInput id='' x='' y='' defaultValue='' width='' height=''/>;
					break;
				case "GridList":
					resualtXml= <GridList id='' x='' y =''  rows="2" />;
					break;
				case "PageNavigator":
					resualtXml= <PageNavigator id='' x='' y='' />;
					break;
			}
			return resualtXml;
			
		}
		
		
		
		/**
		 * 传入显示对象，返回对应的对象类名字 
		 * @param dis
		 * @return 
		 * 
		 */		
		public static function displayObjectToString(dis:DisplayObject):String
		{
			if(!dis){
				return null
			}
			if(dis is GridList){
				return "GridList"
			}
			if(dis is Scroller){
				return "Scroller"
			}
			if(dis is CheckBox){
				return "CheckBox"
			}
			if(dis is Button){
				return "Button"
			}
			if(dis is Panel){
				return "Panel"
			}
			if(dis is Image){
				return "Image"
			}
			if(dis is Label){
				return "Label"
			}
		
			if(dis is TitleWindow){
				return "TitleWindow"
			}
			if(dis is GridList)
				return "GridList";
			if(dis is List){
				return "List"
			}
			if(dis is RadioButton){
				return "RadioButton"
			}
			if(dis is TabBar){
				return "TabBar"
			}
			if(dis is TextInput){
				return "TextInput"
			}
			if(dis is PageNavigator)
			{
				return "PageNavigator"
			}
			return null
		}
		
		/**
		 * 英文属性转换为中文属性 
		 * @param englishArr
		 * @return 
		 * 
		 */		
		public static function attrTransTochina(englishArr:String):String
		{
			var resaultStr:String="";
			switch(englishArr)
			{
				case "x":
					resaultStr="x坐标"
					break;
				case "y":
					resaultStr="y坐标"
					break;
				case "id":
					resaultStr="ID"
					break;
				case "width":
					resaultStr="宽度"
					break;
				case "height":
					resaultStr="高度"
					break;
				case "label":
					resaultStr="文本"
					break;
				case "assetName":
					resaultStr="资源"
					break;
				case "textImgName":
					resaultStr="美术字"
					break;
				case "labelColorMouseOver":
					resaultStr="over色"
					break;
				case "labelColorMouseDown":
					resaultStr="down色"
					break;
				case "labelColorNormal":
					resaultStr="颜色"
					break;
				case "toolTip":
					resaultStr="提示"
					break;
				case "layoutType":
					resaultStr="布局"
					break;
				case "checked":
					resaultStr="选中"
					break;
				case "text":
					resaultStr="文本"
					break;
				case "groupName":
					resaultStr="组名"
					break;
				case "defaultValue":
					resaultStr="文本"
					break;
				case "autoSize":
					resaultStr="对齐"
					break;
				case "lableStr":
					resaultStr="选项文本"
					break;
				case "renderSize":
					resaultStr="按钮宽高"
					break;
				case "defaultDataStr":
					resaultStr="默认数据"
					break;
				case "rows":
					resaultStr="列数";
					break;
			}
			
			return resaultStr;
		}
		
		
		
	}
}
package ll.ui
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.utils.getDefinitionByName;
	
	import ll.ui.collections.ArrayCollection;
	import ll.ui.collections.ICollection;
	import ll.ui.components.List;
	import ll.ui.components.Panel;
	import ll.ui.components.Scroller;
	import ll.ui.components.ViewStack;
	import ll.ui.core.DataGroup;
	import ll.ui.core.UIComponent;
	import ll.ui.core.UISprite;
	import ll.ui.interfaces.IScroll;
	import ll.ui.renderer.ItemRenderer;
	
	public class ViewCreate
	{
		public function ViewCreate()
		{
		}
		
		private static var instance:ViewCreate = new ViewCreate();
		/**
		 * 根据XML配置来创建界面，<br/>
		 * @example 现有组件配置如下：
		 <Image id='' x='' y=''  width='' height='' assetName='' toolTip=''/>
		 <Label id='' x='' y='' text='' autoSize='' toolTip=''/>
		 <Button id='' x='' y='' width='' height='' label='' assetName='资源名:是否为单态' textImgName='' labelColorMouseOver='' labelColorMouseDown='' labelColorNormal='' toolTip=''/>
		 <CheckBox id='' x='' y='' width='' height='' label='' layoutType='' checked=''/>
		 <RadioButton id='' x='' y='' width='' height='' label='' groupName='' />
		 <List id='' x='' y ='' layoutType='' mouseWheelLine=''>
		 <ItemRenderer>(插入render的Xml)
		 </ItemRenderer>
		 </List>
		 <TabBar id='' x='' y=''>
		 </TabBar>
		 <GridList id='' x='' y='' rows='' mouseWheelLine=''>
		 <ItemRenderer width='' height=''> (插入render的Xml)
		 </ItemRenderer>
		 </GridList>
		 <PageNavigator id='' x='' y='' />
		 <Panel id='' x='' y='' width='' height='' assetName='' lineWidth='' lineHeight='' mouseWheelLine=''>
		 </Panel>
		 <TextInput id='' x='' y='' defaultValue='' width='' height=''/>
		 <Scroller  id='' x='' y='' width='' height='' assetName='' titleName=''>
		 <IScroll>(插入扩展IScroll的组件：Panel，List,GridList)
		 </IScroll>
		 </Scroller>
		 <ViewStack id='' x='' y='' >
		 <Panel>
		 </Panel>
		 ....
		 <Panel>
		 </Panel>
		 </ViewStack>
		 */		
		public  static function createView(xml:XML, container:DisplayObjectContainer, root:DisplayObject):void
		{
			instance.toCreateView(xml, container, root);
		}
		
		private function toCreateView(xml:XML, container:DisplayObjectContainer, root:DisplayObject):void
		{
			for each(var child:XML in xml.children())
			{
				if(container is DataGroup)
				{//具有呈现器的组件
					DataGroup(container).itemRendererXml = child;
					if(String(xml.@defaultDataStr) != ""){
						var tempArrayConnect:ICollection=DataGroup(container).dataProvider==null?new ArrayCollection():DataGroup(container).dataProvider;
						tempArrayConnect.source=String(xml.@defaultDataStr).split(",");
					}
				}else{
					var uiComponent:DisplayObject = creatUIComponent(child)
					if(container is ViewStack)
					{
						ViewStack(container).addPanel(uiComponent as Panel);
					}else{
						if(container is Scroller)
						{
							Scroller(container).viewport = IScroll(uiComponent);
						}else{
							container.addChild(uiComponent);
							if(container.hasOwnProperty(uiComponent["id"])  || container  is ItemRenderer)
							{
								container[uiComponent["id"]] = uiComponent;
							}
						}
						if(root.hasOwnProperty(uiComponent["id"]))
						{
							root[uiComponent["id"]] = uiComponent;
						}
					}
					if(child.children().length() > 0)
						toCreateView(child, uiComponent as UISprite, root);
				}
			}
		}
		
		private function creatUIComponent(child:XML):DisplayObject
		{
			var cla:Class = getDefinitionByName("ll.ui.components." + child.name()) as Class;
			var dp:DisplayObject = new cla() as DisplayObject;
			
//			if(dp is DataGroup)//必须先设置datagroup的renderxml，，不然defaultDataStr会导致rander的组件错误
//			{
//				DataGroup(dp).itemRendererXml = XML(child.ItemRenderer);
//			}
			
			if(dp&&dp.hasOwnProperty("viewXml")){
				dp["viewXml"]=child;
			}
			for each(var att:XML in child.attributes())
			{
				dp[String(att.name())] = child[att.name()];
			}
			return dp;
		}
		
		public static function getViewXml(container:DisplayObjectContainer,rootXml:XML=null):XML
		{
			if(!container)
				return null;
			var xml:XML = rootXml ? rootXml : new XML(<root></root>);
			var length:int = container.numChildren;
			var child:DisplayObject;
			var childXml:XML;
			for (var i:int = 0; i < length; i++) 
			{
				childXml=null;
				child = container.getChildAt(i);
				childXml=analysisToXml(child);
				xml.appendChild(childXml);
			}
			return xml;
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
				if(dis is List){
					var renderXml:XML;
					var numChild:int=(dis as List).numChildren;
					renderXml=getViewXml(dis as DisplayObjectContainer,new XML(<ItemRenderer></ItemRenderer>));
					curDisXml.appendChild(renderXml);
				}
			}
			return curDisXml;
		}
	}
}
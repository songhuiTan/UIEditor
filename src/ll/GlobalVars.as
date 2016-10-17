package ll
{
	import ll.ui.managers.AssetsManager;
	
	import flash.geom.Rectangle;

	public class GlobalVars
	{
		public static var defaultPath:String;
		public static var assetPath:String;
		public function GlobalVars()
		{
		}
		
		public static function parseConfigXml(xml:XML):void
		{
			defaultPath = String(xml.DefaultUI.@path);
			assetPath = String(xml.AssetUI.@path);
			for each(var child:XML in xml.scale9Grid.children())
			{
				var rectArr:Array = String(child.@rect).split(",");
				if(rectArr.length == 4)
					AssetsManager.getInstance().putImgScale9Grid(String(child.@name), new Rectangle(rectArr[0], rectArr[1], rectArr[2], rectArr[3])); 
			}
		}
	}
}
package ll.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * 颜色转换工具 
	 * @author SilenXiao
	 * 
	 */		
	public class ColorTransKit
	{
		/**灰色*/
		public static const GRAY:String = "GRAY";
		/**白色*/
		public static const WHITE:String = "WHITE";
		/**黑色*/
		public static const BLACK:String = "BLACK";
		/**红色*/
		public static const RED:String = "RED";
		/**深红色*/
		public static const RED_DARK:String = "RED_DARK";
		/**蓝色*/
		public static const BLUE:String = "BLUE";
		/**绿色*/
		public static const GREEN:String = "GREEN";
		/**黄色*/
		public static const YELLOW:String = "YELLOW";
		/**橙色*/
		public static const ORANGE:String = "ORANGE";
		/**紫色*/
		public static const PURPLE:String = "PURPLE";
		
		/**变暗*/
		public static const DARK:String = "DARK";
		/**变亮*/
		public static const LIGHT:String = "LIGHT";
		
		
		/**
		 * 改变颜色(通过ColorMatrixFilter)
		 * @param obj	改变颜色的对象
		 * @param color	颜色
		 */		
		public static function changeColor(obj:DisplayObject, color:String):void
		{
			var selectedColor:ColorMatrixFilter;
			switch(color)
			{
				case GRAY:
					selectedColor = gray();
					break;
				case WHITE:
					selectedColor = white();
					break;
				case BLACK:
					selectedColor = black();
					break;
				case RED:
					selectedColor = red();
					break;
				case RED_DARK:
					selectedColor = redDark();
					break;
				case BLUE:
					selectedColor = blue();
					break;
				case GREEN:
					selectedColor = green();
					break;
				case YELLOW:
					selectedColor = yellow();
					break;
				case ORANGE:
					selectedColor = orange();
					break;
				case PURPLE:
					selectedColor = purple();
					break;
				case DARK:
					selectedColor = dark();
					break;
				case LIGHT:
					selectedColor = light();
					break;
			}
			
			obj.filters = [];
			if(selectedColor)
				obj.filters = [selectedColor];
		}
		
		/**
		 * 获取改变颜色后的bitmapdata
		 * @param obj	要改变颜色的对象（BitmapData）
		 * @param color	颜色
		 * @return 		BitmapData
		 */		
		public static function changeColorAndGetBitmapData(obj:BitmapData, color:String):BitmapData
		{
			if(!obj)
				return null;
			
			var bm:Bitmap = new Bitmap(obj);
			changeColor(bm, color);
			var bmd:BitmapData = new BitmapData(bm.width, bm.height, true, 0);
			bmd.draw(bm);
			return bmd;
		}
		
		/**
		 * 变为灰色
		 * @return ColorMatrixFilter
		 */		
		public static function gray():ColorMatrixFilter
		{
			var matrix:Array = [	0.4, 0.4, 0.4, 0, 0, 
				0.4, 0.4, 0.4, 0, 0, 
				0.4, 0.4, 0.4, 0, 0,
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为白色
		 * @return ColorMatrixFilter
		 */		
		public static function white():ColorMatrixFilter
		{
			var matrix:Array = [	1, 1, 1, 0, 200, 
				1, 1, 1, 0, 200, 
				1, 1, 1, 0, 200, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为黑色
		 * @return ColorMatrixFilter
		 */		
		public static function black():ColorMatrixFilter
		{
			var matrix:Array = [	0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 
				0, 0, 0, 0, 0, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为红色
		 * @return ColorMatrixFilter
		 */		
		public static function red():ColorMatrixFilter
		{
			var matrix:Array = [	1, 1, 1, 0, 20, 
				0, 0, 0, 0, 20, 
				0, 0, 0, 0, 20, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为深红色(以大红色为基础)
		 * @return ColorMatrixFilter
		 */	
		public static function redDark():ColorMatrixFilter
		{
			var matrix:Array = [	0.5, 0.5, 0.5, 0, 0, 
				0.2, 0.2, 0.2, 0, 0, 
				0.1, 0.1, 0.1, 0, 0, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为蓝色(以大红色为基础)
		 * @return ColorMatrixFilter
		 */		
		public static function blue():ColorMatrixFilter
		{
			var matrix:Array = [	0, 0, 0, 0, 20, 
				0.7, 0.7, 0.7, 0, 20, 
				1, 1, 1, 0, 20, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为绿色(以大红色为基础)
		 * @return ColorMatrixFilter
		 */		
		public static function green():ColorMatrixFilter
		{
			var matrix:Array = [	0, 0, 0, 0, 20, 
				0.7, 0.7, 0.7, 0, 20, 
				0.3, 0.3, 0.3, 0, 20, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为橙色(以大红色为基础)
		 * @return ColorMatrixFilter
		 */		
		public static function orange():ColorMatrixFilter
		{
			var matrix:Array = [	1, 1, 1, 0, 0, 
				0.5, 0.5, 0.5, 0, 0, 
				0, 0, 0, 0, 0, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为黄色(以大红色为基础)
		 * @return ColorMatrixFilter
		 */		
		public static function yellow():ColorMatrixFilter
		{
			var matrix:Array = [	0.9, 0.9, 0.9, 0, 20, 
				0.7, 0.7, 0.7, 0, 20, 
				0, 0, 0, 0, 20, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变为紫色(以大红色为基础)
		 * @return ColorMatrixFilter
		 */		
		public static function purple():ColorMatrixFilter
		{
			var matrix:Array = [	1, 1, 1, 0, 20, 
				0, 0, 0, 0, 20, 
				1, 1, 1, 0, 20, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变暗
		 * @return ColorMatrixFilter
		 */		
		public static function dark():ColorMatrixFilter
		{
			var matrix:Array = [	0.5, 0, 0, 0, 0, 
				0, 0.5, 0, 0, 0, 
				0, 0, 0.5, 0, 0, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 变亮
		 * @return ColorMatrixFilter
		 */		
		public static function light():ColorMatrixFilter
		{
			var matrix:Array = [	1, 0, 0, 0, 100, 
				0, 1, 0, 0, 100, 
				0, 0, 1, 0, 100, 
				0, 0, 0, 1, 0];
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		/**
		 * 扣血的颜色
		 * @return 
		 */		
		public static function bloodMask():ColorMatrixFilter
		{
			var matrix:Array = [];
			matrix = matrix.concat([1, 0.1, 0.1, 0, 70]); // red
			matrix = matrix.concat([0.1, 1, 0.1, 0, 70]); // green
			matrix = matrix.concat([0.1, 0.1, 1, 0, 70]); // blue
			matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var color:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			return color;
		}
		
		
	}
}
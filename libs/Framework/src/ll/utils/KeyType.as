package ll.utils
{
	public class KeyType
	{
		public static const VK_A:KeyType = new KeyType(65);
		public static const VK_B:KeyType = new KeyType(66);
		public static const VK_C:KeyType = new KeyType(67);
		public static const VK_D:KeyType = new KeyType(68);
		public static const VK_E:KeyType = new KeyType(69);
		public static const VK_F:KeyType = new KeyType(70);
		public static const VK_G:KeyType = new KeyType(71);
		public static const VK_H:KeyType = new KeyType(72);
		public static const VK_I:KeyType = new KeyType(73);
		public static const VK_J:KeyType = new KeyType(74);
		public static const VK_K:KeyType = new KeyType(75);
		public static const VK_L:KeyType = new KeyType(76);
		public static const VK_M:KeyType = new KeyType(77);
		public static const VK_N:KeyType = new KeyType(78);
		public static const VK_O:KeyType = new KeyType(79);
		public static const VK_P:KeyType = new KeyType(80);
		public static const VK_Q:KeyType = new KeyType(81);
		public static const VK_R:KeyType = new KeyType(82);
		public static const VK_S:KeyType = new KeyType(83);
		public static const VK_T:KeyType = new KeyType(84);
		public static const VK_U:KeyType = new KeyType(85);
		public static const VK_V:KeyType = new KeyType(86);
		public static const VK_W:KeyType = new KeyType(87);
		public static const VK_X:KeyType = new KeyType(88);
		public static const VK_Y:KeyType = new KeyType(89);
		public static const VK_Z:KeyType = new KeyType(90);
		
		public static const VK_0:KeyType = new KeyType(48);
		public static const VK_6:KeyType = new KeyType(54);
		public static const VK_8:KeyType = new KeyType(56);
		public static const VK_9:KeyType = new KeyType(57);
		
		public static const VK_BACKSPACE:KeyType = new KeyType(8);
		public static const VK_TAB:KeyType = new KeyType(9);
		public static const VK_ENTER:KeyType = new KeyType(13);
		public static const VK_SHIFT:KeyType = new KeyType(16);
		public static const VK_CONTROL:KeyType = new KeyType(17);
		public static const VK_ESCAPE:KeyType = new KeyType(27);
		public static const VK_SPACE:KeyType = new KeyType(32);
		
		public static const VK_LEFT:KeyType = new KeyType(37);
		public static const VK_UP:KeyType = new KeyType(38);
		public static const VK_RIGHT:KeyType = new KeyType(39);
		public static const VK_DOWN:KeyType = new KeyType(40);
		
		private var code:uint;
		public function KeyType(code:uint)
		{
			this.code = code;
		}
		public function getCode():uint{
			return code;
		}
	}
}
package cx.net.utils
{
	public class KernelCmd
	{
		public static const CONNECT_CHECK		: uint = 1;							//链接校验
		public static const HEAD_SIZE 			: uint = 8;
		public static const SIZE_POS 			: uint = 2;
		
		//内核命令码
		public static const MDM_KN_COMMAND:int=0;			//内核命令
		public static const SUB_KN_DETECT_SOCKET:int=1;		//检测命令
	}
}
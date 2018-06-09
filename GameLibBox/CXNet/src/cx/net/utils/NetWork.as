package cx.net.utils
{
	public class NetWork
	{
		public function NetWork()
		{
		}
		public static function _inetNtoa(dwServerAddr:uint):String
		{
			var b0:uint = dwServerAddr & 0x000000ff;
			var b1:uint = (dwServerAddr >> 8) & 0x000000ff;
			var b2:uint = (dwServerAddr >> 16)& 0x000000ff;
			var b3:uint = (dwServerAddr >> 24)& 0x000000ff;
			var result:String = b0 + "." + b1 + "." + b2 + "." + b3;
			return result;
		}
		public static function _ipToInt( ip : String ) : int
		{
			if (ip.split('.').length == 3)
			{
				ip = ip + ".0";
			}
			var strs : Array = ip.split('.');
			var num2 : int = ( ( parseInt(strs[0]) * 0x100 ) * 0x100) * 0x100;
			var num3 : int = (parseInt(strs[1]) * 0x100) * 0x100;
			var num4 : int = parseInt(strs[2]) * 0x100;
			var num5 : int =parseInt(strs[3]);
			return (((num2 + num3) + num4) + num5);
		}
		public static function _inetPort(dwPort : uint) : int
		{
			var b0:uint = dwPort & 0x000000ff; 
			var b1:uint = (dwPort >> 8) & 0x000000ff;
			var b2:uint = (dwPort >> 16)& 0x000000ff;
			var b3:uint = (dwPort >> 24)& 0x000000ff;
			return b0 * 1000 + b1 * 100 + b2 * 10 + b3;
		}
	}
}
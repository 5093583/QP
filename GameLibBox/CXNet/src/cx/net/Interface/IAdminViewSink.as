package cx.net.Interface
{
	import flash.utils.ByteArray;

	public interface IAdminViewSink
	{
		function ReadAdminSocket(wSubCmd : uint, pBuffer : ByteArray, wDataSize : uint) : Boolean;
	}
}
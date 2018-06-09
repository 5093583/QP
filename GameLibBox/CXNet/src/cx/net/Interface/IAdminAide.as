package cx.net.Interface
{
	import flash.utils.ByteArray;

	public interface IAdminAide
	{
		function SetClientSocket(pIClientSocket : IClientSocket) : void;
		function SetViewSink(pIViewSink : IAdminViewSink) : void;
		
		function SendCmd(wSubCmd : uint) : Boolean;
		function SendData(wSubCmd : uint,pBuffer : ByteArray,wDataSize : uint) : Boolean;
		
		function GetInterface() : IAdminAide;
		function Destroy() : void;
	}
}
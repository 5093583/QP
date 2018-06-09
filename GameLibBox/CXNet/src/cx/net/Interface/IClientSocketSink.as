package cx.net.Interface
{
	import flash.utils.ByteArray;

	public interface IClientSocketSink
	{
		function SocketConnect(iErrorCode : int,szErrorDesc : String,pIClientSocket : IClientSocket) : Boolean;
		
		function SocketRead(wMainCmdID : uint,wSubCmdID : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket : IClientSocket) : Boolean;
		
		function SocketClose(pIClientSocket : IClientSocket,bCloseByServer : Boolean) : Boolean;
	}
}
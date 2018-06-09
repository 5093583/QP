package cx.net.Interface
{
	import flash.utils.ByteArray;

	public interface IClientSocketRecvSink
	{
		function SocketRead(wMainCmdID:uint,wSubCmdID:uint,pBuffer:ByteArray,wDataSize:int,pIClientSocket:IClientSocket):Boolean;
	}
}
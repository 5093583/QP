package cx.gamebase.Interface
{
	import cx.net.Interface.IClientSocket;
	
	import flash.utils.ByteArray;

	public interface ITCPSocketSink
	{
		/**
		 * 消息接收
		 * */
		function SocketRecv(wMainCmd : uint,wSubCmd : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket:IClientSocket) : Boolean;
		/**
		 * 关闭
		 * */
		function SocketClose(bNotifyGame : Boolean) : Boolean;
		
	}
}
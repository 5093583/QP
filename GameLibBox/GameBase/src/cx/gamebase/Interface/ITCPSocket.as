package cx.gamebase.Interface
{
	
	import cx.gamebase.Interface.ITCPSocketSink;
	import cx.net.Interface.IClientSocketRecvSink;
	
	import flash.utils.ByteArray;

	public interface ITCPSocket extends IClientSocketRecvSink
	{
		/**
		 * socket回调钩子
		 * */
		function AddSocketSink(pSocketSink : ITCPSocketSink) : Boolean;
		function RemoveSocketSink(pSocketSink : ITCPSocketSink) : Boolean;
		function RemoveAllSocketSink() : Boolean;
		
		/**
		 * 发送数据
		 * */
		function SendData(wMainCmd : uint,wSubCmd : uint,pBuffer : ByteArray,wDataSize : int) : Boolean;
		function SendCmd(wMainCmd : uint,wSubCmd : uint) : Boolean;
	}
}
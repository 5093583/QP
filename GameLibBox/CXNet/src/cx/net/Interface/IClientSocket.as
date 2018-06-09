package cx.net.Interface
{
	import flash.utils.ByteArray;
	
	public interface IClientSocket
	{
		function SetSocketSink(pSocketSink : IClientSocketSink) : Boolean;
		function GetSocketSink() : IClientSocketSink;
		
		function AddSocketRecvSink(pSocketRecvSink : IClientSocketRecvSink) : Boolean;
		function RemoveSocketRecvSink(pSocketRecvSink : IClientSocketRecvSink) : Boolean;
		
		function GetLastSendTick() : uint;
		function GetLastRecvTick() : uint;
		
		function GetConnectState():int;
		
		function Connect(szServerIP:String,wPort:int):Boolean;
		
		function SendCmd(wMainCmdID:int,wSubCmdID:int):Boolean;
		function SendData(wMainCmdID:int,wSubCmdID:int,pData:ByteArray,wDataSize:int):Boolean;
		
		function CloseSocket(bNotify:Boolean):Boolean;
	}
}
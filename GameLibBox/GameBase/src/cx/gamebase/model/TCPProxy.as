package cx.gamebase.model
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.Interface.ITCPSocket;
	import cx.gamebase.Interface.ITCPSocketSink;
	import cx.gamebase.events.TCPEvent;
	import cx.gamebase.sturuct.CMD_GF_Info;
	import cx.gamebase.sturuct.GameCmd;
	import cx.net.Interface.IClientSocket;
	import cx.net.Interface.IClientSocketRecvSink;
	import cx.net.enum.enSocketState;
	
	import flash.utils.ByteArray;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	
	public class TCPProxy implements ITCPSocket,IDestroy
	{
		private static var _instance : TCPProxy;
		public static function GetInstance() : TCPProxy
		{
			return _instance == null ? ( _instance = new TCPProxy() ) : _instance;
		}
		
		/**
		 * socket接口
		 * */
		private var _socket : IClientSocket;
		public function get gameSocket() : IClientSocket
		{
			return _socket;
		}
		/**
		 * 回调钩子数组
		 * */
		private var _sinks : Array;
		public function TCPProxy()
		{
			OnInit();
		}
		protected function OnInit() : void
		{
			_sinks = new Array();
			Controller.addEventListener(TCPEvent.SOCKET_SINK,OnTCPSocketEvent);
		}
		protected function OnTCPSocketEvent(tc : TEvent) : void
		{
			switch(tc.m_nMsg)
			{
				case TCPEvent.SOCKET_INIT:
				{
					_socket = tc.nWParam as IClientSocket;
					if(_socket.GetConnectState() == enSocketState.en_Connected)
					{
						_socket.AddSocketRecvSink(this as IClientSocketRecvSink);
						//向服务器发送获取游戏信息消息
						var info : CMD_GF_Info = new CMD_GF_Info();
						info.bAllowLookon = 0;
						_socket.SendData(GameCmd.MDM_GF_FRAME,GameCmd.SUB_GF_INFO,info.toByteArray(),info.size);
					}else
					{
						Controller.dispatchEvent(TCPEvent.MESSAGE_EVENT,2,"游戏链接服务错误,请关闭游戏尝试重新链接.");
					}
					break;
				}
				case TCPEvent.SOCKET_CLOSE:
				{
					for(var i : uint = 0;i<_sinks.length;i++)
					{
						var sink : ITCPSocketSink = _sinks[i];
						sink.SocketClose(tc.nWParam as Boolean);
					}
					break;
				}
			}
		}
		/**
		 * 删除
		 * */
		public function Destroy() : Boolean
		{
			if(_socket) { _socket.RemoveSocketRecvSink(this); }
			RemoveAllSocketSink();
			_sinks = null;
			_instance = null;
			Controller.removeEventListener(TCPEvent.SOCKET_SINK,OnTCPSocketEvent);
			return true;
		}
		/**--------------------------------------------------------------------
		 * 接口
		 * --------------------------------------------------------------------*/
		/**
		 * socket回调钩子
		 * */
		public function AddSocketSink(pSocketSink : ITCPSocketSink) : Boolean
		{
			if(_sinks.indexOf(pSocketSink) != -1) return false;
			
			return _sinks.push(pSocketSink) > 0;
		}
		public function RemoveSocketSink(pSocketSink : ITCPSocketSink) : Boolean
		{
			var index : int = _sinks.indexOf(pSocketSink);
			if(index == -1) return false;
			return _sinks.splice(index,1) != null;
		}
		public function RemoveAllSocketSink() : Boolean
		{
			_sinks.splice(0);
			return _sinks.length == 0;
		}
		/**
		 * 发送数据
		 * */
		public function SendData(wMainCmd : uint,wSubCmd : uint,pBuffer : ByteArray,wDataSize : int) : Boolean
		{
			return _socket.SendData(wMainCmd,wSubCmd,pBuffer,wDataSize);
		}
		public function SendCmd(wMainCmd : uint,wSubCmd : uint) : Boolean
		{
			return _socket.SendCmd(wMainCmd,wSubCmd);
		}
		
		public function SocketRead(wMainCmdID:uint,wSubCmdID:uint,pBuffer:ByteArray,wDataSize:int,pIClientSocket:IClientSocket):Boolean
		{
			var bSuccess : Boolean = false;
			for(var i : uint = 0;i<_sinks.length;i++)
			{
				var sink : ITCPSocketSink = _sinks[i];
				bSuccess = sink.SocketRecv(wMainCmdID,wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				if(bSuccess) break;
			}
			return bSuccess;
		}
	}
}
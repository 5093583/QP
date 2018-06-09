package cx.net
{
	import cx.net.Interface.IClientSocket;
	import cx.net.Interface.IClientSocketRecvSink;
	import cx.net.Interface.IClientSocketSink;
	import cx.net.enum.enSocketState;
	import cx.net.utils.KernelCmd;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.Socket;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import t.cx.air.TConst;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.DateHelper;
	import t.cx.air.utils.Memory;
	
	public class ClientSocket implements IClientSocket
	{
		protected var m_SocketState 			: uint;
		protected var m_pIClientSocketSink		: IClientSocketSink;
		protected var m_arrSocketRecvSink 		: Array;
		
		protected var m_hSocket 				: Socket;
		protected var m_wRecvSize				: int;
		protected var m_cbRecvBuf				: ByteArray;
		
		protected var m_timerDetectSocket		: Timer;
		
		protected var m_dwSendTickCount:uint;
		protected var m_dwRecvTickCount:uint;
		protected var m_wSurvivalTime : int;
		
		private const QUEUE_OFFLINE				: int = 10000; 
		public function ClientSocket()
		{
			InitSocket();
		}
		protected function InitSocket() : void
		{
			m_SocketState = enSocketState.en_NoConnect;
			m_cbRecvBuf = Memory._newLiEndianBytes();
			m_arrSocketRecvSink	= new Array();
			m_wRecvSize = 0;
		}
		protected function onTimerHandle(e : TimerEvent) : void
		{
			switch(m_wSurvivalTime)
			{
				case 0:
				{
					CloseSocket(true);
					break;
				}
				case 1:
				{
					m_wSurvivalTime--;
					SendCmd(KernelCmd.MDM_KN_COMMAND,KernelCmd.SUB_KN_DETECT_SOCKET);
					break;
				}
				case 2:
				{
					m_wSurvivalTime--;
					break;
				}
			}
		}
		//-----------------------------------------------------------------------------------------
		public function SetSocketSink(pSocketSink:IClientSocketSink):Boolean
		{
			m_pIClientSocketSink = pSocketSink;
			return m_pIClientSocketSink != null;
		}
		public function GetSocketSink():IClientSocketSink
		{
			return m_pIClientSocketSink;
		}
		public function AddSocketRecvSink(pSocketRecvSink:IClientSocketRecvSink):Boolean
		{
			m_arrSocketRecvSink.push(pSocketRecvSink);
			return true;
		}
		public function RemoveSocketRecvSink(pSocketRecvSink:IClientSocketRecvSink):Boolean
		{
			var index : int = m_arrSocketRecvSink.indexOf(pSocketRecvSink);
			if(-1 != index )
			{
				m_arrSocketRecvSink.splice(index,1);
			}
			return true;
		}
		public function GetLastSendTick():uint
		{
			return m_dwSendTickCount;
		}
		public function GetLastRecvTick():uint
		{
			return m_dwRecvTickCount;
		}
		public function GetConnectState():int
		{
			return m_SocketState;
		}
		public function Connect(szServerIP:String, wPort:int):Boolean
		{
			if(m_hSocket != null)
			{
				trace("Socket Connected");
				return false;
			}
			try
			{
				var connetCheck : int= NetConst.pCxSocket.CxTcpConnect(TConst.TC_SOCKET_VER);
				if(connetCheck != KernelCmd.CONNECT_CHECK)
				{
					trace('connect_check error!',TConst.TC_SOCKET_VER);
					return false;
				}
				m_hSocket = new Socket();
				configureListeners();
				if(m_hSocket.connected)
				{
					throw new Error("Socket Connected");
				}
				var myDate:Date=new Date();
				m_dwSendTickCount=myDate.getMilliseconds() / 1000;
				m_dwRecvTickCount=myDate.getMilliseconds() / 1000;
				m_wRecvSize=0;
				m_cbRecvBuf.clear();
				m_hSocket.connect(szServerIP,wPort);
				m_SocketState=enSocketState.en_Connecting;
			} catch(ex : Error) {
				trace("[Socket Connected]"+ex.getStackTrace());
			}
			//if(m_timerDetectSocket) { m_timerDetectSocket.start(); }
			return true;
		}
		
		public function SendCmd(wMainCmdID:int, wSubCmdID:int):Boolean
		{
			if(m_hSocket == null) return false;
			if(m_SocketState != enSocketState.en_Connected) { return false; }
			var cbDataBuffer : ByteArray = Memory._newLiEndianBytes();
			var returnType : int = NetConst.pCxSocket.CxTcpEncrypt(wMainCmdID,wSubCmdID,cbDataBuffer,0);
			
			if(returnType != 0)
			{
				switch(returnType)
				{
					case 1:
					{
						throw(new Error('发送数据包过大'));
						break;
					}
					case 2:
					{
						throw(new Error('发送数据包小于数据包头'));
						break;
					}
				}
				return false;
			}
			var wSendSize : int = cbDataBuffer.bytesAvailable;
			m_wSurvivalTime = 1;
			return SendBuffer(cbDataBuffer,wSendSize);
		}
		public function SendData(wMainCmdID:int, wSubCmdID:int, pData:ByteArray, wDataSize:int):Boolean
		{
			if(m_hSocket == null || m_SocketState != enSocketState.en_Connected) return false;
			
			var returnType : int = NetConst.pCxSocket.CxTcpEncrypt(wMainCmdID,wSubCmdID,pData,wDataSize);
			pData.position = 0;
			if(returnType != 0)
			{
				switch(returnType)
				{
					case 1:
					{
						throw(new Error('发送数据包过大'));
						break;
					}
					case 2:
					{
						throw(new Error('发送数据包小于数据包头'));
						break;
					}
				}
				return false;
			}
			var wSendSize : int = pData.bytesAvailable;
			m_wSurvivalTime = 1;
			return SendBuffer(pData,wSendSize);
		}
		
		public function CloseSocket(bNotify:Boolean):Boolean
		{
			if(m_SocketState != enSocketState.en_NoConnect)
			{
				resetSocket();
				if(m_pIClientSocketSink!=null)
				{
					m_pIClientSocketSink.SocketClose(this,bNotify);
				}
			}
			return true;
		}
		private function resetSocket() : void
		{
			m_SocketState =enSocketState.en_NoConnect;
			if(m_hSocket != null) {
				try {
					m_hSocket.close();
				}
				catch(e : Error) {
					trace(e);
				}
			}
			NetConst.pCxSocket.CxTcpClose();
			m_wRecvSize=0;
			m_cbRecvBuf.clear();
			m_dwSendTickCount=0;
			m_dwRecvTickCount=0;
			deconfigureListeners();
			//if(m_timerDetectSocket != null){ m_timerDetectSocket.stop(); }
			m_hSocket = null;
		}
		//-----------------------------------------------------------------------------------------
		private function SendBuffer(pBuffer:ByteArray,wSendSize:int):Boolean
		{
			if(m_hSocket && m_hSocket.connected)
			{
				m_hSocket.writeBytes(pBuffer);
				m_hSocket.flush();	
			}
			
			return true;
		}
		private function configureListeners():void
		{
			try
			{
				m_hSocket.addEventListener(Event.CLOSE,closeHandler);
				m_hSocket.addEventListener(Event.CONNECT,connectHandler);
				m_hSocket.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
				m_hSocket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
				m_hSocket.addEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
			}
			catch(ex : Error)
			{
				trace("[configureListeners]"+ex.getStackTrace());
			}
		}
		private function deconfigureListeners():void
		{
			if (m_hSocket != null)
			{
				m_hSocket.removeEventListener(Event.CLOSE,closeHandler);
				m_hSocket.removeEventListener(Event.CONNECT,connectHandler);
				m_hSocket.removeEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
				m_hSocket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,securityErrorHandler);
				m_hSocket.removeEventListener(ProgressEvent.SOCKET_DATA,socketDataHandler);
			}
		}
		private function closeHandler(e : Event) : void
		{
			trace('closeHandler: '+e.toString());
			CloseSocket(true);
		}
		
		private function ioErrorHandler(e : IOErrorEvent) : void
		{
			trace('ioErrorHandler: '+e.toString());
			if (m_pIClientSocketSink!=null)
			{
				m_pIClientSocketSink.SocketConnect(1,"您的网络不稳定，请检查网络后重新登录游戏！.",this);
			}
			CloseSocket(false);
		}
		private function securityErrorHandler(e : SecurityErrorEvent) : void
		{
			trace('securityErrorHandler: '+e.toString());
			if (m_pIClientSocketSink!=null)
			{
				m_pIClientSocketSink.SocketConnect(2,"服务器安全设置，您暂时不能访问.",this);
			}
			CloseSocket(false);
		}
		private function connectHandler(e : Event) : void
		{
			if (m_hSocket.connected)
			{
				m_SocketState=enSocketState.en_Connected;
			}
			else
			{
				trace('connectHandler: '+m_hSocket.connected);
				CloseSocket(false);
			}
			var szErrorDesc:String=e.toString();
			if (m_pIClientSocketSink!=null)
			{
				m_pIClientSocketSink.SocketConnect(0,szErrorDesc,this);
			}
		}
		private function socketDataHandler(e : ProgressEvent) : void
		{
			try
			{
				var iRetCode : int = m_hSocket.bytesAvailable;
				m_hSocket.readBytes(m_cbRecvBuf,m_wRecvSize,iRetCode);
				m_wRecvSize += iRetCode;
				m_dwRecvTickCount = DateHelper.now.getMilliseconds()/1000;
				while(m_wRecvSize>=KernelCmd.HEAD_SIZE)
				{
					m_cbRecvBuf.position = KernelCmd.SIZE_POS;
					var wPackageSize : int = WORD.read(m_cbRecvBuf);
					
					m_cbRecvBuf.position = 0;
					if(wPackageSize > m_cbRecvBuf.bytesAvailable) break;
					var cbDataBuffer : ByteArray = Memory._newLiEndianBytes();
					Memory._copyMemory(cbDataBuffer,m_cbRecvBuf,wPackageSize);
					m_wRecvSize -= wPackageSize;
					var cbNewDataBuffer : ByteArray = Memory._newLiEndianBytes();
					//trace(m_cbRecvBuf.position + "****" + m_cbRecvBuf.bytesAvailable + "  *****  " + m_wRecvSize + "  *******  " + wPackageSize)
					if(m_wRecvSize<0)
					{
						trace('----------------------------------------------------------------------------' + m_cbRecvBuf.length)
						m_wRecvSize = 0;
					}else{
						Memory._copyMemory(cbNewDataBuffer,m_cbRecvBuf,m_wRecvSize,0,wPackageSize);
					}
					m_cbRecvBuf = cbNewDataBuffer;
					var returnType : int = NetConst.pCxSocket.CxTcpCrevasse(cbDataBuffer,wPackageSize);
					switch(returnType)
					{
						case 1:
						{
							CloseSocket(true);
							throw Error('数据包版本错误');
							return;
						}
						case 2:
						{
							CloseSocket(true);
							throw Error('数据包大小错误');
							return;
						}
						case 3:
						{
							CloseSocket(true);
							throw Error('数据包效验码错误');
							return;
						}
					}
					
					m_wSurvivalTime = 2;
					cbDataBuffer.position = KernelCmd.SIZE_POS;
					var wDataSize  : int = WORD.read(cbDataBuffer) - KernelCmd.HEAD_SIZE;
					var wMainCmdID : int = WORD.read(cbDataBuffer);
					var wSubCmdID  : int = WORD.read(cbDataBuffer);
					var pDataBuffer : ByteArray = Memory._newLiEndianBytes();
					Memory._copyMemory(pDataBuffer,cbDataBuffer,wDataSize,0,KernelCmd.HEAD_SIZE);
					
					if(wMainCmdID == KernelCmd.MDM_KN_COMMAND)
					{
						switch (wSubCmdID)
						{
							case KernelCmd.SUB_KN_DETECT_SOCKET:					//网络检测
							{
								SendData(KernelCmd.MDM_KN_COMMAND,KernelCmd.SUB_KN_DETECT_SOCKET,pDataBuffer,wDataSize);
								break;
							}
						};
						continue;
					}
					
					var bSuccess : Boolean = false;
					if(m_pIClientSocketSink)
					{
						bSuccess = m_pIClientSocketSink.SocketRead(wMainCmdID,wSubCmdID,pDataBuffer,wDataSize,this as IClientSocket);
					}
					if(!bSuccess)
					{
						var pRecvSink : IClientSocketRecvSink;
						for(var i : uint = 0;i<m_arrSocketRecvSink.length;i++)
						{
							pRecvSink = m_arrSocketRecvSink[i] as IClientSocketRecvSink;
							if(pRecvSink)
							{
								bSuccess = pRecvSink.SocketRead(wMainCmdID,wSubCmdID,pDataBuffer,wDataSize,this as IClientSocket);
							}
						}
					}
					if(!bSuccess)
					{
						throw Error("网络数据包处理失败:" +wMainCmdID + " " +wSubCmdID);
					}
				}
			}
			catch(e : Error)
			{
				trace('socketDataHandler: ['+wMainCmdID + ','+ wSubCmdID +']'+e.toString());
				CloseSocket(true);
				Controller.dispatchEvent(TConst.TEST_CONST,0,('socketDataHandler: ['+wMainCmdID + ','+ wSubCmdID +']'+e));
			}
		}
		
	}
}
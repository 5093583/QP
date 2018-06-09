package cx.client.logon.model
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.enum.enChatKind;
	import cx.client.logon.model.events.MsgEvent;
	import cx.client.logon.model.struct.CMD_GP_CheckResult;
	import cx.client.logon.model.struct.CMD_GP_DeleteFriend_result;
	import cx.client.logon.model.struct.CMD_GP_FriendInfo;
	import cx.client.logon.model.struct.CMD_GP_InputFriend_Sine;
	import cx.client.logon.model.struct.CMD_GP_InputFriend_Sine_Result;
	import cx.client.logon.model.struct.CMD_GP_PlayWithFriend;
	import cx.client.logon.model.struct.CMD_GP_PlayerOffline;
	import cx.client.logon.model.struct.CMD_GP_PlayerOnline;
	import cx.client.logon.model.struct.CMD_GP_WaitInputFriend;
	import cx.client.logon.model.struct.CMD_MSG_ChatRecv;
	import cx.client.logon.model.struct.CMD_MSG_ChatSend;
	import cx.client.logon.model.struct.CMD_MSG_GongGao;
	import cx.client.logon.model.struct.CMD_MSG_OUTUSER;
	import cx.client.logon.model.struct.CMD_MSG_RoomlistUpdate;
	import cx.client.logon.model.struct.CMD_MSG_SendUserList;
	import cx.client.logon.model.struct.CMD_MSG_VerifyConnect;
	import cx.client.logon.model.struct.CMD_MSG_VerifyField;
	import cx.client.logon.model.struct.CMD_MSG_VerifySuccess;
	import cx.client.logon.model.struct.MsgCmd;
	import cx.client.logon.view.message.Message;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.sturuct.tagMatch;
	import cx.net.ClientSocket;
	import cx.net.Interface.IClientSocket;
	import cx.net.Interface.IClientSocketSink;
	import cx.net.enum.enSocketState;
	
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.utils.MD5;
	import t.cx.air.utils.SystemEx;
	import t.cx.cmd.struct.tagGameServer;
	
	public class MessageNet implements IClientSocketSink
	{
		
		private var _callBackVecs	: Vector.<Object>;
		
		
		private var 	_checkMatchTimer	:Timer;
		private const 	CHECK_MATCH_DELAY	:int = 8000;
		
		
		
		
		private static var instance : MessageNet;
		public static function _getInstance() : MessageNet
		{
			return instance == null ? (instance = new MessageNet) : instance;
		}
		private var _gongGao 			: CMD_MSG_GongGao;
		public function get gongGao()	: CMD_MSG_GongGao
		{
			return _gongGao;
		}
		private var socket 				: ClientSocket;
		public function get ISocket() 	: IClientSocket
		{
			return socket as IClientSocket;
		}
		private var _chatCallBack 		: Function;
		private var _chatMaxLen 		: uint;
		private var _chatTimer 			: Number;
		public function get chatMaxLen()  : uint
		{
			return _chatMaxLen;
		}
		public function get chatTimer() : Number
		{
			return _chatTimer;
		}
		
		
		
		private var _verifyTimer:Timer;
		
		public function MessageNet()
		{
			socket = new ClientSocket();
			socket.SetSocketSink(this);
			_chatTimer = 0;
			
			
			_callBackVecs = new Vector.<Object>();
		}
		
		public function SocketConnect(iErrorCode:int, szErrorDesc:String, pIClientSocket:IClientSocket):Boolean
		{
//			if(iErrorCode != 0) return false;
			if(iErrorCode != 0) {
				runCallBack(false,szErrorDesc);	
				return false;
			}
			//链接服务，发送验证消息
			var user : UserModel = LogonModel._GetInstance().user;
			var msgVerify : CMD_MSG_VerifyConnect = new CMD_MSG_VerifyConnect();
			msgVerify.dwUserID = user.selfID;
			msgVerify.szUserPassword = MD5.hash(user.selfInfo.szPassword);
			msgVerify.dwMessageVer = TConst.VER_MESSAGE_FRAME;
			msgVerify.szComputerID = SystemEx._clientSequence();
			pIClientSocket.SendData(MsgCmd.MDM_MSG_VERIFY,MsgCmd.SUB_MSG_CONNECT,msgVerify.ToByteArray(),msgVerify.size);
			return false;
		}
		
		public function SocketRead(wMainCmdID:uint, wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wMainCmdID)
			{
				case MsgCmd.MDM_MSG_VERIFY:
				{
					return OnReadVerifyEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case MsgCmd.MDM_MSG_CAHT:
				{
					return OnReadChatEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case MsgCmd.MDM_MSG_NET:
				{
					return OnReadNetEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case MsgCmd.MDM_MSG_UPDATE:
				{
					return OnReadUpdateEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case MsgCmd.MDM_MSG_FRIENDMES:
				{
					return OnReadFriendEvent(wSubCmdID, pBuffer, wDataSize, pIClientSocket);
				}
				case MsgCmd.MDM_MSG_USERLIST:
				{
					return onReadUserListEvent(wSubCmdID, pBuffer, wDataSize, pIClientSocket);
				}
			}
			return false;
		}
		
		public function SocketClose(pIClientSocket:IClientSocket, bCloseByServer:Boolean):Boolean
		{
			return false;
		}
		/** ------------------------------------------------------------------- 
		 * 公共函数
		 * ------------------------------------------------------------------- */
//		public function Connect(addChatCallBack : Function = null) : Boolean
//		{
//			var addr : String = TDas._getStringItem(TConst.MESSAGE,256);
//			
//			if(addr != null)
//			{
//				var arr : Array = addr.split('-');
//				socket.Connect(arr[0],arr[1]);
//			}
//			_chatCallBack = addChatCallBack;
//			return true;
//		}
		
		public function SendCallbackMessage(describe:String, callBack : Function) : Boolean
		{
			return Connect(callBack, describe);
		}
		
		public function Connect(callBack : Function=null, key : String='') : Boolean
		{
			if(socket.GetConnectState() == enSocketState.en_Connected) {
				if(callBack != null)
					callBack(socket as IClientSocket);
				return true;
			}
			_callBackVecs.push({'key':key,'callBack':callBack});
			
			var addr : String = TDas._getStringItem(TConst.MESSAGE,256);
			
			if(addr != null)
			{
				var arr : Array = addr.split('-');
				socket.Connect(arr[0],arr[1]);
			}
//			_chatCallBack = addChatCallBack;
			return true;
		}
		
		
		
		private function runCallBack(bResult : Boolean,szErr : String ='') : Boolean
		{
			if(!bResult)
				Controller.dispatchEvent('msgConnectError', 0, szErr);
				
			for each(var obj : Object in _callBackVecs) { 
				notifySocketConnect(obj,szErr); 
			}
			_callBackVecs = new Vector.<Object>();
			return bResult;
		}
		private function notifySocketConnect(obj : Object,szErr : String ='') : void
		{
			if(obj != null && obj.callBack != null) {
				obj.callBack(socket as IClientSocket,szErr);
			}
		}
		
		
		public function Close() : void
		{
			socket.CloseSocket(false);
		}
		public function IsConnected() : Boolean
		{
			return socket.GetConnectState() == enSocketState.en_Connected;
		}
		
		
		
		private function startMsgVerify():void
		{
			if(_verifyTimer && _verifyTimer.running )	return;	
			_verifyTimer = new Timer(30000);
			_verifyTimer.addEventListener(TimerEvent.TIMER, msgVerify_timerHandler);
			_verifyTimer.start();
		}
		
		private function msgVerify_timerHandler(e:TimerEvent):void
		{
			if( IsConnected() )
			{
				//链接服务，发送验证消息
				var user : UserModel = LogonModel._GetInstance().user;
				var msgVerify : CMD_MSG_VerifyConnect = new CMD_MSG_VerifyConnect();
				msgVerify.dwUserID = user.selfID;
				msgVerify.szUserPassword = MD5.hash(user.selfInfo.szPassword);
				msgVerify.dwMessageVer = TConst.VER_MESSAGE_FRAME;
				msgVerify.szComputerID = SystemEx._clientSequence();
				socket.SendData(MsgCmd.MDM_MSG_VERIFY,MsgCmd.SUB_MSG_CONNECT,msgVerify.ToByteArray(),msgVerify.size);
			}
			else
			{
				_verifyTimer.stop();
				_verifyTimer.removeEventListener(TimerEvent.TIMER, msgVerify_timerHandler);
				Connect();
			}
		}
		
		
		
		
		//发送聊天消息
		public function SendChatMessage(szChat : String,dwTargetID : int = 0) : void
		{
			if(!IsConnected()) return;
			var time : Number = new Date().time;
			if((time - _chatTimer) > 100) {
				var user : UserModel = LogonModel._GetInstance().user;
				var chat : CMD_MSG_ChatSend = new CMD_MSG_ChatSend();
				chat.bChatKind = enChatKind.enChat_Shout;
				chat.dwUserID = user.selfID;
				chat.dwTargetID = dwTargetID;
				chat.szUserName = user.selfID.toString();
				chat.szChat = szChat;
				socket.SendData(MsgCmd.MDM_MSG_CAHT,MsgCmd.SUB_MSG_CHAT_SEND,chat.ToByteArray(),chat.size);
			}
			_chatTimer = time;
		}
		/**-----------------------------------------------------------------------------
		 * 消息读取
		 * ------------------------------------------------------------------------------*/
		//好友
		protected function onReadUserListEvent(wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wSubCmdID)
			{
				case MsgCmd.SUB_MSG_SENDUSERLIST:
				{
					var userListResult:CMD_MSG_SendUserList = CMD_MSG_SendUserList._readBuffer(pBuffer);
					Controller.dispatchEvent('getUserListResult', 0, userListResult);
					return true;
				}
				case MsgCmd.SUB_MSG_SENDUSERLIST_FINISH:
				{
					Controller.dispatchEvent('getUserListResultFinish');
					return true;
				}
			}
			return false;
		}

		
		//好友
		protected function OnReadFriendEvent(wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wSubCmdID)
			{
				case MsgCmd.SUB_GP_DELETEFRIEND:
				{
					var deleteFriendResult:CMD_GP_DeleteFriend_result = CMD_GP_DeleteFriend_result._readBuffer(pBuffer);
					Controller.dispatchEvent('deleteFriendResult', 0, deleteFriendResult);
					return true;
				}
				case MsgCmd.SUB_GP_WAITINPUTFRIEND:
				{
					var inputFriendStaus:CMD_GP_WaitInputFriend = CMD_GP_WaitInputFriend._readBuffer(pBuffer);
					Controller.dispatchEvent('updateInputFriendStatus', 0, inputFriendStaus);
					return true;
				}
				case MsgCmd.SUB_GP_INPUTFRIEND_NO_YES_RESULT:
				{
					var inputFriend:CMD_GP_InputFriend_Sine_Result = CMD_GP_InputFriend_Sine_Result._readBuffer(pBuffer);
					Controller.dispatchEvent("inputFriendResult", 0, inputFriend);
					return true;	
				}
				case MsgCmd.SUB_GP_FRIENDINFO:
				{
					var friendInfo:CMD_GP_FriendInfo = CMD_GP_FriendInfo._readBuffer(pBuffer);
					Controller.dispatchEvent('receiveFriendInfo', 0, friendInfo);
					return true;
				}
				case MsgCmd.SUB_GP_PLAYERONLINE:
				{
					var playerOnline:CMD_GP_PlayerOnline = CMD_GP_PlayerOnline._readBuffer(pBuffer);
					Controller.dispatchEvent('updateFriendOnline', 0, playerOnline.dwUserID);
					return true;
				}
				case MsgCmd.SUB_GP_PLAYOFFLINE:
				{
					var playerOffline:CMD_GP_PlayerOffline = CMD_GP_PlayerOffline._readBuffer(pBuffer);
					Controller.dispatchEvent('updateFriendOffline', 0, playerOffline.dwUserID);
					return true;
				}
				case MsgCmd.SUB_GP_CHECKRESULT:
				{
					var checkFriend:CMD_GP_CheckResult = CMD_GP_CheckResult._readBuffer(pBuffer);
					Controller.dispatchEvent('checkFriendResult', 0, checkFriend);
					return true;
				}
				case MsgCmd.SUB_GP_PLAYWITHFRIEND:
				{
					var playWithFriendResult:CMD_GP_PlayWithFriend = CMD_GP_PlayWithFriend._readBuffer(pBuffer);
					Controller.dispatchEvent('playWithFriendResult', 0, playWithFriendResult);
					return true;
				}
			}
			return false;
		}
		
		protected function OnReadVerifyEvent(wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wSubCmdID)
			{
				case MsgCmd.SUB_MSG_VERIFY_SUCCESS:
				{
					var suc : CMD_MSG_VerifySuccess = CMD_MSG_VerifySuccess._readBuffer(pBuffer);
					_chatMaxLen = suc.wChatLength;
					_chatTimer = suc.wLimitChatTimes;
					
					
					runCallBack(true);
					
//					startMsgVerify();
					
					return true;
				}
				case MsgCmd.SUB_MSG_VERIFY_FIELD:
				{
					var err : CMD_MSG_VerifyField = CMD_MSG_VerifyField._readBuffer(pBuffer);
//					Message.show(err.szErrorDescribe);
					
					runCallBack(false, err.szErrorDescribe);
					
					pIClientSocket.CloseSocket(false);
					return true;
				}
			}
			return false;
		}
		//接收聊天消息
		protected function OnReadChatEvent(wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wSubCmdID)
			{
				case MsgCmd.SUB_MSG_CHAT_RECV:
				{
					var recv : CMD_MSG_ChatRecv = CMD_MSG_ChatRecv._readBuffer(pBuffer);
					if(_chatCallBack != null && recv.dwUserID != UserModel._getInstance().selfID)
					{
						_chatCallBack(recv.szUserName,recv.szChat);
					}
					return true;
				}
			}
			return false;
		}
		protected function OnReadUpdateEvent(wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			var serverList : ServerList = ServerList._getInstance();
			var i : int = 0;
			switch(wSubCmdID)
			{
				case MsgCmd.SUB_MSG_SERVER_LIST:
				{
					var ServerCount : uint = wDataSize / CMD_MSG_RoomlistUpdate.SIZE;
					for( i = 0;i<ServerCount;i++)
					{
						var ServerUpdate : CMD_MSG_RoomlistUpdate = CMD_MSG_RoomlistUpdate._readBytes(pBuffer);
						if(ServerUpdate != null) { serverList.UpdateServer(ServerUpdate); }
					}
					return true;
				}
				case MsgCmd.SUB_MSG_SERVER_MATCH:
				{
					var MatchCount : int = wDataSize/tagMatch.SIZE;
					if(MatchCount < 1) 
					{
						serverList.CheckTaskID([]);
						return true;
					}
					var tasks : Array = new Array();
					for( i = 0;i<MatchCount;i++)
					{
						var match : tagMatch = tagMatch._readBuffer(pBuffer);
						serverList.InsertMatch(match);
						tasks.push(match.dwTaskID);
						Controller.dispatchEvent(GameEvent.GAME_MATCH_EVENT,1,match,pIClientSocket);
					}
					serverList.CheckTaskID(tasks);
					
					if(_checkMatchTimer && _checkMatchTimer.running)
						resetTimer();
					else
						startTimer();
					
					return true;
				}
			}
			return false;
		}
		
		
		private function startTimer():void
		{
			if(_checkMatchTimer == null)
				_checkMatchTimer = new Timer(CHECK_MATCH_DELAY);
			_checkMatchTimer.repeatCount = 1;
			_checkMatchTimer.addEventListener(TimerEvent.TIMER_COMPLETE, checkMatchTimerHandler);
			_checkMatchTimer.start();
		}
		
		private function resetTimer():void
		{
			if(_checkMatchTimer != null)
				_checkMatchTimer.reset();
			
			startTimer();
		}
		
		private function checkMatchTimerHandler(e:TimerEvent):void
		{
			ServerList._getInstance().CheckTaskID([]);
			_checkMatchTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, checkMatchTimerHandler);
			_checkMatchTimer.stop();
		}
		
		
		
		protected function OnReadNetEvent(wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wSubCmdID)
			{
				case MsgCmd.SUB_MSG_NET_MESSAGE:
				{
					_gongGao = CMD_MSG_GongGao._readBuffer(pBuffer);
					Controller.dispatchEvent(MsgEvent.MSG_MESSAGE,_gongGao.MessageByte,_gongGao.MessageTxt);				
					return true;
				}
				case MsgCmd.SUB_MSG_NET_OUTUSER:
				{
					var RecvOutUser : CMD_MSG_OUTUSER = CMD_MSG_OUTUSER._readBuffer(pBuffer);
					Controller.dispatchEvent(MsgEvent.MSG_OUTUSER,1,RecvOutUser.OutUser);
					return true;
				}
			}
			return false;
		}
	}
}
package cx.client.logon.model
{
	import cx.client.logon.model.struct.CMD_GP_BankCheck_Result;
	import cx.client.logon.model.struct.CMD_GP_Bank_TransferResult;
	import cx.client.logon.model.struct.CMD_GP_CashMoneyResult;
	import cx.client.logon.model.struct.CMD_GP_ChangePassWordResult;
	import cx.client.logon.model.struct.CMD_GP_ChcekBindEmail_Result;
	import cx.client.logon.model.struct.CMD_GP_CheckBank_Result;
	import cx.client.logon.model.struct.CMD_GP_CheckPhone_Result;
	import cx.client.logon.model.struct.CMD_GP_CreateCustomGameRoom_Result;
	import cx.client.logon.model.struct.CMD_GP_InputFriend_Result;
	import cx.client.logon.model.struct.CMD_GP_InputFriend_Sine_Result;
	import cx.client.logon.model.struct.CMD_GP_ListConfig;
	import cx.client.logon.model.struct.CMD_GP_LockMachineResult;
	import cx.client.logon.model.struct.CMD_GP_LogonError;
	import cx.client.logon.model.struct.CMD_GP_LogonSuccess;
	import cx.client.logon.model.struct.CMD_GP_RecordSignIn_result;
	import cx.client.logon.model.struct.CMD_GP_Refurbish;
	import cx.client.logon.model.struct.CMD_GP_RefurbishSignIn_result;
	import cx.client.logon.model.struct.CMD_GP_Refurbish_result;
	import cx.client.logon.model.struct.CMD_GP_SaveMoneyResult;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.model.vo.UserInfo;
	import cx.client.logon.view.message.Message;
	import cx.net.ClientSocket;
	import cx.net.Interface.IClientSocket;
	import cx.net.Interface.IClientSocketSink;
	import cx.net.enum.enSocketState;
	
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.utils.HashMap;
	import t.cx.cmd.TCmd;
	import t.cx.cmd.events.CxEvent;
	import t.cx.cmd.struct.tagGameKind;
	import t.cx.cmd.struct.tagGameServer;
	import t.cx.cmd.struct.tagGameStation;
	import t.cx.cmd.struct.tagGameType;
	
	public class LogonNet implements IClientSocketSink
	{
		
		private static var _instance : LogonNet;
		public static function _getInstance() : LogonNet
		{
			return _instance == null ? _instance = new LogonNet() : _instance;
		}
		
		private var _netClient 		: ClientSocket;
		private var _callBackVecs	: Vector.<Object>;
		
		private var _NetIndex 		: uint;
		private var _port 			: int;
		private var _ip 			: Array;
		public function LogonNet()
		{
			_netClient = new ClientSocket();
			_netClient.SetSocketSink(this);
			_callBackVecs = new Vector.<Object>();
		}
		public function SocketConnect(iErrorCode:int, szErrorDesc:String, pIClientSocket:IClientSocket):Boolean
		{
			if(iErrorCode != 0) {
				runCallBack(false,szErrorDesc);	
				return false;
			}
			runCallBack(true);
			return true;
		}
		public function SocketRead(wMainCmdID:uint, wSubCmdID:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wMainCmdID)
			{
				case LGCmd.MDM_GP_LOGON:
				{
					return OnReadLogon(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case LGCmd.MDM_GP_SERVER_LIST:		//列表服务
				{
					return OnReadServerList(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case LGCmd.MDM_GP_BANK:
				{
					return OnReadBankEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case LGCmd.MDM_GP_USER:
				{
					return OnReadUserEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
			}
			pIClientSocket.CloseSocket(false);
			return false;
		}
		
		public function SocketClose(pIClientSocket:IClientSocket, bCloseByServer:Boolean):Boolean
		{
			runCallBack( false, "!登录服务链接失败，请重试或联系客服" );
			return true;
		}
		private function runCallBack(bResult : Boolean,szErr : String ='') : Boolean
		{
			for each(var obj : Object in _callBackVecs) { 
				notifySocketConnect(obj,szErr); 
			}
			_callBackVecs = new Vector.<Object>();
			return bResult;
		}
		private function notifySocketConnect(obj : Object,szErr : String ='') : void
		{
			if(obj != null) {
				obj.callBack(_netClient as IClientSocket,szErr);
			}
		}
		public function Register(callback : Function) : Boolean
		{
			return onContent('Register',callback);
		}
		public function Logon(callback : Function) : Boolean
		{
			return onContent('Logon',callback);
		}
		public function Refresh() : Boolean
		{
			return onContent('refresh',refreshCallBack);
		}
		
		private function refreshCallBack(pClientSocket : IClientSocket,szErr : String ='') : void
		{
			var sendRefresh : CMD_GP_Refurbish = new CMD_GP_Refurbish();
			sendRefresh.dwUserID = UserModel._getInstance().selfID;
			pClientSocket.SendData(LGCmd.MDM_GP_USER,LGCmd.SUB_GP_REFURBISH,sendRefresh.toByteArray(),sendRefresh.size);
		}
		//本机绑定
		public function SendBindComputer(callBack : Function) : Boolean
		{
			return onContent('Bind',callBack);
		}
		//银行存钱
		public function SendBankSave(callBack : Function) : Boolean
		{
			return onContent('bankSave',callBack);
		}
		//银行取钱
		public function SendBankCash(callBack : Function) : Boolean
		{
			return onContent('bankCash',callBack);
		}
		//修改银行密码
		public function SendBankPassword(callBack : Function) : Boolean
		{
			return onContent('bankPassword',callBack);
		}
		public function SendBankCheckIsEnble(callBack : Function) : Boolean
		{
			return onContent('bankCheckIsEnble',callBack);
		}
		
		//向服务器发送消息
		public function SendCallbackMessage(describe:String, callBack : Function) : Boolean
		{
			return onContent(describe, callBack);
		}
		
		
		
		//获取房间信息
		public function GetRoomList(wKindID : int,callBack : Function) : void
		{
			onContent('GetRoomList',callBack);
		}
		private function onContent(key : String,callBack : Function) : Boolean
		{
			if(_netClient.GetConnectState() == enSocketState.en_Connected) {
				callBack(_netClient as IClientSocket);
				return true;
			}
			_callBackVecs.push({'key':key,'callBack':callBack});
			if(_ip == null ) {
				var logon : String = TDas._getStringItem(TConst.LOGON,256);
				var _addrs : Array = logon.split('-');
				if(logon != null) {
					_ip 	= _addrs[0].split(',');
					_port = _addrs[1];
				}
			}
			_NetIndex = TDas._getByteItem(TConst.PROXY)-1;
			_NetIndex = _NetIndex%_ip.length;
			return _netClient.Connect(_ip[_NetIndex],_port);
		}
		//-----------------------------------------------------------------------------------------
		//游戏登录
		private function OnReadLogon(wSubCmdID : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case LGCmd.SUB_GP_LOGON_SUCCESS:
				{
					var logonSuc : CMD_GP_LogonSuccess = CMD_GP_LogonSuccess.OnReadByteArray(pBuffer);
					var user : UserInfo = UserModel._getInstance().selfInfo;
					user.dwUserID 		= logonSuc.dwUserID;
					user.wFaceID 		= logonSuc.wFaceID;
					user.cbMember 		= logonSuc.cbMember;
					user.cbGender 		= logonSuc.cbGender;
					user.cbMoorStatus 	= logonSuc.cbMoorStatus;
					user.dwExperience 	= logonSuc.dwExperience;
					user.lScore			= logonSuc.lScore;
					user.lBankScore 	= logonSuc.lBankScore;
					return true;
				}
				case LGCmd.SUB_GP_LOGON_ERROR:
				{
					pIClientSocket.CloseSocket(false);
					var logonErr : CMD_GP_LogonError = CMD_GP_LogonError._readByteArray(pBuffer,wDataSize);
					Controller.dispatchEvent(CxEvent.CX_LOGON_ERR,1,logonErr);
					return true;
				}
				case LGCmd.SUB_GP_LOGON_FINISH:
				{
					pIClientSocket.CloseSocket(false);
					Controller.dispatchEvent(CxEvent.CX_LOGON_FINISH);
					return true;
				}
				case LGCmd.SUB_GP_REGISTER_SUCCESS:
				{
					pIClientSocket.CloseSocket(false);
					Controller.dispatchEvent(CxEvent.CX_REGISTER_SUCCESS);
					return true;
				}
			}
			pIClientSocket.CloseSocket(true);
			return false;
		}
		
		//游戏列表服务
		private function OnReadServerList(wSubCmdID : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket : IClientSocket) : Boolean
		{
			var listNum : uint = 0;
			var listIndex : uint = 0;
			var serverList : ServerList = ServerList._getInstance();
			switch(wSubCmdID)
			{
				case LGCmd.SUB_GP_LIST_CONFIG:
				{
					var RecvConfigList : CMD_GP_ListConfig = CMD_GP_ListConfig.OnReadByteArray(pBuffer);
					TScore.radix = RecvConfigList.cbRadixPoint;
					//演示平台
					//TScore.radix = 0;
					return true;
				}
				case LGCmd.SUB_GP_LIST_TYPE:
				case LGCmd.SUB_GP_LIST_KIND:
				case LGCmd.SUB_GP_LIST_STATION:
				{
					return true;
				}
				case LGCmd.SUB_GP_LIST_SERVER:
				{
					listNum = wDataSize/tagGameServer.SIZE;
					for(listIndex = 0;listIndex<listNum;listIndex++)
					{
						var server : tagGameServer= tagGameServer._readByteArray(pBuffer);
						if(server) { serverList.InsertServer(server); }
					}
					return true;
				}
				case LGCmd.SUB_GP_LIST_FINISH:
				{
					pIClientSocket.CloseSocket(false);
					serverList.LoadServerComplete();
					return true;
				}
			}
			return false;
		}
		//用户消息
		protected function OnReadUserEvent(wSubCmdID : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket : IClientSocket) : Boolean
		{
			pIClientSocket.CloseSocket(false);
			var user : UserModel = UserModel._getInstance();
			switch(wSubCmdID)
			{
				case LGCmd.SUB_GP_MOOR_MACHINE_RESULT:
				{
					var moorResult : CMD_GP_LockMachineResult = CMD_GP_LockMachineResult._readBuffer(pBuffer);
//					if(moorResult.lResultCode !=0) {
//						Message.show(moorResult.szErrorDescribe);
//					}else {
//						user.selfInfo.cbMoorStatus = user.selfInfo.cbMoorStatus == 0?1:0;
//						var sucStr : String = user.selfInfo.cbMoorStatus == 0?'撤销机器绑定成功！':'本机绑定成功，该账号只能在本机登录';
//						if(user.selfInfo.cbMoorStatus == 0) { TDas._setStringItem('gameMac','',32); }
//						Message.show(sucStr);
//					}
					Controller.dispatchEvent('bindComputerResult', 0, moorResult);
					return true;
				}
				case LGCmd.SUB_GP_REFURBISH_RESULT:
				{
					var refresh : CMD_GP_Refurbish_result = CMD_GP_Refurbish_result._readBuffer(pBuffer);
					user.UpdateUserInfo({score:refresh.lScore,bankScore : refresh.lBankScore,face:refresh.wFaceID});
					return true;
				}
					
				case LGCmd.SUB_GP_REFURBISHSIGNIN_RESULT:
				{
					var signin:CMD_GP_RefurbishSignIn_result = CMD_GP_RefurbishSignIn_result._readBuffer(pBuffer);
					Controller.dispatchEvent('userSignin', 0, signin);
					return true;
				}
				case LGCmd.SUB_GP_RECORDSIGNIN_RESULT:
				{
					var signed:CMD_GP_RecordSignIn_result = CMD_GP_RecordSignIn_result._readBuffer(pBuffer);
					Controller.dispatchEvent('userSignedResult', 0, signed);
					return true;
				}
				case LGCmd.SUB_GP_CHCEKBINDEMAIL_RESULT:
				{
					var bingEmail:CMD_GP_ChcekBindEmail_Result = CMD_GP_ChcekBindEmail_Result._readBuffer(pBuffer);
					Controller.dispatchEvent("bindEmailResult", 0, bingEmail);
					return true;
				}
				case LGCmd.SUB_GP_CHCEKPHONE_RESULT:
				{
					var bingPhone:CMD_GP_CheckPhone_Result = CMD_GP_CheckPhone_Result._readBuffer(pBuffer);
					Controller.dispatchEvent("bindPhoneResult", 0, bingPhone);
					return true;
				}
				case LGCmd.SUB_GP_CHECKBANKINFO_RESULT:
				{
					var bingBankCard:CMD_GP_CheckBank_Result = CMD_GP_CheckBank_Result._readBuffer(pBuffer);
					Controller.dispatchEvent("bindBankCardResult", 0, bingBankCard);
					return true;
				}
				case LGCmd.SUB_GP_CREATECUSTOMGAMEROOM_RESULT:
				{
					var createRoom:CMD_GP_CreateCustomGameRoom_Result = CMD_GP_CreateCustomGameRoom_Result._readBuffer(pBuffer);
					Controller.dispatchEvent("createGameRoomResult", 0, createRoom);
					return true;
				}
//				case LGCmd.SUB_GP_INPUTFRIEND_RESULT:
//				{
//					var inputFriend:CMD_GP_InputFriend_Sine_Result = CMD_GP_InputFriend_Sine_Result._readBuffer(pBuffer);
//					Controller.dispatchEvent("inputFriendResult", 0, inputFriend);
//					return true;
//				}
					
					
			}
			return false;
		}
		
		//银行事件
		protected function OnReadBankEvent(wSubCmdID : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket : IClientSocket) : Boolean
		{
			pIClientSocket.CloseSocket(false);
			var user : UserModel = UserModel._getInstance();
			switch(wSubCmdID)
			{
				case LGCmd.SUB_GP_BANK_SAVE_SUCCESS:
				case LGCmd.SUB_GP_BANK_SAVE_ERROR:
				{
					var saveResult : CMD_GP_SaveMoneyResult = CMD_GP_SaveMoneyResult._readBuffer(pBuffer);
					if(saveResult.lResultCode == 0) {
						user.UpdateUserInfo({score:saveResult.lScore,bankScore:saveResult.insureScore});
						Message.show("存入成功,当前身上携带金币" + TScore.toStringEx(user.selfInfo.lScore) ,Message.MSG_NORMAL);
					}else {
						Message.show(saveResult.szDescribeMsg + ",存入失败!");
					}
					Controller.dispatchEvent("bank_save_event", 0, saveResult);
					return true;
				}
				case LGCmd.SUB_GP_BANK_CASH_SUCCESS:
				case LGCmd.SUB_GP_BANK_CASH_ERROR:
				{
					var cashResult : CMD_GP_CashMoneyResult = CMD_GP_CashMoneyResult._readBuffer(pBuffer);
					if(cashResult.lResultCode == 0) {
						user.UpdateUserInfo({score:cashResult.lScore,bankScore:cashResult.insureScore});
						Message.show('取出成功,当前携带金币' + TScore.toStringEx(cashResult.lScore));
					}else {
						Message.show(cashResult.szDescribeMsg);
					}
					Controller.dispatchEvent("bank_cash_event", 0, cashResult);
					return true;
				}
				case LGCmd.SUB_GP_BANK_CHANGE_SUCCESS:
				{
					Message.show('密码修改成功');
					return true;
				}
				case LGCmd.SUB_GP_BANK_CHANGE_ERROR:
				{
					var changeError : CMD_GP_ChangePassWordResult = CMD_GP_ChangePassWordResult._readBuffer(pBuffer);
					Message.show(changeError.szDescribeMsg);
					return true;
				}
				case LGCmd.SUB_GP_BANK_TRANSFER_RESULT:
				{
					var transfer:CMD_GP_Bank_TransferResult = CMD_GP_Bank_TransferResult._readBuffer(pBuffer);
					Controller.dispatchEvent("user_given_event", 0, transfer);
					return true;
				}
				case LGCmd.SUB_GP_BANK_CHECK_RESULT:
				{
					var recvBankCheck : CMD_GP_BankCheck_Result = CMD_GP_BankCheck_Result._readBuffer(pBuffer);
					
					Controller.dispatchEvent("bank_Check_Result", 0, recvBankCheck.cbEnble);
					return true;
					
				}
					
			}
			return false;
		}
	}
}
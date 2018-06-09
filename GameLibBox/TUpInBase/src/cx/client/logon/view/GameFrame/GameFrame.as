package cx.client.logon.view.GameFrame
{
	import com.greensock.TweenMax;
	
	import cx.admin.AdminCMD;
	import cx.admin.AideManager;
	import cx.admin.CMD_GF_AideLeave;
	import cx.admin.CMD_GF_AidePlay;
	import cx.client.logon.model.GameFrameModel;
	import cx.client.logon.model.MessageNet;
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.events.MsgEvent;
	import cx.client.logon.model.vo.KindOption;
	import cx.client.logon.view.GameFrame.GameMsgSprite;
	import cx.client.logon.view.GameFrame.GamePacket;
	import cx.client.logon.view.message.Message;
	import cx.gamebase.enum.enSmt;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.events.TCPEvent;
	import cx.gamebase.model.GameUserModel;
	import cx.gamebase.sturuct.CMD_GR_LogonByUserID;
	import cx.gamebase.sturuct.CMD_GR_LogonError;
	import cx.gamebase.sturuct.CMD_GR_LogonSuccess;
	import cx.gamebase.sturuct.CMD_GR_Message;
	import cx.gamebase.sturuct.CMD_GR_QueueField;
	import cx.gamebase.sturuct.CMD_GR_ServerInfo;
	import cx.gamebase.sturuct.CMD_GR_SitFailed;
	import cx.gamebase.sturuct.CMD_GR_TableInfo;
	import cx.gamebase.sturuct.CMD_GR_TableStatus;
	import cx.gamebase.sturuct.CMD_GR_UserQueue;
	import cx.gamebase.sturuct.CMD_GR_UserScore;
	import cx.gamebase.sturuct.CMD_GR_UserSitReq;
	import cx.gamebase.sturuct.CMD_GR_UserStatus;
	import cx.gamebase.sturuct.GameCmd;
	import cx.gamebase.sturuct.tagOnLineCountInfo;
	import cx.gamebase.sturuct.tagServerParmater;
	import cx.gamebase.sturuct.tagUserInfoHead;
	import cx.net.ClientSocket;
	import cx.net.Interface.IClientSocket;
	import cx.net.Interface.IClientSocketSink;
	import cx.net.NetConst;
	import cx.net.enum.enSocketState;
	import cx.net.utils.NetWork;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.globalization.StringTools;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import mx.utils.ObjectUtil;
	
	import t.cx.Interface.ICxKernelClient;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.file.TFileLoader;
	import t.cx.air.file.TPather;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.MD5;
	import t.cx.air.utils.SystemEx;
	import t.cx.cmd.SendPacketHelper;
	import t.cx.cmd.enum.enDTP;
	import t.cx.cmd.events.CxEvent;
	import t.cx.cmd.struct.tagGameKind;
	import t.cx.cmd.struct.tagGameServer;
	import t.cx.common.events.GlobalEvent;
	
	public class GameFrame extends Sprite implements ICxKernelClient,IClientSocketSink
	{
		private var _user 		: UserModel;
		private var _queueTime  : Timer;
		private var _queueCount : uint;
		
		
		private var _NetIndex 	: uint;
		private var _serverList : ServerList;
		private var _Server		: tagGameServer;
		private var _Kind		: tagGameKind;
		private var _KindOption : KindOption;
		private var _bDestroying : Boolean;
		public function set serverParam(val : tagServerParmater) : void
		{
			_Server = _serverList.GetServer(val.wServerID);
			_Kind = _serverList.GetKind(_Server.wKindID);
			_KindOption = _serverList.GetKindOption(_Server.wKindID);
			SetWH(_KindOption.width,_KindOption.height);
		}
		private function SetWH(w : Number,h : Number) : void
		{
			this.graphics.clear();
			this.graphics.beginFill(0x000000,0);
			this.graphics.drawRect(0,0,w,h);
			this.graphics.endFill();
			thePack.width =  w;
			thePack.height = h;
		}
		private var _urlLoader	: URLLoader;
		private var _loader		: Loader;
		private var _gameDisplay: DisplayObject;
		
		private var _GameSocket : ClientSocket;
		private var _serverInfo	: CMD_GR_ServerInfo;
		
		private var _bContinueGame : Boolean;
		private var _bCanLeave		: Boolean;
		public function CanLeaveGame() : Boolean
		{
			return _bCanLeave;
		}
		public function IsInGame() : Boolean
		{
			return _gameDisplay!=null;
		}
		public function GameFrame()
		{
			super();
			_serverList = ServerList._getInstance();
			_NetIndex = TDas._getByteItem(TConst.PROXY)-1;
			if(stage) 
				{ init(); }
			else 
				{ addEventListener(Event.ADDED_TO_STAGE,init); }
		}
		public function CxGetWH():Point
		{
			return new Point(_KindOption.width ,_KindOption.height);
		}
		
		public function CxGetDisplayObject(type:String="", bShow:Boolean=false) : DisplayObject
		{
			return this;
		}
		public function CxIcon(size : uint = 128) : Array
		{
			if(_KindOption != null && _KindOption.iconBitmapData)
			{
				return [_KindOption.iconBitmapData];
			}
			return null;
		}
		
		public function CxWindowTitle() : String
		{
			return _Server.szServerName;
		}
		public function CxShowType(parent:*=null):String
		{
			return '_' + _KindOption.type;
		}
		public function CxClientDestroy(cbDestroyCode:uint):Boolean
		{
			trace("CxClientDestroy   " + cbDestroyCode)
			if(cbDestroyCode == 10) {
				onExit(2); 
				return false; 
			}
			_bDestroying = true;
			onStartTime(true);
			
			if(_gameDisplay)
			{
				Controller.dispatchEvent(GameEvent.PRE_G_EXIT,1);
				if(this.contains(_gameDisplay)) { this.removeChild(_gameDisplay); }
				_gameDisplay = null;
			}
			
			if( cbDestroyCode==2 || !_bContinueGame )
			{
				_user.Destroy();
				_user = null;
				if(_GameSocket)
				{
					_GameSocket.CloseSocket(false);
					_GameSocket = null;
				}
				onHideGongGao();
				if(theAideManager != null) { theAideManager.ResetList(); }
			}else {
				if(_user != null) {
					_user.RemoveAll();
				}
			}
			_queueCount = 0;
			thePack.StopLoad();
			theMsg.Hide();
			_bCanLeave = false;
			unLoader();
			Controller.removeEventListener(MsgEvent.MSG_OUTUSER,onOutUserEvent);
			Controller.removeEventListener(MsgEvent.MSG_MESSAGE,OnAdminMessgae);
			_bDestroying = false;
			_serverList._bGameOpen = false;
			TweenMax.killAll(true);
			SystemEx._froceGC();
			return true;
		}
		
		public function SocketConnect(iErrorCode : int,szErrorDesc : String,pIClientSocket : IClientSocket) : Boolean
		{
			if(iErrorCode != 0)
			{
				onStartTime(true);
				Message.show(szErrorDesc);
				return false;
			}
			thePack.SetText('游戏服务连接成功,开始登录服务器');
			//发送游戏登陆消息
			var logon : CMD_GR_LogonByUserID = new CMD_GR_LogonByUserID();
			logon.dwUserID = _user.selfInfo.dwUserID;
			logon.szPassWord = MD5.hash(_user.selfInfo.szPassword);
			logon.dwPlazaVersion =  TConst.VER_PLAZA_FRAME;
			logon.dwProcessVersion = 0;
			var bytes : ByteArray = logon.Write();
			var mac : String = SystemEx._clientSequence();
			var wPacketSize : uint = SendPacketHelper._attachTCHAR(bytes,mac,33,enDTP.DTP_COMPUTER_ID);
			pIClientSocket.SendData(GameCmd.MDM_GR_LOGON,GameCmd.SUB_GR_LOGON_USERID,bytes,logon.SIZE + wPacketSize);
			return true;
		}
		public function SocketRead(wMainCmdID : uint,wSubCmdID : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wMainCmdID)
			{
				case GameCmd.MDM_GR_LOGON:			//登陆消息
				{
					return OnGameLogonEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.MDM_GR_INFO:			//游戏信息消息
				{
					return OnGameInfoEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.MDM_GR_USER:			//玩家消息
				{
					return OnGameUserEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.MDM_GR_STATUS:			//游戏状态
				{
					return OnTableStatus(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.MDM_GR_SYSTEM:			//系统消息
				{
					return OnSystemEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.MDM_GR_SERVER_INFO:	//服务消息
				{
					return OnServerInfoEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
				case AdminCMD.MDM_GF_AIDE:
				{
					return OnServerAideEvent(wSubCmdID,pBuffer,wDataSize,pIClientSocket);
				}
			}
			return false;
		}
		
		public function SocketClose(pIClientSocket : IClientSocket,bCloseByServer : Boolean) : Boolean
		{
			thePack.SetText('游戏服务关闭');
			Controller.dispatchEvent(TCPEvent.SOCKET_SINK,TCPEvent.SOCKET_CLOSE,bCloseByServer);
			if(bCloseByServer) {
				Message.show("游戏服务器连接错误.");
			}
			_bCanLeave= true;
			_bContinueGame = false;
			if(!_bDestroying) { onExit(); }
			return true;
		}
		public function CXShowed(bExitCode : uint) : void
		{
			
		}
		//用户消息
		protected function OnGameUserEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			try {
				switch(wSubCmdID)
				{
					case GameCmd.SUB_GR_USER_COME:
					{
						try {
							var userHead : tagUserInfoHead = tagUserInfoHead._readBuffer(pBuffer);
							if(userHead)
							{
								_user.InsertPlayer(userHead);
								if(userHead.wTableID != TConst.INVALID_TABLE) {		//如果玩家在游戏内
									if(_user.selfID == userHead.dwUserID) {			//如果是自己 
										sendUserInfoToGame(userHead.wTableID);
									}else if(_user.SelfHead.wTableID == userHead.wTableID) {
										Controller.dispatchEvent(GameEvent.USER_COME,1,userHead.clone());
									}
								}
								if( theAideManager!=null ) { Controller.dispatchEvent(GameEvent.USER_COME,3,userHead.clone()); }
							}
						}catch(e : Error) {
							Message.show('OnGameUserEvent:' + wSubCmdID+'|'+pBuffer.bytesAvailable+'|'+wDataSize + '|' + e.toString(),3);
							return false;
						}
						
						return true;
					}
					case GameCmd.SUB_GR_USER_STATUS:		
					{
						return OnUserStatus(pBuffer,wDataSize,pIClientSocket);
					}
					case GameCmd.SUB_GR_USER_SCORE:			//用户积分变化
					{
						return OnUserScore(pBuffer,wDataSize,pIClientSocket);
					}
					case GameCmd.SUB_GR_SIT_FAILED:
					{
						var SitField : CMD_GR_SitFailed = CMD_GR_SitFailed._readBuffer(pBuffer);
						Message.show(SitField.szFailedDescribe);
						onExit();
						return true;
					}
					case GameCmd.SUB_GR_USER_QUEUE:			//游戏队列添加成功
					{
						var RecvQueueCom : CMD_GR_UserQueue = CMD_GR_UserQueue._readBuffer(pBuffer);
						thePack.SetText('系统响应队列请求完成,正在为您自动分桌...');
						return true;
					}
					case GameCmd.SUB_GR_USER_QUEUE_COM:		//队列分配成功
					{
						_bCanLeave = true;
						onStartTime(true);
						thePack.SetText('系统自动分桌完成,正在进入游戏...');
						return true;
					}
					case GameCmd.SUB_GR_USER_QUEUE_FIELD:
					{
						onStartTime(true);
						_bCanLeave= true;
						_bContinueGame = false;
						var RecvQueueField : CMD_GR_QueueField = CMD_GR_QueueField._readBuffer(pBuffer);
						Message.show(RecvQueueField.szFailedDescribe);
						onExit();
						return true;
					}
				}
			}catch(e : Error) {
				Message.show('OnGameUserEvent:' + wSubCmdID+'|'+pBuffer.bytesAvailable+'|'+wDataSize + '|' + e.toString(),3);
				return false;
			}
			return false;
		}
		//-------------------------------------------------------------------------------------
		//管理员
		protected function OnServerAideEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case AdminCMD.SUB_GF_AIDE_STATUS:
				{
					if( theAideManager != null ) 
					{
						Controller.dispatchEvent( "AIDE_USER_STATUS",1,CMD_GR_UserStatus._readBuffer(pBuffer) );
						return true;
					}
					return false;
				}
				case AdminCMD.SUB_GF_AIDE_LEAVE:
				{	
					if( theAideManager != null ) 
					{
						var RecvLeaveID : uint = CMD_GF_AideLeave._readBuffer(pBuffer).dwUserID;
						Controller.dispatchEvent( "AIDE_USER_LEAVE",1,RecvLeaveID );
						return true;
					}
					return false;
				}
				case AdminCMD.SUB_GF_AIDE_PLAY:
				{
					var RecvAdminPlay : CMD_GF_AidePlay = CMD_GF_AidePlay._readBuffer(pBuffer);
					var userInfo : tagUserInfoHead = _user.GetUser(RecvAdminPlay.dwUserID);
					if( userInfo != null) {
						userInfo.dwViewID = RecvAdminPlay.dwViewID;
						userInfo.AideIP = RecvAdminPlay.szViewIP;
					}
					return true;
				}
			}
			return false;
		}
		//-------------------------------------------------------------------------------------
		//消息出来函数
		protected function OnGameLogonEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case GameCmd.SUB_GR_LOGON_SUCCESS:	//登陆成功
				{
					var logonSuccess : CMD_GR_LogonSuccess = CMD_GR_LogonSuccess._readBuffer(pBuffer);
					if(_user.selfID != logonSuccess.dwUserID)	 {		//登陆获取ID与用户ID不符
						Message.show('登陆获取ID与用户ID不符');
						thePack.SetText('登陆获取ID与用户ID不符('+_queueCount+')...');
						return false;
					}
					thePack.SetText('游戏服务连接成功...');
					return true;
				}
				case GameCmd.SUB_GR_LOGON_ERROR:	//登陆失败
				{
					thePack.SetText('游戏服务连接失败('+_queueCount+')...');
					_bCanLeave= true;
					var logonError : CMD_GR_LogonError = CMD_GR_LogonError._readBuffer(pBuffer);
					Message.show(logonError.szErrorDescribe);
					onExit();
					return true;
				}
				case GameCmd.SUB_GR_LOGON_FINISH:	//登陆完成
				{
					if(_user.Aide && theAideManager != null) {
						return onAdminLogonFinish();
					}else {
						return onSendEnterTable();
					}
				}
			}
			Message.show("数据未处理【wMainID】:" + 1 + '【wSubID】:' + wSubCmdID);
			return false;
		}
		
		private function onAdminLogonFinish() : Boolean
		{
			thePack.SetText('游戏服务登录成功('+_queueCount+')...');
			if(!(_user && _user.selfInfo)) return false;
			var myStatus : CMD_GR_UserStatus = _user.GetStatusByID(_user.selfID);
			if(myStatus == null )return false;
			if(myStatus.cbUserStatus <= TConst.US_FREE || _bContinueGame)
			{
				if(_Kind.wTypeID == 1)				//财富类游戏
				{
					return onSendEnterTable();
				}else {
					if(!_bContinueGame) {
						_GameSocket.SendCmd(AdminCMD.MDM_GF_AIDE,AdminCMD.SUB_GF_AIDE_USERLIST);
					}
				}
				return true;
			}else{
				thePack.SetText('断线重入玩家...');
				if(!OnInstallGame()) { onExit(1); }
				return true;
			}
			return false;
		}
		
		private function onSendEnterTable() : Boolean
		{
			thePack.SetText('游戏服务登录成功('+_queueCount+')...');
			if(!(_user && _user.selfInfo)) return false;
			var myStatus : CMD_GR_UserStatus = _user.GetStatusByID(_user.selfID);
			if(myStatus == null )return false;
			if(myStatus.cbUserStatus <= TConst.US_FREE || _bContinueGame)
			{
				if(_serverInfo.cbHideUserInfo!=0)	//防作弊房间
				{
					if(_Kind.wTypeID == 1)				//财富类游戏
					{
						var sit : CMD_GR_UserSitReq = new CMD_GR_UserSitReq();
						sit.wChairID = TConst.INVALID_CHAIR;
						sit.wTableID = TConst.INVALID_CHAIR; 
						_GameSocket.SendData(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_SIT_REQ,sit.Write(),sit.size());
						thePack.SetText('游戏服务登录成功,请求服务器上坐...');
						return true;
					}else {
						_queueCount = 0;
						onStartTime();
						var bReturn : Boolean = _GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_QUEUE_REQ);
						thePack.SetText('游戏服务登录成功,请求队列服务('+_queueCount+')...');
						return bReturn;
					}
					return false;
				}else							
				{
					Message.show("非防作弊模式未开启.");
					thePack.SetText('游戏服务登录成功,房间为非防作弊，无法进入('+_queueCount+')...');
					_GameSocket.CloseSocket(false);
					return true;
				}
			}else {
				thePack.SetText('断线重入玩家...');
				if(!OnInstallGame()) { onExit(1); }
				return true;
			}
			return false;
		}
		//服务配置消息
		protected function OnGameInfoEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case GameCmd.SUB_GR_SERVER_INFO:
				{
					_serverInfo = CMD_GR_ServerInfo._readBuffer(pBuffer);
					return true;
				}
				case GameCmd.SUB_GR_COLUMN_INFO:
				{
					return true;
				}
				case GameCmd.SUB_GR_CONFIG_FINISH:
				{
					return true;
				}
			}
			
			thePack.SetText("数据未处理【wMainID】:" + 3 + '【wSubID】:' + wSubCmdID);
			Message.show("数据未处理【wMainID】:" + 3 + '【wSubID】:' + wSubCmdID);
			return false;
		}
		
		//用户积分变化
		protected function OnUserScore(pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			var RecvScore : CMD_GR_UserScore = CMD_GR_UserScore._readBuffer(pBuffer);
			if(RecvScore.dwUserID == _user.selfID) { 
				_user.selfInfo.lScore = RecvScore.UserScore.lScore; 
			}
			var userInfo : tagUserInfoHead = _user.GetUser(RecvScore.dwUserID);
			if(userInfo) {
				userInfo.UserScoreInfo.lScore = RecvScore.UserScore.lScore;
				userInfo.UserScoreInfo.lDrawCount = RecvScore.UserScore.lDrawCount;
				userInfo.UserScoreInfo.lExperience = RecvScore.UserScore.lExperience;
				userInfo.UserScoreInfo.lFleeCount = RecvScore.UserScore.lFleeCount;
				userInfo.UserScoreInfo.lLostCount = RecvScore.UserScore.lLostCount;
				userInfo.UserScoreInfo.lWinCount = RecvScore.UserScore.lWinCount;
			}
			Controller.dispatchEvent(GameEvent.USER_SCORE,1,RecvScore);
			return true;
		}
		
		protected function OnUserStatus(pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			try {
				var userStatus : CMD_GR_UserStatus = CMD_GR_UserStatus._readBuffer(pBuffer);
				trace("更新用户状态： " + userStatus.cbUserStatus + "  " + userStatus.dwUserID + "   " + userStatus.wChairID + "  " +userStatus.wTableID)
				var oldStatus : CMD_GR_UserStatus = _user.UpdateStatus(userStatus);
				trace("原来用户状态： " + userStatus.cbUserStatus + "  " + userStatus.dwUserID + "   " + userStatus.wChairID + "  " +userStatus.wTableID)
				if(userStatus.dwUserID != _user.SelfHead.dwUserID){				//其他人的状态消息
					if(userStatus.cbUserStatus == TConst.US_NULL)	 {													//用户离开
						_user.Remove(userStatus.dwUserID);
						if(oldStatus!= null) {
							if(oldStatus.wTableID == _user.SelfHead.wTableID) { Controller.dispatchEvent(GameEvent.USER_STATUS,1,userStatus,oldStatus);  }
						}
					}else {
						if( (oldStatus == null || oldStatus.cbUserStatus <= TConst.US_FREE) && userStatus.cbUserStatus >= TConst.US_SIT)	{		//用户坐下
							if(userStatus.wTableID == _user.SelfHead.wTableID) { sendUserInfoToGame(userStatus.wTableID); }
						}
					}
				}else{
					if(userStatus.cbUserStatus <= TConst.US_FREE)														//用户自己离开游戏
					{
						if(oldStatus != null && oldStatus.cbUserStatus > TConst.US_FREE && !_bContinueGame)
						{
							onExit(1);
						}
						return true;
					}
					if(userStatus.cbUserStatus>TConst.US_FREE)
					{
						var bStart : Boolean = false;
						if(oldStatus == null) {
							bStart = false;
							oldStatus = userStatus.Clone();
						}else if(oldStatus.cbUserStatus<=TConst.US_FREE) {
							bStart = true;
						}
						if(bStart) {
							//安装游戏
							if(!OnInstallGame()) { onExit(1); }
						}
					}
				}
				//通知游戏
				if(userStatus.wTableID == _user.SelfHead.wTableID) { Controller.dispatchEvent(GameEvent.USER_STATUS,1,userStatus,oldStatus); }
			}catch(e : Error) {
				trace('OnGameUserEvent:OnUserStatus:' + pBuffer.bytesAvailable+'|'+wDataSize + '|' + e.toString(),3);
				return false;
			}
			return true;
		}
		//桌子信息
		protected function OnTableStatus(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			
			switch(wSubCmdID)
			{
				case GameCmd.SUB_GR_TABLE_INFO:
				{
					var tableInfo : CMD_GR_TableInfo = CMD_GR_TableInfo._readBuffer(pBuffer);
					
					return true;
				}
				case GameCmd.SUB_GR_TABLE_STATUS:						//桌子状态
				{
					var tableStatus : CMD_GR_TableStatus = CMD_GR_TableStatus._readBuffer(pBuffer);
					return true;
				}
			}
			return false;
		}
		protected function OnSystemEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case GameCmd.SUB_GR_MESSAGE:
				{
					var msg : CMD_GR_Message = CMD_GR_Message._readBuffer(pBuffer);
					switch(msg.wMessageType)
					{
						case enSmt.INFO:			//信息消息
						{
							return true;
						}
						case enSmt.EJECT:			//弹出消息
						case enSmt.GLOBAL:			//全局消息
						{
							return true;
						}
						case enSmt.CLOSE_GAME:		//关闭游戏
						{
							_bCanLeave= true;
							Message.show(msg.szContent);
							onExit(1);
							return true;
						}
					}
					return true;
				}
			}
			return false;
		}
		//消息服务器
		protected function OnServerInfoEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case GameCmd.SUB_GR_ONLINE_COUNT_INFO:
				{
					var onLineInfo : tagOnLineCountInfo = tagOnLineCountInfo._readBuffer(pBuffer);
					Controller.dispatchEvent(TCPEvent.TCP_SERVER_INFO,TCPEvent.TCP_ONLINE_COUNTINFO,onLineInfo);
					return true;
				}
			}
			return false;
		}
		//-------------------------------------------------------------------------------------
		private function init(e : Event = null) : void
		{
			_queueCount=0;
			_bCanLeave = true;
			_user		= UserModel._getInstance(); 
			thePack.mouseChildren = false;
			theGongGao.mouseEnabled = false;
			theGongGao.mouseWheelEnabled = false;	
			if(_Server != null && _Kind != null)
			{
				thePack.StartLoad(_Kind.wKindID);
				
				Controller.addEventListener(MsgEvent.MSG_OUTUSER,onOutUserEvent);
				Controller.addEventListener(MsgEvent.MSG_MESSAGE,OnAdminMessgae);
				
				_serverList._bGameOpen = true;
				thePack.SetText(_Server.szServerName + '启动,正在连接服务器...');
				
				//选择电信  与 联通
				var ip : String = NetWork._inetNtoa(_Server.dwServerAddr[_NetIndex]);
				var port : int = _Server.wServerPort;
				if(_GameSocket == null)
				{
					trace("_GameSocket is null   ")
					_GameSocket = new ClientSocket();
					_GameSocket.SetSocketSink(this);
					_GameSocket.Connect( ip,port );
					if(theAideManager != null) { theAideManager.tcp = _GameSocket; }
				}else {
					if(!_user.Aide || theAideManager == null) {
						onSendEnterTable();
					}else {
						onAdminLogonFinish();
					}
				}
			}else {
				Message.show('没有找到该游戏服务,请联系客服.');
				onExit(0);
			}
		}
		private function onOutUserEvent(e : TEvent) : void
		{
			_bCanLeave = true;
			if(_GameSocket != null && _GameSocket.GetConnectState() == enSocketState.en_Connected) {
				_GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_ADMIN_OUT);
			}
			_bContinueGame = false;
			if(NetConst.pCxWin) { NetConst.pCxWin.CxExit(this,2); }
			Message.show('您被管理员踢出游戏');
		}
		
		private var _gongGaotimer : Timer;
		private function OnAdminMessgae(e : TEvent) : void
		{
			if(e.m_nMsg == 1)
			{
				onHideGongGao();
				theGongGao.htmlText = e.nWParam as String;
				theGongGao.visible = true;
				theGongGao.y = (this.height - theGongGao.height);
				_gongGaotimer = new Timer(100,250);
				_gongGaotimer.addEventListener(TimerEvent.TIMER,onGgTimerEvent);
				_gongGaotimer.start();
			}
		}
		private function StopTimer() : void
		{
			if(_gongGaotimer != null)
			{
				_gongGaotimer.removeEventListener(TimerEvent.TIMER,onGgTimerEvent);
				_gongGaotimer.stop();
				_gongGaotimer = null;
			}
		}
		private function onHideGongGao() : void
		{
			theGongGao.text = '';
			theGongGao.visible = false;
			StopTimer();
		}
		private function onGgTimerEvent(e : TimerEvent) : void
		{
			if(_gongGaotimer == null) return;
			theGongGao.y -= this.height / _gongGaotimer.repeatCount;
			if(_gongGaotimer.repeatCount - _gongGaotimer.currentCount <=0) { StopTimer(); }
		}
		private function onStartTime(bKill : Boolean = false) : void
		{
			if(bKill)
			{
				if(_queueTime != null)
				{
					_queueTime.stop();
					_queueTime.removeEventListener(TimerEvent.TIMER_COMPLETE,onCheckQueueEvent);
					_queueTime = null;
				}
				return;
			}
			_queueCount++;
			onStartTime(true);
			_queueTime = new Timer(10000,1);
			_queueTime.addEventListener(TimerEvent.TIMER_COMPLETE,onCheckQueueEvent);
			_queueTime.start();
		}
		private function onCheckQueueEvent(e : TimerEvent) : void
		{
			if( !(_GameSocket && _GameSocket.GetConnectState() == enSocketState.en_Connected) )
			{
				if(_GameSocket != null) {
					_GameSocket.Connect(  NetWork._inetNtoa(_Server.dwServerAddr[ (_NetIndex+1)%2 ]),_Server.wServerPort );
				}else {
					_GameSocket = new ClientSocket();
					_GameSocket.SetSocketSink(this);
					_GameSocket.Connect(  NetWork._inetNtoa(_Server.dwServerAddr[ (_NetIndex+1)%2 ]),_Server.wServerPort );
				}
				return;
			}
			thePack.SetText('系统正在为您分配房间('+_queueCount+')....');
			_GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_QUEUE_REQ_AGAIN);
			onStartTime();
		}
		private function onExit(bExitCode : uint = 0) : void
		{
			trace("onExit...................." + bExitCode)
			
			if(_bCanLeave){
				if(bExitCode != 0) { sendLeaveReq(bExitCode); }
				if(NetConst.pCxWin) { NetConst.pCxWin.CxExit(this,bExitCode); }
			}else {
				theMsg.Show('游戏进行中,强行退出将视为逃跑并扣除部分金币,是否继续？');
			}
		}
		//清理游戏数据
		private function unLoader() : void
		{
			if(_urlLoader) { 
				if(_urlLoader.data) { _urlLoader.data = null; }
				_urlLoader.close(); 
				_urlLoader = null; 
			}
			if(_loader) {
				_loader.unloadAndStop();
				_loader = null;
			}
		}
		//加载游戏
		protected function OnInstallGame() : Boolean
		{
			var path : String = _KindOption.exe;
			path += (TConst.TC_DEUBG==1)?'.swf':'.cxc';
			path = TPather._fullPath(path);
			if(!TPather._exist(path)) { 
				Message.show("游戏尚未安装,请手动更新."); 
				return false;  
			}
			//添加游戏部件加载完成监听
			Controller.addEventListener(GameEvent.INIT_G_COMPLETE,OnGameInitCompleteEvent);
			Controller.addEventListener('AlterWindow',OnAlterWindow);
			//加载游戏
			OnLoaderGameByteArray(path);
			return true;
		}
		protected function OnLoaderGameByteArray(url : String) : void
		{
			//创建loader 或外部创建
			if(_urlLoader) { unLoader() };
			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE,OnSWFLoaded);
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.load(new URLRequest(url));
		}
		protected function OnSWFLoaded(e : Event) : void
		{
			_urlLoader.removeEventListener(Event.COMPLETE,OnSWFLoaded);
			var bytes:ByteArray = _urlLoader.data;
			bytes.readBytes(_urlLoader.data,0,_urlLoader.bytesTotal);
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,OnConvertGame);
			//从ByteArray 加载数据
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.allowLoadBytesCodeExecution = true; 
			if(TConst.TC_DEUBG != 1) { bytes = TPather._decodeSwf(bytes); }
			_loader.loadBytes(bytes,loaderContext);
		}
		protected function OnConvertGame(e : Event) : void
		{
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,OnConvertGame);
			_gameDisplay = _loader.content;
			this.addChildAt(_gameDisplay,0);
			unLoader();
		}
		protected function OnGameInitCompleteEvent(e : TEvent) : void
		{
			Controller.removeEventListener(GameEvent.INIT_G_COMPLETE,OnGameInitCompleteEvent);
			Controller.removeEventListener('AlterWindow',OnAlterWindow);
			_bContinueGame = false;
			Controller.dispatchEvent(TCPEvent.SOCKET_SINK,TCPEvent.SOCKET_INIT,_GameSocket as IClientSocket);
			Controller.dispatchEvent(TCPEvent.GAME_ATTRIBUTE,0,_Server,_Kind);
			//添加游戏内部事件监听
			Controller.addEventListener(GameEvent.GAME_SEND_EXIT,OnGameReqExitEvent);
			Controller.addEventListener(GameEvent.CLIENT_GAME_OFFLIE,OnGameOffLineEvent);
			Controller.addEventListener(GameEvent.CONTINUE_GAME,OnContinueGameEvent);
			Controller.addEventListener(GameEvent.GAME_LEAVE_ENABLE,OnLeaveEnableEvent);
			Controller.addEventListener(GameEvent.USER_GAME_SCORE,OnUserGameScore);
			if(MessageNet._getInstance().gongGao != null) {
				Controller.dispatchEvent(GameEvent.GAME_NOTICE_EVENT,0,MessageNet._getInstance().gongGao.MessageTxt);
			}
			//发送用户进入游戏
			sendUserInfoToGame(_user.SelfHead.wTableID);
			//隐藏掉加载界面
			thePack.StopLoad();
			if(_user.Aide && theAideManager != null) {
				theAideManager.HideLeft();
			}
		}
		private function OnAlterWindow(e : TEvent) : void
		{
			if(NetConst.pCxWin) { NetConst.pCxWin.CxResTore(this) }
		}
		private function OnUserGameScore(e : TEvent) : void
		{
			var userInfo : tagUserInfoHead = _user.SelfHead;
			if(userInfo != null) {  _user.UpdateUserInfo( {score:e.nLParam} );  }
		}
		protected function OnGameReqExitEvent(e : TEvent) : void
		{
			trace("OnGameReqExitEvent............." + e.m_nMsg)
			unListernController();
			if(e.m_nMsg == 2) { 
				_bCanLeave = true;
				if(_Kind.wTypeID == 1 || _Kind.wKindID == 2000 || _Kind.wKindID==2003) 
				{ 
					GameFrameModel._GetInstance().exit = false; 
				}
				onExit(2);
			}else {
				onExit(1);
			}
		}
	
		protected function OnGameOffLineEvent(e : TEvent) : void
		{
			OnGameReqExitEvent(e);
			Message.show("您的网络断开,请检查网络后继续游戏!");
		}
		protected function OnLeaveEnableEvent(event : TEvent) : void
		{
			trace("OnLeaveEnableEvent........" + event.m_nMsg)
			_bCanLeave = event.m_nMsg==1;
		}
		protected function OnContinueGameEvent(event : TEvent) : void
		{
			trace("OnContinueGameEvent..............")
			unListernController();
			TConst.TC_AUTO_ENTER_GAME = _Server.wServerID;
			_bContinueGame = true;
			_bCanLeave = true;
			onExit(5);
		}
		private function unListernController() : void
		{
			Controller.removeEventListener(GameEvent.GAME_SEND_EXIT,OnGameReqExitEvent);
			Controller.removeEventListener(GameEvent.CONTINUE_GAME,OnContinueGameEvent);
			Controller.removeEventListener(GameEvent.GAME_LEAVE_ENABLE,OnLeaveEnableEvent);
			Controller.removeEventListener(GameEvent.USER_GAME_SCORE,OnUserGameScore);
			Controller.removeEventListener(GameEvent.CLIENT_GAME_OFFLIE,OnGameOffLineEvent);
		}
		private function sendLeaveReq(bExitCode : uint) : void
		{
			if(_GameSocket != null && _GameSocket.GetConnectState() == enSocketState.en_Connected) {
				_GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_LEFT_GAME_REQ);
			}
		}
		//发送玩家本桌的用户
		private function sendUserInfoToGame(tableID : int) : void
		{
			var arr : Array = _user.GetUsersByTable(tableID);
			var self : tagUserInfoHead = _user.SelfHead;
			Controller.dispatchEvent(GameEvent.USER_COME,1,self.clone());
			for(var i : uint =0;i<arr.length;i++)
			{
				var userInfo : tagUserInfoHead = arr[i] as tagUserInfoHead;
				if(self.dwUserID == userInfo.dwUserID) continue;
				Controller.dispatchEvent(GameEvent.USER_COME,1,userInfo.clone());
			}
		}
		//mc
		private function get thePack() : GamePacket
		{
			return this['GamePackMC'];
		}
		private function get theMsg() : GameMsgSprite
		{
			return this['GameMsgMC'];
		}
		private function get theGongGao() : TextField
		{
			return this['MsgTxt'];
		}
		private function get theAideManager() : AideManager
		{
			return this['AideManageMC'];
		}
	}
}
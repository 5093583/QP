package gamesOther
{
	import com.greensock.TweenMax;
	import com.plaza.MsgManager;
	
	import cx.admin.AdminCMD;
	import cx.admin.AideManager;
	import cx.admin.CMD_GF_AideLeave;
	import cx.admin.CMD_GF_AidePlay;
	import cx.client.logon.model.GameFrameModel;
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.events.MsgEvent;
	import cx.client.logon.model.vo.KindOption;
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
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.text.TextField;
	import flash.ui.Mouse;
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
	import t.cx.air.utils.HashMap;
	import t.cx.air.utils.IDConvert;
	import t.cx.air.utils.MD5;
	import t.cx.air.utils.Memory;
	import t.cx.air.utils.SystemEx;
	import t.cx.cmd.SendPacketHelper;
	import t.cx.cmd.enum.enDTP;
	import t.cx.cmd.events.CxEvent;
	import t.cx.cmd.struct.tagGameKind;
	import t.cx.cmd.struct.tagGameServer;
	import t.cx.common.events.GlobalEvent;
	
	public class GameFrameOther extends Sprite implements ICxKernelClient,IClientSocketSink
	{
		private var _user 		: UserModel;
		private var _queueTime  : Timer;
		private var _queueCount : uint;
		
		private var _serverList : ServerList;
		private var _NetIndex 	: uint;
		private var _Server		: tagGameServer;
		private var _Kind		: tagGameKind;
		private var _KindOption : KindOption;
		private var _bDestroying : Boolean;
		
		private var _TableCount  : uint;
		private var _TableWitch  : Number ;
		private var _TableHeight : Number;
		private var _StartPoint  : Number;
		public function set serverParam(val : tagServerParmater) : void
		{
			_Server = _serverList.GetServer(val.wServerID);
			_Kind = _serverList.GetKind(_Server.wKindID);
			_KindOption = _serverList.GetKindOption(_Server.wKindID);
		}
		
		private var _urlLoader	: URLLoader;
		private var _loader		: Loader;
		private var _gameDisplay: DisplayObject;
		private var _bClientReaday	: Boolean;
		
		private var _GameSocket : ClientSocket;
		private var _serverInfo	: CMD_GR_ServerInfo;
		
		private var _bContinueGame : Boolean;
		private var _bCanLeave		: Boolean;
		private var _tableChairStatus : Array;
		private var _tableHeadBmp : HashMap;
		public function CanLeaveGame() : Boolean
		{
			return _bCanLeave;
		}
		public function IsInGame() : Boolean
		{
			return _gameDisplay!=null;
		}
		
		
		//		private function sp_clickHandler(e:MouseEvent):void
		//		{
		//			OnInstallGame();
		//		}
		
		public function GameFrameOther()
		{
			//			var sp:Sprite = new Sprite;
			//			sp.graphics.clear();
			//			sp.graphics.beginFill(0xff0000);
			//			sp.graphics.drawRect(0, 0, 40, 20);
			//			sp.graphics.endFill();
			//			this.addChild(sp);
			//			sp.addEventListener(MouseEvent.CLICK, sp_clickHandler);
			
			
			
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
			if(cbDestroyCode == 10) {
				onExit(2); 
				return false; 
			}
			_bDestroying = true;
			onStartTime(true);
			
			if(_gameDisplay)
			{
				_bClientReaday = false;
				Controller.dispatchEvent(GameEvent.PRE_G_EXIT,1);
				if(this.contains(_gameDisplay)) { this.removeChild(_gameDisplay);}
				_gameDisplay = null;
			}
			
			if( cbDestroyCode==2 || !_bContinueGame )
			{
				if(_user)
				{
					_user.Destroy();
					_user = null;
				}
				if(_GameSocket)
				{
					_GameSocket.CloseSocket(false);
					_GameSocket = null;
				}
				//				if(theAideManager != null ) { theAideManager.ResetList(); }
			}else {
				if(_user != null) { _user.RemoveAll(); }
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
				//				Message.show(szErrorDesc);
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
			if(bCloseByServer) 
			{
				//				Message.show("游戏服务器连接错误.");
				//				MsgManager.getInstance().showMessage1('游戏服务器连接断开，请稍后尝试重新进入游戏！如未解决，请联系客服！', close_clickHandler);
				Controller.dispatchEvent( 'mema_serverClose' , 1);
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
							if(_tableChairStatus == null) _tableChairStatus = Memory._newTwoDimension(_serverInfo.wTableCount,_serverInfo.wChairCount,0);
							if(_tableHeadBmp == null) _tableHeadBmp = new HashMap();
							var userHead : tagUserInfoHead = tagUserInfoHead._readBuffer(pBuffer);
							if(userHead)
							{
								//trace('=====用户进入========' + getObjcetProperties(userHead))
								_user.InsertPlayer(userHead);
								if(userHead.wTableID != TConst.INVALID_TABLE) {		//如果玩家在游戏内
									if(_user.selfID == userHead.dwUserID) {			//如果是自己 
										sendUserInfoToGame(userHead.wTableID);
									}
										//									else if(_user.SelfHead().wTableID == userHead.wTableID) 
									else if(_user.SelfHead.wTableID == userHead.wTableID)
									{
										Controller.dispatchEvent(GameEvent.USER_COME,1,userHead.clone());
									}
								}
								//								if( theAideManager!=null && _serverInfo.wKindID != 1004 ) { Controller.dispatchEvent(GameEvent.USER_COME,3,userHead.clone()); }
								if(_serverInfo.wKindID == 1027 || (_serverInfo.wKindID >= 1004 && _serverInfo.wKindID <= 1008))
								{
									_tableHeadBmp.put(userHead.dwUserID,userHead.wFaceID);
									if(userHead.wTableID!=TConst.INVALID_TABLE&&userHead.wChairID!=TConst.INVALID_CHAIR)
									{
										_tableChairStatus[userHead.wTableID][userHead.wChairID] = 1;
									}
								}
							}
						}catch(e : Error) {
							//							Message.show('OnGameUserEvent:' + wSubCmdID+'|'+pBuffer.bytesAvailable+'|'+wDataSize + '|' + e.toString(),3);
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
						//						Message.show(SitField.szFailedDescribe);
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
						//						Message.show(RecvQueueField.szFailedDescribe);
						onExit();
						return true;
					}
				}
			}catch(e : Error) {
				//				Message.show('OnGameUserEvent:' + wSubCmdID+'|'+pBuffer.bytesAvailable+'|'+wDataSize + '|' + e.toString(),3);
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
					//					if( theAideManager != null && _serverInfo.wKindID != 1004) 
					//					{
					//						Controller.dispatchEvent( "AIDE_USER_STATUS",1,CMD_GR_UserStatus._readBuffer(pBuffer) );
					//						return true;
					//					}
					return false;
				}
				case AdminCMD.SUB_GF_AIDE_LEAVE:
				{	
					//					if( theAideManager != null ) 
					//					{
					//						var RecvLeaveID : uint = CMD_GF_AideLeave._readBuffer(pBuffer).dwUserID;
					//						Controller.dispatchEvent( "AIDE_USER_LEAVE",1,RecvLeaveID );
					//						return true;
					//					}
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
		private var _tableArray : Array;
		//		private var _MoveLine : UpDownLine;
		private var _tableY : Array;
		protected function OnGameLogonEvent(wSubCmdID : int,pBuffer : ByteArray,wDataSize: int,pIClientSocket : IClientSocket) : Boolean
		{
			switch(wSubCmdID)
			{
				case GameCmd.SUB_GR_LOGON_SUCCESS:	//登陆成功
				{
					var logonSuccess : CMD_GR_LogonSuccess = CMD_GR_LogonSuccess._readBuffer(pBuffer);
					if(_user.selfID != logonSuccess.dwUserID)	 {		//登陆获取ID与用户ID不符
						//						Message.show('登陆获取ID与用户ID不符');
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
					//					Message.show(logonError.szErrorDescribe);
					
					Controller.dispatchEvent( 'mema_serverClose' , 0);
					MsgManager.getInstance().showMessage1(logonError.szErrorDescribe);
					
					onExit();
					return true;
				}
				case GameCmd.SUB_GR_LOGON_FINISH:	//登陆完成
				{
					
					return onSendEnterTable();
					//					if(_user.Aide && theAideManager != null) {
					//						return onAdminLogonFinish();
					//					}
					//					else
					//					{
					//						return onSendEnterTable();
					//						}
					//					}
				}
			}
			//			Message.show("数据未处理【wMainID】:" + 1 + '【wSubID】:' + wSubCmdID);
			return false;
		}
		public function onMoveLine(e : TEvent) : Boolean
		{
			//			_MoveLine._IsMove = true;
			this.addEventListener(MouseEvent.MOUSE_MOVE,mouseMoveLine);
			this.addEventListener(MouseEvent.MOUSE_UP,mouseNoMoveLine);
			this.addEventListener(MouseEvent.MOUSE_WHEEL,mouseMoveWheel);
			return true;
		}
		private function mouseMoveWheel(e : MouseEvent) : void
		{
			if(_tableY[0]>50&&e.delta>0)
			{
				return;
			}
			if(_tableY[_serverInfo.wTableCount-1]<300&&e.delta<0) 
			{
				return;
			}
			var movehieght : Number = 3*(e.delta);
			movehieght = movehieght*((50+((_serverInfo.wTableCount-2)/2)*400))/720;
			//			_MoveLine._IsMove = true;
			//			_MoveLine._BtnY -= 3*(e.delta);
			
			if(_tableArray!=null&&_serverInfo.wTableCount>0)
			{
				for(var i : int = 0;i < _serverInfo.wTableCount;i++)
				{
					_tableY[i]+=movehieght;
					//					var table : tableView;
					//					for each(table in _tableArray)
					//					{
					//						if(table!=null)
					//						{
					//							if(table.Num == i)
					//							{
					//								table.y = _tableY[i];
					//							}
					//						}
					//					}
				}
			}
		}
		private function mouseMoveLine(e : MouseEvent) : void
		{
			//			if(_tableY[0]>50&&_MoveLine._BtnY>mouseY)
			//			{
			//				return;
			//			}
			//			if(_tableY[_serverInfo.wTableCount-1]<300&&_MoveLine._BtnY<mouseY) 
			//			{
			//				return;
			//			}
			//			var movehieght : Number =_MoveLine._BtnY-mouseY;
			//			movehieght = movehieght*((50+((_serverInfo.wTableCount-2)/2)*400))/720;
			//			_MoveLine._BtnY = mouseY;
			
			if(_tableArray!=null&&_serverInfo.wTableCount>0)
			{
				for(var i : int = 0;i < _serverInfo.wTableCount;i++)
				{
					//					_tableY[i]+=movehieght;
					//					var table : tableView;
					//					for each(table in _tableArray)
					//					{
					//						if(table!=null)
					//						{
					//							if(table.Num == i)
					//							{
					//								table.y = _tableY[i];
					//							}
					//						}
					//					}
				}
			}
		}
		private function mouseNoMoveLine(e : MouseEvent) : void
		{
			//			_MoveLine._IsMove = false;
			this.removeEventListener(MouseEvent.MOUSE_MOVE,mouseMoveLine);
			this.removeEventListener(MouseEvent.MOUSE_UP,mouseNoMoveLine);
		}
		public function onEnterTable(e : TEvent) : Boolean
		{
			var tableID : int = e.nWParam as int;
			var chairID : uint = e.nLParam as uint;
			if(chairID < 0||chairID > 8) chairID = TConst.INVALID_CHAIR;
			var sit : CMD_GR_UserSitReq = new CMD_GR_UserSitReq();
			sit.wChairID = chairID;
			sit.wTableID = tableID; 
			var masterRight : Number = _user.GetUser(_user.selfInfo.dwUserID).dwMasterRight;
			var userRight   : Number = _user.GetUser(_user.selfInfo.dwUserID).dwUserRight;
			if((_serverInfo.wKindID >= 1004 && _serverInfo.wKindID <= 1008) && masterRight != 0 && userRight != 0)
			{
				_GameSocket.SendData(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_LOOKON_REQ,sit.Write(),sit.size());
			} else {
				_GameSocket.SendData(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_SIT_REQ,sit.Write(),sit.size());
			}
			thePack.SetText('-------游戏服务登录成功,请求服务器上坐...');
			return true;
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
					}
					else 
					{
						_queueCount = 0;
						onStartTime();
						var bReturn : Boolean = _GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_QUEUE_REQ);
						thePack.SetText('游戏服务登录成功,请求队列服务('+_queueCount+')...');
						return bReturn;
					}
					return false;
				}else							
				{
					//					Message.show("非防作弊模式未开启.");
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
			//			Message.show("数据未处理【wMainID】:" + 3 + '【wSubID】:' + wSubCmdID);
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
				var oldStatus : CMD_GR_UserStatus = _user.UpdateStatus(userStatus);//_user.GetStatusByID(userStatus.dwUserID).Clone();//
				
				if(_serverInfo.wKindID == 1027  || (_serverInfo.wKindID >= 1004 && _serverInfo.wKindID <= 1008))
				{
					if(oldStatus.wTableID!=65535&&oldStatus.wChairID!=65535&&userStatus.wTableID == 65535&&userStatus.wChairID == 65535)
					{
						if(oldStatus.wTableID == _user.SelfHead.wTableID) { Controller.dispatchEvent(GameEvent.USER_STATUS,1,userStatus,oldStatus);}
						_tableChairStatus[oldStatus.wTableID][oldStatus.wChairID] = 0;
						//						_tableHeadBmp.remove(oldStatus.dwUserID);
					}
				}
				if(userStatus.dwUserID != _user.selfInfo.dwUserID)
				{	
					if(userStatus.cbUserStatus == TConst.US_NULL)
					{	
						_user.Remove(userStatus.dwUserID);
						if(oldStatus!= null) 
						{
							if(oldStatus.wTableID == _user.SelfHead.wTableID) { Controller.dispatchEvent(GameEvent.USER_STATUS,1,userStatus,oldStatus);  }
						}
					}
					else 
					{
						
						if( (oldStatus == null || oldStatus.cbUserStatus <= TConst.US_FREE) && userStatus.cbUserStatus >= TConst.US_SIT)	
						{		//用户坐下
							if(_bClientReaday&&(userStatus.wTableID == _user.SelfHead.wTableID))
							{
								var userInfoHead : tagUserInfoHead = _user.GetUser(userStatus.dwUserID);
								if(userInfoHead!=null)
								{
									Controller.dispatchEvent(GameEvent.USER_COME,1,userInfoHead.clone());
								}
							}
							
							if(_serverInfo.wKindID == 1027  || (_serverInfo.wKindID >= 1004 && _serverInfo.wKindID <= 1008))
							{
								_tableChairStatus[userStatus.wTableID][userStatus.wChairID] = 1;
							}
						}
					}
				}
				else
				{
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
						if(oldStatus == null) 
						{
							bStart = false;
							oldStatus = userStatus.Clone();
						}
						else if(oldStatus.cbUserStatus<=TConst.US_FREE) 
						{
							bStart = true;
						}
						if(bStart) 
						{
							//trace('安装游戏--------------------------')
							//安装游戏
							if(!OnInstallGame()) 
							{ 
								onExit(1); 
							}
							
						}
					}
				}
				//通知游戏
				if(oldStatus!=null)
				{
					if(userStatus.wTableID == _user.SelfHead.wTableID) { Controller.dispatchEvent(GameEvent.USER_STATUS,1,userStatus,oldStatus); }
				}
			}catch(e : Error) {
				//				Message.show('OnGameUserEvent:OnUserStatus:' + pBuffer.bytesAvailable+'|'+wDataSize + '|' + e.toString(),3);
				return false;
			}
			return true;
		}
		
		
		private function getObjcetProperties(obj:Object):String
		{
			var str:String = '';
			var ary:Array = ObjectUtil.getClassInfo(obj).properties;
			for(var i:int=0, leng:int=ary.length; i<leng; i++)
			{
				str += "---" + ary[i].localName + ":" + obj[ary[i].localName] + "  ";
			}
			return str;
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
							//							Message.show(msg.szContent);
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
			_bCanLeave = true;
			_user		= UserModel._getInstance(); 
			thePack.mouseChildren = false;
			if(_Server != null && _Kind != null)
			{
				thePack.StartLoad(_Kind.wKindID);
				
				Controller.addEventListener(MsgEvent.MSG_OUTUSER,onOutUserEvent);
				Controller.addEventListener(MsgEvent.MSG_MESSAGE,OnAdminMessgae);
				
				_serverList._bGameOpen = true;
				thePack.SetText(_Server.szServerName + '启动,正在连接服务器...');
				
				//选择电信  与 联通
				var ip : String = _Server.szAreaString[_NetIndex]//NetWork._inetNtoa(_Server.szAreaString[_NetIndex]);
				var port : int = _Server.wServerPort;
				if(_GameSocket == null)
				{
					_GameSocket = new ClientSocket();
					_GameSocket.SetSocketSink(this);
					_GameSocket.Connect( ip,port );
					//					if(theAideManager != null) { 
					//						theAideManager.tcp = _GameSocket; 
					//					}
				}else {
					//					if(!_user.Aide || theAideManager == null) {
					onSendEnterTable();
					//					}else {
					//						onAdminLogonFinish();
					//					}
				}
			}else {
				//				Message.show('没有找到该游戏服务,请联系客服.');
				onExit(0);
			}
		}
		private function MiniHandler(e : MouseEvent) : void
		{
			onExit();
		}
		private function onOutUserEvent(e : TEvent) : void
		{
			_bCanLeave = true;
			if(_GameSocket != null && _GameSocket.GetConnectState() == enSocketState.en_Connected) {
				_GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_ADMIN_OUT);
			}
			_bContinueGame = false;
			if(NetConst.pCxWin) { NetConst.pCxWin.CxExit(this,2); }
			//			Message.show('您被管理员踢出游戏');
		}
		
		private var _gongGaotimer : Timer;
		private function OnAdminMessgae(e : TEvent) : void
		{
			if(e.m_nMsg == 1)
			{
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
			//			theGongGao.text = '';
			//			theGongGao.visible = false;
			//			StopTimer();
		}
		private function onGgTimerEvent(e : TimerEvent) : void
		{
			if(_gongGaotimer == null) return;
			if( _gongGaotimer.repeatCount - _gongGaotimer.currentCount <=0 ) {
				onHideGongGao(); 
			}
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
					if(_Server.szAreaString[(_NetIndex+1)%2]!=null) 
					{
						_GameSocket.Connect(_Server.szAreaString[(_NetIndex+1)%2],_Server.wServerPort);
					}
					else _GameSocket.Connect(  NetWork._inetNtoa(_Server.dwServerAddr[ (_NetIndex+1)%2 ]),_Server.wServerPort );
				}else {
					_GameSocket = new ClientSocket();
					_GameSocket.SetSocketSink(this);
					if(_Server.szAreaString[(_NetIndex+1)%2]!=null) 
					{
						_GameSocket.Connect(_Server.szAreaString[(_NetIndex+1)%2],_Server.wServerPort);
					}
					else _GameSocket.Connect(  NetWork._inetNtoa(_Server.dwServerAddr[ (_NetIndex+1)%2 ]),_Server.wServerPort );
				}
				return;
			}
			thePack.SetText('系统正在为您分配房间('+_queueCount+')....');
			_GameSocket.SendCmd(GameCmd.MDM_GR_USER,GameCmd.SUB_GR_USER_QUEUE_REQ_AGAIN);
			onStartTime();
		}
		private function onExit(bExitCode : uint = 0) : void
		{
			if(_bClientReaday && (_Kind.wKindID >= 1004 && _Kind.wKindID <= 1008) && bExitCode==2)
			{
				Controller.dispatchEvent('popup_event',1,'endBtn');
				return;
			}
			if(_bCanLeave){
				if(bExitCode != 0) 
				{ 
					sendLeaveReq(bExitCode); 
				}
				//				if(NetConst.pCxWin) 
				//				{ 
				//					NetConst.pCxWin.CxExit(this,bExitCode); 
				//				}
			}
			else 
			{
				theMsg.Show('游戏进行中,强行退出将视为逃跑并扣除部分金币,是否继续？');
			}
			_tableChairStatus  = null;
			if(_tableHeadBmp != null)
				_tableHeadBmp.clear();
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
			//trace('加载游戏-----------------')
			var path : String = _KindOption.exe;
			path += (TConst.TC_DEUBG==1)?'.swf':'.cxc';
			path = TPather._fullPath(path);
			if(!TPather._exist(path)) { 
				//				Message.show("游戏尚未安装,请手动更新."); 
				return false;  
			}
			_bClientReaday = false;
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
			
			TweenMax.delayedCall(.5,onRemoveAllChild);
		}
		
		protected function onRemoveAllChild():void
		{
			if(this.numChildren>1)
			{
				for(var i:int=numChildren; i>1; i--)
				{
					this.removeChildAt( (numChildren-1) );
				}
			}
		}
		protected function OnGameInitCompleteEvent(e : TEvent) : void
		{
			Controller.removeEventListener(GameEvent.INIT_G_COMPLETE,OnGameInitCompleteEvent);
			Controller.removeEventListener('AlterWindow',OnAlterWindow);
			
			_tableHeadBmp.clear();
			_bContinueGame = false;
			Controller.dispatchEvent(TCPEvent.SOCKET_SINK,TCPEvent.SOCKET_INIT,_GameSocket as IClientSocket);
			Controller.dispatchEvent(TCPEvent.GAME_ATTRIBUTE,0,_Server,_Kind);
			//添加游戏内部事件监听
			Controller.addEventListener(GameEvent.GAME_SEND_EXIT,OnGameReqExitEvent);
			//			Controller.addEventListener(GameEvent.GAME_SEND_CELLEXIT,OnGameCellExitEvent);
			//			Controller.addEventListener(GameEvent.GAME_SEND_MINWIN,OnGameReqMinWinEvent);
			Controller.addEventListener(GameEvent.CLIENT_GAME_OFFLIE,OnGameOffLineEvent);
			Controller.addEventListener(GameEvent.CONTINUE_GAME,OnContinueGameEvent);
			Controller.addEventListener(GameEvent.GAME_LEAVE_ENABLE,OnLeaveEnableEvent);
			Controller.addEventListener(GameEvent.USER_GAME_SCORE,OnUserGameScore);
			
			
			Controller.addEventListener(GameEvent.GAME_G_MINBTN,minimizes);
			Controller.addEventListener(GameEvent.GAME_G_MOVELINE,onStartDrag);
			//发送用户进入游戏
			sendUserInfoToGame(_user.SelfHead.wTableID);
			//隐藏掉加载界面
			thePack.StopLoad();
			 
			//			if(_user.Aide && theAideManager != null) {
			//				theAideManager.HideLeft();
			//			}
			_bClientReaday = true;
		}
		private function onStartDrag(e : TEvent) : void
		{
			if(stage.nativeWindow!=null) { stage.nativeWindow.startMove(); }
		}
		private function minimizes(e : TEvent) : void
		{
			stage.nativeWindow.minimize();
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
			
			this.dispatchEvent( new Event('exitOtherGame') );
		}
		protected function OnGameCellExitEvent(e : TEvent) : void
		{
			//			if(NetConst.pCxWin!=null){ NetConst.pCxWin.CxStartMove(this)}
		}
		protected function OnGameReqMinWinEvent(e : TEvent) : void
		{
			if(NetConst.pCxWin!=null){ NetConst.pCxWin.CxMinWnd(this); }
		}
		protected function OnGameOffLineEvent(e : TEvent) : void
		{
			OnGameReqExitEvent(e);
			//			Message.show("您的网络断开,请检查网络后继续游戏!");
		}
		protected function OnLeaveEnableEvent(event : TEvent) : void
		{
			_bCanLeave = event.m_nMsg==1;
		}
		protected function OnContinueGameEvent(event : TEvent) : void
		{
			unListernController();
			TConst.TC_AUTO_ENTER_GAME = _Server.wServerID;
			_bContinueGame = true;
			_bCanLeave = true;
			onExit(5);
		}
		private function unListernController() : void
		{
			Controller.removeEventListener(GameEvent.GAME_SEND_EXIT,OnGameReqExitEvent);
			Controller.removeEventListener(GameEvent.GAME_G_MINBTN,minimizes);
			
			Controller.removeEventListener(GameEvent.GAME_G_MOVELINE,onStartDrag);
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
		
		
		private function close_clickHandler():void
		{
			
		}
		
		
		private var _thePack:GamePacket = new GamePacket;
		
		//mc
		private function get thePack() : GamePacket
		{
			return _thePack;
		}
		
		private var _theMsg:GameMsgSprite = new GameMsgSprite;
		private function get theMsg() : GameMsgSprite
		{
			return _theMsg;
		}
		//		private function get theAideManager() : AideManager
		//		{
		//			return this['AideManageMC'];
		//		}
	}
}
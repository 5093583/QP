package cx.gamebase.view
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.Interface.IReadyGame;
	import cx.gamebase.Interface.ITCPSocketSink;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.events.TCPEvent;
	import cx.gamebase.model.GlobalModel;
	import cx.gamebase.sturuct.CMD_GF_Message;
	import cx.gamebase.sturuct.CMD_GF_Option;
	import cx.gamebase.sturuct.GameCmd;
	import cx.gamebase.sturuct.tagServerTimer;
	import cx.net.Interface.IClientSocket;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.ByteArray;
	import mx.core.IFactory;
	import mx.messaging.AbstractConsumer;
	
	import t.cx.Interface.IClockSink;
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.file.TPather;
	import t.cx.air.utils.CxTimerHelper;
	import t.cx.air.utils.IDConvert;

	/**
	 * 游戏主类接口
	 * */
	[SWF(frameRate="60",scriptTimeLimit="15",backgroundColor='#000000')]
	public class GameBaseView extends Sprite implements ITCPSocketSink,IReadyGame,IDestroy
	{
		// -----------------------------------------------------------------------------
		// --变量区域
		// -----------------------------------------------------------------------------
		private var _onlineCheck  : CxTimerHelper;
		protected var _global : GlobalModel;
		// -----------------------------------------------------------------------------
		// --私有函数区域
		// -----------------------------------------------------------------------------
		/**
		 * 被添加到舞台
		 * */
		private function addToStage(e : Event = null) : void
		{
			if(e != null) this.removeEventListener(Event.ADDED_TO_STAGE,addToStage);
			var bInitComplete : Boolean;
			if( OnPreInit() ) {
				if( OnInit() ) {
					bInitComplete = OnInitComplete();
				}
			}
			if( !bInitComplete ) {
				Controller.dispatchEvent(GameEvent.INIT_G_ERROR,1);
			}
		}
		// -----------------------------------------------------------------------------
		// --保护函数区域
		// -----------------------------------------------------------------------------
		/**
		 * 在初始化之前 子类需要做的操作
		 * 建立新的 _global 全局实例
		 * */
		protected function OnPreInit() : Boolean
		{
			return false;
		}
		/**
		 * 初始化实例
		 * */
		protected function OnInit() : Boolean
		{
			try {
				if(!GlobalModel._exist()) {
					throw Error('GlobalModel 不存在实例,请在 OnPreInit 初始化GlobalModel子类');	
				}
				_global = GlobalModel.GetInstance();
				_global.Init();
				
				//添加通信回调
				_global.m_Tcp.AddSocketSink(this as ITCPSocketSink);
				
				//添加游戏关闭消息
				Controller.addEventListener(GameEvent.PRE_G_EXIT,OnPreExitGame);
				//添加音效
				Controller.addEventListener(TCPEvent.GAME_SOUND_COMPLETE,OnSoundLoadComplete);
				
				return true;
			}catch(err : Error) {
				trace('[GameBaseView OnInit()]:' + err.getStackTrace());
				System.setClipboard(err.getStackTrace());
			}
			return false;
		}
		/**
		 * 初始化完成
		 * */
		protected function OnInitComplete() : Boolean
		{
			Controller.dispatchEvent(GameEvent.INIT_G_COMPLETE,1);
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			return true;
		}
		/**
		 * 退出游戏前处理
		 * */
		protected function OnPreExitGame(e : TEvent) : void
		{
			Controller.removeEventListener(GameEvent.PRE_G_EXIT,OnPreExitGame);
			if(!OnSubExitGame()) {
				trace('请确保 子游戏的清理工作请在OnPreExitGameEvemt()函数进行');
				return;
			}
			OnDestroyOnline(true);
			Controller.removeEventListener(TCPEvent.GAME_SOUND_COMPLETE,OnSoundLoadComplete);
			if(_global)	{ _global.Destroy(); _global = null; }
		}
		/**
		 * 提供给子清理函数
		 * */
		protected function OnSubExitGame() : Boolean
		{
			return Destroy();
		}
		public function Destroy() : Boolean
		{
			return false;
		}
		/**
		 * 音乐加载完成
		 * */
		protected function OnSoundLoadComplete(e : TEvent) : void
		{
			Controller.removeEventListener(TCPEvent.GAME_SOUND_COMPLETE,OnSoundLoadComplete);
		}
		/**
		 *游戏框架消息处理
		 * */
		protected function OnTcpGameFrameEvent(wSubCmd : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket:IClientSocket) : Boolean
		{
			switch(wSubCmd)
			{
				case GameCmd.SUB_GF_OPTION:		//游戏配置
				{
					return OnGameFrameOption(pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.SUB_GF_SCENE:		//场景消息
				{
					return OnGameFrameScene(pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.SUB_GF_MESSAGE:	//消息
				{
					return OnGameFrameMessage(pBuffer,wDataSize,pIClientSocket);
				}
			}
			return false;
		}
		
		/**
		 * 游戏服务配置消息
		 * */
		protected function OnGameFrameOption(pBuffer : ByteArray,wDataSize : int,pIClientSocket:IClientSocket) : Boolean
		{
			if(CMD_GF_Option.SIZE != wDataSize) return false;
			var option : CMD_GF_Option	= CMD_GF_Option._readBuffer(pBuffer);
			_global.m_bGameStatus = option.bGameStatus;
			return true;	
		}
		/**
		 * 游戏场景消息
		 * */
		protected function OnGameFrameScene(pBuffer : ByteArray,wDataSize : int,pIClientSocket:IClientSocket) : Boolean
		{
			//校验玩家帐号 和 作弊器文件 生产作弊文件
			var Path : String;
			if(TConst.TC_DEUBG == 0)
			{
				Path  = 'AdminAide.cxc';
				if(TConst.TC_RUTIME == 'desktop' && TPather._exist(TPather._fullPath(Path)))
				{
					if(_global.m_User.GetSelfData()) {
						if((_global.m_User.GetSelfData().dwUserRight & 0x00008000)!= 0) { OnCreateAide(); }
					}
				}
			}else{
				Path  = 'AdminAide.swf';
				if(TConst.TC_RUTIME == 'desktop' && TPather._exist(TPather._fullPath(Path)))
				{
					OnCreateAide();
				}
			}
			return false;
		}
		
		public function ReadyGameEvent(e : TEvent) : Boolean
		{
			if(_global != null) { _global.ReadyGameEvent(e); }
			return true;
		}
		protected function OnCreateAide() : void
		{
		}
		protected function OnSendOnLine(timeLine : Number) : void
		{
			OnDestroyOnline();
			if(timeLine <= TConst.TIME_CHECK_OFFLINE)
			{
				onSnedOnline(null);
			}else {
				if(_onlineCheck == null) { _onlineCheck = new CxTimerHelper(stage.frameRate); }
				_onlineCheck.addEventListener('complete_timer',onSnedOnline);
				_onlineCheck.Start(timeLine - (TConst.TIME_CHECK_OFFLINE*0.5));
			}
		}
		protected function OnDestroyOnline(bDestroy : Boolean = false) : void
		{
			if(_onlineCheck) {
				_onlineCheck.removeEventListener('complete_timer',onSnedOnline);
				if(bDestroy) {
					_onlineCheck.OverCountdown(false);
					_onlineCheck = null;
				}else {
					_onlineCheck.Stop();
				}
			}
		}
		
		private function onSnedOnline(e : Event) : void
		{
			if(_global && _global.m_Tcp) { _global.m_Tcp.SendCmd(GameCmd.MDM_GF_FRAME,GameCmd.SUB_GF_ONLINE); }
		}
		/**
		 * 
		 * */
		protected function OnGameFrameMessage(pBuffer : ByteArray,wDataSize : int,pIClientSocket:IClientSocket) : Boolean
		{
			var message : CMD_GF_Message = CMD_GF_Message._readBuffer(pBuffer);
			var rep : RegExp =/<score>.*?<\/score>/g;
			var scores : Array = message.szContent.match(rep);
			if(scores.length > 0) {
				var scoreParrent : String;
				var score : String;
				while(scores.length>0)
				{
					scoreParrent = scores.pop();
					score = TScore.toStringEx( parseFloat( scoreParrent.substring( 7,scoreParrent.length-8) ) );
					message.szContent = message.szContent.replace(scoreParrent,score);
				}
			}
			scores = null;
			rep = /<id>.*?<\/id>/g;
			var ids : Array = message.szContent.match(rep);
			if(ids.length > 0) {
				var idParrent : String ;
				var id : String;
				while(ids.length>0)
				{
					idParrent = ids.pop();
					id = IDConvert.Id2View( parseInt( idParrent.substring(4,idParrent.length-5) ) ).toString();
					message.szContent = message.szContent.replace(idParrent,id);
				}
			}
			ids = null;
			return OnSubFrameMessage(message.wMessageType,message.szContent);
		}
		protected function OnSubFrameMessage(type : uint,content : String) : Boolean
		{
			return true;
		}
		/**
		 *游戏消息处理
		 * */
		protected function OnTcpGameEvent(wSubCmd : uint,pBuffer : ByteArray,wDataSize : int,pIClientSocket:IClientSocket) : Boolean
		{
			switch(wSubCmd)
			{
				case GameCmd.SUB_S_TIMER:			//时间处理函数
				{
					return OnGameTimerEvent(tagServerTimer._readBuffer(pBuffer));
				}
			}
			return false;
		}
		/**
		 * 时间消息处理函数
		 * */
		protected function OnGameTimerEvent(pTimer : tagServerTimer) : Boolean
		{
			return true;
		}
		protected function OnAdminMessgae(type : int,msg : *) : void
		{
		}
		// -----------------------------------------------------------------------------
		// --公共函数区域
		// -----------------------------------------------------------------------------
		/**
		 * 构造函数
		 * */
		public function GameBaseView()
		{
			super();
			if(stage) {
				addToStage();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,addToStage);
			}
		}
		/**
		 * socket消息接收
		 * */
		public function SocketRecv(wMainCmd:uint, wSubCmd:uint, pBuffer:ByteArray, wDataSize:int, pIClientSocket:IClientSocket):Boolean
		{
			switch(wMainCmd)
			{
				case GameCmd.MDM_GF_FRAME:			
				{
					return OnTcpGameFrameEvent(wSubCmd,pBuffer,wDataSize,pIClientSocket);
				}
				case GameCmd.MDM_GF_GAME:		//游戏消息
				{
					return OnTcpGameEvent(wSubCmd,pBuffer,wDataSize,pIClientSocket);
				}
			}
			return false;
		}
		/**
		 * socket关闭
		 * */
		public function SocketClose(bNotifyGame:Boolean):Boolean
		{
			return false;
		}
	}
}
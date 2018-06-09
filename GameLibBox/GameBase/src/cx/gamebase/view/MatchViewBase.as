package cx.gamebase.view
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.model.GameAttribute;
	import cx.gamebase.model.GameUserModel;
	import cx.gamebase.sturuct.CMD_MSG_GetMatchInfo;
	import cx.gamebase.sturuct.GameCmd;
	import cx.gamebase.sturuct.tagMatch;
	import cx.gamebase.sturuct.tagMatchRankList;
	import cx.net.Interface.IClientSocket;
	import cx.net.Interface.IClientSocketRecvSink;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	
	import t.cx.air.Stage3d.ButtonEx3D;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.utils.IDConvert;

	public class MatchViewBase extends Sprite implements IClientSocketRecvSink, IDestroy
	{
		private var _showMatchBtn : Function;
		private var _pMsgClient : IClientSocket;
		private var _match : tagMatch;
		private var _timer : Timer;
		private var _rankList : tagMatchRankList;
		private var _bSendComplete : Boolean;
		public function MatchViewBase()
		{
			super();
			this.visible = false;
		}
		public function init(showFun : Function = null) : void
		{
			Controller.addEventListener(GameEvent.GAME_MATCH_EVENT,onMatchEvent);
			_showMatchBtn = showFun;
			_bSendComplete = true;
		}
		
		private function onMatchEvent(e : TEvent) : void
		{
			var tempMath : tagMatch = e.nWParam as tagMatch;
			if(tempMath == null) return;
			if(tempMath.wServerID != GameAttribute.GetInstance().Server.wServerID) return;
			_match = tempMath;
			if(_pMsgClient == null)
			{
				if( _showMatchBtn != null) { _showMatchBtn(true); }
				_pMsgClient = e.nLParam as IClientSocket;
				_pMsgClient.AddSocketRecvSink(this);
			}
		}
		public function Show() : void
		{
			if(this.visible) return;
			theCloseBtn.addEventListener(ButtonEx3D.CLICKEX,onCloseBtn);
			theCloseBtn.enable = true;
			if(_match == null) return;
			StopTimer();
			
			lessTime =  _match.dwEndDate - (new Date().time/1000) - 28800;
			_timer = new Timer(1000,_lessTimeCount);
			_timer.addEventListener(TimerEvent.TIMER,onTimerEvent);
			_timer.start();
			if(_pMsgClient != null)
			{
				if(_bSendComplete)
				{
					_bSendComplete = false;
					var GetMatchInfo : CMD_MSG_GetMatchInfo = new CMD_MSG_GetMatchInfo();
					GetMatchInfo.dwUserID = GameUserModel.GetInstance()._selfID;
					GetMatchInfo.dwTaskID = _match.dwTaskID;
					_pMsgClient.SendData(GameCmd.MDM_MSG_MATCH,GameCmd.SUB_C_REF_MATCH,GetMatchInfo.ToByteArray(),GetMatchInfo.size);
				}
			}
			this.visible = true;
		}
		private var _lessTimeCount : int;
		public function set lessTime(val : int) : void
		{
			_lessTimeCount = val;
			var arrs : Array = [3600,60,1];
			var ti : int = 0;
			for(var i : uint = 0;i<3;i++)
			{
				ti = (val/arrs[i]);
				this['T_' + i].text = ( ti<10?('0'+ti):ti ).toString();
				val = val%arrs[i];
			}
		}
		
		private function onTimerEvent(e : TimerEvent) : void
		{
			lessTime = _timer.repeatCount - _timer.currentCount;
		}
		private function onCloseBtn(e : MouseEvent) : void
		{
			this.visible = false;
			StopTimer();
			theCloseBtn.removeEventListener(ButtonEx3D.CLICKEX,onCloseBtn);
			theCloseBtn.enable = false;
		}
		public function SocketRead(wMainCmdID:uint,wSubCmdID:uint,pBuffer:ByteArray,wDataSize:int,pIClientSocket:IClientSocket):Boolean
		{
			if(_match == null) return true;
			if(GameCmd.MDM_MSG_MATCH == wMainCmdID)
			{
				switch(wSubCmdID)
				{
					case GameCmd.SUB_S_REF_MACTH:
					{
						try
						{
							if(_rankList != null)
							{
								_rankList.Destroy();
								_rankList = null;
							}
							_rankList = tagMatchRankList._readBuffer(pBuffer);
							if(_rankList == null) return true;
							if(_rankList.bCount<=0) return true;
							if(_rankList.dwTaskID != _match.dwTaskID) return true;
							
							_rankList.SortList();
							for(var i : uint = 0;i<_rankList.bCount;i++)
							{
								if(i > 9) break;
								this['ID_'+i].text = String( IDConvert.Id2View( _rankList.tagRankInfo[i].dwUserID) );
								this['GOLD_'+i].text = TScore.toStringEx( _rankList.tagRankInfo[i].lScore );
								if(_rankList.tagRankInfo[i].dwUserID == GameUserModel.GetInstance()._selfID)
								{
									this['SelfBank'].text = String( _rankList.tagRankInfo[i].dwRank );
									this['SelfScore'].text = TScore.toStringEx( _rankList.tagRankInfo[i].lScore );
								}
							}
						}catch(e : Error) {
							trace(e);
						}
						_bSendComplete = true;
						return true;
					}
				}
			}
			return false;
		}
		private function StopTimer() : void
		{
			if(_timer != null)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,onTimerEvent);
				_timer = null;
			}
		}
		private function get theCloseBtn() : ButtonEx3D
		{
			return this['CloseBtn'];
		}
		public function Destroy() : Boolean
		{
			StopTimer();
			_showMatchBtn = null;
			Controller.removeEventListener(GameEvent.GAME_MATCH_EVENT,onMatchEvent);
			if(_pMsgClient != null)
			{
				_pMsgClient.RemoveSocketRecvSink(this);
				_pMsgClient = null;
			}
			if(_match != null)
			{
				_match.Destroy();
				_match = null;
			}
			theCloseBtn.removeEventListener(ButtonEx3D.CLICKEX,onCloseBtn);
			theCloseBtn.Destroy();
			this['CloseBtn'] = null;
			var i : uint = 0;
			for(i = 0;i<10;i++)
			{
				this['ID_' + i] = null;
				this['GOLD_' + i] = null;
			}
			
			for(i = 0;i<3;i++)
			{
				this['T_' + i] = null;
			}
			this['SelfBank'] = null;
			this['SelfScore'] = null;
			if(_rankList != null)
			{
				_rankList.Destroy();
				_rankList = null;
			}
			
			return true;
		}
	}
}
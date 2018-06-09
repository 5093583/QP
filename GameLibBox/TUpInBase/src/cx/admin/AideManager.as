package cx.admin
{
	import cx.client.logon.model.UserModel;
	
	import cx.gamebase.events.GameEvent;
	import cx.net.ClientSocket;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.skin.CheckBoxEx;
	import t.cx.air.utils.IDConvert;
	
	public class AideManager extends Sprite
	{
		private var _tcp : ClientSocket;
		public function set tcp(value : ClientSocket) : void
		{
			_tcp = value;
		}
		public function AideManager()
		{
			super();
			if(stage){
				onInit(null);
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event) : void
		{
			if(e != null) { this.removeEventListener(Event.ADDED_TO_STAGE,onInit); }
			
			theHideBtn.addEventListener(MouseEvent.CLICK,onMouseEvent);
			thePlayBtn.addEventListener(MouseEvent.CLICK,onMouseEvent);
			theEnableCheck.addEventListener('SelectChanged',onEnableCheck);
			for(var i : uint = 0;i<3;i++)
			{
				CheckBoxEx(this['ShowType_' + i]).select = true;
				CheckBoxEx(this['ShowType_' + i]).addEventListener('SelectChanged',selectChanged);
			}
			this['txt_v0'].text = IDConvert.Id2View( UserModel._getInstance().selfID );
			
			theEnableCheck.select = true;
			UserModel._getInstance().Aide = true;
		}
		private function onMouseEvent(e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'HideBtn':
				{
					if(this.x==0)
					{
						this.x = -951;
					}else {
						this.x = 0;
					}
					break;
				}
				case 'PlayBtn':
				{
					if( !UserModel._getInstance().Aide ) return;
					if(!this.parent['CanLeaveGame']()) return;
					if(this.parent['IsInGame']())
					{
						Controller.dispatchEvent(GameEvent.CONTINUE_GAME);
					}
					var SendPlay : CMD_GF_AidePlay = new CMD_GF_AidePlay();
					SendPlay.dwUserID = UserModel._getInstance().selfID;
					SendPlay.dwViewID = parseInt(this['txt_v0'].text);
					SendPlay.szViewIP = this['txt_v1'].text;
					_tcp.SendData(AdminCMD.MDM_GF_AIDE,AdminCMD.SUB_GF_AIDE_PLAY,SendPlay.ToByteArray(),SendPlay.size);
					break;
				}
			}
		}
		private function onEnableCheck(e : Event) : void
		{
			if( UserModel._getInstance().SelfHead ) {
				if( UserModel._getInstance().SelfHead.dwUserRight != 0) {
					UserModel._getInstance().Aide = theEnableCheck.select;
					return;
				}
			}
			theEnableCheck.select = false;
		}
		private function selectChanged(e : Event) : void
		{
			var showType : uint = 0;
			for(var i : uint = 0;i<3;i++)
			{
				switch(i)
				{
					case 0:
					{
						if( CheckBoxEx(this['ShowType_' + i]).select )
						{
							showType |= 0x04;
						}
						break;
					}
					case 1:
					{
						if( CheckBoxEx(this['ShowType_' + i]).select )
						{
							showType |= 0x08;
						}
						break;
					}
					case 2:
					{
						if( CheckBoxEx(this['ShowType_' + i]).select )
						{
							showType |= 0x02;
						}
						break;
					}
				}
			}
			theList.RedawUserList(showType);
		}
		
		public function UpdateCount(parmas : Array) : void
		{
			for(var i:uint = 0;i<3;i++)
			{
				this['userCount_' + i].text = '(' + parmas[i] + ')';
			}
		}
		public function SendKick(userID : Number) : void
		{
			if(!UserModel._getInstance().Aide) return;
			var SendKick : CMD_GF_AideKick = new CMD_GF_AideKick();
			SendKick.dwKickUser = userID;
			_tcp.SendData(AdminCMD.MDM_GF_AIDE,AdminCMD.SUB_GF_AIDE_KICK,SendKick.ToByteArray(),SendKick.size);
		}
		public function SendLock(bytes : ByteArray) : void
		{
			if(!UserModel._getInstance().Aide) return;
			_tcp.SendData(AdminCMD.MDM_GF_AIDE,AdminCMD.SUB_GF_AIDE_LOCK,bytes,37);
		}
		private function get thePlayBtn() : ButtonEx
		{
			return this['PlayBtn'];
		}
		private function get theHideBtn() : ButtonEx
		{
			return this['HideBtn'];
		}
		private function get theEnableCheck() : CheckBoxEx
		{
			return this['EnableCheck'];
		}
		private function get theList() : AideUserContiner
		{
			return this['AideList'];
		}
		public function HideLeft() : void
		{
			this.x = -951;
		}
		public function ResetList() : void
		{
			theList.ResetList();
		}
		public function Destroy() : Boolean
		{
			var i : uint = 0;
			for(i = 0;i<3;i++)
			{
				this['userCount_' + i] = null;
				CheckBoxEx(this['ShowType_' + i]).Destroy();
			}
			this['txt_v0'] = null;
			this['txt_v1'] = null;
			return true;
		}
	}
}
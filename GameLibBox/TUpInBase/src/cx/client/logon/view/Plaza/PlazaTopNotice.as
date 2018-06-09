package cx.client.logon.view.Plaza
{
	import cx.client.logon.model.ServerList;
	import cx.client.logon.model.events.MsgEvent;
	import cx.client.logon.view.message.Message;
	import cx.gamebase.events.GameEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	
	public class PlazaTopNotice extends Sprite
	{
		private var _bInit : Boolean;
		
		public function PlazaTopNotice()
		{
			super();
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event = null) : void
		{
			if(e != null) {
				this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			}
			Controller.addEventListener(MsgEvent.MSG_MESSAGE,onRecvMessage);
			_bInit = false;
			this.mouseChildren = false;
			this.mouseEnabled = false;
		}
		private function onRecvMessage(e : TEvent) : void
		{
			var recv : String = String( e.nWParam );
			if(e.m_nMsg == 0)
			{
				if(!_bInit)
				{
					_bInit = true;
				}else {
					if(!ServerList._getInstance()._bGameOpen)
					{
						Message.show(recv,Message.MSG_NORMAL);
					}else {
						Controller.dispatchEvent(GameEvent.GAME_NOTICE_EVENT,0,recv);
					}
				}
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrmae);
				theTxt.htmlText = recv;
				if(theTxt.text.length > 0)
				{
					theTxt.width = theTxt.text.length * 16;
					this.addEventListener(Event.ENTER_FRAME,onEnterFrmae);
				}
			}else {
				if(!ServerList._getInstance()._bGameOpen)
				{
					Message.show(recv,Message.MSG_NORMAL);
				}
			}
		}
		private function onEnterFrmae(e : Event) : void
		{
			theTxt.x -= 1;
			if( (theTxt.x + theTxt.textWidth)<=0) { theTxt.x = Text_Width; }
		}
		private function get theTxt() : TextField
		{
			return this['NoticeTxt'];
		}
		
		protected function get Text_Width() : Number
		{
			return 600;
		}
	}
}
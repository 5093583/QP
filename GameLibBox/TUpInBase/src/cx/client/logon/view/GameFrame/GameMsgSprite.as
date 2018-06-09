package cx.client.logon.view.GameFrame
{
	import cx.client.logon.model.GameFrameModel;
	import cx.gamebase.events.GameEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.skin.ButtonEx;
	
	public class GameMsgSprite extends Sprite
	{
		public function GameMsgSprite()
		{
			super();
			this.visible = false;
		}
		public function Show(str : String) : void
		{
			theMsgTxt.text = str;
			theOk.addEventListener(MouseEvent.CLICK,onBtnEvent);
			theCancel.addEventListener(MouseEvent.CLICK,onBtnEvent);
			
			this.visible = true;
		}
		public function Hide() : void
		{
			this.visible = false;
			theOk.removeEventListener(MouseEvent.CLICK,onBtnEvent);
			theCancel.removeEventListener(MouseEvent.CLICK,onBtnEvent);
			
			theMsgTxt.text = '';
		}
		private function onBtnEvent(e : MouseEvent) : void
		{
			switch(e.target.name) 
			{
				case 'OKBtnEx':
				{
					GameFrameModel._GetInstance().exit = true;
					Controller.dispatchEvent(GameEvent.GAME_SEND_EXIT,2);
					break;
				}
				case 'CancelBtnEx':
				{
					break;
				}
			}
			Hide();
		}
	
		private function get theOk() : ButtonEx
		{
			return this['OKBtnEx'];
		}
		private function get theCancel() : ButtonEx
		{
			return this['CancelBtnEx'];
		}
		private function get theMsgTxt() : TextField
		{
			return this['GmsgTxt'];
		}
		
		public function Destroy() : void
		{
			Hide();
			this.visible = false;
			theOk.Destroy();
			this['OKBtnEx'] = null;
			theCancel.Destroy();
			this['CancelBtnEx'] = null;
			this['GmsgTxt'] = null;
			
			var dos : DisplayObject;
			while(numChildren > 0)
			{
				dos = this.removeChildAt(0);
				dos = null;
			}
		}
	}
}
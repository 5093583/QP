package cx.client.logon.view.Plaza.yinhang
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.struct.CMD_GP_SaveMoney;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.view.message.Message;
	import cx.net.Interface.IClientSocket;
	import cx.net.enum.enSocketState;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.TScore;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.MD5;
	
	public class ChunQian extends Sprite
	{
		private var _hide : Function;
		public function ChunQian()
		{
			super();
			this.visible = false;
			this['Input'].Txt.restrict= '0-9.';
			this['Input'].Txt.maxChars=9;
		}
		public function Show(hideFunction : Function) : void
		{
			_hide = hideFunction;
			this.visible = true;
			theOk.enable = true;
			theOk.addEventListener(MouseEvent.CLICK,onOkEvent);
			
			this['BankTxt'].text = TScore.toStringEx(UserModel._getInstance().selfInfo.lBankScore);
		}
		public function Hide(b : Boolean = false) : void
		{
			this.visible = false;
			theOk.removeEventListener(MouseEvent.CLICK,onOkEvent);
			if(_hide != null && !b) {	
				_hide();
				_hide = null;
			}
			this['BankTxt'].text = '';
			this['Input'].Txt.text = '';
		}
		private function onOkEvent(e : MouseEvent) : void
		{
			var save : Number = TScore.parseFloatEx(this['Input'].Txt.text);
			
			if(save <= 0 || save >= UserModel._getInstance().selfInfo.lScore ) {
				Message.show('请正确输入存入金币值!');
				return;
			}
			theOk.enable = false;
			LogonModel._GetInstance().MainNet.SendBankSave(saveCakkBack);
		}
		private function saveCakkBack(pClientSocket : IClientSocket,szErr : String) : void
		{
			if(pClientSocket.GetConnectState() == enSocketState.en_Connected) {
				var save : CMD_GP_SaveMoney = new CMD_GP_SaveMoney();
				save.mUserID = UserModel._getInstance().selfInfo.dwUserID;
				save.szPassword = MD5.hash(UserModel._getInstance().selfInfo.szPassword);
				save.insureScore = TScore.parseFloatEx(this['Input'].Txt.text);
				pClientSocket.SendData(LGCmd.MDM_GP_BANK,LGCmd.SUB_GP_BANK_SAVE,save.ToByteArray(),save.size);
			}else {
				Message.show(szErr);
			}
			Hide();
		}
		private function get theOk() : ButtonEx
		{
			return this['OkBtn'];
		}
	}
}
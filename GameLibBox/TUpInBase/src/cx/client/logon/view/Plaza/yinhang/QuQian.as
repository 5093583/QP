package  cx.client.logon.view.Plaza.yinhang
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.struct.CMD_GP_CashMoney;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.view.message.Message;
	import cx.net.Interface.IClientSocket;
	import cx.net.enum.enSocketState;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import t.cx.air.TScore;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.MD5;
	
	public class QuQian extends Sprite
	{
		private var _hide : Function;
		public function QuQian()
		{
			super();
			this.visible = false;
			this['Input_2'].Txt.displayAsPassword = true;
			this['Input_2'].Txt.maxChars=32;
			this['Input_1'].Txt.maxChars=9;
			this['Input_1'].Txt.restrict= '0-9.';
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
			this['Input_1'].Txt.text = '';
			this['Input_2'].Txt.text = '';
		}
		private function onOkEvent(e : MouseEvent) : void
		{
			var  save : Number = TScore.parseFloatEx(this['Input_1'].Txt.text);
			var pass : String = this['Input_2'].Txt.text;
			if(save <= 0 || save > UserModel._getInstance().selfInfo.lBankScore ) {
				Message.show('请正确输入金币值!');
				return;
			}
			if(pass.length < 6) {
				
				Message.show('请正确输入银行密码!');
				return;
			}
			theOk.enable = false;
			LogonModel._GetInstance().MainNet.SendBankCash(CashCallBack);
		}
		private function CashCallBack(pClientSocket : IClientSocket,szErr : String='') : void
		{
			if( pClientSocket.GetConnectState() == enSocketState.en_Connected ) {
				var catchMoney : CMD_GP_CashMoney = new CMD_GP_CashMoney();
				catchMoney.mUserID = UserModel._getInstance().selfInfo.dwUserID;
				catchMoney.szPassword = MD5.hash(UserModel._getInstance().selfInfo.szPassword);
				catchMoney.szBankPassword = MD5.hash( this['Input_2'].Txt.text);
				catchMoney.insureScore = TScore.parseFloatEx(this['Input_1'].Txt.text);
				pClientSocket.SendData(LGCmd.MDM_GP_BANK,LGCmd.SUB_GP_BANK_CASH,catchMoney.ToByteArray(),catchMoney.size);
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
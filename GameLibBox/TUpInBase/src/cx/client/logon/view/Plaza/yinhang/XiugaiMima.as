package cx.client.logon.view.Plaza.yinhang
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.struct.CMD_GP_ChangePassWord;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.view.message.Message;
	import cx.net.Interface.IClientSocket;
	import cx.net.enum.enSocketState;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.MD5;
	
	public class XiugaiMima extends Sprite
	{
		private var _hide : Function;
		public function XiugaiMima()
		{
			super();
			this.visible = false;
			for(var i : uint = 1;i<4;i++)
			{
				this['Input_' + i].Txt.displayAsPassword = true;
				this['Input_' + i].Txt.maxChars = 32;
			}
		}
		
		public function Show(hideFunction : Function) : void
		{
			_hide = hideFunction;
			theOk.enable = true;
			theOk.addEventListener(MouseEvent.CLICK,onOkEvent);
			
			this.visible = true;
		}
		public function Hide(b : Boolean = false) : void
		{
			this.visible = false;
			if(_hide != null && !b) {
				_hide();
				_hide = null;
			}
			for(var i : uint = 1;i<4;i++)
			{
				this['Input_' + i].Txt.text='';
			}
			theOk.removeEventListener(MouseEvent.CLICK,onOkEvent);
		}
		private function onOkEvent(e : MouseEvent) : void
		{
			var len : uint = 0;
			for(var i : uint = 1;i<4;i++)
			{
				len = this['Input_' + i].Txt.text.length;
				if(len < 6 || len > 32) {
					Message.show('请正确输入密码!');
					stage.focus = this['Input_' + i].Txt;
					return;
				}
			}
			if(this['Input_1'].Txt.text == this['Input_2'].Txt.text) {
				Message.show('原始密码与新密码相同!');
				return;
			}
			if(this['Input_3'].Txt.text != this['Input_2'].Txt.text) {
				Message.show('两次密码输入不一致!');
				return;
			}
			theOk.enable = false;
			LogonModel._GetInstance().MainNet.SendBankPassword(PassCallBack);
		}
		
		private function PassCallBack(pClientSocket : IClientSocket,szErr : String = '') : void
		{
			if(pClientSocket.GetConnectState() == enSocketState.en_Connected) {
				var changePass : CMD_GP_ChangePassWord = new CMD_GP_ChangePassWord();
				changePass.mUserID = UserModel._getInstance().selfInfo.dwUserID;
				changePass.szPassword = MD5.hash(UserModel._getInstance().selfInfo.szPassword);
				changePass.szBankPassword = MD5.hash(this['Input_1'].Txt.text);
				changePass.szChangePassword = MD5.hash(this['Input_2'].Txt.text);
				pClientSocket.SendData(LGCmd.MDM_GP_BANK,LGCmd.SUB_GP_BANK_CHANGEPASSWORD,changePass.ToByteArray(),changePass.size);
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
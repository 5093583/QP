package cx.client.logon.view.Plaza
{
	import cx.client.logon.model.LogonNet;
	import cx.client.logon.model.UserModel;
	import cx.client.logon.model.struct.CMD_GP_LockMachine;
	import cx.client.logon.model.struct.LGCmd;
	import cx.client.logon.model.vo.UserInfo;
	import cx.client.logon.view.message.Message;
	import cx.net.Interface.IClientSocket;
	import cx.net.enum.enSocketState;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.MD5;
	import t.cx.air.utils.SystemEx;
	
	public class BangDingSprite extends Sprite
	{
		public function BangDingSprite()
		{
			super();
			this.visible = false;
			thePass.displayAsPassword = true;
			thePass.maxChars=32;
		}
		public function Show() : void
		{
			if(!this.visible) {
				if(UserModel._getInstance().selfInfo.cbMoorStatus == 1){
					theInfo.text = '您已经绑定本机，是否取消绑定.';
				}else {
					theInfo.text = '您尚未绑定本机，是否绑定.';
				}
				theOk.enable = true;
				theOk.addEventListener(MouseEvent.CLICK,onButtonEvent);
				theClose.addEventListener(MouseEvent.CLICK,onButtonEvent);
				this.visible = true;
			}
		}
		public function Hide() : void
		{
			this.visible = false;
			theInfo.text = '';
			theOk.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			thePass.text = '';
		}
		private function onButtonEvent(e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'OkBtn':
				{
					if(thePass.text.length<6) {
						Message.show('请正确填写银行密码!');
						return;
					}
					theOk.enable = false;
					LogonNet._getInstance().SendBindComputer(onBindCallBack);
					break;
				}
				default:
				{
					Hide();
					break;
				}
			}
		}
		private function onBindCallBack(pIClientSocket : IClientSocket,szErr : String='') : void
		{
			//发送绑定本机消息
			if(pIClientSocket.GetConnectState() == enSocketState.en_Connected) {
				var bind : CMD_GP_LockMachine = new CMD_GP_LockMachine();
				bind.dwOper = UserModel._getInstance().selfInfo.cbMoorStatus == 0?1:0;
				bind.mUserID = UserModel._getInstance().selfInfo.dwUserID;
				bind.szPassword = MD5.hash(thePass.text);
				bind.szSerialNumber = SystemEx._clientSequence();
				pIClientSocket.SendData(LGCmd.MDM_GP_USER,LGCmd.SUB_GP_MOOR_MACHINE,bind.toByteArray(),bind.size);
			}else {
				Message.show(szErr);
			}
			Hide();
		}
		protected function get theInfo() : TextField
		{
			return this['InfoTxt'];
		}
		protected function get theOk() : ButtonEx
		{
			return this['OkBtn'];
		}
		protected function get theClose() : ButtonEx
		{
			return this['CloseBtn'];
		}
		protected function get thePass() : TextField
		{
			return this['PassTxt'];
		}
	}
}
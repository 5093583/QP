package cx.client.logon.view.Plaza.chat
{
	import cx.client.logon.model.LogonModel;
	import cx.client.logon.model.UserModel;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.utils.IDConvert;
	
	public class ChatView extends Sprite
	{
		public function ChatView()
		{
			super();
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		
		protected function onInit(e : Event = null) : void
		{
			if(e != null) {
				this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			}
			theChatTxt.maxChars = 1;
			theChatTxt.restrict='';
			theChatTxt.addEventListener(MouseEvent.CLICK,onShowChatCombox);
			
		}
		private function onShowChatCombox(e : MouseEvent) : void
		{
			theChatComBox.Show(onSetCahtText);
		}
		private function onSetCahtText(str : String) : void
		{
			theChatTxt.text = '';
			if(str.length > 0) {
				AddChatInfo(UserModel._getInstance().selfID.toString(),str);
				LogonModel._GetInstance().msgNet.SendChatMessage(str);
			}
		}
		public function AddChatInfo(uName : String,info : String) : void
		{
			var chatStr : String = '';
			chatStr ="[ " + IDConvert.Id2View( parseInt(uName) ) + " ]<FONT color='#AFAF00'> 说: " + info + '</FONT>\n';
			if(theChatOutput.numLines > 15) {
				theChatOutput.htmlText = '';
			}
			theChatOutput.htmlText += chatStr;
			theChatOutput.scrollV = theChatOutput.maxScrollV;
		}
		private function get theChatComBox() : ChatComBox
		{
			return this['ChatComBoxMC'];
		}
		
		protected function get theChatOutput() : TextField
		{
			return this['ChatOutPut'];
		}
		protected function get theChatTxt() : TextField
		{
			return this['ChatTxt'];
		}
	}
}
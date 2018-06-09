package cx.client.logon.view.message
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.TScore;
	import t.cx.air.skin.ButtonEx;
	
	public class MessageItem extends MovieClip
	{
		private var _closeFun : Function;
		
		public function MessageItem()
		{
			super();
		}
		public function SetContainer(msg : String,type : uint,closeHandle: Function = null) : void
		{
			theTitle.text = type==1?'警告':(type==0?'提示':'温馨提示');
			onUnListernBtn();
			if(type == 1)
			{
				if(!theQxBtn.hasEventListener(MouseEvent.CLICK)) {
					theQxBtn.addEventListener(MouseEvent.CLICK,onMouseClick);
					theQxBtn.x = 550
				}
				theQxBtn.visible = true;
			}
			if(!theQrBtn.hasEventListener(MouseEvent.CLICK)) {
				theQrBtn.addEventListener(MouseEvent.CLICK,onMouseClick);
				theQrBtn.x = type==1?390:470;
			}
			theQrBtn.visible = true;
			var rep : RegExp =/<score>.*?<\/score>/g;
			var scores : Array = msg.match(rep);
			if(scores.length > 0) {
				var scoreParrent : String;
				var score : String;
				while(scores.length>0)
				{
					scoreParrent = scores.pop();
					score = TScore.toStringEx( parseFloat( scoreParrent.substring( 7,scoreParrent.length-8) ) );
					msg = msg.replace(scoreParrent,score);
				}
			}
			theMsg.htmlText =msg.split(" ").join("");
			_closeFun = closeHandle;
		}
		
		private function onMouseClick(e : MouseEvent) : void
		{
			onUnListernBtn();
			this.parent.removeChild(this);
			if(_closeFun != null) {
				if(e.target.name == 'QueRenbtn') {
					_closeFun('yes');
				}else {
					_closeFun('no');
				}
			}
			theTitle.text	='';
			theMsg.text 	= '';
		}
		private function onUnListernBtn() : void
		{
			if(theQrBtn.hasEventListener(MouseEvent.CLICK)) {
				theQrBtn.removeEventListener(MouseEvent.CLICK,onMouseClick);
			}
			if(theQxBtn.hasEventListener(MouseEvent.CLICK)) {
				theQxBtn.removeEventListener(MouseEvent.CLICK,onMouseClick);
			}
			theQrBtn.visible = false;
			theQxBtn.visible = false;
		}
		private function get theTitle() : TextField
		{
			return this['titleTxt'];
		}
		
		private function get theMsg() : TextField
		{
			return this['MsgTxt'];
		}
		private function get theQxBtn() : ButtonEx
		{
			return this['QuXiaoBtn'];
		}
		private function get theQrBtn() : ButtonEx
		{
			return this['QueRenbtn'];
		}
	}
}
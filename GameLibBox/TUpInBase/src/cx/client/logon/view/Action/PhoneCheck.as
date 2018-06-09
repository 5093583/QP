package cx.client.logon.view.Action
{
	import cx.client.logon.view.message.Message;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.skin.ButtonEx;
	
	public class PhoneCheck extends Sprite
	{
		private var _callBack : Function;
		public function PhoneCheck()
		{
			super();
			this.visible = false;
			if(stage)
			{
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}else {
				onInit();
			}
		}
		
		private function onInit(e : Event = null) : void
		{
			theYanZheng.restrict = "0-9";
		}
		
		public function Show(phone : String,callBack : Function) : void
		{
			theOk.addEventListener(MouseEvent.CLICK,onMouseEvent);
			theClose.addEventListener(MouseEvent.CLICK,onMouseEvent);
			_callBack = callBack;
			thePhone.text = phone;
			this.visible = true;
		}
		private function onMouseEvent(e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'OkBtn':
				{
					if(theYanZheng.text.length<4) {
						Message.show('请输入正确验证码!');
						return;
					}
					theOk.enable = false;
					_callBack(1,theYanZheng.text);
					
					Destroy();
					break;
				}
				default:
				{
					_callBack(0,'');
					Destroy();
					break;
				}
			}
		}
		private function get thePhone() : TextField
		{
			return this['PhoneTxt'];
		}
		private function get theOk() : ButtonEx
		{
			return this['OkBtn'];
		}
		private function get theClose() : ButtonEx
		{
			return this['CloseBtn'];
		}
		private function get theYanZheng() : TextField
		{
			return this['YZTxt'];
		}
		public function Destroy() : void
		{
			if(this.parent != null) { this.parent.removeChild(this); }
			this.visible = false;
			theOk.Destroy();
			theOk.removeEventListener(MouseEvent.CLICK,onMouseEvent);
			theClose.Destroy();
			theClose.removeEventListener(MouseEvent.CLICK,onMouseEvent);
			_callBack = null;
			this['YZTxt'] = null;
			this['PhoneTxt'] = null;
		}
	}
}
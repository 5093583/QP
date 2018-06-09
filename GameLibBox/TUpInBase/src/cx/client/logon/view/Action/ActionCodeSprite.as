package cx.client.logon.view.Action
{
	import cx.client.logon.view.message.Message;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.SystemEx;
	
	public class ActionCodeSprite extends Sprite
	{
		private var _callBack : Function;
		public function ActionCodeSprite()
		{
			super();
			this.visible = false;
			if(stage)
			{
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}else {
				onInit(null);
			}
			this['InputTxt'].Txt.text = '';
		}
		
		protected function onInit(e :Event) : void
		{
			if(e != null) {
				this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		public function Show(val : String,callBack : Function) : void
		{
			theTitle.text = val.substring(0,val.indexOf('&'));
			theActionInfo.text = val.substring(val.indexOf('&')+1);
			_callBack = callBack;
			
			theOk.addEventListener(MouseEvent.CLICK,onMouseEvent);
			theClose.addEventListener(MouseEvent.CLICK,onMouseEvent);
			
			this.visible = true;
		}
		private function onMouseEvent(e : MouseEvent) : void
		{
			switch(e.target.name)
			{
				case 'OkBtn':
				{
					if(this['InputTxt'].Txt.text.length!=8) {
						Message.show('礼包号码错误!');
						return;
					}
					theOk.enable = false;
					var vnum : String = this['InputTxt'].Txt.text + '&' + SystemEx._clientSequence();
					_callBack(1,vnum);
					Destroy();
					break;
				}
				default:
				{
					Destroy();
					break;
				}
			}
		}
		
		private function get theOk() : ButtonEx
		{
			return this['OkBtn'];
		}
		private function get theClose() : ButtonEx
		{
			return this['CloseBtn'];
		}
		
		
		private function get theActionInfo() : TextField
		{
			return this['ActionInfoTxt'];
		}
		private function get theTitle() : TextField
		{
			return this['TitleTxt'];
		}
		public function Destroy() : Boolean
		{
			if(this.parent != null) { this.parent.removeChild(this); }
			this['InputTxt'].Txt = null;
			this['InputTxt'] = null;
			
			this['ActionInfoTxt']=null;
			
			theOk.Destroy();
			theOk.removeEventListener(MouseEvent.CLICK,onMouseEvent);
			theClose.Destroy();
			theClose.removeEventListener(MouseEvent.CLICK,onMouseEvent);
			_callBack = null;
			
			return true;
		}
	}
}
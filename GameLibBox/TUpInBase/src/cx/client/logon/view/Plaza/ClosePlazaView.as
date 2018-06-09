package cx.client.logon.view.Plaza
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import t.cx.air.skin.ButtonEx;
	
	public class ClosePlazaView extends Sprite
	{
		private var _callback : Function;
		public function ClosePlazaView()
		{
			super();
			this.visible = false;
		}
		
		public function Show(callBack : Function) : void
		{
			_callback = callBack;
			
			theChangeAccount.addEventListener(MouseEvent.CLICK,onChangeEvent);
			theExit.addEventListener(MouseEvent.CLICK,onExitPlaza);
			theClose.addEventListener(MouseEvent.CLICK,onCloseEvent);
			
			this.visible = true;
		}
		
		private function onChangeEvent(e : MouseEvent) : void
		{
			if(_callback != null) { _callback(2); }
			onCloseEvent(null);
		}
		private function onExitPlaza(e : MouseEvent) : void
		{
			if(_callback != null) { _callback(1); }
			onCloseEvent(null);
		}
		
		private function onCloseEvent(e : MouseEvent) : void
		{
			this.visible = false;
			theClose.removeEventListener(MouseEvent.CLICK,onCloseEvent);
			theExit.removeEventListener(MouseEvent.CLICK,onExitPlaza);
			theChangeAccount.removeEventListener(MouseEvent.CLICK,onChangeEvent);
			_callback = null;
		}
		
		protected function get theChangeAccount() : ButtonEx
		{
			return this['ChangeBtn'];
		}
		protected function get theExit() : ButtonEx
		{
			return this['ExitPlazaBtn'];
		}
		protected function get theClose() : ButtonEx
		{
			return this['CloseBtn'];
		}
		
	}
}
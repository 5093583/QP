package cx.client.logon.view.welcome
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import t.cx.air.skin.ButtonEx;
	
	public class WelcomeView extends Sprite
	{
		private var _enterCallBack : Function;
		public function WelcomeView()
		{
			super();
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		public function AddCallBack(callBack : Function) : void
		{
			_enterCallBack = callBack;
		}
		protected function onInit(e : Event = null) : void
		{
			if(e != null){
				this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			}
			this['EnterBtn'].addEventListener(MouseEvent.CLICK,onEnterGame);
		}
		private function onEnterGame(e : MouseEvent) : void
		{
			_enterCallBack();
		}
		public function Destory() : void
		{
			_enterCallBack = null;
			this['EnterBtn'].removeEventListener(MouseEvent.CLICK,onEnterGame);
			this['webcontiner'].Destory();
			this['webcontiner'] = null;
			this['EnterBtn'] = null;
		}
		protected function theTContiner() : WelcomeWebContiner
		{
			return this['webcontiner'];
		}
	}
}
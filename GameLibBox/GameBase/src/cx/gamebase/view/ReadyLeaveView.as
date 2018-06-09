package cx.gamebase.view
{
	import com.greensock.TweenMax;
	
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.events.GameEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.skin.ButtonEx;
	
	public class ReadyLeaveView extends Sprite implements IDestroy
	{
		public static const READY_LEAVE : String = 'ready_leave';
		public function ReadyLeaveView()
		{
			super();
			this.visible = false;
			Controller.addEventListener(READY_LEAVE,Show);
		}
		public function Show(e : TEvent = null) : void
		{
			theContinueBtn.addEventListener(MouseEvent.CLICK,onButtonEvent);
			theLeaveBtn.addEventListener(MouseEvent.CLICK,onButtonEvent);
			TweenMax.from(this,0.5,{y:730,alpha:0});
			TweenMax.delayedCall(10,onAutoLeave);
			this.visible = true;
		}
		private function onAutoLeave() : void
		{
			theContinueBtn.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			theLeaveBtn.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			
			Controller.dispatchEvent(GameEvent.GAME_SEND_EXIT,1);
		}
		private function onButtonEvent(e : MouseEvent) : void
		{
			theContinueBtn.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			theLeaveBtn.removeEventListener(MouseEvent.CLICK,onButtonEvent);
			switch(e.target.name)
			{
				case 'ReContinueBtn':
				{
					Controller.dispatchEvent(GameEvent.CONTINUE_GAME,1);
					break;
				}
				case 'LeaveGameBtn':
				{
					Controller.dispatchEvent(GameEvent.GAME_SEND_EXIT,1);
					break;
				}
			}
		}
		
		private function get theContinueBtn() : ButtonEx
		{
			return this['ReContinueBtn'];
		}
		private function get theLeaveBtn() : ButtonEx
		{
			return this['LeaveGameBtn'];
		}
		
		public function Destroy() : Boolean
		{
			theContinueBtn.Destroy();
			this['ReContinueBtn'] = null;
			
			theLeaveBtn.Destroy();
			this['LeaveGameBtn'] = null;
			
			return true;
		}
		
	}
}
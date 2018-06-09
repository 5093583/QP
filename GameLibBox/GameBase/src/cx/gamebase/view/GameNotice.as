package cx.gamebase.view
{
	import com.greensock.TweenMax;
	
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import mx.effects.Tween;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	
	public class GameNotice extends Sprite implements IDestroy
	{
		private var _bInit : Boolean;
		private var _bLock : Boolean = false;
		private var _timeID : int;
		private var _bShow : Boolean = false;
		public function GameNotice()
		{
			super();
			Controller.addEventListener(GameEvent.GAME_NOTICE_EVENT,onRecvMessage);
			_bInit = false;
			if(stage) {
				onInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		private function onInit(e : Event = null) : void
		{
			theLock.gotoAndStop(1);
			theHorn.gotoAndStop(1);
		}
		private function onRecvMessage(e : TEvent) : void
		{
			var recv : String = String( e.nWParam );
			if(stage == null) {
				TweenMax.delayedCall(1,onRecvMessage,[e]);
			}else {
				clearInterval(_timeID);
				if(!_bInit) { _bInit = true; }
				theTxt.htmlText = recv;
				if(theTxt.text.length > 0)
				{
					theTxt.width = theTxt.text.length * 16;
					if(!theLock.hasEventListener(MouseEvent.CLICK)) {
						theLock.addEventListener(MouseEvent.CLICK,onSelectLock);
					}
					if(!_bLock) {
						if( !stage.hasEventListener( Event.ENTER_FRAME ) )
						{
							stage.addEventListener(Event.ENTER_FRAME,onEnterFrameEvent);
						}
						theHorn.gotoAndPlay(1);
						this.visible = true;
						_bShow = true;
					}
				}
			}
		}
		private function onSelectLock(e : MouseEvent) : void
		{
			_bLock = !_bLock;
			theLock.gotoAndStop(_bLock?2:1);
			if(!_bLock) { _timeID = 0; }
		}
		private function onEnterFrameEvent(e : Event) : void
		{
			if(_bShow)
			{
				_timeID++;
				if(_timeID>240) {
					_timeID = 240
				}
			}else {
				_timeID--;
				if(_timeID<=0) {
					_timeID = 0;
				}
			}
			if(_timeID <= 0 || _timeID >= 240)
			{
				if(!_bLock) {
					_bShow = !_bShow;
				}else {
					_bShow = true;
				}
				this.visible = _bShow;
				if( _bShow ) {
					theHorn.gotoAndPlay(1);
				}else {
					theHorn.gotoAndStop(1);
				}
			}
			if( _bShow )
			{
				theTxt.x -= 1;
				if( (theTxt.x + theTxt.textWidth)<=0 ) { theTxt.x = 455; }
			}
		}
		private function get theTxt() : TextField
		{
			return this['HTxt'];
		}
		private function get theLock() : MovieClip
		{
			return this['LockTableMC'];
		}
		private function get theHorn() : MovieClip
		{
			return this['HornMC'];
		}
		public function Destroy() : Boolean
		{
			Controller.removeEventListener(GameEvent.GAME_NOTICE_EVENT,onRecvMessage);
			if(stage) {
				stage.removeEventListener(Event.ENTER_FRAME,onEnterFrameEvent);
			}
			theLock.gotoAndStop(1);
			this['LockTableMC'] = null;
			theHorn.gotoAndStop(1);
			this['HornMC'] = null;
			this['HTxt'] = null;
			return true;
		}
	}
}
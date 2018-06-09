package games.cowlord.view.cartoon
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	public class Clock extends Sprite
	{
		private var _timer : Timer;
		public function Clock()
		{
			super();
			this.visible = true;
			theZhuangTai.gotoAndStop(1);
		}
		
		public function StartClock(time:Number,zt:int) : void
		{
			
			var repeat : uint = time / 1000;
			Stop();
			_timer = new Timer(1000,repeat);
			_timer.addEventListener(TimerEvent.TIMER,onTimerEvent);
			_timer.start();
			
			this.x = 85;
			this.y = 226;
			
			theTime.text = repeat > 9?repeat.toString() : ('0' + repeat);
			theTime.visible = true;
			theZhuangTai.gotoAndStop(zt);
		}
		public function Stop() : void
		{
			if(_timer) {
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER,onTimerEvent);
				_timer = null;
			}
			theTime.text = '00';
			theTime.visible = false;
		}
		private function onTimerEvent(e : TimerEvent) : void
		{
			var time : int = _timer.repeatCount - _timer.currentCount;
			if(time <= 0) {
				Stop(); 
				return;
			}
			theTime.text = time > 9?time.toString() : ('0' + time);
		}
		public function Destroy() : void
		{
			Stop();
			this['TimeTxt'] = null;
			this['ZhuangTai'] = null;
		}
		private function get theTime() : TextField
		{
			return this['TimeTxt'];
		}
		private function get theZhuangTai() : MovieClip
		{
			return this['ZhuangTai'];
		}
		
	}
}
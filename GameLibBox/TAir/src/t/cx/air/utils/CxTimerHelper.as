package t.cx.air.utils
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.core.Application;
	
	import t.cx.Interface.IClockSink;

	[Event(name="count_down_complete",type="flash.events.Event")]
	[Event(name="complete_timer",type="flash.events.Event")]
	public class CxTimerHelper extends Shape
	{
		private var _totalTime 		: Number;
		private var _countdownTime  : Number;
		private var _startTime 		: Number;
		private var _frame 			: Number;
		
		private var _checkCount 	: uint;
		private var _repeat			: uint;
		
		private var _timer			: Timer;
		
		private var _clockSink : IClockSink;
		public function set ClockSink(val : IClockSink) : void
		{
			_clockSink = val;
		}
		public function get ClockSink() : IClockSink
		{
			return _clockSink;
		}
		
		public function CxTimerHelper(frame : Number = 24)
		{
			_frame 			= frame;
		}
		public function OverCountdown(bComplete : Boolean = true) : void
		{
			StopTimer();
			this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			_startTime 		= 0;
			_countdownTime 	= 0;
			_checkCount		= 0;
			if(_clockSink != null) { _clockSink.ClockCountDown(_repeat,_totalTime); }
			if(bComplete) { 
				dispatchEvent(new Event( 'count_down_complete' ));
				if(_totalTime == 0 ) {
					Start(_totalTime,_repeat);
				}else {
					_repeat =_repeat>0?_repeat-1:_repeat;
					if(_repeat>0) {
						Start(_totalTime,_repeat);
					}else {
						dispatchEvent(new Event( 'complete_timer' ));	
					}
				}
			}
		}
		public function Reset() : void
		{
			Stop();
			_startTime = 0;
			_repeat = _checkCount;
			_countdownTime = _totalTime;
		}
		public function Start(totalTimer : Number,repeat : uint = 1) : void
		{
			_checkCount		= repeat;
			_repeat 		= _checkCount;
			_totalTime 		= totalTimer;
			_countdownTime 	= _totalTime;
			_startTime 		= new Date().time;
			if(_countdownTime <= _frame) 
			{
				SetTimer(_countdownTime);
			}else {
				this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		public function ReStart() : void
		{
			_startTime 		= new Date().time;
			if(_countdownTime <= _frame) 
			{
				SetTimer(_countdownTime);
			}else {
				this.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
		}
		public function Stop(bComplete : Boolean = false) : void
		{
			StopTimer();
			if(this.hasEventListener(Event.ENTER_FRAME))
			{
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			}
			if(bComplete) { dispatchEvent(new Event( 'count_down_complete' )); }
		}
		private function onEnterFrame(e : Event) : void
		{
			_countdownTime -=  ( new Date().time - _startTime );
			if(_countdownTime <= 0)
			{
				OverCountdown();
			}else if(_countdownTime < _frame)
			{
				this.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
				SetTimer(_countdownTime);
			}
			_startTime = new Date().time;
		}
		
		private function SetTimer(len : Number) : void
		{
			StopTimer();
			_timer = new Timer(len,1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerEvent);
			_timer.start();
		}
		private function StopTimer() : void
		{
			if(_timer)
			{
				_timer.stop();
				_timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimerEvent);
				_timer = null;
			}
		}
		private function onTimerEvent(e : TimerEvent) : void
		{
			OverCountdown();
		}
		public function Destroy() : void
		{
			OverCountdown(false);
			if( _clockSink!= null ) {
				_clockSink.Destroy();
				_clockSink= null;
			}
		}
	}
}
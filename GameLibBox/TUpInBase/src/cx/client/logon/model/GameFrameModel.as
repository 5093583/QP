package cx.client.logon.model
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class GameFrameModel
	{
		private static var _instance : GameFrameModel;
		public static function _GetInstance() : GameFrameModel
		{
			return _instance == null ? _instance = new GameFrameModel() : _instance;
		}
		
		private var _enterTime : Timer;
		private var _bExit : Boolean;
		public function set exit(val : Boolean) : void
		{
			_bExit = val;
			stopTime();
			if(_bExit) { startTime(); }
		}
		public function GameFrameModel()
		{
		}
		
		public function CanEnter() : Boolean
		{
			return !_bExit;
		}
		public function GetLeaveTime() : int
		{
			if(_enterTime == null) return 0;
			return _enterTime.repeatCount - _enterTime.currentCount;
		}
		private function startTime() : void
		{
			if(_enterTime != null) { stopTime(); }
			_enterTime = new Timer(1000,30);
			_enterTime.addEventListener(TimerEvent.TIMER_COMPLETE,onComplete);
			_enterTime.start();
		}
		private function stopTime() : void
		{
			if(_enterTime != null)
			{
				_enterTime.stop();
				_enterTime.removeEventListener(TimerEvent.TIMER_COMPLETE,onComplete);
				_enterTime = null;
			}
		}
		private function onComplete(e : TimerEvent) : void
		{
			_bExit = false;
		}
	}
}
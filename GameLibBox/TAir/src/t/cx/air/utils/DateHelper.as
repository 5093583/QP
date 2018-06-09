package t.cx.air.utils
{
	public class DateHelper
	{
		private static var _tiemStart : Number;
		public function DateHelper()
		{
		}
		public static function get now() : Date
		{
			return new Date();
		}
		public static function get time() : Number
		{
			return now.getTime();
		}
		
		public static function SubTime(last : Number) : Number
		{
			return time - last;
		}
		
		public static function GetStrTimeAll(value : Number) : String
		{
			var date : Date = new Date();
			date.setTime(value);
			return date.getFullYear() + '/' + date.getMonth()+1 + '/' + date.getDate() + '/' 
					+ date.getHours() + '/' + date.getMinutes();
		}
		//-----------------------------------------------------------------
		//计时开始
		public static function Start() : Number
		{
			_tiemStart = now.time;
			return _tiemStart;
		}
		public static function End() : Number
		{
			return SubTime(_tiemStart);
		}
	}
}
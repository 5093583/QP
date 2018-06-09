package t.cx.air
{
	public class TScore
	{
		public static var radix : uint = 0;
		public function TScore()
		{
		}
		
		public static function toFixedStringEx(score : Number, fixed:int=0) : String
		{
			var _r : int = Math.pow(10,radix);
			var str:String = (score / _r).toFixed(fixed);
			if(str.indexOf('.') != -1)
				str = str.substr(0, str.indexOf('.') );
			return str;
		}
		
		public static function toStringEx(score : Number) : String
		{
			var _r : int = Math.pow(10,radix);
			return (score / _r).toFixed(radix);
		}
		public static function toFloatEx(score : Number) : Number
		{
			var _r : int = Math.pow(10,radix);
			return (score / _r);
		}
		public static function parseFloatEx(str : String) : Number
		{
			var _r : int = Math.pow(10,radix);
			return parseFloat((parseFloat(str) * _r).toFixed(0));
		}
	}
}
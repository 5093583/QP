package t.cx.air.graphics
{
	import flash.geom.Point;

	public class TBezier
	{
		public function TBezier()
		{
		}
		
		public static function BezierLine(t : Number,fromX : Number,fromY : Number,toX : Number,toY : Number,conX : Number,conY : Number) : Point
		{
			var point : Point = new Point();
			point.x = Math.pow(1-t,2) * fromX + 2 * t * (1-t) * conX + Math.pow(t,2) * toX;
			point.y = Math.pow(1-t,2) * fromY + 2 * t * (1-t) * conY + Math.pow(t,2) * toY;
			return point;
		}
	}
}
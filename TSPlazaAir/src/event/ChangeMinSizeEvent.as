package event
{
	import flash.events.Event;
	import flash.geom.Point;
	
	public class ChangeMinSizeEvent extends Event
	{
		public static var SET_MINSIZE:String = "set_minsize";
		private var _minSize:Point;
		
		public function getMinSize():Point
		{
			return _minSize;
		}
		
		public function ChangeMinSizeEvent(type:String, minSize:Point, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_minSize = minSize;
		}
		
		override public function clone():Event
		{
			return new ChangeMinSizeEvent(type, _minSize, bubbles, cancelable);
		}
		
	}
}
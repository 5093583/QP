package event
{
	import flash.events.Event;
	
	public class ChangeGameColorEvent extends Event
	{
		public static const COLOR_INDEXCHANGE:String = 'color_indexchange';
		
		public var _selectIndex:int;
		
		public function ChangeGameColorEvent(type:String, selectIndex:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_selectIndex = selectIndex;
		}
		
		
		override public function clone():Event
		{
			return new ChangeGameColorEvent(type, _selectIndex, bubbles, cancelable);
		}
		
		
	}
}
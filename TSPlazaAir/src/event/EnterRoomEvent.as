package event
{
	import flash.events.Event;
	
	public class EnterRoomEvent extends Event
	{
		public static var ENTER_ROOM:String = "enter_room";
		private var _roomInfo:Object;

		public function get roomInfo():Object
		{
			return _roomInfo;
		}
		
		
		public function EnterRoomEvent(type:String, roomInfo:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_roomInfo = roomInfo;
		}
		
		
		override public function clone():Event
		{
			return new EnterRoomEvent(type, _roomInfo, bubbles, cancelable);
		}
		
		
	}
}
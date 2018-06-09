package event
{
	import flash.events.Event;
	
	public class PlayWithFriendEvent extends Event
	{
		public static const PLAY_WITHFRIEND:String = 'play_withfriend';
		
		public var accept:Boolean;
		public var friendID:int;
		public var info:Object;
		
		public function PlayWithFriendEvent(type:String, _accept:Boolean, _friendID:int, _info:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			accept 	= _accept;
			friendID= _friendID;
			info 	= _info;
		}
		
		
		override public function clone():Event
		{
			return new PlayWithFriendEvent(type, accept, friendID, info, bubbles, cancelable);
		}
		
		
		
		
	}
}
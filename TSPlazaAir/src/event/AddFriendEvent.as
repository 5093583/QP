package event
{
	import flash.events.Event;
	
	public class AddFriendEvent extends Event
	{
		public static const ADD_FRIEND:String = 'add_friend';
		
		public var added:Boolean;
		public var userID:int;
		public var gender:int;
		
		public function AddFriendEvent(type:String, _added:Boolean, _userID:int, _gender:int, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			added 	= _added;
			userID 	= _userID;
			gender	= _gender;
		}
		
		
		override public function clone():Event
		{
			return new AddFriendEvent(type, added, userID, gender, bubbles, cancelable);
		}
		
		
	}
}
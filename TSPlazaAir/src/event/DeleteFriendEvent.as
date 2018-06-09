package event
{
	import flash.events.Event;
	
	public class DeleteFriendEvent extends Event
	{
		public static var DELETE_FRIEND:String = "delete_friend";
		private var _userID:uint;
		
		
		public function DeleteFriendEvent(type:String, userID:uint, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			_userID = userID;
		}
		
		
		override public function clone():Event
		{
			return new DeleteFriendEvent(type, _userID, bubbles, cancelable);
		}
		
		
		
		
	}
}
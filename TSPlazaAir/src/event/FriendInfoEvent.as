package event
{
	import flash.events.Event;
	
	public class FriendInfoEvent extends Event
	{
		public static const FRIEND_INFO:String = 'change_friendinfo';
		
		
		//name：用户昵称	desc：用户描述	type：1修改，2删除，3添加
		public var info:Object;
		
		public function FriendInfoEvent(type:String, _info:Object, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			info = _info;
		}
		
		
		
		override public function clone():Event
		{
			return new FriendInfoEvent(type, info, bubbles, cancelable);
		}
		
	}
}
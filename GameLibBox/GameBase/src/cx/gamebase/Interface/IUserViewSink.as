package cx.gamebase.Interface
{
	import cx.gamebase.sturuct.tagUserInfoHead;

	public interface IUserViewSink
	{
		function UpdateUserCome(userInfo : tagUserInfoHead,wViewChairID : uint) : Boolean;
		
		function UpdateUserStatus(userID : int,cbStatus : uint, wTableID : int, wViewChairID : uint) : Boolean;
		
		function UpdateUserScore(userID : int, wViewChairID : uint, fScore : Number) : Boolean;
	}
}
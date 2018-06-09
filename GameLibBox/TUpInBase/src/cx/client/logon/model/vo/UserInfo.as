package cx.client.logon.model.vo
{
	public class UserInfo
	{
		public var wFaceID			: int;						//头像索引
		public var cbGender 		: uint;						//用户性别
		public var cbMember 		: uint;						//会员等级
		public var dwUserID 		: Number;					//用户 I D
		public var dwExperience 	: Number;					//用户经验
		public var lScore 			: Number;					//用户金币
		public var lBankScore 		: Number;					//银行金币
		public var cbUserStatus		: uint;						//用户当前状态
		//扩展信息
		public var cbMoorStatus 	: uint;						//锁机状态
		//玩家
		public var szAccount 		: String;
		public var szPassword		: String;
		
		public var szName			: String;					//用户名称
		
		public function UserInfo()
		{
			
		}
	}
}
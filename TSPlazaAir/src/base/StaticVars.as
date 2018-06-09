package base
{
	import flash.display.NativeWindow;

	public class StaticVars
	{
		
		[Bindable]
		public static var gameRollTextStr:String = "迎新年，贺新春，满局赠送金币活动隆重推出! 在指定房间玩满指定局数即可获得对应金币奖励，点击了解详情!";
		
		[Bindable]
		public static var hallRollTextStr:String = "迎新年，贺新春，满局赠送金币活动隆重推出! 在指定房间玩满指定局数即可获得对应金币奖励，点击了解详情!";
		
		public static var enterGameLessScore:Number;
		
		public static var serverID:int;
		public static var kindID:int;
		public static var serverName:String;
		public static var szGameNum:String;
		public static var scellScore : Number;
		public static var iRevenuel : Number;
		public static var isMatch : Boolean = false;;
		
		public static var isTryPlayed:Boolean 		= false;
		public static var tryPlayScore:int 			= 0;
		
		public static var refuseAddFriend:Boolean 	= false;
		
		
		public static var playWithFriend:Boolean 	= false;
		public static var tog_userID:int;
		public static var tog_friendID:int;
		
		
		public static var enterRoom:Boolean 		= false;
		public static var isPlayedWithFriend:Boolean= false;
		
		//进入房间前赋值，离开房间后销毁
		public static var enterAppointPwd:String;
		public static var enterAppointRoom:Boolean 	= false;
		
		public static var _selfID:uint;
		
		public static var _gamebgColor:uint 		= 0;
		public static var _isVoiceOn:Boolean 		= true;
		
		
		public static var delayedExitGame:Number 	= 30;
		
		
		public static var nativeWindow:NativeWindow;
		
		
		
		//游戏背景
		public static var colorAry:Array = [0x2f0d0b, 0x1b1129, 0x312616, 0x222d1a, 0x193433, 0x002943];
		public static var _colorIndex:int = 0;
		
		public function StaticVars()
		{
		}
	}
}
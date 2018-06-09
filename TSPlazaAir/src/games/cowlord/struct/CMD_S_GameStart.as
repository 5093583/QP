package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_GameStart
	{
		public static const SIZE:uint=10;
		public var wBankerUser:int;			//庄家位置
		public var lBankerScore:Number;		//庄家金币
		public var lUserMaxScore:Number;	//我的金币
		public var cbTimeLeave:uint;		//剩余时间
		public var nChipRobotCount:uint;	//人数上限 (下注机器人)
		
		public function CMD_S_GameStart()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GameStart
		{
			var result:CMD_S_GameStart=new CMD_S_GameStart();
			result.wBankerUser=WORD.read(bytes);
			result.lBankerScore=LONGLONG.read(bytes);
			result.lUserMaxScore=LONGLONG.read(bytes);
			result.cbTimeLeave=BYTE.read(bytes);
			result.nChipRobotCount=BYTE.read(bytes);
			return result;
		}
	}
}
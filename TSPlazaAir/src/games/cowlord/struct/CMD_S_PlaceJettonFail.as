package games.cowlord.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;

	public class CMD_S_PlaceJettonFail
	{
		public static const SIZE:uint=10;
		public var wPlaceUser:int;			//下注玩家
		public var lJettonArea:uint;		//下注区域
		public var lPlaceScore:uint;		//下注分数
		
		
		public var cbFailType:uint;			//失败原因 
		/*
		0 : 玩家下注金币大于注册金币 1 ：玩家下注超过区域限制 2：玩家下注超过个人限制 
		3：超过庄家下注限制4：玩家手中金币不够下注 5：庄家离开 6：下注失败（原因之外）
		*/
		
		public function CMD_S_PlaceJettonFail()
		{
			
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_PlaceJettonFail
		{
			var result :CMD_S_PlaceJettonFail=new CMD_S_PlaceJettonFail();
				result.wPlaceUser=WORD.read(bytes);
				result.lJettonArea=BYTE.read(bytes);
				result.lPlaceScore=BYTE.read(bytes);
				
				result.cbFailType = BYTE.read(bytes);
				
				return result;
		}
	}
}
////失败结构
//struct CMD_S_PlaceJettonFail
//{
//	WORD							wPlaceUser;							//下注玩家
//	BYTE							lJettonArea;						//下注区域
//	BYTE						lPlaceScore;						//当前下注  类型原为LONGLONG
//};
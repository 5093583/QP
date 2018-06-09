package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONGLONG;
	import t.cx.air.utils.CType.WORD;

	//失败结构
	public class CMD_S_PlaceJettonFail
	{
		public static const SIZE 			:uint	=4;
		public var 	wPlaceUser  :int;            //下注玩家
		public var  lJettonArea :uint;           //下注区域 
		public var  lPlaceScore :uint;           //当前下注
		
		public function CMD_S_PlaceJettonFail()
		{
		}
		public static function _readBuffer(bytes :ByteArray) : CMD_S_PlaceJettonFail
		{
			var result :CMD_S_PlaceJettonFail =new CMD_S_PlaceJettonFail();
			result.wPlaceUser 	= WORD.read(bytes);
			result.lJettonArea 	= BYTE.read(bytes);
			result.lPlaceScore 	= LONGLONG.read(bytes);
			return result;
		}
		
 	}
}
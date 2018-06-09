package games.baccarat.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;

	//记录信息
	public class tagServerGameRecord 
	{
			public static const SIZE : uint = 5;
			public var cbKingWinner :uint;			//天王赢家
			public var bPlayerTwoPair :uint;		//对子标识
			public var bBankerTwoPair :uint;		//对子标识
			public var cbPlayerCount :uint;			//闲家点数
			public var cbBankerCount :uint;			//庄家点数
			public var cbUserSelect	: uint;
			public function tagServerGameRecord()
			{
				bBankerTwoPair = 0;
				bPlayerTwoPair = 0;
				cbKingWinner = 0;
				cbPlayerCount= 0;
				cbBankerCount= 0;
				cbUserSelect = 1;
			}
			public static function _readBuffer(bytes :ByteArray):tagServerGameRecord
			{
				var result : tagServerGameRecord = new tagServerGameRecord();
				result.cbKingWinner = BYTE.read(bytes);
				result.bPlayerTwoPair = BYTE.read(bytes);
				result.bBankerTwoPair = BYTE.read(bytes);
				result.cbPlayerCount = BYTE.read(bytes);
				result.cbBankerCount = BYTE.read(bytes);				
				return result;
			}

	}
}
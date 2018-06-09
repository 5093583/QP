package games.sparrow.struct
{
	import games.sparrow.model.MjModel;
	
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class tagWeaveItem
	{
		public var cbWeaveKind : uint;						//组合类型
		public var cbCenterCard : uint;						//中心麻将
		public var cbPublicCard : Boolean;					//公开标志(暗杠为FALSE，其他组合为TRUE，即亮牌)
		public var wProvideUser : int;						//供应用户
		public var cbCardData : Array;						//实际麻将
		
		public function tagWeaveItem()
		{
			cbWeaveKind = 0;
			cbCenterCard = 0;
			cbPublicCard = false;
			wProvideUser = 0;
			cbCardData = Memory._newArrayAndSetValue(4,255);
		}
		
		public static function _readBuffer(bytes : ByteArray) : tagWeaveItem
		{
			var result : tagWeaveItem = new tagWeaveItem();
			result.cbWeaveKind = BYTE.read(bytes);
			result.cbCenterCard = MjModel.MjInstance().m_Logic.SwitchToCardIndex( BYTE.read(bytes) );
			result.cbPublicCard = BYTE.read(bytes)==1;
			result.wProvideUser = WORD.read(bytes);
			for(var i : uint = 0;i<4;i++)
			{
				result.cbCardData[i] = MjModel.MjInstance().m_Logic.SwitchToCardIndex( BYTE.read(bytes) );
			}
			return result;
		}
		public function toString():String
		{
			return cbWeaveKind + '/' + cbCenterCard + '/' + cbPublicCard + '/' + wProvideUser + '/[' + cbCardData + ']';
		}
	}
}
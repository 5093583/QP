package games.sparrow.struct
{
	import flash.utils.ByteArray;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.CType.WORD;
	import t.cx.air.utils.Memory;

	public class CMD_S_StatusPlay
	{
		//游戏变量
		public var lCellScore : Number;						//房间底分
		public var wSiceCount : Array;						//骰子点数
		public var wBankerUser : int;						//庄家用户
		public var wCurrentUser : int;						//当前用户
		
		//状态变量
		public var cbActionCard : int;						//动作麻将
		public var cbActionMask : int;						//动作掩码
		public var cbHearStatus : Array;					//听牌状态
		public var cbLeftCardCount : int;					//剩余数目
		public var bTrustee : Array;						//是否托管
		
		//出牌信息
		public var wOutCardUser : uint;						//出牌用户
		public var cbOutCardData : uint;					//出牌麻将
		public var cbDiscardCount : Array;					//丢弃数目
		public var cbDiscardCard : Array;					//丢弃记录
		
		//麻将数据
		public var cbCardCount : uint;						//麻将数目
		public var cbCardData : Array;						//麻将列表
		public var cbSendCardData : uint;					//发送麻将
		
		//组合麻将
		public var cbWeaveCount : Array;					//组合数目
		public var WeaveItemArray : Array;					//组合麻将
		
		//花牌信息
		public var cbFaceCard : Array;						//开启花牌
		public var bIsBaoPai : uint;						//是否有宝牌
		
		
		public var cbIsTryPlay:uint;
		public var lTryPlayScore:Number;	
		
		public function CMD_S_StatusPlay()
		{
			wSiceCount = Memory._newArrayAndSetValue(2,0);
			cbHearStatus= Memory._newArrayAndSetValue(2,0);
			bTrustee = Memory._newArrayAndSetValue(2,0);
			cbDiscardCount = Memory._newArrayAndSetValue(2,0);
			cbDiscardCard = Memory._newTwoDimension(2,19,0);
			cbCardData = Memory._newArrayAndSetValue(14,0);
			cbWeaveCount = Memory._newArrayAndSetValue(2,0);
			WeaveItemArray = Memory._newTwoDimension(2,4,null);
			cbFaceCard = Memory._newArrayAndSetValue(8,0);
		}
		public static function _readBuffer(bytes : ByteArray) : CMD_S_StatusPlay
		{
			var result : CMD_S_StatusPlay = new CMD_S_StatusPlay();
			try{
				var i : uint = 0;
				result.lCellScore = LONG.read(bytes);
				for(i = 0;i<2;i++) { result.wSiceCount[i] = WORD.read(bytes); }
				result.wBankerUser  = WORD.read(bytes);
				result.wCurrentUser = WORD.read(bytes);
				result.cbActionCard = BYTE.read(bytes);
				result.cbActionMask = BYTE.read(bytes);
				for(i = 0;i<2;i++) { result.cbHearStatus[i] = BYTE.read(bytes); }
				result.cbLeftCardCount = BYTE.read(bytes);
				for(i = 0;i<2;i++) { result.bTrustee[i] = BYTE.read(bytes); }
				
				result.wOutCardUser = WORD.read(bytes);
				result.cbOutCardData = BYTE.read(bytes);
				for(i = 0;i<2;i++)
				{
					result.cbDiscardCount[i] = BYTE.read(bytes);
				}
				var j : uint = 0;
				for(i = 0;i<2;i++)
				{
					for(j = 0;j<19;j++)
					{
						result.cbDiscardCard[i][j]= BYTE.read(bytes);
					}
				}
				result.cbCardCount =  BYTE.read(bytes);
				for(i = 0;i<14;i++)
				{
					result.cbCardData[i] = BYTE.read(bytes);
				}
				result.cbSendCardData = BYTE.read(bytes);
				for(i = 0;i<2;i++)
				{
					result.cbWeaveCount[i] = BYTE.read(bytes);
				}
				for(i = 0;i<2;i++)
				{
					for(j =0;j<4;j++)
					{
						result.WeaveItemArray[i][j] = tagWeaveItem._readBuffer(bytes);
					}
				}
				for(i = 0;i<8;i++)
				{
					result.cbFaceCard[i] = BYTE.read(bytes);
				}
				result.bIsBaoPai = BYTE.read(bytes);
				
				result.cbIsTryPlay = BYTE.read(bytes);
				result.lTryPlayScore = LONG.read(bytes);
			}catch(err : Error)
			{
				trace(err);
			}
			
			
			
			return result;
		}
	}
}
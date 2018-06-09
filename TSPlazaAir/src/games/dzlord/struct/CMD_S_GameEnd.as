package games.dzlord.struct
{
	import flash.utils.ByteArray;
	
	import games.dzlord.utils.DZFor_9CMDconst;
	
	import t.cx.air.utils.CType.BYTE;
	import t.cx.air.utils.CType.LONG;
	import t.cx.air.utils.Memory;

	public class CMD_S_GameEnd
	{
		public static const SIZE:uint=217;
			public var cbTotalEnd:uint;					//强退标志
			public var lGameTax:Array;					//游戏税收
			public var lGameScore:Array;				//游戏得分
			public var cbCardData:Array;				//用户扑克
			public var cbLastCenterCardData:Array;		//最后扑克		筛选之后
			public var cbGameEndCardType:Array;			//结束牌型
	
			

		public function CMD_S_GameEnd()
		{
			lGameTax = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			lGameScore = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
			cbCardData = Memory._newTwoDimension(DZFor_9CMDconst.GAME_PLAYER,2);
			cbLastCenterCardData = Memory._newTwoDimension(DZFor_9CMDconst.GAME_PLAYER,5);
			cbGameEndCardType = Memory._newArrayAndSetValue(DZFor_9CMDconst.GAME_PLAYER,0);
		}
		public static function _readBuffer(bytes:ByteArray):CMD_S_GameEnd
		{
			var result :CMD_S_GameEnd=new CMD_S_GameEnd();
			
			result.cbTotalEnd = BYTE.read(bytes);
			
			var i:uint;
			var j:uint;
			for(i=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				result.lGameTax[i]=LONG.read(bytes);
			}
			
			for(i=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				result.lGameScore[i]=LONG.read(bytes);
			}
			
			for(i=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				for( j=0;j<2;j++)
				{
					result.cbCardData[i][j]=BYTE.read(bytes);
				}
			}
			for(i=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				for(j=0;j<5;j++)
				{
					result.cbLastCenterCardData[i][j]=BYTE.read(bytes);
				}
			}
			
			for(i=0;i<DZFor_9CMDconst.GAME_PLAYER;i++)
			{
				result.cbGameEndCardType[i]=BYTE.read(bytes);
			}
			return result;
		}
		
	}
}
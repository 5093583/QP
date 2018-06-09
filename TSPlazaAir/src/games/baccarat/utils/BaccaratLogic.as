package games.baccarat.utils
{
	import base.StaticVars;
	
	import cx.gamebase.sturuct.tagUserInfoHead;
	
	import games.baccarat.model.BaccaratModel;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.Memory;

	public class BaccaratLogic
	{
		//数值掩码
		public const MASK_COLOR				: uint = 0xF0;						//花色掩码
		public const MASK_VALUE				: uint = 0x0F;						//数值掩码
		
		
		public function BaccaratLogic()
		{
		}
		/**
		 * 获取数值
		 * */
		public function GetCardValue(cbCardData : uint) : uint
		{
			return cbCardData&MASK_VALUE; 
		}
		/**
		 * 获取花色
		 * */
		public function GetCardColor(cbCardData : uint) : uint
		{
			return cbCardData&MASK_COLOR;
		}
		
		/**
		 * 逻辑数值
		 * */
		public function GetCardLogicValue(cbCardData : uint) : uint
		{
			//扑克属性
			var cbCardColor : uint=GetCardColor(cbCardData);
			var cbCardValue : uint=GetCardValue(cbCardData);
			//转换数值
			//if (cbCardColor==0x40) return cbCardValue+2;
			return (cbCardValue==1)?(cbCardValue+13):cbCardValue;
		}
		public function GetCardPip(cbCardData : uint) : uint
		{
			var cbValue : uint = GetCardValue(cbCardData);
			
			return cbValue>=10?0:cbValue;
		}
		public function IsTwoPair(count : uint, cards : Array ) : uint
		{
			//if(count != 2) return 0;
			if(GetCardValue(cards[0]) == GetCardValue(cards[1])) return 1;
			return 0;
		}
		//最大下注
		public function GetUserMaxJetton() : Number
		{
			//已下注额
			var model : BaccaratModel = BaccaratModel._getInstance();
			var lNowJetton : Number = 0;
			lNowJetton += model.m_lAreaScore[0];
			lNowJetton += model.m_lAreaScore[2];
			lNowJetton += model.m_lAreaScore[4];
			lNowJetton += model.m_lAreaScore[6];
			lNowJetton += model.m_lAreaScore[8];
			lNowJetton += model.m_lAreaScore[10];
			lNowJetton += model.m_lAreaScore[12];
			lNowJetton += model.m_lAreaScore[14];
			//获取玩家
			var fScore : Number;
			if(StaticVars.isTryPlayed)
				fScore= StaticVars.tryPlayScore;
			else
				fScore= model.m_User.GetSelfData().UserScoreInfo.lScore;
			fScore -= model.m_lAreaLimitScoreLest;
			
			//玩家下注
			var lMeMaxScore : Number = Memory._min(fScore,model.m_lUserMaxScore);
			lMeMaxScore -= lNowJetton;
			lMeMaxScore = Memory._max(lMeMaxScore, 0);
			return lMeMaxScore;
		}
		//最大下注
		public function GetMaxPlayerScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton : Number=GetUserMaxJetton();
			
			//最大下注
			var lMaxJetton : Number=0;
			
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit:Number =model.m_lAreaLimitScore - model.m_lAreaScore[1];
				//其他区域
				var lOtherAreaScore : Number= model.m_lAreaScore[5]+ model.m_lAreaScore[3]+ model.m_lAreaScore[11]+ model.m_lAreaScore[9];
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null ) { lBankerScore = bankUser.UserScoreInfo.lScore; }
				
				//庄家限制
				var lMaxPlayerScore:Number = lBankerScore+lOtherAreaScore;
				lMaxPlayerScore -= (model.m_lAreaScore[1]+model.m_lAreaScore[7]*2+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12);
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerScore, lUserMaxJetton);	
				lMaxJetton =Memory._min(lMaxJetton, lAreaLimit);
			} else {
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		
		//最大下注
		public function GetMaxPlayerKingScore() : Number
		{	
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton : Number =GetUserMaxJetton();
			
			//庄家判断
			var lMaxJetton : Number=0;
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit:Number =model.m_lAreaLimitScore - model.m_lAreaScore[7];
				//其他区域
				var lOtherAreaScore : Number = model.m_lAreaScore[5]+ model.m_lAreaScore[11]+ model.m_lAreaScore[9];
				
				//庄家积分
//				var lBankerScore : Number=model.m_User.GetSelfData().UserScoreInfo.lScore;
				var lBankerScore : Number;
				if(StaticVars.isTryPlayed)
					lBankerScore= StaticVars.tryPlayScore;
				else
					lBankerScore= model.m_User.GetSelfData().UserScoreInfo.lScore;
				
				//庄家限制
				var lMaxPlayerKingScore : Number= lBankerScore+lOtherAreaScore;
				lMaxPlayerKingScore -= (model.m_lAreaScore[1]+model.m_lAreaScore[7]*2+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12);
				
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerKingScore/2, lUserMaxJetton);
				lMaxJetton = Memory._min(lMaxJetton, lAreaLimit);
			}
			else
			{
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		
		//最大下注
		public function GetMaxPlayerTwoPairScore() : Number
		{
			//玩家限制
			var lUserMaxJetton : Number=GetUserMaxJetton();
			var model : BaccaratModel = BaccaratModel._getInstance();
		
			
			//庄家判断
			var lMaxJetton : Number=0;
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit : Number= model.m_lAreaLimitScore - model.m_lAreaScore[13];
				//区域下注
				var lPlayerJettonCount : Number=model.m_lAreaScore[7]+model.m_lAreaScore[1];
				var lBankerJettonCount : Number=model.m_lAreaScore[9]+model.m_lAreaScore[5];
				var lTieJettonCount : Number=model.m_lAreaScore[11]+model.m_lAreaScore[3];
				
				//区域赔额
				var lPlayerCompensateCount : Number=model.m_lAreaScore[7]*2+model.m_lAreaScore[1];
				var lBankerCompensateCount : Number=model.m_lAreaScore[9]*2+model.m_lAreaScore[5];
				var lTieCompensateCount	   : Number=model.m_lAreaScore[11]*33+model.m_lAreaScore[3]*8;
				
				//庄家输额
				var lTieWinCount : Number=lTieCompensateCount;
				var lPlayerWinCount : Number=lPlayerCompensateCount-(lBankerJettonCount+lTieJettonCount);
				var lBankerWinCount : Number=lBankerCompensateCount-(lPlayerJettonCount+lTieJettonCount);
				
				//最大输额
				var lOtherAreaScore : Number = Memory._max(lTieWinCount,Memory._max(lPlayerWinCount,lBankerWinCount));
				
				//庄家积分
//				var lBankerScore : Number=model.m_User.GetSelfData().UserScoreInfo.lScore;
				var lBankerScore : Number;
				if(StaticVars.isTryPlayed)
					lBankerScore= StaticVars.tryPlayScore;
				else
					lBankerScore= model.m_User.GetSelfData().UserScoreInfo.lScore;
				
				//庄家限制
				var lMaxPlayerTwoPairScore : Number = lBankerScore-lOtherAreaScore;
				lMaxPlayerTwoPairScore -= ((model.m_lAreaScore[13]+model.m_lAreaScore[15])*12);
				
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerTwoPairScore/12, lUserMaxJetton);
				lMaxJetton = Memory._min(lMaxJetton, lAreaLimit);
			}
			else
			{
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		
		//最大下注
		public function GetMaxBankerScore() : Number
		{
			//玩家限制
			var lUserMaxJetton : Number=GetUserMaxJetton();
			var model : BaccaratModel = BaccaratModel._getInstance();
			
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit : Number = model.m_lAreaLimitScore - model.m_lAreaScore[5];
				//其他区域
				var lOtherAreaScore : Number= model.m_lAreaScore[1]+ model.m_lAreaScore[3]+ model.m_lAreaScore[11]+ model.m_lAreaScore[7];
				
				//庄家积分
//				var lBankerScore : Number=model.m_User.GetSelfData().UserScoreInfo.lScore;
				var lBankerScore : Number;
				if(StaticVars.isTryPlayed)
					lBankerScore= StaticVars.tryPlayScore;
				else
					lBankerScore= model.m_User.GetSelfData().UserScoreInfo.lScore;
				
				//庄家限制
				var lMaxBankerScore : Number = lBankerScore+lOtherAreaScore;
				lMaxBankerScore -= (model.m_lAreaScore[5]+model.m_lAreaScore[9]*2+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12);
		
				//最大下注
				lMaxJetton = Memory._min(lMaxBankerScore, lUserMaxJetton);
				lMaxJetton =  Memory._min(lMaxJetton, lAreaLimit);
			} else {
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		
		//最大下注
		public function GetMaxBankerKingScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton : Number=GetUserMaxJetton();
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit : Number = model.m_lAreaLimitScore - model.m_lAreaScore[9];
				//其他区域
				var lOtherAreaScore:Number = model.m_lAreaScore[1]+ model.m_lAreaScore[3]+ model.m_lAreaScore[11]+ model.m_lAreaScore[7];
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null )
				{
					lBankerScore = bankUser.UserScoreInfo.lScore;
				}
				//庄家限制
				var lMaxBankerKingScore:Number = lBankerScore+lOtherAreaScore;
				lMaxBankerKingScore -= (model.m_lAreaScore[5]+model.m_lAreaScore[9]*2+(model.m_lAreaScore[13]+model.m_lAreaScore[14])*12);
				//最大下注
				lMaxJetton = Memory._min(lMaxBankerKingScore/2, lUserMaxJetton);	
				lMaxJetton = Memory._min(lMaxJetton, lAreaLimit);
			}
			else
			{
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton = Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		//最大下注
		public function GetMaxBankerTwoPairScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton : Number=GetUserMaxJetton();
			
			//最大下注
			var lMaxJetton:Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit : Number= model.m_lAreaLimitScore - model.m_lAreaScore[15];
				//区域下注
				var lPlayerJettonCount : Number=model.m_lAreaScore[7]+model.m_lAreaScore[1];
				var lBankerJettonCount : Number=model.m_lAreaScore[9]+model.m_lAreaScore[5];
				var lTieJettonCount : Number=model.m_lAreaScore[11]+model.m_lAreaScore[3];
				//区域赔额
				var lPlayerCompensateCount : Number=model.m_lAreaScore[7]*2+model.m_lAreaScore[1];
				var lBankerCompensateCount : Number=model.m_lAreaScore[9]*2+model.m_lAreaScore[5];
				var lTieCompensateCount : Number=model.m_lAreaScore[11]*33+model.m_lAreaScore[3]*8;
				//庄家输额
				var lTieWinCount : Number=lTieCompensateCount;
				var lPlayerWinCount : Number=lPlayerCompensateCount-(lBankerJettonCount+lTieJettonCount);
				var lBankerWinCount : Number=lBankerCompensateCount-(lPlayerJettonCount+lTieJettonCount);
				//最大输额
				var lOtherAreaScore:Number = Memory._max(lTieWinCount,Memory._max(lPlayerWinCount,lBankerWinCount));
				//庄家积分
//				var lBankerScore : Number=model.m_User.GetSelfData().UserScoreInfo.lScore;
				var lBankerScore : Number;
				if(StaticVars.isTryPlayed)
					lBankerScore= StaticVars.tryPlayScore;
				else
					lBankerScore= model.m_User.GetSelfData().UserScoreInfo.lScore;
				
				//庄家限制
				var lMaxPlayerTwoPairScore : Number = lBankerScore-lOtherAreaScore;
				lMaxPlayerTwoPairScore -= ((model.m_lAreaScore[13]+model.m_lAreaScore[15])*12);
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerTwoPairScore/12, lUserMaxJetton);
				lMaxJetton = Memory._min(lMaxJetton, lAreaLimit);
			}
			else
			{
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		
		//最大下注
		public function GetMaxTieScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton : Number=GetUserMaxJetton();
			
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit : Number= model.m_lAreaLimitScore - model.m_lAreaScore[3];
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null ) { lBankerScore = bankUser.UserScoreInfo.lScore; }
				//返回积分
				var lReturnScore : Number= model.m_lAreaScore[11] * 33 + model.m_lAreaScore[3] * 8+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12;
				//可下积分
				lMaxJetton= Memory._min(( lBankerScore - lReturnScore )/8, (model.m_lAreaLimitScore-model.m_lAreaScore[3])) ;
				//最大下注
				lMaxJetton = Memory._min(lMaxJetton, lUserMaxJetton);	
				lMaxJetton = Memory._min(lMaxJetton, lAreaLimit);
			}
			else
			{
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		//最大下注
		public function GetMaxTieKingScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton:Number=GetUserMaxJetton();
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit:Number = model.m_lAreaLimitScore - model.m_lAreaScore[11];
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null ) { lBankerScore = bankUser.UserScoreInfo.lScore; }
				//返回积分
				var lReturnScore:Number = model.m_lAreaScore[11] * 33 + model.m_lAreaScore[3] * 8+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12;
				//可下积分
				lMaxJetton= Memory._min(( lBankerScore - lReturnScore )/33, (model.m_lAreaLimitScore-model.m_lAreaScore[3])) ;
				//最大下注
				lMaxJetton = Memory._min(lMaxJetton, lAreaLimit);
			}
			else
			{
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
		
		
		public function GetPlayerScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton:Number=GetUserMaxJetton();
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit:Number = model.m_lAreaLimitScore - model.m_lAreaScore[1];
				//其他区域
				var lOtherAreaScore : Number= model.m_lAreaScore[5]+ model.m_lAreaScore[3]+ model.m_lAreaScore[11]+ model.m_lAreaScore[9];
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null ) { lBankerScore = bankUser.UserScoreInfo.lScore; }

				//庄家限制
				var lMaxPlayerScore:Number = lBankerScore+lOtherAreaScore;
				lMaxPlayerScore -= (model.m_lAreaScore[1]+model.m_lAreaScore[7]*2+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12);
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerScore, lUserMaxJetton);	
				lMaxJetton =Memory._min(lMaxJetton, lAreaLimit);
			}else {
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton =Memory._max(lMaxJetton, 0);
			return lMaxJetton;
		}
		
		public function GetBankerScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton:Number=GetUserMaxJetton();
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit:Number = model.m_lAreaLimitScore - model.m_lAreaScore[5];
				//其他区域
				var lOtherAreaScore : Number= model.m_lAreaScore[1]+ model.m_lAreaScore[3]+ model.m_lAreaScore[11]+ model.m_lAreaScore[7];
				
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null ) { lBankerScore = bankUser.UserScoreInfo.lScore; }
				//庄家限制
				var lMaxPlayerScore:Number = lBankerScore+lOtherAreaScore;
				lMaxPlayerScore -= model.m_lAreaScore[5]+model.m_lAreaScore[9]*2+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*12;
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerScore, lUserMaxJetton);	
				lMaxJetton =Memory._min(lMaxJetton, lAreaLimit);
			}else {
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			lMaxJetton =Memory._max(lMaxJetton, 0);
			return lMaxJetton;
		}
		public function GetTieScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			//玩家限制
			var lUserMaxJetton:Number=GetUserMaxJetton();
			//最大下注
			var lMaxJetton : Number=0;
			//庄家判断
			if (model.m_wBankerUser!=TConst.INVALID_CHAIR)
			{
				//区域限制
				var lAreaLimit:Number = model.m_lAreaLimitScore - model.m_lAreaScore[3];
				//其他区域
				var lReturnScore : Number= model.m_lAreaScore[11] * 32 + model.m_lAreaScore[3] * 8+(model.m_lAreaScore[13]+model.m_lAreaScore[15])*11;
				//庄家积分
				var bankUser : tagUserInfoHead = model.m_User.GetUserByChair( model.m_wBankerUser );
				var lBankerScore : Number= 0;
				if( bankUser!=null ) { lBankerScore = bankUser.UserScoreInfo.lScore; }
				//庄家限制
				var lMaxPlayerScore:Number =  Memory._min(( lBankerScore - lReturnScore )/8, lAreaLimit) ;
				//最大下注
				lMaxJetton = Memory._min(lMaxPlayerScore, lUserMaxJetton);	
				lMaxJetton =Memory._min(lMaxJetton, lAreaLimit);
			}else {
				lMaxJetton=Memory._max(lUserMaxJetton,0);
			}
			//可下积分
			lMaxJetton= Memory._min(( lBankerScore - lReturnScore )/8, (model.m_lAreaLimitScore-model.m_lAreaScore[3])) ;
			lMaxJetton=Memory._max(lMaxJetton,0);
			return lMaxJetton;
		}
	}
}
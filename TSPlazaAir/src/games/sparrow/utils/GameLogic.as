package games.sparrow.utils
{
	import games.sparrow.struct.tagGangCardResult;
	
	import t.cx.air.utils.Memory;
	
	public class GameLogic
	{
		private const MASK_COLOR : uint = 0xF0;
		private const MASK_VALUE : uint = 0x0F;
		private const MAX_INDEX : uint = 34;
		
		//动作标志(Weave Item Kind)
		public static const  WIK_NULL		 : uint =	0x00;								//没有类型
		public static const  WIK_LEFT		 : uint =	0x01;								//左吃类型
		public static const  WIK_CENTER	 	 : uint =  	0x02;								//中吃类型
		public static const  WIK_RIGHT	 	 : uint = 	0x04;								//右吃类型
		public static const  WIK_PENG		 : uint = 	0x08;								//碰牌类型
		public static const  WIK_GANG		 : uint = 	0x10;								//杠牌类型
		public static const  WIK_LISTEN	 	 : uint = 	0x20;								//听牌类型
		public static const  WIK_CHI_HU	 	 : uint = 	0x40;								//吃胡类型
		public static const  WIK_BUHUA		 : uint = 0x80;									//补花类型 
		
		//胡牌定义
		/*
		//	非役满牌型(27) (累计番数)
		*/
		public static const   CHR_TUI_DAO				:  int = 0x00000001;									//推倒胡(1番)(不符合下列任何牌型的胡法)
		public static const   CHR_MEN_QING				:  int = 0x00000002;									//门清(1)
		public static const   CHR_MEN_QING_TING			:  int = 0x00000004;									//门清报听(1)
		public static const   CHR_MEN_QING_ZI_MO		:  int = 0x00000008;									//门清自摸(1)
		public static const   CHR_TIAN_TING				:  int = 0x00000010;									//天听(2)
		public static const   CHR_PING_HU				:  int = 0x00000020;									//平胡(1)
		public static const   CHR_DUAN_YAO				:  int = 0x00000040;									//断幺九(1)
		public static const   CHR_YI_BEI_KOU			:  int = 0x00000080;									//一杯口(2)(一色二顺)
		public static const   CHR_LIANG_BEI_KOU			:  int = 0x00000100;									//两杯口(4)(二色二顺)
		public static const   CHR_QI_DUI				:  int = 0x00000200;									//七对子(3)
		public static const   CHR_LONG_QI_DUI			:  int = 0x00000400;									//龙七对(6)
		public static const   CHR_PENG_PENG				:  int = 0x00000800;									//碰碰胡(2)
		public static const   CHR_SAN_SE_TONG_SHUN		:  int = 0x00001000;									//三色同顺(2)
		public static const   CHR_SAN_AN_KE				:  int = 0x00002000;									//三暗刻(2)
		public static const   CHR_SAN_LIAN_KE			:  int = 0x00004000;									//三连刻(3)
		public static const   CHR_SAN_SE_TONG_KE		:  int = 0x00008000;									//三色同刻(3)
		public static const   CHR_HUN_QUAN_YAO			:  int = 0x00010000;									//混全带幺(3)
		public static const   CHR_CHUN_QUAN_YAO			:  int = 0x00020000;									//纯全带幺(4)
		public static const   CHR_HUN_LAO_TOU			:  int = 0x00040000;									//混老头(2) ==> 国标混幺九
		public static const   CHR_HUN_YI_SE				:  int = 0x00080000;									//混一色(3)
		public static const   CHR_QING_YI_SE			:  int = 0x00100000;									//清一色(5)
		public static const   CHR_XIAO_SAN_YUAN			:  int = 0x00200000;									//小三元(4)
		public static const   CHR_YI_QI_TONG_GUAN		:  int = 0x00400000;									//一气通贯(2) ==> 国标清龙
		public static const   CHR_GANG_KAI				:  int = 0x00800000;									//杠上开花(2)
		public static const   CHR_MING_GANG			:  int = 0x01000000;										//明杠(1)
		public static const   CHR_AN_KE					:  int = 0x02000000										//暗刻
		public static const   CHR_JIAN_KE				:  int = 0x04000000										//剑刻
		public static const   CHR_ZI_MO					:  int = 0x08000000;									//自摸
		public static const   CHR_AN_GANG				:  int = 0x10040000										//暗杠
		/*
		//	役满牌型(18) (番数封顶: 13番)
		*/
		public static const   CHR_TIAN					:  int = 0x10000001;									//天胡
		public static const   CHR_DI					:  int = 0x10000002;									//地胡
		public static const   CHR_REN					:  int = 0x10000004;									//人胡
		public static const   CHR_XIAO_SI_XI			:  int = 0x10000008;									//小四喜
		public static const   CHR_DA_SI_XI				:  int = 0x10000010;									//大四喜
		public static const   CHR_DA_SAN_YUAN			:  int = 0x10000020;									//大三元
		public static const   CHR_DA_CHE_LUN			:  int = 0x10000040;									//大车轮
		public static const   CHR_SI_AN_KE				:  int = 0x10000080;									//四暗刻
		public static const   CHR_SI_LIAN_KE			:  int = 0x10000100;									//四连刻
		public static const   CHR_SI_GANG				:  int = 0x10000200;									//四杠子
		public static const   CHR_BAI_WAN_DAN			:  int = 0x10000400;									//百万石
		public static const   CHR_ZI_YI_SE				:  int = 0x10000800;									//字一色
		public static const   CHR_QING_LAO_TOU			:  int = 0x10001000;									//清老头 ==> 国标清幺九
		public static const   CHR_LV_YI_SE				:  int = 0x10002000;									//绿一色
		public static const   CHR_HONG_KONG_QUE			:  int = 0x10004000;									//红孔雀
		public static const   CHR_JIU_LIAN_DENG			:  int = 0x10008000;									//九莲宝灯
		public static const   CHR_SHI_SAN_YAO			:  int = 0x10010000;									//十三幺
		public static const   CHR_XIN_GAN_XIAN			:  int = 0x10020000;									//东北新干线
		
		
		private static var _instance : GameLogic;
		public static function getInstance() : GameLogic
		{
			return _instance == null?(_instance = new GameLogic()) : _instance;
		}
		public function GameLogic()
		{
		}
		
		public function SwitchToCardData(cbCardIndex : uint) : uint
		{
			if( cbCardIndex < 27 ) {
				return ((cbCardIndex/9)<<4)|(cbCardIndex%9+1);
			} else {
				return (0x30|(cbCardIndex-27+1));
			}
		}
		//麻将转换
		public function  SwitchToCardIndex(cbCardData : int) : int
		{
			return ((cbCardData&MASK_COLOR)>>4)*9+(cbCardData&MASK_VALUE)-1;
		}
		
		//麻将转换
		public function SwitchToCardDatas(cbCardIndex : Array, cbCardData : Array) : uint
		{
				//转换麻将
				var cbPosition : uint=0;
				for (var i : uint=0;i<MAX_INDEX;i++)
				{
					if (cbCardIndex[i]!=0)
					{
						//麻将排序
						for (var j : uint=0;j<cbCardIndex[i];j++)
						{
							cbCardData[cbPosition++]=SwitchToCardData(i);
						}
					}
				}
			return cbPosition;
		}
		//麻将转换
		public function SwitchToCardIndexs( cbCardData : Array,  cbCardCount : uint,cbCardIndex : Array) : uint
		{
			//转换麻将
			for (var i : uint =0;i<cbCardCount;i++)
			{
				cbCardIndex[SwitchToCardIndex(cbCardData[i])]++;
			}
			return cbCardCount;
		}
		
		//删除麻将
		public function RemoveCard(cbCardIndex : Array, cbRemoveCard : uint) : Boolean
		{
			//删除麻将
			var cbRemoveIndex : uint =SwitchToCardIndex(cbRemoveCard);
			if (cbCardIndex[cbRemoveIndex]>0)
			{
				cbCardIndex[cbRemoveIndex]--;
				return true;
			}
			return false;
		}
		
		//删除麻将
		public function RemoveCards(cbCardIndex : Array, cbRemoveCard : Array, cbRemoveCount : uint) : Boolean
		{
			var i : uint = 0;
			//删除麻将
			for ( i=0;i<cbRemoveCount;i++)
			{
				//删除麻将
				var cbRemoveIndex : uint= cbRemoveCard[i];
				if (cbCardIndex[cbRemoveIndex]==0)
				{
					//还原删除
					for (var j : uint =0;j<i;j++) 
					{
						cbCardIndex[cbRemoveCard[j]]++;
					}
					
					return false;
				}
				else 
				{
					--cbCardIndex[cbRemoveIndex];
				}
			}
			return true;
		}
		//删除麻将
		public function RemoveCardArrs(cbCardData : Array, cbCardCount : uint, cbRemoveCard : Array, cbRemoveCount : uint) : Boolean
		{
			//定义变量
			var cbDeleteCount : uint =0;
			var cbTempCardData : Array = Memory._newArrayAndSetValue(14,0);
			if (cbCardCount>cbTempCardData.length) return false;
			Memory._copyArray(cbTempCardData,cbCardData,cbCardCount);
			
			var i : uint = 0;
			//置零麻将
			for ( i=0;i<cbRemoveCount;i++)
			{
				for (var j : uint=0;j<cbCardCount;j++)
				{
					if (cbRemoveCard[i]==cbTempCardData[j])
					{
						cbDeleteCount++;
						cbTempCardData[j]=0;
						break;
					}
				}
			}
			//成功判断
			if (cbDeleteCount!=cbRemoveCount)  { return false; }
			
			//清理麻将
			var cbCardPos : uint = 0;
			for ( i=0;i<cbCardCount;i++)
			{
				if (cbTempCardData[i]!=0) 
					cbCardData[cbCardPos++]=cbTempCardData[i];
			}
			return true;
		}
		//有效判断
		public function IsValidCard( cbCardData : uint) : Boolean
		{
			var cbValue : uint=(cbCardData&MASK_VALUE);
			var cbColor : uint=(cbCardData&MASK_COLOR)>>4;
			return (((cbValue>=1)&&(cbValue<=9)&&(cbColor<=2))||((cbValue>=1)&&(cbValue<=0x0f)&&(cbColor==3)));
		}

		//杠牌分析
		public function AnalyseGangCard(cbCardIndex : Array, WeaveItem : Array,  cbWeaveCount : uint, GangCardResult : tagGangCardResult) : uint
		{
			//设置变量
			var cbActionMask : uint =WIK_NULL;
			var i : uint = 0;
			//手上杠牌 (暗杠)
			for ( i=0;i<MAX_INDEX;i++)
			{
				if (cbCardIndex[i]==4)
				{
					cbActionMask|=WIK_GANG;
					GangCardResult.cbCardData[GangCardResult.cbCardCount] = i;
					GangCardResult.cbGangType[GangCardResult.cbCardCount] = 2;	//暗杠
					GangCardResult.cbCardCount++;
				}
			}
			//组合杠牌 (碰杠)
			for ( i=0;i<cbWeaveCount;i++)
			{
				if (WeaveItem[i].cbWeaveKind==WIK_PENG)
				{
					if (cbCardIndex[WeaveItem[i].cbCenterCard]==1)
					{
						cbActionMask |= WIK_GANG;
						GangCardResult.cbCardData[GangCardResult.cbCardCount]=WeaveItem[i].cbCenterCard;
						GangCardResult.cbGangType[GangCardResult.cbCardCount] = 3;	//碰杠
						GangCardResult.cbCardCount++
					}
				}
			}
			return cbActionMask;
		}
		
		
		//获取组合
		public function GetWeaveCard( cbWeaveKind : uint, cbCenterCard : uint,cbCardBuffer : Array):uint
		{
			//组合麻将
			switch (cbWeaveKind)
			{
				case WIK_LEFT:		//左吃操作
				{
					//设置变量
					cbCardBuffer[0]=cbCenterCard;
					cbCardBuffer[1]=cbCenterCard+1;
					cbCardBuffer[2]=cbCenterCard+2;
					
					return 3;
				}
				case WIK_RIGHT:		//右吃操作
				{
					//设置变量
					cbCardBuffer[0]=cbCenterCard;
					cbCardBuffer[1]=cbCenterCard-2;
					cbCardBuffer[2]=cbCenterCard-1;
					
					return 3;
				}
				case WIK_CENTER:	//中吃操作
				{
					//设置变量
					cbCardBuffer[0]=cbCenterCard;
					cbCardBuffer[1]=cbCenterCard-1;
					cbCardBuffer[2]=cbCenterCard+1;
					
					return 3;
				}
				case WIK_PENG:		//碰牌操作
				{
					//设置变量
					cbCardBuffer[0]=cbCenterCard;
					cbCardBuffer[1]=cbCenterCard;
					cbCardBuffer[2]=cbCenterCard;
					
					return 3;
				}
				case WIK_GANG:		//杠牌操作
				{
					//设置变量
					cbCardBuffer[0]=cbCenterCard;
					cbCardBuffer[1]=cbCenterCard;
					cbCardBuffer[2]=cbCenterCard;
					cbCardBuffer[3]=cbCenterCard;
					return 4;
				}
			}
			return 0;
		}

		//胡牌番数
		public function  CalcFanValue(ChiHuRightArr : Array) : Array 
		{
			var arr : Array = new Array();
			//役满牌型
			var ChiHuRight : int = ChiHuRightArr[0];
			
			//非役满牌型
			if ( (ChiHuRight&CHR_TUI_DAO)!=0 ) 
				arr.push({name:'推倒胡',value:1});
			if ( (ChiHuRight&CHR_MEN_QING)!=0 ) 
				arr.push({name:'门清',value:1});
			if ( (ChiHuRight&CHR_MEN_QING_TING)!=0 ) 
				arr.push({name:'门清报听',value:1});
			if ( (ChiHuRight&CHR_MEN_QING_ZI_MO)!=0 ) 
				arr.push({name:'门清自摸',value:1});
			if ( (ChiHuRight&CHR_TIAN_TING)!=0 )
				arr.push({name:'天听',value:1});
			if ( (ChiHuRight&CHR_PING_HU)!=0 ) 
				arr.push({name:'平胡',value:1});
			if ( (ChiHuRight&CHR_DUAN_YAO)!=0 ) 
				arr.push({name:'断幺九',value:1});
			if ( (ChiHuRight&CHR_YI_BEI_KOU)!=0 ) 
				arr.push({name:'一杯口',value:1});
			if ( (ChiHuRight&CHR_LIANG_BEI_KOU)!=0 )
				arr.push({name:'两杯口',value:1});
			if ( (ChiHuRight&CHR_QI_DUI)!=0 ) 
				arr.push({name:'七对子',value:2});
			if ( (ChiHuRight&CHR_LONG_QI_DUI)!=0 ) 
				arr.push({name:'龙七对',value:2});
			if ( (ChiHuRight&CHR_PENG_PENG)!=0 ) 
				arr.push({name:'碰碰胡',value:1});
			if ( (ChiHuRight&CHR_SAN_SE_TONG_SHUN)!=0 ) 
				arr.push({name:'三色同顺',value:1});
			if ( (ChiHuRight&CHR_SAN_AN_KE)!=0 )
				arr.push({name:'三暗刻',value:2});
			if ( (ChiHuRight&CHR_SAN_LIAN_KE)!=0 ) 
				arr.push({name:'三连刻',value:2});
			if ( (ChiHuRight&CHR_SAN_SE_TONG_KE)!=0 ) 
				arr.push({name:'三色同刻',value:2});
			if ( (ChiHuRight&CHR_HUN_QUAN_YAO)!=0 )
				arr.push({name:'混全带幺',value:2});
			if ( (ChiHuRight&CHR_CHUN_QUAN_YAO)!=0 ) 
				arr.push({name:'纯全带幺',value:2});
			if ( (ChiHuRight&CHR_HUN_LAO_TOU)!=0 ) 
				arr.push({name:'混老头',value:2});
			if ( (ChiHuRight&CHR_HUN_YI_SE)!=0 ) 
				arr.push({name:'混一色',value:1});
			if ( (ChiHuRight&CHR_QING_YI_SE)!=0 ) 
				arr.push({name:'清一色',value:2});
			if ( (ChiHuRight&CHR_XIAO_SAN_YUAN)!=0 ) 
				arr.push({name:'小三元',value:3});
			if ( (ChiHuRight&CHR_YI_QI_TONG_GUAN)!=0 ) 
				arr.push({name:'一气通贯',value:2});
			if ( (ChiHuRight&CHR_GANG_KAI)!=0 ) 
				arr.push({name:'杠上开花',value:1});
			if ( (ChiHuRight&CHR_JIAN_KE)!=0 ) 
				arr.push({name:'剑刻',value:1});
			if ( (ChiHuRight&CHR_AN_KE)!=0 ) 
				arr.push({name:'暗刻',value:1});
			if ( (ChiHuRight&CHR_ZI_MO)!=0 )
				arr.push({name:'自摸',value:2});
			
			ChiHuRight = ChiHuRightArr[1];
			if ( (ChiHuRight&CHR_TIAN) != 0 )
				arr.push({name:'天胡',value:3});
			if ( (ChiHuRight&CHR_DI) != 0 )
				arr.push({name:'地胡',value:3});
			if ( (ChiHuRight&CHR_REN) != 0 )
				arr.push({name:'人胡',value:3});
			if ( (ChiHuRight&CHR_XIAO_SI_XI)!=0  )
				arr.push({name:'小四喜',value:3});
			if ( (ChiHuRight&CHR_DA_SI_XI)!=0 )
				arr.push({name:'大四喜',value:3});
			if ( (ChiHuRight&CHR_DA_SAN_YUAN)!=0 )
				arr.push({name:'大三元',value:3});
			if ( (ChiHuRight&CHR_DA_CHE_LUN)!=0 )
				arr.push({name:'大车轮',value:3});
			if ( (ChiHuRight&CHR_SI_AN_KE) !=0 )
				arr.push({name:'四暗刻',value:3});
			if ( (ChiHuRight&CHR_SI_LIAN_KE)!=0 )
				arr.push({name:'四连刻',value:3});
			if ( (ChiHuRight&CHR_SI_GANG)!=0 )
				arr.push({name:'四杠子',value:3});
			if ( (ChiHuRight&CHR_BAI_WAN_DAN)!=0 )
				arr.push({name:'百万石',value:3});
			if ( (ChiHuRight&CHR_ZI_YI_SE)!=0 )
				arr.push({name:'字一色',value:3});
			if ( (ChiHuRight&CHR_QING_LAO_TOU)!=0 )
				arr.push({name:'清老头',value:3});
			if ( (ChiHuRight&CHR_LV_YI_SE)!=0 )
				arr.push({name:'绿一色',value:3});
			if ( (ChiHuRight&CHR_HONG_KONG_QUE)!=0 )
				arr.push({name:'红孔雀',value:3});
			if ( (ChiHuRight&CHR_JIU_LIAN_DENG)!=0 )
				arr.push({name:'九莲宝灯',value:3});
			if ( (ChiHuRight&CHR_SHI_SAN_YAO)!=0 )
				arr.push({name:'十三幺',value:3});
		 	if ( (ChiHuRight&CHR_XIN_GAN_XIAN)!=0 )
				arr.push({name:'东北新干线',value:3});
			return arr;
		}
	}
	
}
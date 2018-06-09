package games.gswz.units
{
	import flash.utils.ByteArray;
	
	import games.gswz.struct.tagAnalyseResult;
	
	import t.cx.air.utils.Memory;
	
	public class GswzLogic
	{
		
		//扑克类型
		public static const CT_SINGLE			:uint = 1;									//单牌类型
		public static const CT_ONE_DOUBLE		:uint = 2;									//对子类型
		public static const CT_TWO_DOUBLE		:uint = 3;									//两对类型
		public static const CT_THREE_TIAO		:uint = 4;									//三条类型
		public static const	CT_SHUN_ZI			:uint = 5;									//顺子类型
		public static const CT_TONG_HUA			:uint = 6;									//同花类型
		public static const CT_HU_LU			:uint = 7;									//葫芦类型
		public static const CT_TIE_ZHI			:uint = 8;									//铁支类型
		public static const CT_TONG_HUA_SHUN	:uint = 9;									//同花顺型
		
		
		//宏定义
		
		public static const MAX_COUNT			:uint = 5;									//最大数目
		
		//数值掩码
		public static const	LOGIC_MASK_COLOR	:uint = 0xF0;								//花色掩码
		public static const	LOGIC_MASK_VALUE	:uint = 0x0F;								//数值掩码
		
		
		
		public function GswzLogic()
		{
		}
		
		
		
		//获取类型
		public function GetCardType(cbCardData:Array, cbCardCount:int):int
		{
			SortCardList(cbCardData, cbCardCount);
			
			//简单牌形
			switch (cbCardCount)
			{
				case 1: //单牌
				{
					return CT_SINGLE;
				}
				case 2:	//对牌
				{
					return (GetCardLogicValue(cbCardData[0])==GetCardLogicValue(cbCardData[1]))?CT_ONE_DOUBLE:CT_SINGLE;
				}
			}
			
			//五条类型
			if (cbCardCount==5)
			{
				//变量定义
				var cbSameColor:Boolean=true,bLineCard:Boolean=true;
				var cbFirstColor:int=GetCardColor(cbCardData[0]);
				var cbFirstValue:int=GetCardLogicValue(cbCardData[0]);
				
				//牌形分析
				for (var i:int=1;i<cbCardCount;i++)
				{
					//数据分析
					if (GetCardColor(cbCardData[i])!=cbFirstColor) cbSameColor=false;
					if (cbFirstValue!=(GetCardLogicValue(cbCardData[i])+i)) bLineCard=false;
					
					//结束判断
					if ((cbSameColor==false)&&(bLineCard==false)) break;
				}
				
				//顺子类型
				if ((cbSameColor==false)&&(bLineCard==true)) return CT_SHUN_ZI;
				
				//同花类型
				if ((cbSameColor==true)&&(bLineCard==false)) return CT_TONG_HUA;
				
				//同花顺类型
				if ((cbSameColor==true)&&(bLineCard==true)) return CT_TONG_HUA_SHUN;
			}
			
			//扑克分析
			var AnalyseResult:tagAnalyseResult = new tagAnalyseResult;
			AnalysebCardData(cbCardData,cbCardCount,AnalyseResult);
			
			//类型判断
			if (AnalyseResult.cbFourCount==1) return CT_TIE_ZHI;
			if (AnalyseResult.cbDoubleCount==2) return CT_TWO_DOUBLE;
			if ((AnalyseResult.cbDoubleCount==1)&&(AnalyseResult.cbThreeCount==1)) return CT_HU_LU;
			if ((AnalyseResult.cbThreeCount==1)&&(AnalyseResult.cbDoubleCount==0)) return CT_THREE_TIAO;
			if ((AnalyseResult.cbDoubleCount==1)&&(AnalyseResult.cbThreeCount==0)) return CT_ONE_DOUBLE;
			
			return CT_SINGLE;
		}
		
		
		//排列扑克
		public function SortCardList(cbCardData:Array, cbCardCount:int):void
		{
			//转换数值
			var cbLogicValue:Array = new Array(MAX_COUNT);
			for (var i:int=0;i<cbCardCount;i++) cbLogicValue[i]=GetCardLogicValue(cbCardData[i]);	
			
			//排序操作
			var bSorted:Boolean=true;
			var cbTempData:int=cbCardCount-1,bLast:int=cbCardCount-1;
			do
			{
				bSorted=true;
				for (i=0;i<bLast;i++)
				{
					if ((cbLogicValue[i]<cbLogicValue[i+1])||
						((cbLogicValue[i]==cbLogicValue[i+1])&&(cbCardData[i]<cbCardData[i+1])))
					{
						//交换位置
						cbTempData=cbCardData[i];
						cbCardData[i]=cbCardData[i+1];
						cbCardData[i+1]=cbTempData;
						cbTempData=cbLogicValue[i];
						cbLogicValue[i]=cbLogicValue[i+1];
						cbLogicValue[i+1]=cbTempData;
						bSorted=false;
					}	
				}
				bLast--;
			} while(bSorted==false);
			
			return;
		}
		
		
		
		
		
		
		//逻辑数值
		public function GetCardLogicValue(cbCardData:int):int
		{
			//扑克属性
			var bCardColor:int=GetCardColor(cbCardData);
			var bCardValue:int=GetCardValue(cbCardData);
			
			//转换数值
			return (bCardValue<=2)?(bCardValue+13):bCardValue;
		}
		
		
		/**
		 * 获取数值
		 * */
		public function GetCardValue(cbCardData : uint) : uint
		{
			return cbCardData&LOGIC_MASK_VALUE; 
		}
		/**
		 * 获取花色
		 * */
		public function GetCardColor(cbCardData : uint) : uint
		{
			return cbCardData&LOGIC_MASK_COLOR;
		}
		
		
		//分析扑克
		public function AnalysebCardData(cbCardData:Array, cbCardCount:int, AnalyseResult:tagAnalyseResult):void
		{
			//设置结果
			//				ZeroMemory(&AnalyseResult,sizeof(AnalyseResult));
			
			//扑克分析
			for (var i:int=0;i<cbCardCount;i++)
			{
				//变量定义
				var cbSameCount:int=1;
				var cbSameCardData:ByteArray=new ByteArray;
				cbSameCardData[0] = cbCardData[i];
				cbSameCardData[1] = 0;
				cbSameCardData[2] = 0;
				cbSameCardData[3] = 0;
				var cbLogicValue:int=GetCardLogicValue(cbCardData[i]);
				
				//获取同牌
				for (var j:int=i+1;j<cbCardCount;j++)
				{
					//逻辑对比
					if (GetCardLogicValue(cbCardData[j])!=cbLogicValue) break;
					
					//设置扑克
					cbSameCardData[cbSameCount++]=cbCardData[j];
				}
				
				//保存结果
				switch (cbSameCount)
				{
					case 1:		//单张
					{
						AnalyseResult.cbSignedLogicVolue[AnalyseResult.cbSignedCount]=cbLogicValue;
						AnalyseResult.cbSignedCount++;
						AnalyseResult.cbSignedCardData 	= cbSameCardData;
						//							CopyMemory(&AnalyseResult.cbSignedCardData[(AnalyseResult.cbSignedCount++)*cbSameCount],cbSameCardData,cbSameCount);
						break;
					}
					case 2:		//两张
					{
						AnalyseResult.cbDoubleLogicVolue[AnalyseResult.cbDoubleCount]=cbLogicValue;
						AnalyseResult.cbDoubleCount++;
						AnalyseResult.cbDoubleCardData 	= cbSameCardData;
						//							CopyMemory(&AnalyseResult.cbDoubleCardData[(AnalyseResult.cbDoubleCount++)*cbSameCount],cbSameCardData,cbSameCount);
						break;
					}
					case 3:		//三张
					{
						AnalyseResult.cbThreeLogicVolue[AnalyseResult.cbThreeCount]=cbLogicValue;
						AnalyseResult.cbThreeCount++;
						AnalyseResult.cbThreeCardData 	= cbSameCardData;
						//							CopyMemory(&AnalyseResult.cbThreeCardData[(AnalyseResult.cbThreeCount++)*cbSameCount],cbSameCardData,cbSameCount);
						break;
					}
					case 4:		//四张
					{
						AnalyseResult.cbFourLogicVolue[AnalyseResult.cbFourCount]=cbLogicValue;
						AnalyseResult.cbFourCount++;
						AnalyseResult.cbFourCardData 	= cbSameCardData;
						//							CopyMemory(&AnalyseResult.cbFourCardData[(AnalyseResult.cbFourCount++)*cbSameCount],cbSameCardData,cbSameCount);
						break;
					}
				}
				
				//设置递增
				i+=cbSameCount-1;
			}
			
			return;
		}
		
		
		
		
		
		
	}
}
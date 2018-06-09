package games.landlord.utils
{
	
	import games.landlord.model.LandModel;
	import games.landlord.model.vo.tagAnalyseResult;
	import games.landlord.model.vo.tagOutCardResult;
	
	import t.cx.air.utils.Memory;
	
	public class LandLogic
	{
		protected static var _instance : LandLogic;
		public static function GetInstance() : LandLogic
		{
			return _instance == null ? _instance = new LandLogic() : _instance;
		}
		
		
		
		//排序类型
		public const ST_ORDER				: uint = 0;							//大小排序
		public const ST_COUNT				: uint = 1;							//数目排序
		
		//////////////////////////////////////////////////////////////////////////
		//数目定义
		
		public const MAX_COUNT				: uint = 20;						//最大数目
		public const FULL_COUNT				: uint = 54;						//全牌数目
		public const BACK_COUNT				: uint = 3;							//底牌数目
		public const NORMAL_COUNT			: uint = 17;						//常规数目
		
		//////////////////////////////////////////////////////////////////////////
		
		//数值掩码
		public const MASK_COLOR				: uint = 0xF0;						//花色掩码
		public const MASK_VALUE				: uint = 0x0F;						//数值掩码
		
		//扑克类型
		public const CT_ERROR				: uint = 0;							//错误类型
		public const CT_SINGLE				: uint = 1;							//单牌类型
		public const CT_DOUBLE				: uint = 2;							//对牌类型
		public const CT_THREE				: uint = 3;							//三条类型
		public const CT_SINGLE_LINE			: uint = 4;							//单连类型
		public const CT_DOUBLE_LINE			: uint = 5;							//对连类型
		public const CT_THREE_LINE			: uint = 6;							//三连类型
		public const CT_THREE_LINE_TAKE_ONE	: uint = 7;							//三带一单
		public const CT_THREE_LINE_TAKE_TWO	: uint = 8;							//三带一对
		public const CT_FOUR_LINE_TAKE_ONE	: uint = 9;							//四带两单
		public const CT_FOUR_LINE_TAKE_TWO	: uint = 10;						//四带两对
		public const CT_PLANE				: uint = 11;						//飞机类型
		public const CT_BOMB_CARD			: uint = 12;						//炸弹类型
		public const CT_MISSILE_CARD		: uint = 13;						//火箭类型
		
		public function LandLogic()
		{
		}
		/**
		 * 扑克排序
		 * */
		public function SortCardList(cbCards : Array,cbCardCount : uint,cbSortType : uint) : void
		{
			//数目过虑
			if (cbCardCount==0) return;
			//转换数值
			var cbSortValue : Array = Memory._newArrayAndSetValue(20,0);
			var i : uint = 0;
			for (i=0;i<cbCardCount;i++) cbSortValue[i]=GetCardLogicValue(cbCards[i]);
			
			//排序操作
			var bSorted : Boolean = true;
			var cbThreeCount : uint = cbCardCount-1;
			var cbLast : uint = cbCardCount-1;
			do
			{
				bSorted=true;
				for (i=0;i<cbLast;i++)
				{
					if ((cbSortValue[i]<cbSortValue[i+1])||
						((cbSortValue[i]==cbSortValue[i+1])&&(cbCards[i]<cbCards[i+1])))
					{
						//交换位置
						cbThreeCount=cbCards[i];
						cbCards[i]=cbCards[i+1];
						cbCards[i+1]=cbThreeCount;
						cbThreeCount=cbSortValue[i];
						cbSortValue[i]=cbSortValue[i+1];
						cbSortValue[i+1]=cbThreeCount;
						bSorted=false;
					}	
				}
				cbLast--;
			} while(bSorted==false);
			
			
			//数目排序
			if (cbSortType==ST_COUNT)
			{
				//分析扑克
				var cbIndex : uint=0;
				var AnalyseResult : tagAnalyseResult = AnalysebCardData(cbCards,cbCardCount);
				
				//拷贝四牌
				Memory._copyArray(cbCards,AnalyseResult.cbFourCardData,AnalyseResult.cbFourCount*4,cbIndex);
				cbIndex+=AnalyseResult.cbFourCount*4;
				
				//拷贝三牌
				Memory._copyArray(cbCards,AnalyseResult.cbThreeCardData,AnalyseResult.cbThreeCount*3,cbIndex);
				cbIndex+=AnalyseResult.cbThreeCount*3;
				
				//拷贝对牌
				Memory._copyArray(cbCards,AnalyseResult.cbDoubleCardData,AnalyseResult.cbDoubleCount*2,cbIndex);
				cbIndex+=AnalyseResult.cbDoubleCount*2;
				
				//拷贝单牌
				Memory._copyArray(cbCards,AnalyseResult.cbSignedCardData,AnalyseResult.cbSignedCount*1,cbIndex);
				cbIndex+=AnalyseResult.cbSignedCount;
			}
		}
		
		/**
		 * 有效判断
		 * */
		public function IsValidCard(cbCardData : uint) : Boolean
		{
			//获取属性
			var cbCardColor : uint =GetCardColor(cbCardData);
			var cbCardValue : uint =GetCardValue(cbCardData);
			
			//有效判断
			if ((cbCardData==0x4E)||(cbCardData==0x4F)) return true;
			if ((cbCardColor<=0x30)&&(cbCardValue>=0x01)&&(cbCardValue<=0x0D)) return true;
			
			return false;
		}
		
		/**
		 * 获取类型
		 * */
		public function GetCardType(cbCards : Array,cbCardCount : uint) : uint
		{
			//简单牌型
			switch (cbCardCount)
			{
				case 0:	//空牌
				{
					return CT_ERROR;
				}
				case 1: //单牌
				{
					return CT_SINGLE;
				}
				case 2:	//对牌火箭
				{
					//牌型判断
					if ((cbCards[0]==0x4F)&&(cbCards[1]==0x4E)) return CT_MISSILE_CARD;
					if (GetCardLogicValue(cbCards[0])==GetCardLogicValue(cbCards[1])) return CT_DOUBLE;
					return CT_ERROR;
				}
			}
			//分析扑克
			var AnalyseResult : tagAnalyseResult = AnalysebCardData(cbCards,cbCardCount);
			var i : uint = 0;
			//四牌判断
			if (AnalyseResult.cbFourCount>0)
			{
				//牌型判断
				if ((AnalyseResult.cbFourCount==1)&&(cbCardCount==4)) return CT_BOMB_CARD;
				if ((AnalyseResult.cbFourCount==1)&&(AnalyseResult.cbSignedCount==2)&&(cbCardCount==6)) return CT_FOUR_LINE_TAKE_ONE;
				if ((AnalyseResult.cbFourCount==1)&&(AnalyseResult.cbDoubleCount==2)&&(cbCardCount==8)) return CT_FOUR_LINE_TAKE_TWO;
				if ((AnalyseResult.cbFourCount==1)&&(AnalyseResult.cbDoubleCount==1)&&(cbCardCount==6)) return CT_FOUR_LINE_TAKE_ONE;
				
				return CT_ERROR;
			}
			var cbCardData : uint;
			var cbFirstLogicValue : uint;
			//三牌判断
			if (AnalyseResult.cbThreeCount>0)
			{
				//三条类型
				if(AnalyseResult.cbThreeCount==1 && cbCardCount==3) return CT_THREE ;
				
				//连牌判断
				if (AnalyseResult.cbThreeCount>1)
				{
					//变量定义
					cbCardData = AnalyseResult.cbThreeCardData[0];
					cbFirstLogicValue =GetCardLogicValue(cbCardData);
					
					//错误过虑
					if (cbFirstLogicValue>=15) return CT_ERROR;
					
					//连牌判断
					for ( i=1;i<AnalyseResult.cbThreeCount;i++ )
					{
						cbCardData =AnalyseResult.cbThreeCardData[i*3];
						if (cbFirstLogicValue!=(GetCardLogicValue(cbCardData)+i)) return CT_ERROR;
					}
				}
				//牌形判断
				if (AnalyseResult.cbThreeCount==1){
					if (AnalyseResult.cbThreeCount*3==cbCardCount) return CT_THREE_LINE;
					if (AnalyseResult.cbThreeCount*4==cbCardCount) return CT_THREE_LINE_TAKE_ONE;
					if ((AnalyseResult.cbThreeCount*5==cbCardCount)&&(AnalyseResult.cbDoubleCount==AnalyseResult.cbThreeCount)) return CT_THREE_LINE_TAKE_TWO;
				}else if (AnalyseResult.cbThreeCount*3==cbCardCount||
					(AnalyseResult.cbThreeCount*4==cbCardCount&&AnalyseResult.cbThreeCount == (AnalyseResult.cbSignedCount+AnalyseResult.cbDoubleCount*2)) ||
					(AnalyseResult.cbThreeCount*5==cbCardCount&&AnalyseResult.cbDoubleCount==AnalyseResult.cbThreeCount)){
					return CT_PLANE;
				}
				return CT_ERROR;
			}
			
			//两张类型
			if (AnalyseResult.cbDoubleCount>=3)
			{
				//变量定义
				cbCardData =AnalyseResult.cbDoubleCardData[0];
				cbFirstLogicValue=GetCardLogicValue(cbCardData);
				
				//错误过虑
				if (cbFirstLogicValue>=15) return CT_ERROR;
				
				//连牌判断
				for ( i=1;i<AnalyseResult.cbDoubleCount;i++ )
				{
					cbCardData=AnalyseResult.cbDoubleCardData[i*2];
					if (cbFirstLogicValue!=(GetCardLogicValue(cbCardData)+i)) return CT_ERROR;
				}
				
				//二连判断
				if ((AnalyseResult.cbDoubleCount*2)==cbCardCount) return CT_DOUBLE_LINE;
				
				return CT_ERROR;
			}
			//单张判断
			if ((AnalyseResult.cbSignedCount>=5)&&(AnalyseResult.cbSignedCount==cbCardCount))
			{
				//变量定义
				cbCardData			= AnalyseResult.cbSignedCardData[0];
				cbFirstLogicValue 	= GetCardLogicValue(cbCardData);
				
				//错误过虑
				if (cbFirstLogicValue>=15) return CT_ERROR;
				
				//连牌判断
				for ( i=1;i<AnalyseResult.cbSignedCount;i++ )
				{
					cbCardData =AnalyseResult.cbSignedCardData[i];
					if (cbFirstLogicValue!=(GetCardLogicValue(cbCardData)+i)) return CT_ERROR;
				}
				return CT_SINGLE_LINE;
			}
			return CT_ERROR;
		}
		/**
		 * 分析扑克
		 * */
		public function AnalysebCardData(cbCardData : Array,cbCardCount : uint) : tagAnalyseResult
		{
			var result : tagAnalyseResult = new tagAnalyseResult;
			var i : uint = 0;
			var j : uint = 0;
			//扑克分析
			for (i=0; i<cbCardCount; i++)
			{
				//变量定义
				var cbSameCount : uint 		=1;
				var cbCardValueTemp : uint 	=0;
				
				var cbLogicValue : uint = GetCardLogicValue(cbCardData[i]);
				//搜索同牌
				for ( j=i+1;j<cbCardCount;j++)
				{
					//获取扑克
					if (GetCardLogicValue(cbCardData[j])!=cbLogicValue) break;
					//设置变量
					cbSameCount++;
				}
				//设置结果
				var cbIndex : uint = 0;
				switch (cbSameCount)
				{
					case 1:		//单张
					{
						cbIndex =result.cbSignedCount++;
						result.cbSignedCardData[cbIndex*cbSameCount]=cbCardData[i];
						break;
					}
					case 2:		//两张
					{
						cbIndex =result.cbDoubleCount++;
						result.cbDoubleCardData[cbIndex*cbSameCount]=cbCardData[i];
						result.cbDoubleCardData[cbIndex*cbSameCount+1]=cbCardData[i+1];
						break;
					}
					case 3:		//三张
					{
						cbIndex =result.cbThreeCount++;
						result.cbThreeCardData[cbIndex*cbSameCount]=cbCardData[i];
						result.cbThreeCardData[cbIndex*cbSameCount+1]=cbCardData[i+1];
						result.cbThreeCardData[cbIndex*cbSameCount+2]=cbCardData[i+2];
						break;
					}
					case 4:		//四张
					{
						cbIndex=result.cbFourCount++;
						result.cbFourCardData[cbIndex*cbSameCount]=cbCardData[i];
						result.cbFourCardData[cbIndex*cbSameCount+1]=cbCardData[i+1];
						result.cbFourCardData[cbIndex*cbSameCount+2]=cbCardData[i+2];
						result.cbFourCardData[cbIndex*cbSameCount+3]=cbCardData[i+3];
						break;
					}
				}
				//设置索引
				i+=cbSameCount-1;
			}
			return result;
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
			if (cbCardColor==0x40) return cbCardValue+2;
			return (cbCardValue<=2 && cbCardValue>0)?(cbCardValue+13):cbCardValue;
		}
		/**
		 * 删除扑克
		 * */
		public function RemoveCard( cbRemoveCard : Array, cbRemoveCount : uint,cbCardData : Array, cbCardCount : uint) : Boolean
		{
			//定义变量
			var cbDeleteCount : uint = 0;
			var cbTempCardData : Array = Memory._newArrayAndSetValue(20,0);
			if (cbCardCount>cbTempCardData.length) return false;
			Memory._copyArray(cbTempCardData,cbCardData,cbCardCount);
			var i : uint = 0;
			var j : uint = 0;
			//置零扑克
			for ( i=0;i<cbRemoveCount;i++)
			{
				for ( j=0;j<cbCardCount;j++)
				{
					if (cbRemoveCard[i]==cbTempCardData[j])
					{
						cbDeleteCount++;
						cbTempCardData[j]=0;
						break;
					}
				}
			}
			if (cbDeleteCount!=cbRemoveCount) return false;
			
			//清理扑克
			var cbCardPos : uint = 0;
			for ( i=0;i<cbCardCount;i++ )
			{
				if (cbTempCardData[i]!=0) cbCardData[cbCardPos++]=cbTempCardData[i];
			}
			return true;
		}
		
		/**
		 * 对比扑克
		 * */
		public function CompareCard(cbFirstCard : Array,cbNextCard : Array, cbFirstCount : uint, cbNextCount : uint) : Boolean
		{
			//获取类型
			var cbNextType : uint = GetCardType(cbNextCard,cbNextCount);
			var cbFirstType: uint = GetCardType(cbFirstCard,cbFirstCount);
			
			//类型判断
			if (cbNextType==CT_ERROR) return false;
			if (cbNextType==CT_MISSILE_CARD) return true;
			//炸弹判断
			if ((cbFirstType!=CT_BOMB_CARD)&&(cbNextType==CT_BOMB_CARD)) return true;
			if ((cbFirstType==CT_BOMB_CARD)&&(cbNextType!=CT_BOMB_CARD)) return false;
			
			//规则判断
			if ((cbFirstType!=cbNextType)||(cbFirstCount!=cbNextCount)) return false;
			var cbNextLogicValue : uint;
			var cbFirstLogicValue : uint;
			var NextResult : tagAnalyseResult;
			var FirstResult : tagAnalyseResult;
			//开始对比
			switch (cbNextType)
			{
				case CT_SINGLE:
				case CT_DOUBLE:
				case CT_THREE:
				case CT_SINGLE_LINE:
				case CT_DOUBLE_LINE:
				case CT_THREE_LINE:
				case CT_BOMB_CARD:
				{
					//获取数值
					cbNextLogicValue	= GetCardLogicValue(cbNextCard[0]);
					cbFirstLogicValue	= GetCardLogicValue(cbFirstCard[0]);
					//对比扑克
					return cbNextLogicValue>cbFirstLogicValue;
				}
				case CT_THREE_LINE_TAKE_ONE:
				case CT_THREE_LINE_TAKE_TWO:
				case 	CT_PLANE:
				{
					//分析扑克
					NextResult = AnalysebCardData(cbNextCard,cbNextCount);
					FirstResult= AnalysebCardData(cbFirstCard,cbFirstCount);
					//获取数值
					cbNextLogicValue = GetCardLogicValue(NextResult.cbThreeCardData[0]);
					cbFirstLogicValue= GetCardLogicValue(FirstResult.cbThreeCardData[0]);
					
					//对比扑克
					return cbNextLogicValue>cbFirstLogicValue;
				}
				case CT_FOUR_LINE_TAKE_ONE:
				case CT_FOUR_LINE_TAKE_TWO:
				{
					//分析扑克
					NextResult = AnalysebCardData(cbNextCard,cbNextCount);
					FirstResult= AnalysebCardData(cbFirstCard,cbFirstCount);
					
					//获取数值
					cbNextLogicValue	=GetCardLogicValue(NextResult.cbFourCardData[0]);
					cbFirstLogicValue	=GetCardLogicValue(FirstResult.cbFourCardData[0]);
					//对比扑克
					return cbNextLogicValue>cbFirstLogicValue;
				}
			}
			
			return false;
		}
		public var resultCard:Array = new Array();
		public var cardArray:Array = new Array();
		public var resultIndex:int = 0;
		public var index:int = 0;
		public var cb_three_index:int = 0;
		public function SearchFirestCard(cbHandCardData : Array, cbHandCardCount : uint,cbTurnCardData : Array, cbTurnCardCount : uint) : tagOutCardResult
		{
			var i:int = 0;
			var j:int = 0;
			var result : tagOutCardResult = new tagOutCardResult();
			var AnalyseResult : tagAnalyseResult = new tagAnalyseResult();
			//构造扑克
			var cbCardData : Array= Memory._newArrayAndSetValue(20,0);
			var cbCardCount : uint = cbHandCardCount;
			Memory._copyArray(cbCardData,cbHandCardData,cbHandCardCount);
			//排列扑克
			SortCardList(cbCardData,cbCardCount,ST_ORDER);
			if(resultCard.length != 0)
			{
				if(index == 0)
				{
					//获取玩家出牌类型
					var cbTurnOutType : uint = GetCardType(cbTurnCardData,cbTurnCardCount);
					switch(cbTurnOutType) {
						case CT_SINGLE:					//单牌类型
						case CT_DOUBLE:					//对牌类型
						case CT_THREE:					//三条类型
						{
							for(i = 0;i<resultIndex;i++)
							{
								for(j = 0;j<resultCard[i].length;j++)
								{
									cardArray.push(resultCard[i][j]);
								}
							}
							for(i = 0;i<cardArray.length;i++)
							{
								for(j = cbHandCardCount-1;j>=0;j--)
								{
									if(cbHandCardData[j] == cardArray[i])
									{
										cbHandCardData.splice(j,1);
									}
								}	
							}
							//判断炸弹//搜索火箭
							if( (AnalyseResult.cbFourCount>0)||((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E)) )
							{
								for(i = 0;i<resultIndex;i++)
								{
									for(j = 0;j<resultCard[i].length;j++)
									{
										cardArray.push(resultCard[i][j]);
									}
								}
								for(i = 0;i<cardArray.length;i++)
								{
									for(j = cbHandCardCount-1;j>=0;j--)
									{
										if(cbHandCardData[j] == cardArray[i])
										{
											cbHandCardData.splice(j,1);
										}
									}	
								}
							}
							break;
						}
						case CT_THREE_LINE_TAKE_ONE:	//三带一单
						{
							//分析扑克
							AnalyseResult = AnalysebCardData(cbHandCardData,cbHandCardData.length);
							if(AnalyseResult.cbThreeCount >=1)
							{
								//判断手里的三带数值是否大于玩家出牌的数值
								for(i = 0;i<AnalyseResult.cbThreeCardData.length;i++)
								{
									if(GetCardLogicValue(AnalyseResult.cbThreeCardData[i])>GetCardLogicValue(cbTurnCardData[1]))
									{
										cb_three_index++;
									}
								}
								if(cb_three_index/3>1)
								{
									//大于1证明手牌里面有两个以上能管上的三带
									for(i = 0;i<resultIndex;i++)
									{
										for(j = 0;j<resultCard[i].length;j++)
										{
											cardArray.push(resultCard[i][j]);
										}
									}
									for(i = 0;i<cardArray.length;i++)
									{
										for(j = cbHandCardCount-1;j>=0;j--)
										{
											if((i+1)/4 == 1)
											{
												break;
											}else{
												if(cbHandCardData[j] == cardArray[i])
												{
													cbHandCardData.splice(j,1);
												}
											}
										}	
									}
									cb_three_index = 0;
								}else if(cb_three_index/3 == 1){
									//等于1证明手牌里面只有一个能管上的三带
									for(i = 0;i<resultIndex;i++)
									{
										for(j = 0;j<resultCard[i].length;j++)
										{
											cardArray.push(resultCard[i][j]);
										}
									}
									var index_re:int = cardArray.length;
									for(i = 0;i<index_re/4;i++)
									{
										for(j = cbHandCardCount-1;j>=0;j--)
										{
											if(cbHandCardData[j] == cardArray[index_re-1])
											{
												cbHandCardData.splice(j,1);
												index_re-=4;
											}
										}
									}
									cb_three_index = 0;
								}
								
							}
							//判断炸弹//搜索火箭
							if( (AnalyseResult.cbFourCount>0)||((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E)) )
							{
								for(i = 0;i<resultIndex;i++)
								{
									for(j = 0;j<resultCard[i].length;j++)
									{
										cardArray.push(resultCard[i][j]);
									}
								}
								for(i = 0;i<cardArray.length;i++)
								{
									for(j = cbHandCardCount-1;j>=0;j--)
									{
										if(cbHandCardData[j] == cardArray[i])
										{
											cbHandCardData.splice(j,1);
										}
									}	
								}
							}
							break;
						}
						case CT_THREE_LINE_TAKE_TWO:	//三带一对
						{
							//分析扑克
							AnalyseResult = AnalysebCardData(cbHandCardData,cbHandCardData.length);
							if(AnalyseResult.cbThreeCount>= 1 && AnalyseResult.cbDoubleCount != 0)
							{
								//判断手里的三带数值是否大于玩家出牌的数值
								for(i = 0;i<AnalyseResult.cbThreeCardData.length;i++)
								{
									if(GetCardLogicValue(AnalyseResult.cbThreeCardData[i])>GetCardLogicValue(cbTurnCardData[2]))
									{
										cb_three_index++;
									}
								}
								if(cb_three_index/3>1)
								{
									//大于1证明手牌里面有两个以上能管上的三带
									for(i = 0;i<resultIndex;i++)
									{
										for(j = 0;j<resultCard[i].length;j++)
										{
											cardArray.push(resultCard[i][j]);
										}
									}
									for(i = 0;i<cardArray.length;i++)
									{
										for(j = cbHandCardCount-1;j>=0;j--)
										{
											if( ((i+1)/4 == 1) || ((i+1)/5 == 1) )
											{
												break;
											}else{
												if(cbHandCardData[j] == cardArray[i])
												{
													cbHandCardData.splice(j,1);
												}
											}
										}	
									}
									cb_three_index = 0;
								}else if(cb_three_index/3 == 1){
									//等于1证明手牌里面只有一个能管上的三带
									for(i = 0;i<resultIndex;i++)
									{
										for(j = 0;j<resultCard[i].length;j++)
										{
											cardArray.push(resultCard[i][j]);
										}
									}
									var index_two:int = cardArray.length;
									for(i = 0;i<(index_two/5)*2;i++)
									{
										for(j = cbHandCardCount-1;j>=0;j--)
										{
											if(cbHandCardData[j] == AnalyseResult.cbDoubleCardData[(AnalyseResult.cbDoubleCount)*2-1-i])
											{
												cbHandCardData.splice(j,1);
											}
										}
									}
									cb_three_index = 0;
								}
							}
							//判断炸弹//搜索火箭
							if( (AnalyseResult.cbFourCount>0)||((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E)) )
							{
								for(i = 0;i<resultIndex;i++)
								{
									for(j = 0;j<resultCard[i].length;j++)
									{
										cardArray.push(resultCard[i][j]);
									}
								}
								for(i = 0;i<cardArray.length;i++)
								{
									for(j = cbHandCardCount-1;j>=0;j--)
									{
										if(cbHandCardData[j] == cardArray[i])
										{
											cbHandCardData.splice(j,1);
										}
									}	
								}
							}	
							break;
						}
						case CT_SINGLE_LINE:		//单连类型
						{
							//只删除结果数组的最后一张
							for(i = 0;i<resultIndex;i++)
							{
								for(j = 0;j<resultCard[i].length;j++)
								{
									cardArray.push(resultCard[i][j]);
								}
							}
							for(j = cbHandCardCount-1;j>=0;j--)
							{
								if(GetCardLogicValue(cbHandCardData[j]) == GetCardLogicValue(cardArray[cardArray.length-1]))
								{
									cbHandCardData.splice(j,1);
								}
							}
							//判断炸弹//搜索火箭
							if( (AnalyseResult.cbFourCount>0)||((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E)) )
							{
								for(i = 0;i<resultIndex;i++)
								{
									for(j = 0;j<resultCard[i].length;j++)
									{
										cardArray.push(resultCard[i][j]);
									}
								}
								for(i = 0;i<cardArray.length;i++)
								{
									for(j = cbHandCardCount-1;j>=0;j--)
									{
										if(cbHandCardData[j] == cardArray[i])
										{
											cbHandCardData.splice(j,1);
										}
									}	
								}
							}	
							break;
						}
						case CT_DOUBLE_LINE:		//对连类型
						{
							//保存每次结果的最小的一对牌，删除
							for(i = 0;i<resultIndex;i++)
							{
								cardArray.push(resultCard[i][resultCard[i].length-1]);
								cardArray.push(resultCard[i][resultCard[i].length-2]);
							}
							for(i = 0;i<cardArray.length;i++)
							{
								for(j = cbHandCardCount-1;j>=0;j--)
								{
									if(cbHandCardData[j] == cardArray[i])
									{
										cbHandCardData.splice(j,1);
									}
								}	
							}
							//判断炸弹//搜索火箭
							if( (AnalyseResult.cbFourCount>0)||((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E)) )
							{
								for(i = 0;i<resultIndex;i++)
								{
									for(j = 0;j<resultCard[i].length;j++)
									{
										cardArray.push(resultCard[i][j]);
									}
								}
								for(i = 0;i<cardArray.length;i++)
								{
									for(j = cbHandCardCount-1;j>=0;j--)
									{
										if(cbHandCardData[j] == cardArray[i])
										{
											cbHandCardData.splice(j,1);
										}
									}	
								}
							}	
							break;
						}
						case CT_THREE_LINE:				//三连类型
						{
							//保存每次结果的最小的三张牌，删除
							for(i = 0;i<resultIndex;i++)
							{
								cardArray.push(resultCard[i][resultCard[i].length-1]);
								cardArray.push(resultCard[i][resultCard[i].length-2]);
								cardArray.push(resultCard[i][resultCard[i].length-3]);
							}
							for(i = 0;i<cardArray.length;i++)
							{
								for(j = cbHandCardCount-1;j>=0;j--)
								{
									if(cbHandCardData[j] == cardArray[i])
									{
										cbHandCardData.splice(j,1);
									}
								}	
							}
							//判断炸弹//搜索火箭
							if( (AnalyseResult.cbFourCount>0)||((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E)) )
							{
								for(i = 0;i<resultIndex;i++)
								{
									for(j = 0;j<resultCard[i].length;j++)
									{
										cardArray.push(resultCard[i][j]);
									}
								}
								for(i = 0;i<cardArray.length;i++)
								{
									for(j = cbHandCardCount-1;j>=0;j--)
									{
										if(cbHandCardData[j] == cardArray[i])
										{
											cbHandCardData.splice(j,1);
										}
									}	
								}
							}
							break;
						}
					}
					result = SearchOutCard(cbHandCardData, cbHandCardData.length,cbTurnCardData, cbTurnCardCount);
					if((result.cbCardCount == 0)&&(resultCard.length!=0))
					{
						for(i = 0;i<resultCard[index].length;i++)
						{
							result.cbResultCard[i] = resultCard[index][i];
						}
						result.cbCardCount = resultCard[index].length;
						index ++;
					}else{
						resultCard[resultIndex] = new Array();
						for(i = 0;i<result.cbCardCount;i++)
						{
							resultCard[resultIndex].push(result.cbResultCard[i]);
						}
						resultIndex++;
					}
				}else{
					if(index == resultIndex)
					{
						index = 0;
					}
					for(i = 0;i<resultCard[index].length;i++)
					{
						result.cbResultCard[i] = resultCard[index][i];
					}
					result.cbCardCount = resultCard[index].length;
					index ++;
				}
			}else{
				result = SearchOutCard(cbHandCardData, cbHandCardCount,cbTurnCardData, cbTurnCardCount);
				if(result.cbCardCount != 0)
				{
					resultCard[resultIndex] = new Array();
					for(i = 0;i<result.cbCardCount;i++)
					{
						resultCard[resultIndex].push(result.cbResultCard[i]);
					}
					resultIndex++;
				}
			}
			return result;
		}
		//出牌搜索
		public function SearchOutCard(cbHandCardData : Array, cbHandCardCount : uint,cbTurnCardData : Array, cbTurnCardCount : uint,searchIndex : uint = 0) : tagOutCardResult
		{
			var result : tagOutCardResult = new tagOutCardResult();
			var land : LandModel = LandModel._getInstance();
			
			//构造扑克
			var cbCardData : Array= Memory._newArrayAndSetValue(20,0);
			var cbCardCount : uint = cbHandCardCount;
			searchIndex = searchIndex % cbCardCount;
			Memory._copyArray(cbCardData,cbHandCardData,cbHandCardCount);
			//排列扑克
			SortCardList(cbCardData,cbCardCount,ST_ORDER);
			
			//获取类型
			var cbTurnOutType : uint = GetCardType(cbTurnCardData,cbTurnCardCount);
			
			//出牌分析
			var cbLogicValue : uint = 0 ,i : int = 0 ,j : int = 0 ,cbIndex : uint,cbHandLogicValue : uint = 0,cbLineCount : uint =0;
			var AnalyseResult : tagAnalyseResult;
			switch(cbTurnOutType) {
				case CT_ERROR:					//错误类型
				{
					//获取数值
					cbLogicValue = GetCardLogicValue(cbCardData[cbCardCount-1 - searchIndex]);
					var cbSameCount : uint = 1;
					//多牌判断
					for ( i = (1+searchIndex);i<cbCardCount;i++ )
					{
						if (GetCardLogicValue(cbCardData[cbCardCount-i-1])==cbLogicValue) 
						{
							cbSameCount++;
						}
						else { break; }
					}
					//完成处理
					if (cbSameCount>1) {
						result.cbCardCount=cbSameCount;
						for ( j=0;j<cbSameCount;j++ ) 
						{
							result.cbResultCard[j]=cbCardData[cbCardCount-1-searchIndex-j];
						}
						return result;
					}
					//单牌处理
					result.cbCardCount=1;
					result.cbResultCard[0]=cbCardData[cbCardCount-1];
					return result;
				}
				case CT_SINGLE:					//单牌类型
				case CT_DOUBLE:					//对牌类型
				case CT_THREE:					//三条类型
				{
					//获取数值
					cbLogicValue=GetCardLogicValue(cbTurnCardData[0]);
					//分析扑克
					AnalyseResult = AnalysebCardData(cbCardData,cbCardCount);
					//寻找单牌
					if (cbTurnCardCount<=1) {
						searchIndex = searchIndex % AnalyseResult.cbSignedCount;
						for ( i=searchIndex ;i< AnalyseResult.cbSignedCount; i++ ) {
							
							if (GetCardLogicValue(AnalyseResult.cbSignedCardData[AnalyseResult.cbSignedCount - i -1])>cbLogicValue) {
								//设置结果
								result.cbCardCount=cbTurnCardCount;
								Memory._copyArray(result.cbResultCard,AnalyseResult.cbSignedCardData,cbTurnCardCount,0,AnalyseResult.cbSignedCount - i -1);
								return result;
							}
						}
					}
					//寻找对牌
					if (cbTurnCardCount<=2)
					{
						searchIndex = searchIndex % AnalyseResult.cbDoubleCount;
						for (i=searchIndex;i<AnalyseResult.cbDoubleCount;i++)
						{
							cbIndex=(AnalyseResult.cbDoubleCount-i-1)*2;
							if (GetCardLogicValue(AnalyseResult.cbDoubleCardData[cbIndex])>cbLogicValue)
							{
								//设置结果
								result.cbCardCount=cbTurnCardCount;
								Memory._copyArray(result.cbResultCard,AnalyseResult.cbDoubleCardData,cbTurnCardCount,0,cbIndex);
								return result;
							}
						}
					}
					//寻找三牌
					if (cbTurnCardCount<=3)
					{
						searchIndex =searchIndex % AnalyseResult.cbThreeCount;
						for ( i=searchIndex;i<AnalyseResult.cbThreeCount;i++)
						{
							cbIndex=(AnalyseResult.cbThreeCount-i-1)*3;
							if (GetCardLogicValue(AnalyseResult.cbThreeCardData[cbIndex])>cbLogicValue)
							{
								//设置结果
								result.cbCardCount=cbTurnCardCount;
								Memory._copyArray(result.cbResultCard,AnalyseResult.cbThreeCardData,cbTurnCardCount,0,cbIndex);
								return result;
							}
						}
					}
					break;
				}
				case CT_SINGLE_LINE:		//单连类型
				{
					//长度判断
					if (cbCardCount<cbTurnCardCount) break;
					//获取数值
					cbLogicValue=GetCardLogicValue(cbTurnCardData[0]);
					//搜索连牌
					for ( i=(cbTurnCardCount-1);i<cbCardCount;i++)
					{
						//获取数值
						cbHandLogicValue=GetCardLogicValue(cbCardData[cbCardCount-i-1]);
						
						//构造判断
						if (cbHandLogicValue>=15) break;
						if (cbHandLogicValue<=cbLogicValue) continue;
						
						//搜索连牌
						cbLineCount =0;
						for ( j=(cbCardCount-i-1);j<cbCardCount;j++)
						{
							if ((GetCardLogicValue(cbCardData[j])+cbLineCount)==cbHandLogicValue) 
							{
								//增加连数
								result.cbResultCard[cbLineCount++]=cbCardData[j];
								//完成判断
								if (cbLineCount==cbTurnCardCount)
								{
									result.cbCardCount=cbTurnCardCount;
									return result;
								}
							}
						}
					}
					break;
				}
				case CT_DOUBLE_LINE:		//对连类型
				{
					//长度判断
					if (cbCardCount<cbTurnCardCount) break;
					
					//获取数值
					cbLogicValue = GetCardLogicValue(cbTurnCardData[0]);
					
					//搜索连牌
					for ( i=(cbTurnCardCount-1);i<cbCardCount;i++)
					{
						//获取数值
						cbHandLogicValue=GetCardLogicValue(cbCardData[cbCardCount-i-1]);
						
						//构造判断
						if (cbHandLogicValue<=cbLogicValue) continue;
						if ((cbTurnCardCount>1)&&(cbHandLogicValue>=15)) break;
						
						//搜索连牌
						cbLineCount=0;
						for ( j=(cbCardCount-i-1);j<(cbCardCount-1);j++)
						{
							if (((GetCardLogicValue(cbCardData[j])+cbLineCount)==cbHandLogicValue)
								&&((GetCardLogicValue(cbCardData[j+1])+cbLineCount)==cbHandLogicValue))
							{
								//增加连数
								result.cbResultCard[cbLineCount*2]=cbCardData[j];
								result.cbResultCard[(cbLineCount++)*2+1]=cbCardData[j+1];
								
								//完成判断
								if (cbLineCount*2==cbTurnCardCount)
								{
									result.cbCardCount=cbTurnCardCount;
									return result;
								}
							}
						}
					}
					break;
				}
				case CT_THREE_LINE:				//三连类型
				case CT_THREE_LINE_TAKE_ONE:	//三带一单
				case CT_THREE_LINE_TAKE_TWO:	//三带一对
				{
					
					//长度判断
					if (cbCardCount<cbTurnCardCount) break;
					
					//获取数值
					cbLogicValue=0;
					for ( i=0;i<cbTurnCardCount-2;i++)
					{
						cbLogicValue=GetCardLogicValue(cbTurnCardData[i]);
						if (GetCardLogicValue(cbTurnCardData[i+1])!=cbLogicValue) continue;
						if (GetCardLogicValue(cbTurnCardData[i+2])!=cbLogicValue) continue;
						break;
					}
					
					//属性数值
					var cbTurnLineCount : uint=0;
					if (cbTurnOutType==CT_THREE_LINE_TAKE_ONE) cbTurnLineCount=cbTurnCardCount/4;
					else if (cbTurnOutType==CT_THREE_LINE_TAKE_TWO) cbTurnLineCount=cbTurnCardCount/5;
					else cbTurnLineCount=cbTurnCardCount/3;
					
					//搜索连牌
					for ( i=cbTurnLineCount*3-1;i<cbCardCount;i++)
					{
						//获取数值
						cbHandLogicValue=GetCardLogicValue(cbCardData[cbCardCount-i-1]);
						
						//构造判断
						if (cbHandLogicValue<=cbLogicValue) continue;
						if ((cbTurnLineCount>1)&&(cbHandLogicValue>=15)) break;
						
						//搜索连牌
						cbLineCount=0;
						for( j=(cbCardCount-i-1);j<(cbCardCount-2);j++)
						{
							//设置变量
							result.cbCardCount=0;
							
							//三牌判断
							if ((GetCardLogicValue(cbCardData[j])+cbLineCount)!=cbHandLogicValue) continue;
							if ((GetCardLogicValue(cbCardData[j+1])+cbLineCount)!=cbHandLogicValue) continue;
							if ((GetCardLogicValue(cbCardData[j+2])+cbLineCount)!=cbHandLogicValue) continue;
							
							if( j>0 && (GetCardLogicValue(cbCardData[j-1])+cbLineCount)==cbHandLogicValue) continue;
							if( (j+3)<cbHandCardCount && (GetCardLogicValue(cbCardData[j+3])+cbLineCount)==cbHandLogicValue) continue;
							
							//增加连数
							result.cbResultCard[cbLineCount*3]=cbCardData[j];
							result.cbResultCard[cbLineCount*3+1]=cbCardData[j+1];
							result.cbResultCard[(cbLineCount++)*3+2]=cbCardData[j+2];
							
							var k : uint = 0;
							var cbSignedCard : uint = 0;
							//完成判断
							if (cbLineCount==cbTurnLineCount)
							{
								//连牌设置
								result.cbCardCount=cbLineCount*3;
								
								//构造扑克
								var cbLeftCardData : Array= Memory._newArrayAndSetValue(20,0);
								var cbLeftCount : uint=cbCardCount-result.cbCardCount;
								Memory._copyArray(cbLeftCardData,cbCardData,cbCardCount);
								
								RemoveCard(result.cbResultCard,result.cbCardCount,cbLeftCardData,cbCardCount);
								
								//分析扑克
								var AnalyseResultLeft : tagAnalyseResult = AnalysebCardData(cbLeftCardData,cbLeftCount);
								
								//单牌处理
								if (cbTurnOutType==CT_THREE_LINE_TAKE_ONE)
								{
									//提取单牌
									for ( k=0;k<AnalyseResultLeft.cbSignedCount;k++)
									{
										//中止判断
										if (result.cbCardCount==cbTurnCardCount) break;
										
										//设置扑克
										cbIndex=AnalyseResultLeft.cbSignedCount-k-1;
										cbSignedCard =AnalyseResultLeft.cbSignedCardData[cbIndex];
										result.cbResultCard[result.cbCardCount++]=cbSignedCard;
									}
									
									//提取对牌
									for ( k=0;k<AnalyseResultLeft.cbDoubleCount*2;k++)
									{
										//中止判断
										if (result.cbCardCount==cbTurnCardCount) break;
										
										//设置扑克
										cbIndex=(AnalyseResultLeft.cbDoubleCount*2-k-1);
										cbSignedCard=AnalyseResultLeft.cbDoubleCardData[cbIndex];
										result.cbResultCard[result.cbCardCount++]=cbSignedCard;
									}
									
									//提取三牌
									for ( k=0;k<AnalyseResultLeft.cbThreeCount*3;k++)
									{
										//中止判断
										if (result.cbCardCount==cbTurnCardCount) break;
										
										//设置扑克
										cbIndex=(AnalyseResultLeft.cbThreeCount*3-k-1);
										cbSignedCard=AnalyseResultLeft.cbThreeCardData[cbIndex];
										result.cbResultCard[result.cbCardCount++]=cbSignedCard;
									}
									
									//提取四牌
									//									for ( k=0;k<AnalyseResultLeft.cbFourCount*4;k++)
									//									{
									//										//中止判断
									//										if (result.cbCardCount==cbTurnCardCount) break;
									//										
									//										//设置扑克
									//										cbIndex=(AnalyseResultLeft.cbFourCount*4-k-1);
									//										cbSignedCard=AnalyseResultLeft.cbFourCardData[cbIndex];
									//										result.cbResultCard[result.cbCardCount++]=cbSignedCard;
									//									}
								}
								var cbCardData1 : uint;
								var cbCardData2 : uint;
								//对牌处理
								if (cbTurnOutType==CT_THREE_LINE_TAKE_TWO)
								{
									//提取对牌
									for (k=0;k<AnalyseResultLeft.cbDoubleCount;k++)
									{
										//中止判断
										if (result.cbCardCount==cbTurnCardCount) break;
										
										//设置扑克
										cbIndex=(AnalyseResultLeft.cbDoubleCount-k-1)*2;
										cbCardData1=AnalyseResultLeft.cbDoubleCardData[cbIndex];
										cbCardData2=AnalyseResultLeft.cbDoubleCardData[cbIndex+1];
										result.cbResultCard[result.cbCardCount++]=cbCardData1;
										result.cbResultCard[result.cbCardCount++]=cbCardData2;
									}
									
									//提取三牌
									for ( k=0;k<AnalyseResultLeft.cbThreeCount;k++)
									{
										//中止判断
										if (result.cbCardCount==cbTurnCardCount) break;
										
										//设置扑克
										cbIndex=(AnalyseResultLeft.cbThreeCount-k-1)*3;
										cbCardData1=AnalyseResultLeft.cbThreeCardData[cbIndex];
										cbCardData2=AnalyseResultLeft.cbThreeCardData[cbIndex+1];
										result.cbResultCard[result.cbCardCount++]=cbCardData1;
										result.cbResultCard[result.cbCardCount++]=cbCardData2;
									}
									
									//提取四牌
									//									for (k=0;k<AnalyseResultLeft.cbFourCount;k++)
									//									{
									//										//中止判断
									//										if (result.cbCardCount==cbTurnCardCount) break;
									//										
									//										//设置扑克
									//										cbIndex=(AnalyseResultLeft.cbFourCount-k-1)*4;
									//										cbCardData1=AnalyseResultLeft.cbFourCardData[cbIndex];
									//										cbCardData2=AnalyseResultLeft.cbFourCardData[cbIndex+1];
									//										result.cbResultCard[result.cbCardCount++]=cbCardData1;
									//										result.cbResultCard[result.cbCardCount++]=cbCardData2;
									//									}
								}
								
								//完成判断
								if (result.cbCardCount==cbTurnCardCount) return result;
							}
						}
					}
					break;
				}
					
					
				case CT_PLANE:
				{
					//长度判断
					if (cbCardCount<cbTurnCardCount) break;
					
					//分析出牌
					var AnalyseTurnCard:tagAnalyseResult = AnalysebCardData(cbTurnCardData, cbTurnCardCount);
					
					//获取数值
					cbLogicValue=GetCardLogicValue(AnalyseTurnCard.cbThreeCardData[0]);
					
					//分析扑克
					AnalyseResult = AnalysebCardData(cbCardData,cbCardCount);
					if(AnalyseResult.cbThreeCount < AnalyseTurnCard.cbThreeCount)	break;
					
					//搜索连牌
					cbLineCount=1;
					
					var searchOver:Boolean = false;
					var beginIndex:int;
					for(i=AnalyseResult.cbThreeCount-1; i>=0; i--)
					{
						cbLineCount=1;
						for( j=i+1; j<AnalyseResult.cbThreeCount; j++)
						{
							if(GetCardLogicValue(AnalyseResult.cbThreeCardData[i*3]) == (GetCardLogicValue(AnalyseResult.cbThreeCardData[j*3])+cbLineCount))
								cbLineCount++;
							if(cbLineCount == AnalyseTurnCard.cbThreeCount)
							{
								cbHandLogicValue = GetCardLogicValue(AnalyseResult.cbThreeCardData[i*3]);
								if(cbHandLogicValue > cbLogicValue)
								{
									searchOver = true;
									beginIndex = i;
								}
								else
									break;
							}
						}
						if(i==0 && cbLineCount==1)	break;
						if(searchOver)	break;
					}
					if(cbLineCount < AnalyseTurnCard.cbThreeCount) break;
					if(!searchOver) break;
					
					for(i=0; i<AnalyseTurnCard.cbThreeCount; i++)
					{
						var index:int = beginIndex*3 + i*3;
						//增加连数
						result.cbResultCard[i*3]	=AnalyseResult.cbThreeCardData[index];
						result.cbResultCard[i*3+1]	=AnalyseResult.cbThreeCardData[index+1];
						result.cbResultCard[i*3+2]	=AnalyseResult.cbThreeCardData[index+2];
						result.cbCardCount += 3;
					}
					
					//提取对牌
					if( AnalyseTurnCard.cbThreeCount == AnalyseTurnCard.cbDoubleCount)
					{
						if(AnalyseResult.cbDoubleCount < AnalyseTurnCard.cbDoubleCount)
							break;
						else
						{
							for(i=0; i<AnalyseTurnCard.cbDoubleCount; i++)
							{
								beginIndex = AnalyseTurnCard.cbThreeCount*3 + i*2;
								result.cbResultCard[beginIndex]	 =AnalyseResult.cbDoubleCardData[AnalyseResult.cbDoubleCount*2-1-i*2];
								result.cbResultCard[beginIndex+1]=AnalyseResult.cbDoubleCardData[AnalyseResult.cbDoubleCount*2-1-i*2-1];
								result.cbCardCount += 2;
							}
						}
					}
					else		//提取单牌
					{
						if(AnalyseResult.cbSignedCount < AnalyseTurnCard.cbThreeCount)
						{
							for(i=0; i<AnalyseResult.cbSignedCount; i++)
							{
								beginIndex = AnalyseTurnCard.cbThreeCount*3 + i;
								result.cbResultCard[beginIndex] = AnalyseResult.cbSignedCardData[AnalyseResult.cbSignedCount-1-i];
								result.cbCardCount += 1;
							}
							for(i=0; i<AnalyseTurnCard.cbThreeCount-AnalyseResult.cbSignedCount; i++)
							{
								beginIndex = AnalyseTurnCard.cbThreeCount*3 + AnalyseResult.cbSignedCount + i;
								result.cbResultCard[beginIndex] = AnalyseResult.cbDoubleCardData[AnalyseResult.cbDoubleCount-1-i];
								result.cbCardCount += 1;
							}
						}
						else
						{
							for(i=0; i<AnalyseTurnCard.cbThreeCount; i++)
							{
								beginIndex = AnalyseTurnCard.cbThreeCount*3 + i;
								result.cbResultCard[beginIndex] = AnalyseResult.cbSignedCardData[AnalyseResult.cbSignedCount-1-i];
								result.cbCardCount += 1;
							}
						}
					}
					
					if (result.cbCardCount==cbTurnCardCount) return result;
					break;
				}	
					
					
			}//switch
			
			
			//搜索炸弹
			if ((cbCardCount>=4)&&(cbTurnOutType!=CT_MISSILE_CARD))
			{
				//变量定义
				cbLogicValue=0;
				if (cbTurnOutType==CT_BOMB_CARD) cbLogicValue=GetCardLogicValue(cbTurnCardData[0]);
				
				//搜索炸弹
				for (i=3;i<cbCardCount;i++)
				{
					//获取数值
					cbHandLogicValue=GetCardLogicValue(cbCardData[cbCardCount-i-1]);
					
					//构造判断
					if (cbHandLogicValue<=cbLogicValue) continue;
					
					//炸弹判断
					var cbTempLogicValue : uint =GetCardLogicValue(cbCardData[cbCardCount-i-1]);
					
					for (j=1;j<4;j++)
					{
						if (GetCardLogicValue(cbCardData[cbCardCount+j-i-1])!=cbTempLogicValue) break;
					}
					if (j!=4) continue;
					
					//设置结果
					result.cbCardCount=4;
					result.cbResultCard[0]=cbCardData[cbCardCount-i-1];
					result.cbResultCard[1]=cbCardData[cbCardCount-i];
					result.cbResultCard[2]=cbCardData[cbCardCount-i+1];
					result.cbResultCard[3]=cbCardData[cbCardCount-i+2];
					
					return result;
				}
			}
			//搜索火箭
			if ((cbCardCount>=2)&&(cbCardData[0]==0x4F)&&(cbCardData[1]==0x4E))
			{
				//设置结果
				result.cbCardCount=2;
				result.cbResultCard[0]=cbCardData[0];
				result.cbResultCard[1]=cbCardData[1];
				return result;
			}
			return result;
		}//SearchOutCard
		
	}
}
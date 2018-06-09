package games.cowlord.view
{
	import com.greensock.TweenMax;
	
	import cx.assembly.card.Card;
	import cx.assembly.chip.ChipEmbed;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.system.ApplicationDomain;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	import games.cowlord.model.CowModle;
	
	import t.cx.air.TConst;
	import t.cx.air.utils.Memory;
	
	public class CardView extends MovieClip
	{
		private var _cow:CowModle;
		private var _cowCards : Vector.< Vector.<Card> >;	//自己手前牌
		private var _cbSortCards: Array;					//排序后手牌
		private var _cpwFourCards:Array						//第四张牌
		private var _disPlayCowArray:Array;					//牛牛提示文字
		private var _FPPointW:Array = new Array([43,58],[63,58],[83,58],[52,81],[73,81]);			//玩家发牌位置
		private var _FPPointZ:Array = new Array([330,0],[350,0],[370,0],[340,25],[360,25]);			//庄家发牌位置	
		private var _JSPointW:Array = new Array([55,58],[74,58],[43,81],[63,81],[83,81]);			//玩家结算牌位置
		private var _JSPointZ:Array = new Array([340,0],[360,0],[330,23],[350,23],[370,23]);		//庄杰结算牌位置
		private var _CowTextPoint:Array = new Array([338,75],[13,320],[232,320],[452,320],[672,320]);//牛牛位置
		private var _stamp:int;
		
		
		public function CardView()
		{
			super();
			_cow = CowModle._getInstance();
			_stamp = 0;
			theCuoPai.gotoAndStop(1);
			theCuoPai.visible = false;
			_cbSortCards = Memory._newTwoDimension(5,5,0);

//			var arr:Array = [[1,2,3,4,5],
//				[3,4,5,6,7],
//				[5,6,7,8,9],
//				[6,5,9,6,12],
//				[9,10,13,17,17]]
//			InitCardList(arr
//			);
		}
		/**
		 * 发牌
		 **/
		public function InitCardList(cbCards : Array,cbSortCards:Array,bAn : Boolean = true):void
		{
			_cowCards = new Vector.<Vector.<Card>>(5);
			_cbSortCards = cbSortCards;
			_cpwFourCards = new Array();
			var i : uint = 0,j : uint = 0;
			for( i = 0;i<5;i++) { _cowCards[i] = new Vector.<Card>(5); }
			
			for( i = 0;i<5;i++){
				for(j = 0;j<5;j++){
					_cowCards[i][j] = new Card(cbCards[i][j],'b2',74.5,99.15);
					_cowCards[i][j].visible = !bAn;
					if(j == 3){
						_cpwFourCards.push(_cowCards[i][j].value);
					}
				}
			}
		}
		/***
		 * 结束状态重入
		 **/
		public function StatusGameEndChad(cbCards : Array):void
		{
			_cowCards = new Vector.<Vector.<Card>>(5);
			var i:int,j:int,wViewChairID:uint,card:Card;
			
			for( i = 0;i<5;i++) { _cowCards[i] = new Vector.<Card>(5); }
			for(i = 0;i<5;i++){
				wViewChairID = _cow.FACardRectHandler(_cow.m_wDiceNumber)[i];
				for(j = 0;j<5;j++){
					_cowCards[i][j] = new Card(cbCards[i][j],'b2',74.5,99.15);
					_cowCards[i][j].visible = true;
					if(i>0){
						_cowCards[i][j].x = _JSPointW[j][0];
						_cowCards[i][j].y = _JSPointW[j][1];
						this['CardAction_'+i].addChild(_cowCards[i][j]);
						this['CardAction_'+i].setChildIndex(_cowCards[i][j],this['CardAction_'+i].numChildren - 1);
					}else{
						_cowCards[i][j].x = _JSPointZ[j][0];
						_cowCards[i][j].y = _JSPointZ[j][1];
						this.addChild(_cowCards[i][j]);
						this.setChildIndex(_cowCards[i][j],this.numChildren - 1);
					}
				}
			}
			DisPlayCowHandler();			//显示牌型
			
		}
		/**
		 * 初始化牌到桌面
		 * 发牌动画
		 **/
		public function ReDrawCard(wCardID:uint,wCardLunNum:uint,matrix:Matrix = null):void
		{
			_stamp ++ ;
			var card:Card = _cowCards[wCardID][wCardLunNum];
			var bx:Number;
			var by:Number;
			bx = _FPPointW[wCardID][0];
			by = _FPPointW[wCardID][1];
			//card.transform.matrix = matrix;
			card.visible = true;
			CardPointHander(wCardID,card,wCardLunNum);
			_cow.m_Sound.PlayEffect(TConst.INVALID_CHAIR,'SendCardEffcet',1);
			if(_stamp == 25)
			{
				//this.parent['HeGuanMC'].gotoAndStop("jiewei");
				//this.parent['HeGuanMC'].RotationHandler(0);		//荷官归位
				TweenMax.delayedCall(.7,SetCardOrder);			//搓牌
				TweenMax.delayedCall(3,DisPlayCowHandler);		//显示牌型
				_stamp = 0;
			}
		}
		private function CardPointHander(wCardID:uint,card:Card,j:int):void
		{
			if(wCardID>0){
				card.x = _FPPointW[j][0];			//玩家牌
				card.y = _FPPointW[j][1];
				this['CardAction_'+wCardID].addChild(card);
				this['CardAction_'+wCardID].setChildIndex(card,this['CardAction_'+wCardID].numChildren - 1);
			}else{
				card.x = _FPPointZ[j][0];			//庄家牌
				card.y = _FPPointZ[j][1];
				this.addChild(card);
				this.setChildIndex(card,this.numChildren - 1);
			}
			card.rotation = 0;
			if(j == 3){
				card.value = 0;
			}
		}
		/**
		 * 结算从新理牌
		 **/
		public function SetCardOrder():void
		{
			var i:int = 0,card:Card,wCardID:int;
			for(i = 1;i<=5;i++){
				wCardID = i;
				if(i==5){
					wCardID = 0;
				}
				card = _cowCards[wCardID][4];
				
				TweenMax.to(card,.5,{
									x:card.x + 15,
									onStart:DisPlayCard,
									onStartParams:[wCardID,_cowCards[wCardID][3],_cpwFourCards[wCardID]],
									onComplete:JSPointHander,
									onCompleteParams:[wCardID],
									delay:wCardID*0.5});
			}
		}
		private function DisPlayCard(wCardID:int,card:Card,val:int):void
		{
				card.value = val;
				if(wCardID > 0){
					theCuoPai.x = _CowTextPoint[wCardID][0] - 30;
					theCuoPai.y = _CowTextPoint[wCardID][1] - 100;
				}else{
					theCuoPai.x = _CowTextPoint[wCardID][0] - 20;
					theCuoPai.y = _CowTextPoint[wCardID][1] - 50;
				}
				
				theCuoPai.visible = true;
				setChildIndex(theCuoPai,numChildren - 1);
				theCuoPai.gotoAndPlay(1);
		}
		private function JSPointHander(wCardID:int):void
		{
			for(var i:int = 0;i<5;i++){
				_cowCards[wCardID][i].value = _cbSortCards[wCardID][i];
				if(wCardID>0){
					_cowCards[wCardID][i].x = _JSPointW[i][0];
					_cowCards[wCardID][i].y = _JSPointW[i][1];
				}else{
					_cowCards[wCardID][i].x = _JSPointZ[i][0];
					_cowCards[wCardID][i].y = _JSPointZ[i][1];
				}
			}
			//theCuoPai.gotoAndStop(1);
		}
		/**
		 * 显示牌型
		 **/
		public function DisPlayCowHandler():void
		{
			//m_wCBCardOx
			for(var i:int = 0;i<5;i++)
			{
				var mc:MovieClip = CreateMouseChip('Niu'+_cow.m_wCBCardOx[i]);
				mc.name = 'mc_'+i;
				mc.x = _CowTextPoint[i][0];
				mc.y = _CowTextPoint[i][1];
				this.addChild(mc);
				this.setChildIndex(mc,this.numChildren - 1);
				if(i>0 && _cow.lAreaWinner[i] == 2){
					this['CardAction_'+i].BlinkHanlder(true);
				}
			}
			TweenMax.delayedCall(3,this.parent['JieSuanMC'].show);
			theCuoPai.visible = false;
		}
		/**
		 * 清理桌面
		 **/
		public function ClearCardHandler():void
		{
			if(_cowCards == null ) return;
			var i:int,j:int;
			//清除牛牛文字
			for(i = 0;i<5;i++){
				if(this.contains(this.getChildByName('mc_'+i))){
					this.removeChild(this.getChildByName('mc_'+i));
				}
			}
			//清除桌面扑克
			for(i = _cowCards.length - 1;i>=0;i--){
				for(j = _cowCards[i].length - 1;j>=0;j--){
					if(i>0){
						if(this['CardAction_'+i].contains(_cowCards[i][j]))this['CardAction_'+i].removeChild(_cowCards[i][j]);
						this['CardAction_'+i].hide();
					}else{
						if(this.contains(_cowCards[i][j]))this.removeChild(_cowCards[i][j]);
					}
				}
			}
			
		}
		public function CreateMouseChip(cowName:String) : MovieClip
		{
			var c : Class = ApplicationDomain.currentDomain.getDefinition(cowName) as Class;
			return new c();
		}
		public function get theCuoPai():MovieClip
		{
			return this['CuoPai'];
		}
		/**
		 * 销毁
		 **/
		public function Destroy():Boolean
		{
			for(var i:int = 1;i<=4;i++){
				this['CardAction_'+i] = null;
			}
			this['CuoPai'] = null;
			_cowCards = null;
			_FPPointW = null;
			_FPPointZ = null;
			_JSPointW = null;
			_JSPointZ = null;
			_cbSortCards = null;
			_cpwFourCards = null;
			_disPlayCowArray = null;
			_CowTextPoint = null;
			return true;
		}
	}
}
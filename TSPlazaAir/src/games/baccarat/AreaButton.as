package games.baccarat
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import gameAssets.baccarat.BaccaratSkinClass;
	
	import games.baccarat.model.BaccaratModel;
	
	import mx.core.UIComponent;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	
	public class AreaButton extends UIComponent
	{
		private var _theModel : BaccaratModel;
		private var _chipVec : Array;
		
		//private var _ChipStorge:MovieClip;
		private var _curGold : Number;
		public function get curGold():Number
		{
			return _curGold;
		}
		
		public function AreaButton(c:Class=null)
		{
			if(c){ targetClass = c; }
			_theModel = BaccaratModel._getInstance();
			_curGold = 0;
		}
		
		public function Destroy():Boolean
		{
			_theModel = null;
			return true;
		}
		
		private var _targetClass:Class;
		public function get targetClass():Class
		{
			return _targetClass;
		}
		
		public function set targetClass(value:Class):void
		{
			targetMc = new value() as MovieClip;
		}
		
		private var _targetMc:MovieClip;
		public function get targetMc():MovieClip
		{
			return _targetMc;
		}
		public function set targetMc(mc:MovieClip):void
		{
			_targetMc = mc;
			this.addChild(_targetMc);
			init();
		}
		
		private var _index:int;
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		
		
		private function init():void
		{
			_targetMc.mouseChildren = false;
			_targetMc.tabChildren = false;
			_targetMc.tabEnabled = false;
			_targetMc.gotoAndStop(1);
		}
		
		public function setMouseEnabled(enable:Boolean):void
		{
			if(enable) {
				_targetMc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			} else {
				_targetMc.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
				_targetMc.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
				_targetMc.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
				_targetMc.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
			}
			_targetMc.gotoAndStop(1);
			this.buttonMode = enable;
		}
		public function ResetStorge(bAddChip : Boolean) : void
		{
//			if( _ChipStorge!=null ){ 
//				_ChipStorge.visible = false; 
//				_ChipStorge.gotoAndStop(1); 
//			}
			_curGold = 0;
		}
		protected function OnMouseOver(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(2);
			_targetMc.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.addEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		protected function OnMouseOut(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(1); 
			_targetMc.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		protected function OnMouseUp(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(1); 
		}
		
		protected function OnMouseDown(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(3);
			var chipIndex : int = _theModel.m_ChipIndex;
			if( checkCanAddScore() ) {
				var lGold : Number = getGoldByIndex( chipIndex );
				if(lGold > 0)
				{
					AddChipValue(chipIndex);
					//_selfGold +=lGold;
					//theSelfGoldTxt.text = TScore.toStringEx(_selfGold);
					var pIndex : uint = parseInt( this.name.charAt(this.name.length-1) );
					//	SendAddScore(pIndex,_chipIndex,lGold);
					if(chipIndex == 4) {
//						BaccaratModel._getInstance().m_Sound.PlayEffect(TConst.INVALID_CHAIR,'dachouma');
						playSoundEffect(TConst.INVALID_CHAIR,'chouma1');
					}else if(chipIndex == 5)
					{
						playSoundEffect(TConst.INVALID_CHAIR,'chouma2');
					}else if(chipIndex == 6)
					{
						playSoundEffect(TConst.INVALID_CHAIR,'chouma3');
					}else
					{
//						BaccaratModel._getInstance().m_Sound.PlayEffect(TConst.INVALID_CHAIR,'chouma');
						playSoundEffect(TConst.INVALID_CHAIR,'chouma');
					}
					Controller.dispatchEvent('SELF_ADDSCORE',1,lGold,index);
				}
			}
			
		}
		
		
		private function playSoundEffect(wChairID : uint,action : String, type : int=-1,value : int=-1,rand : int = -1):void
		{
			if(_theModel == null)	return;
			try
			{
				_theModel.m_Sound.PlayEffect(wChairID, action, type, value, rand);
			}
			catch(e:Error){};
		}
		
		
		public function AddChipValue(chipindex : int) : void
		{
			var fGold : Number = BaccaratModel._getInstance().m_lChipScore[chipindex];
			if(index>=0) {
				var maxScore : Number = theMaxScore;
				if( (_curGold+fGold) > maxScore )
				{
//					Controller.dispatchEvent('WAINING_TEXT',1,"您下注超出了限制,当前最多可下注" +TScore.toStringEx(theMaxScore)+ ".");
					fGold = BaccaratModel._getInstance().m_lChipScore[chipindex-1];
					Controller.dispatchEvent('ChangeChipIndex',0,chipindex-1);
					return;
//					return;
				}
				
				
				_theModel.l_userTotalAdd += fGold;
				
				//如果大于用户身上的钱
//				if( _theModel.l_userTotalAdd > _theModel.l_userTotalIn)
				if( fGold > _theModel.l_userTotalIn )
				{
					trace("5----------------------0");
					_theModel.l_userTotalAdd -= fGold;
					Controller.dispatchEvent('WAINING_TEXT',1,"金币不足，您的下注超过手中下注金币最大值！");
					return;
				}
				
//				if(_ChipStorge==null) {
//					_ChipStorge =new BaccaratSkinClass.view_ChipStorge() as MovieClip;
//				}
//				if(!this.contains(_ChipStorge)){
//					_ChipStorge.x = 70;
//					this.addChild(_ChipStorge);
//				}
			//	_ChipStorge.visible = false;
//				if(!_ChipStorge.visible){
//					_ChipStorge.visible = false;
//					_ChipStorge.gotoAndPlay(1);
//				}
				
				_curGold +=  fGold;
//				_theModel.m_Sound.PlayEffect(TConst.INVALID_CHAIR,'jiazhu');
				//playSoundEffect(TConst.INVALID_CHAIR,'chouma');
				//_ChipStorge['value_txt'].text = TScore.toStringEx(_curGold);
			}
		}
		
		//		public function userAddChip(value:Number) : void
		//		{
		//			if(_chipTotalbg==null) {
		//				_chipTotalbg = new Image;
		//				_chipTotalbg.source = BaccaratSkinClass.view_chipTotal;
		//			}
		//			if(_chipTotalValue==null)
		//				_chipTotalValue = new Label;
		//			if(!this.contains(_chipTotalbg)){
		//				_chipTotalbg.x = 70;
		//				_chipTotalbg.y = 20;
		//				this.addChild(_chipTotalbg);
		//			}
		//			if(!this.contains(_chipTotalValue))
		//			{
		//				_chipTotalValue.x = 80;
		//				_chipTotalValue.y = 30;
		//				this.addChild(_chipTotalValue);
		//			}
		//			if(!_chipTotalbg.visible){
		//				_chipTotalbg.visible = true;
		//				_chipTotalValue.visible = true;
		//			}
		//			_totalGold += value;
		//			_chipTotalValue.text = TScore.toStringEx(_totalGold);
		//			_chipTotal['value_txt'].text = TScore.toStringEx(_totalGold);
		//		}
		
		public function AddChip(chipindex : int) : void
		{
			if(index > 7 || index<0) return;
			if(index == 4) {
				playSoundEffect(TConst.INVALID_CHAIR,'chouma1');
			}else if(index == 5)
			{
				playSoundEffect(TConst.INVALID_CHAIR,'chouma2');
			}else if(index == 6)
			{
				playSoundEffect(TConst.INVALID_CHAIR,'chouma3');
			}else
			{
				playSoundEffect(TConst.INVALID_CHAIR,'chouma');
			}
			//var dos : InteractiveObject  = //BaccaratSkinClass.GetChipSource(chipindex) as InteractiveObject;
			var dos : DisplayObject = BaccaratSkinClass.GetClipIdea(chipindex);
			if(dos != null) {
				//dos.mouseEnabled = false;
				dos.name = 'chip';
				if(_chipVec==null) _chipVec = [];
				_chipVec.push( dos );
				switch(index+1)
				{
					case 1:
					{
						dos.x = 20 + Math.random() * 140;
						dos.y = 15 + Math.random() * 70;
						break;
					}
					case 2:
					{
						dos.x = 20 + Math.random() * 260;
						dos.y = 15 + Math.random() * 70;
						break;
					}
					case 3:
					{
						dos.x = 20 + Math.random() * 140;
						dos.y = 15 + Math.random() * 70;
						break;
					}
					case 4:
					{
						dos.x = 20 + Math.random() * 130;
						dos.y = 15+ Math.random() * 50;
						break;	
					}
					case 5:
					{
						dos.x = 20 + Math.random() * 130;
						dos.y = 15 + Math.random() * 50;
						break;	
					}
					case 6:
					{
						dos.x = 20 + Math.random() * 140;
						dos.y = 15 + Math.random() * 30;
						break;
					}
					case 7:
					{
						dos.x = 20 + Math.random() * 140;
						dos.y = 15 + Math.random() * 30;
						break;
					}
					case 8:
					{
						dos.x = 20 + Math.random() * 260;
						dos.y = 15 + Math.random() * 35;
						break;
					}
				}
				this.addChild(dos);
				if(_theModel.m_user_xiazhu == _theModel.m_User.GetMeChairID())
				{
					if(_theModel.chipArray == null)
						_theModel.chipArray = new Array();
					_theModel.chipArray.push(dos);
				}
			}
		}
		public function removeChip():void
		{
			var len:int = _theModel.chipArray.length-1;
			if(_theModel.chipArray[len] != null)
			{
				if(this.contains(_theModel.chipArray[len]))
					this.removeChild(_theModel.chipArray[len]);
				_theModel.chipArray.splice(len,1);
			}
		}
		public function removeAllChip():void
		{
			var i:int = 0;
			for(i = _theModel.chipArray.length-1;i>=0;i--)
			{
				if(this.contains(_theModel.chipArray[i]))
					this.removeChild(_theModel.chipArray[i]);
				_theModel.chipArray.splice(i,1);
			}
			_theModel.chipArray = new Array();
		}
		public function RemoveChip():void
		{
			if(_chipVec && _chipVec.length)
			{
				var dos : DisplayObject;
				for(var i:int=0,leng:int=_chipVec.length; i<leng; i++)
				{
					//					dos = _chipVec[0] as InteractiveObject;
					dos = _chipVec.shift() as DisplayObject;
					if(this.contains(dos))	this.removeChild(dos);
				}
				_chipVec = [];
			}
		}
		
		public function get theMaxScore() : Number
		{
			var model : BaccaratModel = BaccaratModel._getInstance();
			switch(_index+1)
			{
				case 1:
				{
					return model.lUserPlayerScore;
//					return model.m_Logic.GetMaxPlayerScore();
				}
				case 2:
				{
					return model.lUserTieScore;
//					return model.m_Logic.GetMaxTieScore();
				}
				case 3:
				{
					return model.lUserBankerScore;
//					return model.m_Logic.GetMaxBankerScore();
				}
				case 4:
				{
					return model.lUserPlayerKingScore;
//					return model.m_Logic.GetMaxPlayerKingScore();
				}
				case 5:
				{
					return model.lUserBankerKingScore;
//					return model.m_Logic.GetMaxBankerKingScore();
				}
				case 6:
				{
					return model.lUserTieSamePointScore;
//					return model.m_Logic.GetMaxTieKingScore();
				}
				case 7:
				{
					return model.lUserPlayerTwoPair;
//					return model.m_Logic.GetMaxPlayerTwoPairScore();
				}
				case 8:
				{
					return model.lUserBankerTwoPair;
//					return model.m_Logic.GetMaxBankerTwoPairScore();
				}
			}
			return 0;
		}
		private function getGoldByIndex( index : int ) : Number
		{
			if(index < 0 || index >6) return 0;
			return _theModel.m_lChipScore[index];
		}
		private function checkCanAddScore() : Boolean
		{
			if(_theModel.m_ChipIndex < 0 || _theModel.m_ChipIndex > 6) return false;
			var model : BaccaratModel = BaccaratModel._getInstance();
			if(model.m_wBankerUser==TConst.INVALID_CHAIR && model.m_bEnableSysBanker==0) 
			{
				Controller.dispatchEvent('WAINING_TEXT',1,"当前无人坐庄!");
				return false;
			}
			var theIndex : int = _index;
			var lGold : Number = getGoldByIndex( model.m_lChipScore[ _theModel.m_ChipIndex ] );
			var userScore : Number = model.m_User.GetSelfData().UserScoreInfo.lScore;
			var lUserMaxScore : Number = model.m_Logic.GetUserMaxJetton();
			var maxScore : Number = theMaxScore;
			if( lUserMaxScore<lGold ) 
			{
				if(maxScore == 0) {
					Controller.dispatchEvent('WAINING_TEXT',1,"您下注超出了系统限制.");
				}else {
					if(lUserMaxScore < model.m_lChipScore[0]) {
						Controller.dispatchEvent('WAINING_TEXT',1,"下注玩家最少保留  ["+TScore.toStringEx(model.m_lAreaLimitScoreLest)+"] 金币.");
					}else {
						Controller.dispatchEvent('WAINING_TEXT',1,"下注玩家最少保留  ["+TScore.toStringEx(model.m_lAreaLimitScoreLest)+"] 金币,系统切换筹码.");
					}
					Controller.dispatchEvent('CHANGE_CHIP',1,lUserMaxScore,theMaxScore);
				}
				return false;
			}
			if(maxScore < lGold) {
				if( maxScore < 0) { trace('checkCanAddScore:',maxScore,index); }
				Controller.dispatchEvent('CHANGE_CHIP',1,lUserMaxScore,maxScore);
				Controller.dispatchEvent('WAINING_TEXT',1,"您下注超出了限制,当前最多可下注" +TScore.toStringEx(maxScore)+ ".");
				return false;
			}
			return true;
		}
		
	}
}
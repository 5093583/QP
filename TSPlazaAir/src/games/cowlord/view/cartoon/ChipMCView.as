package games.cowlord.view.cartoon
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.ui.Mouse;
	
	import games.cowlord.model.CowModle;
	
	import t.cx.air.TScore;
	import t.cx.air.skin.ButtonEx;
	
	public class ChipMCView extends MovieClip
	{
		private var _score:Number;
		private var _myScore:Number;
		public function ChipMCView()
		{
			super();
			this.gotoAndStop(1);
			this.visible = true;
			theQUAllUserScoreMC.visible = false;
			theQUMyUserScoreMC.visible  = false;
			_score = 0;
			_myScore = 0;
		}
		/**
		 * 游戏结算 边框闪烁
		 **/
		public function BlinkHanlder(bool:Boolean = false):void
		{
			this.gotoAndPlay(1);
		}
		public function show(score:Number,wCardID:uint):void
		{
			_score += score;
			theQUAllUserScoreMC.visible = true;
			theQUAllUserScoreMC['QUAllUserScore'].text = TScore.toStringEx(_score);
			if(wCardID == CowModle._getInstance().m_User.GetMeChairID()){
				_myScore += score;
				theQUMyUserScoreMC.visible  = true;
				theQUMyUserScoreMC['QUMyUserScore'].text  = TScore.toStringEx(_myScore);;
			}
		}
		public function hide():void
		{
			if(this.filters != null){
				this.filters = null;
			}
			theQUAllUserScoreMC['QUAllUserScore'].text = 0;
			theQUAllUserScoreMC.visible = false;
			
			theQUMyUserScoreMC['QUMyUserScore'].text  = 0;
			theQUMyUserScoreMC.visible  = false;
			
			_score = 0;
			_myScore = 0;
			this.gotoAndStop(1);
		}
		private function get theQUAllUserScoreMC():MovieClip
		{
			return this['QUAllUserScoreMC'];
		}
		private function get theQUMyUserScoreMC():MovieClip
		{
			return this['QUMyUserScoreMC'];
		}
		public function Destory():void
		{
			this['QUAllUserScoreMC'] = null;
			this['QUMyUserScoreMC']  = null;
		}
	}
}
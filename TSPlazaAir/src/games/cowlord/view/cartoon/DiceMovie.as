package games.cowlord.view.cartoon
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class DiceMovie extends MovieClip
	{
		private var _diceNum:int;
		public function DiceMovie()
		{
			super();
			_diceNum = 0;
			this.visible = false;
		}
		public function show(diceNum:int):void
		{
			this.visible = true;
			this.gotoAndPlay(1);
			_diceNum = diceNum;
			this.addEventListener(Event.ENTER_FRAME,DiceShowHandler);
			
		}
		private function DiceShowHandler(e:Event):void
		{
			if(this.currentFrame == this.totalFrames){
				theDice_MC.gotoAndStop(_diceNum);
				this.removeEventListener(Event.ENTER_FRAME,DiceShowHandler);
				TweenMax.delayedCall(1,hide);
			}
		}
		private function hide():void
		{
			this.visible = false;
		}
		private function get theDice_MC():MovieClip
		{
			return this['Dice_MC'];
		}
		public function Destory():Boolean
		{
			this['Dice_MC'] = null;
			this.stop();
			
			return true;
		}
	}
}
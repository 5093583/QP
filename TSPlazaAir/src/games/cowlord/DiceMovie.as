package games.cowlord
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import games.cowlord.model.CowModle;
	
	import mx.core.UIComponent;
	
	public class DiceMovie extends UIComponent
	{
		private var _theModel : CowModle;
		private var _diceNum:int;
		public function DiceMovie(c:Class=null)
		{
			if(c){ targetClass = c; }
			_theModel = CowModle._getInstance();
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
		public function show(diceNum:int):void
		{
			this.visible = true;
			targetMc.gotoAndPlay(1);
			_diceNum = diceNum;
			targetMc.addEventListener(Event.ENTER_FRAME,DiceShowHandler);
		}
		private function DiceShowHandler(e:Event):void
		{
			var mc : MovieClip ;
			if(targetMc.currentFrame == targetMc.totalFrames){
				targetMc.stop();
				mc = targetMc['Dice_MC'] as MovieClip;
				mc.gotoAndStop(_diceNum);
				targetMc.removeEventListener(Event.ENTER_FRAME,DiceShowHandler);
				TweenMax.delayedCall(2,hide);
			}
		}
		private function hide():void
		{
			this.visible = false;
		}
		private function init():void
		{
			_targetMc.gotoAndStop(1);
			this.visible = false;
		}
		public function Destroy():Boolean
		{
			_theModel = null;
			return true;
		}
	}
}
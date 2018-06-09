package  cx.game.cowlord.view
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	
	import cx.assembly.card.Card;
	import cx.gamebase.events.GameEvent;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	import games.cowlord.model.CowModle;
	
	import t.cx.air.TConst;
	import t.cx.air.controller.Controller;
	
	public class HeGuanView extends MovieClip
	{
		private var _cow:CowModle;
		private var XZPoint : Array = new Array(0,40,20,-20,-40);
		private var flag:int = 0;
		private var flag1:int = 0;
		private var intervalTime:int;
		private var timeoutTime:int;
		public function HeGuanView()
		{
			super();
			_cow = CowModle._getInstance();
			this.gotoAndStop('jiewei');
			this.visible = true;
			//StartPlay()
		}
		public function StartPlay() : void
		{
			intervalTime = setInterval(Handler,400);
		}
		
		private function Handler():void
		{
			Controller.dispatchEvent(GameEvent.GAME_LEAVE_ENABLE,0);
			var wCardID:int = _cow.FACardRectHandler(_cow.m_wDiceNumber)[flag%5];
			_cow.m_wCurrentWCardID = wCardID;
			_cow.m_wCurrentLunNum = Math.floor(flag/5);
			this.gotoAndPlay(1);
			if(flag == 25){
				this.gotoAndStop('jiewei');
				clearInterval(intervalTime);
				flag = 0;
				RotationHandler(0);
				return;
			}
			timeoutTime = setTimeout(this.parent['CardViewMC'].ReDrawCard,300,_cow.m_wCurrentWCardID,_cow.m_wCurrentLunNum);
			RotationHandler(XZPoint[wCardID]);
			flag++;
		}
		public function RotationHandler(retion:int):void
		{
			TweenMax.to(this, .4, {transformAroundPoint:{point:new Point(500 , 70), rotation:retion}});
		}
		public function GiveUpHandler(bool:Boolean):void
		{
			if(bool == false)return;
			this.gotoAndPlay("qipai");
		}
		public function StopMovie() : void
		{
			this.gotoAndStop(1);
		}
	
		/**
		 * 销毁
		 **/
		public function Destroy():Boolean
		{
			clearInterval(intervalTime);
			clearTimeout(timeoutTime);
			TweenMax.killAll(true);
			this.XZPoint = null;
			this.stop();
			return true;
		}
	}
}
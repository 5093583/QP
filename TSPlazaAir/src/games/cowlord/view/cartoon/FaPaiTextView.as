package games.cowlord.view.cartoon
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	
	public class FaPaiTextView extends MovieClip
	{
		public function FaPaiTextView()
		{
			super();
			this.gotoAndStop(1);
			this.visible = false;
		}
		public function show(frame:int):void
		{
			this.visible = true;
			this.gotoAndStop(frame);
			TweenMax.from(this,1,{alpha:1});
			TweenMax.delayedCall(2,hiede);
		}
		public function hiede():void
		{
			this.visible = false;
		}
		public function Destory():Boolean
		{
			this.stop();
			return true;
		}
	}
}
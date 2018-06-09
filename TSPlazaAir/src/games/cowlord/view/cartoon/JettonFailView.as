package games.cowlord.view.cartoon
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.utils.setInterval;
	
	public class JettonFailView extends Sprite
	{
		public function JettonFailView()
		{
			super();
			this.visible = false;
			//setInterval(show,1000);
			//show();
		}
		public function show():void
		{
			this.visible = true;
			TweenMax.killAll(true);
			TweenMax.from(this,1,{x:53,y:0,alpha:0});
			TweenMax.delayedCall(1,hide);
		}
		public function hide():void
		{
			this.x = 53;
			this.y = 72;
			this.visible = false;
		}
	}
}
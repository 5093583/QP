package games.cowlord.view.cartoon
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import games.cowlord.model.CowModle;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	
	public class JieSuanView extends Sprite
	{
		private var _cowModel:CowModle;
		public function JieSuanView()
		{
			super();
			_cowModel = CowModle._getInstance();
			this.visible = false;
		}
		public function show():void
		{
			this.visible = true;
			TweenMax.from(this,1,{alpha:1});
			this['UserDScore'].text = TScore.toStringEx(_cowModel.m_wJieSuanArray[0]);			//玩家赢金币
			this['UserFScore'].text = TScore.toStringEx(_cowModel.m_wJieSuanArray[1]);			//玩家返还的金币
			this['DUserDScore'].text = TScore.toStringEx(_cowModel.m_wJieSuanArray[2]);			//庄家赢的金币
			if(_cowModel.m_wJieSuanArray[0]<=0){
				_cowModel.m_Sound.PlayEffect(TConst.INVALID_CHAIR,'lostEffcet');
			}else{
				_cowModel.m_Sound.PlayEffect(TConst.INVALID_CHAIR,'WinEffcet');
			}
			this.parent.dispatchEvent(new Event('jiesuan'));
		}
		public function hide():void
		{
			this.visible = false;
		}
		public function Destory():void
		{
			this['UserDScore'] = null;
			this['UserFScore'] = null;
			this['DUserDScore'] = null;
			TweenMax.killAll(true);
		}
	}
}
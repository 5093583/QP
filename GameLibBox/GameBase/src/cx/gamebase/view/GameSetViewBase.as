package cx.gamebase.view
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.model.SoundModel;
	import cx.sound.enum.enSoundType;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	
	public class GameSetViewBase extends Sprite implements IDestroy
	{
		protected var _soundPlayer	: SoundModel;
		protected var _effectValue	: Number;
		protected var _musicValue	: Number;
		
		public function GameSetViewBase()
		{
			super();
			if(stage)
			{
				OnInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,OnInit);
			}
		}
		protected function OnInit(e : Event = null) : void
		{
			_soundPlayer = SoundModel._getInstance();
		}
		
		public function OnShow() : void
		{
			
		}
		public function OnHide() : void
		{
			
		}
		public function LoadSoundOption() : void
		{
			_effectValue = TDas._getDoubleItem(TConst.EFFECT_VALUE);
			if(isNaN(_effectValue)) _effectValue = 1;
			_musicValue = TDas._getDoubleItem(TConst.MUSIC_VALUE);
			if(isNaN(_musicValue)) _musicValue = 1;
			if(_soundPlayer) 
			{
				_soundPlayer.SetSoundValue(enSoundType.ST_MUSIC,_musicValue);
				_soundPlayer.SetSoundValue(enSoundType.ST_EFFECT,_effectValue);
			}
		}
		protected function OnSaveOption() : void
		{
			TDas._setDoubleItem(TConst.EFFECT_VALUE,_effectValue);
			TDas._setDoubleItem(TConst.MUSIC_VALUE,_musicValue);
		}
		protected function OnSetSound(type : uint,value : Number) : void
		{
			if(_soundPlayer == null) return;
			_musicValue = (type != enSoundType.ST_EFFECT)?value:_musicValue;
			_effectValue =(type != enSoundType.ST_MUSIC)?value:_effectValue;
			_soundPlayer.SetSoundValue(type,value);
		}
		public function Destroy() : Boolean
		{
			_soundPlayer = null;
			return true;
		}
	}
}
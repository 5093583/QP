package cx.gamebase.view
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.view.skins.Column;
	import cx.sound.enum.enSoundType;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.controls.Button;
	
	import t.cx.air.Stage3d.ButtonEx3D;

	public class SetSoundView extends GameSetViewBase implements IDestroy
	{
		private var _soundEffect : Column;
		private var _music : Column;
		public function SetSoundView()
		{
			super();
			this.visible = false;
		}
		protected override function OnInit(e:Event=null):void
		{
			super.OnInit(e);
		}
		public override function LoadSoundOption() : void
		{
			super.LoadSoundOption();
		}
		public override function OnShow() : void
		{
			super.OnShow();
			this.visible = true;
			_soundEffect = new Column(onEffectChange);
			_soundEffect.x = 110;
			_soundEffect.y = 57;
			this.addChild(_soundEffect);
			_music = new Column(onMusicChange);
			_music.x = 110;
			_music.y = 124;
			this.addChild(_music);
			theOK.enable = true;
			theOK.addEventListener(ButtonEx3D.CLICKEX,onOkEvent);
			
			_soundEffect.value = (_effectValue*10) -1;
			_music.value = (_musicValue*10 ) - 1;
		}
		
		private function onMusicChange(value : Number) : void
		{
			OnSetSound(enSoundType.ST_MUSIC,value);
		}
		private function onEffectChange(value : Number) : void
		{
			OnSetSound(enSoundType.ST_EFFECT,value);
		}
		private function onOkEvent(e : MouseEvent) : void
		{
			OnHide();
		}
		public override function OnHide() : void
		{
			super.OnHide();
			this.visible = false;
			if(_soundEffect)
			{
				_soundEffect.Destroy();
				this.removeChild(_soundEffect);
				_soundEffect = null;
			}
			if(_music)
			{
				_music.Destroy();
				this.removeChild(_music);
				_music = null;
			}
			theOK.enable = false;
			theOK.removeEventListener(ButtonEx3D.CLICKEX,onOkEvent);		
			OnSaveOption();
		}
		public override function Destroy():Boolean
		{
			super.Destroy();
			OnHide();
			theOK.Destroy();
			this['OKBtn'] = null;
			return true;
		}
		private function get theOK() : ButtonEx3D
		{
			return this['OKBtn'];
		}
	}
}
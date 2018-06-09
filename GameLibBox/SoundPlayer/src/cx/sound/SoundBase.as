package cx.sound
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundLoaderContext;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class SoundBase extends Sound
	{
		private var _completeFun 	: Function;
		public	var bPlay 			: Boolean;
		private var _soundType 		: uint;
		public function get SoundType() : uint
		{
			return _soundType;
		}
		private var _SoundChannel	: SoundChannel;
		private var m_bRepeat		: Boolean;
		
		private var _valume 		: Number;
		public function set valume(value : Number) : void
		{
			_valume = value;
			
			if(_SoundChannel == null) return;
			_SoundChannel.soundTransform = new SoundTransform(_valume);
		}
		public function get valume() : Number
		{
			return _valume;
		}
		public function get soundType() : uint
		{
			return _soundType;
		}
		public function SoundBase(type : uint = 0,stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(stream, context);
			_soundType 	= type;
			_valume 	= 1;
			m_bRepeat 	= false;
			bPlay 		= false;
		}
		public function PlayAgain() : void
		{
			this.Play(m_bRepeat,_completeFun);
		}
		public function Play(bRepeat : Boolean = false,completeFun : Function = null) : Boolean
		{
			m_bRepeat = bRepeat;
			if(bPlay) return false;
			_SoundChannel = play(0, m_bRepeat ? 0x7fffffff : 0,new SoundTransform(_valume));
			if(!bRepeat && !_SoundChannel.hasEventListener(Event.SOUND_COMPLETE)) {
				_SoundChannel.addEventListener(Event.SOUND_COMPLETE,OnSoundComplete);
			}
			bPlay = true;
			_completeFun = completeFun;
			return bPlay;
		}
		public function stop() : Boolean
		{
			if( _SoundChannel == null || !bPlay) return false;
			bPlay = false;
			_SoundChannel.stop();
			_SoundChannel.removeEventListener(Event.SOUND_COMPLETE,OnSoundComplete);
			return !bPlay;
		}
		public function unLoad():void
		{
			_SoundChannel = null;
		}
		protected function OnSoundComplete(e : Event) : void
		{
			stop();
			if(_completeFun != null) {
				_completeFun();
			}
		}
		
		public function Destroy() : void
		{
			_completeFun = null;
			stop();
			_soundType = 0;
			_valume = 0;
			bPlay = false;
			m_bRepeat = false;
			this.unLoad();
			_SoundChannel = null;
		}
	}
}
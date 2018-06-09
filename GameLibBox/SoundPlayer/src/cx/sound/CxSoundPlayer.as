/**
 * 音频添加规则
 * 	音效 e_开头
 * 	音乐 m_开头
 * */
package cx.sound
{
	import cx.sound.Interface.ISound;
	import cx.sound.enum.enSoundType;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import mx.utils.StringUtil;

	public class CxSoundPlayer extends Sprite implements ISound
	{
		private var _length : uint;
		public function get length() : uint
		{
			return _length;
		}
		protected var m_soundMaps : Dictionary;
		public function get SoundMaps() : Array
		{
			var temp : Array = new Array(_length);
			var index:int = 0;
			for(var i:* in m_soundMaps){
				temp[index] = i;
				index ++;
			}
			return temp;
		}
		protected var m_bMute : Boolean;
		public function get mute() : Boolean
		{
			return m_bMute;
		}
		public function set mute(value : Boolean) : void
		{
			m_bMute = value;
			if(m_bMute) {
				stop();
			}
		}
		public function CxSoundPlayer()
		{
			super();
			OnInitSoundMaps();
		}
		protected function OnInitSoundMaps() : void
		{
			m_soundMaps = new Dictionary();
			m_bMute = false;
			_length = 0;
		}
		public function play(label:String,bRepeat : Boolean = false,completeFun : Function = null): Boolean
		{
			if(mute) return false;
			var sound : SoundBase = get(label);
			if(sound == null) return false;
			return sound.Play(bRepeat,completeFun);
		}
		public function stop(label : String = 'p_all'):Boolean
		{
			if(label == 'p_all') {
				eachValue(stopAll);
			}else {
				var sound : SoundBase = get(label);
				if(sound == null) return false;
				sound.stop();
			}
			return false;
		}
		public function exists(label : String) : Boolean
		{
			return m_soundMaps.indexOf(label) != -1;
		}
		private var _musicValume : Number = 1;
		private var _effectValue : Number = 1;
		public function SetValume(value : Number,type : uint = enSoundType.ST_ALL) : Boolean
		{
			_musicValume = type!=enSoundType.ST_EFFECT?value:_musicValume;
			_effectValue = type!=enSoundType.ST_MUSIC?value:_effectValue;
			for each(var sound : SoundBase in m_soundMaps) {
				if(sound == null) continue;
				if(type == enSoundType.ST_ALL || sound.soundType == type) { sound.valume = value; }
			}
			return true;
		}
		public function getValume(type : uint) : Number
		{
			if(type == 0) return _musicValume;
			return _effectValue;
		}
		public function Destroy() : void
		{
			for each(var sound : SoundBase in m_soundMaps) 
			{
				if(sound == null) continue;
				sound.Destroy();
				sound = null;
			}
			m_soundMaps = null;
		}
		public function containsKey(label : String):Boolean{
			if(m_soundMaps[label] != undefined){
				return true;
			}
			return false;
		}
		protected function put(label : String,sound : SoundBase) : Boolean
		{
			if(label == null || StringUtil.trim(label).length == 0){
				throw new ArgumentError("cannot put a value with undefined or null key!");
				return false;
			}else if(sound == null){
				return remove(label) != null;
			}else{
				var exist:Boolean = containsKey(label);
				if(!exist){
					_length++;
				}
				m_soundMaps[label]=sound;
				return true;
			}
		}
		public function remove(label : String): SoundBase
		{
			var exist:Boolean = containsKey(label);
			if(!exist){
				return null;
			}
			var temp : SoundBase = m_soundMaps[label];
			delete m_soundMaps[label];
			_length--;
			return temp;
		}
		
		protected function eachKey(func:Function):void{
			for(var i:* in m_soundMaps){
				func(i);
			}
		}
		protected function eachValue(func : Function) : void {
			for each(var i:* in m_soundMaps){
				func(i);
			}
		}
		protected function get(label : String): SoundBase
		{
			var value:* = m_soundMaps[label];
			if(value !== undefined){
				return value;
			}
			return null;
		}
		private function stopAll(sound : SoundBase) : void
		{
			sound.stop();
		}
	}
}
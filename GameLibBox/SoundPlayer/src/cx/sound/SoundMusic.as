package cx.sound
{
	import cx.sound.enum.enSoundType;
	
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class SoundMusic extends SoundBase
	{
		public function SoundMusic(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(enSoundType.ST_MUSIC,stream, context);
		}
	}
}
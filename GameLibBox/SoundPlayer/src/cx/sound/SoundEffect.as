package cx.sound
{
	import cx.sound.enum.enSoundType;
	
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	
	public class SoundEffect extends SoundBase
	{
		public function SoundEffect(stream:URLRequest=null, context:SoundLoaderContext=null)
		{
			super(enSoundType.ST_EFFECT,stream, context);
		}
	}
}
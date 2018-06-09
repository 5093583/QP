package cx.gamebase.model
{
	import cx.gamebase.Interface.IDestroy;
	import cx.gamebase.events.TCPEvent;
	import cx.gamebase.sturuct.tagUserInfoHead;
	import cx.sound.Interface.ISound;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.controller.Controller;
	import t.cx.air.file.TPather;

	public class SoundModel implements IDestroy
	{
		private static var _instance : SoundModel;
		public static function _getInstance() : SoundModel
		{
			return _instance == null ? _instance = new SoundModel() : _instance;
		}
		private var _iSound : ISound;
		public function get iSound() : ISound
		{
			return _iSound;
		}
		
		private var _urlLoader : URLLoader;
		private var _loader : Loader;
		
		private var _userModel : GameUserModel;
		public function SoundModel()
		{
			_userModel = GameUserModel.GetInstance();
		}
		public function StartLoad(path : String) : void
		{
			_urlLoader = new URLLoader();
			_urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
			_urlLoader.addEventListener(Event.COMPLETE,OnLoadComplete);
			_urlLoader.load(new URLRequest(path));
		}
		public function Play(name : String,repeat : Boolean = false,callBack : Function = null) : void
		{
			if(_iSound == null) return;
			_iSound.play(name,repeat,callBack);
		//	_iSound.SetValume(0.5,0);
		}
		
		public function PlayEffect(wChairID : uint,action : String,type : int=-1,value : int=-1,rand : int = -1, gType:int=-1) : void
		{
			if(_iSound == null) return;
			var pName : String='';
			var sex : String = '';
			if(wChairID != TConst.INVALID_CHAIR) {
				_userModel = GameUserModel.GetInstance();
				var userInfo : tagUserInfoHead = _userModel.GetUserByChair(wChairID);
				if(userInfo == null) return;
				sex = (userInfo.cbGender%2==0)?'m':'n';
				if(gType == 1)
					sex = 'n';
				sex +='_';
			}
			pName = sex+'e_' + action + (type==-1?'':('_'+type)) + (value==-1?'':('_'+value))+ (rand == -1?'':('_'+rand));
			_iSound.play(pName,false);
		}
		
		public function SetSoundValue(type : uint,value : Number) : void
		{
			if(_iSound == null) return;
			/**
			 * 音乐文件 设置音量存在问题  设置为0 时 应该直接关闭
			 * */
			_iSound.SetValume(value,type);
		}
				
		private function OnLoadComplete(e : Event) : void
		{
			var bytes : ByteArray = e.target.data as ByteArray;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,OnSWFLoaded);
			
			var loaderContext:LoaderContext = new LoaderContext();
			if(loaderContext.hasOwnProperty('allowLoadBytesCodeExecution')) {
				loaderContext['allowLoadBytesCodeExecution'] = true;
			}
			if(TConst.TC_DEUBG != 1)
			{
				bytes = TPather._decodeSwf(bytes);
			}
			_loader.loadBytes(bytes,loaderContext);
			
			_urlLoader.removeEventListener(Event.COMPLETE,OnLoadComplete);
			_urlLoader = null;
		}
		private function OnSWFLoaded(e : Event) : void
		{
			var load : LoaderInfo = e.target as LoaderInfo;
			load.removeEventListener(Event.COMPLETE,OnSWFLoaded);
			_iSound = _loader.content as ISound;
			Controller.dispatchEvent(TCPEvent.GAME_SOUND_COMPLETE,1);
		}
		public function Destroy() : Boolean
		{
			if(_urlLoader) {
				_urlLoader.removeEventListener(Event.COMPLETE,OnLoadComplete);
				_urlLoader = null;
			}
			if(_loader) {
				_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE,OnSWFLoaded);
				_loader.unloadAndStop();
				_loader = null;
			}
			if(iSound) { iSound.Destroy(); }
			
			return true;
		}
	}
}
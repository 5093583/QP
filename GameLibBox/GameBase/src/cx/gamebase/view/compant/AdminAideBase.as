package cx.gamebase.view.compant
{
	import cx.gamebase.model.GlobalModel;
	import cx.net.Interface.IAdminAide;
	import cx.net.Interface.IAdminViewSink;
	
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import t.cx.air.TConst;
	import t.cx.air.file.TPather;
	
	public class AdminAideBase extends Sprite implements IAdminViewSink
	{
		private var PATH : String = "AdminAide";
		private var _loader : Loader;
		
		protected var m_pIAide : IAdminAide;
		protected var m_pGlobalModel : GlobalModel;
		
		public function AdminAideBase()
		{
			super();
			this.visible = false;
			if(stage) {
				OnInit();
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,OnInit);
			}
		}
		
		public function ReadAdminSocket(wSubCmd:uint, pBuffer:ByteArray, wDataSize:uint):Boolean
		{
			return false;
		}
		protected function OnInit(e : Event = null) : void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,OnInit);
			
			m_pGlobalModel = GlobalModel.GetInstance() as GlobalModel;
			//开始加载
			PATH = PATH + (TConst.TC_DEUBG==1?'.swf':'.cxc');
			var url : String = TPather._fullPath(PATH);
			if(!TPather._exist(url)) return;
			var bytes : ByteArray = TPather._readFile(PATH,'bytes') as ByteArray;
			
			var context : LoaderContext = new LoaderContext();
			context.allowLoadBytesCodeExecution = true;
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE,OnLoadComplete);
			_loader.loadBytes(bytes,context);
		}
		protected function OnLoadComplete(e : Event) : Boolean
		{
			var loadInfo : LoaderInfo = e.target as LoaderInfo;
			loadInfo.removeEventListener(Event.COMPLETE,OnLoadComplete);
			this.addChild(loadInfo.content);
			m_pIAide = loadInfo.content as IAdminAide;
			if(m_pIAide == null || m_pGlobalModel.m_Tcp==null)return false;
			m_pIAide.SetViewSink(this);
			m_pIAide.SetClientSocket(m_pGlobalModel.m_Tcp.gameSocket);
			return true;
		}
		
		public function Destroy() : void
		{
			if(m_pIAide != null)
			{
				m_pIAide.Destroy();
				m_pIAide = null;
			}
			
			if(_loader)
			{
				_loader.unloadAndStop();
				_loader.removeChildren();
				_loader = null;
			}
			m_pGlobalModel = null;
		}
	}
}
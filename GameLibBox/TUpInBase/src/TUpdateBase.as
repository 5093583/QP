package
{
	import cx.net.NetConst;
	import flash.data.EncryptedLocalStore;
	import flash.desktop.NativeApplication;
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.desktop.SystemTrayIcon;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.NativeWindowType;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeWindowBoundsEvent;
	import flash.events.NativeWindowDisplayStateEvent;
	import flash.events.ScreenMouseEvent;
	import flash.filesystem.File;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.system.System;
	import flash.utils.ByteArray;
	
	import t.cx.Interface.ICXKernel;
	import t.cx.Interface.ICxKernelClient;
	import t.cx.Interface.IHtmlContiner;
	import t.cx.Interface.IKernelFile;
	import t.cx.Interface.IKernelSocket;
	import t.cx.Interface.IKernelWin;
	import t.cx.air.HtmlSprite;
	import t.cx.air.NativeWin;
	import t.cx.air.TCenterPostion;
	import t.cx.air.TCheckLocalIP;
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.file.TFileLoadVO;
	import t.cx.air.file.TFileLoader;
	import t.cx.air.file.TPather;
	import t.cx.air.load.TURLLoader;
	import t.cx.air.load.UrlloaderVO;
	import t.cx.air.utils.IDConvert;
	import t.cx.air.utils.Memory;
	import t.cx.air.utils.SystemEx;
	
	public class TUpdateBase extends Sprite implements ICXKernel
	{
		private var _screenWidth 	: Number;						//屏幕宽度
		private var _screenHeight 	: Number;						//屏幕高度
		private var _pWindows 		: Vector.<NativeWin>;			//窗口函数
		private var _trayIcon		: SystemTrayIcon;				//系统托盘
		
		//版本
		protected var _newVer		: Number;
		protected var NEW_CHECK_VER : int = 100;
		private var _downloading	: Boolean = false;				//是否下载
		
		private var _windowX		: Number;
		private var _windowY		: Number;
		
		//更新
		private var _checkProgress 	: uint;
		private var _taskCount		: uint;
		protected function get checkProgress() : uint
		{
			return _checkProgress;
		}
		protected function set checkProgress(val : uint) : void
		{
			_checkProgress = val;
			if(progress.currentFrame < _checkProgress) {
				progress.play();
			}
		}
		public function TUpdateBase()
		{
			if( stage ) {
				addToStageEvent(); 
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,addToStageEvent);
			}
			if(TDas._getByteItem(TConst.PROXY) == 0) { TCheckLocalIP._checkIpIsp(); }
			
		}
		private function addToStageEvent(event : Event = null) : void
		{
			if( event ) { this.removeEventListener(Event.ADDED_TO_STAGE,addToStageEvent); }
			
			//设置舞台属性
			stage.align 	= StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			_screenWidth 	= Screen.mainScreen.visibleBounds.width;
			_screenHeight 	= Screen.mainScreen.visibleBounds.height;
			
			if(onConfigUpdate())
			{
				_pWindows = new Vector.<NativeWin>();
				if(CCModule) { 
					CCModule.startAsync(this); 
				}
				NetConst.Init(this as IKernelSocket,this as IKernelFile,this as IKernelWin);
				onDrawLoad();
				TCenterPostion._CenterWindow(stage.nativeWindow);
				onSetIcon();
				onUpdate();
			}
		}
		protected function onConfigUpdate() : Boolean
		{
			
			return true;
		}
		protected function onDrawLoad() : Boolean
		{
			if(updatebackgroundmc != null) { 
				updatebackgroundmc.mouseChildren = false;
				updatebackgroundmc.mouseEnabled = false;
				
				this.addChild(updatebackgroundmc); 
			} else if(updatebackgroundbmp != null) {
				this.addChild(updatebackgroundbmp); 
			}
			if(progress) {
				progress['CloseBtn'].visible = false;
				progressInfo = '正在更新游戏配置文件(1/100)';
				progress.gotoAndStop(1);
				this.addChild(progress);
			}
			return false;
		}
		protected function onSetIcon() : void
		{
			NativeApplication.nativeApplication.icon.bitmaps = [producticon];
			if( NativeApplication.supportsSystemTrayIcon )
			{
				_trayIcon 		= NativeApplication.nativeApplication.icon as SystemTrayIcon;
				_trayIcon.addEventListener(ScreenMouseEvent.CLICK,onTopMainWindow);
			}
		}
		protected function onTopMainWindow(e : ScreenMouseEvent) : void
		{
			SystemEx._froceGC();
			for each(var nav : NativeWin in _pWindows)
			{
				if(nav != null && nav.pWindow.visible)
				{
					switch( nav.pICxClient.CxShowType().toLocaleLowerCase() )
					{
						case '_game2d':
						case '_game3d':
						case '_pop2dwindow':
						{
							nav.pWindow.activate();
							nav.pWindow.orderToFront();
							return;
						}
					}
				}
			}
			stage.nativeWindow.activate();
			stage.nativeWindow.orderToFront();
		}
		protected function onUpdate() : void
		{
			checkProgress = 10;
			TURLLoader.load(new UrlloaderVO(UpdateFile,'update',OnCompleteEvent,OnErrorEvent));
			if(progress != null) {
				progress.addEventListener(Event.ENTER_FRAME,onProEnterFrame);
				progress.gotoAndPlay(1);
			}
		}
		
		protected function OnCompleteEvent(data : XML) : void
		{
			progressInfo = '正在下载,请耐心等待(10/100).';
			//获取版本
			var oldVer : Number = TDas._getDoubleItem(TConst.VER);
			_newVer = parseFloat(data.@ver);
			TDas._setDoubleItem('new_version_check',_newVer);
			
			if(isNaN(oldVer) || oldVer != TConst.TC_LASTVER)
			{
				oldVer = TConst.TC_LASTVER;
			}
			var i : uint = 0;
			
			//ip地址
			var tXMLList : XMLList = data.addr.item;
			for(i = 0; i<tXMLList.length(); i++) {  TDas._setStringItem(tXMLList[i].@target,tXMLList[i],256); }
			//url地址
			tXMLList  = data.url.item;
			for(i = 0; i<tXMLList.length(); i++) { 
				if(tXMLList[i].@target == TConst.POST_URL) {
					TDas._setStringItem(tXMLList[i].@target,tXMLList[i],8192);
					TDas._setDoubleItem(TConst.POST_WIDTH,tXMLList[i].@Width);
					TDas._setDoubleItem(TConst.POST_HEIGHT,tXMLList[i].@Height);
				}else {
					TDas._setStringItem(tXMLList[i].@target,tXMLList[i],256);
				} 
			}
			//聊天列表
			TDas._setStringItem(TConst.CHAT_LIST,data.chatlist,10240);
			//游戏列表配置
			TDas._setStringItem(TConst.GAME_OPTION,data.gameOption,20480);
			//登陆广告配置
			TDas._setStringItem(TConst.LOGON_AD,data.logonAd,5120);
			//大厅广告地址
			TDas._setStringItem(TConst.PLAZA_AD,data.plazaAd1,1024);
			//是否强制更新
			var forceAll : uint = parseFloat(data.@forceAll);
			TDas._setByteItem('new_forceAll',forceAll);
			if(oldVer != _newVer && forceAll == 1) { 
				TDas._setDoubleItem('new_version_check',_newVer);
				onErrorUpate('');
				return; 	
			}
			tXMLList = data.down.item;
			if( _newVer == oldVer)
			{
				TDas._setDoubleItem(TConst.VER,_newVer);
				onStartMain();
				System.disposeXML(data);
				return;
			}
			//搜索下载
			var subVer : Number,downLoadUrl : String;
			for(i = 0;i<tXMLList.length();i++)
			{
				subVer = parseFloat(tXMLList[i].ver);
				if(oldVer < subVer && tXMLList[i].url != '' && tXMLList[i].local != '')
				{
					downLoadUrl =  tXMLList[i].url + '?randCode = '+ ( new Date().time);
					if(tXMLList[i].@request == '0')
					{
						if( TPather._exist( TPather._fullPath(tXMLList[i].local) ) )
						{
							TFileLoader._addTask(new TFileLoadVO(downLoadUrl,i+1,tXMLList[i].@target,tXMLList[i].local,OnFileCompleteEvent,OnFileErrorEvent,OnFileProgEvent));
						}
					}else {
						TFileLoader._addTask(new TFileLoadVO(downLoadUrl,i+1,tXMLList[i].@target,tXMLList[i].local,OnFileCompleteEvent,OnFileErrorEvent,OnFileProgEvent));
					}
				}
			}
			_taskCount = TFileLoader._taskCount();
			
			if( _taskCount > 0) {
				_downloading = true;
				TFileLoader._load();
			}else {
				TDas._setDoubleItem(TConst.VER,oldVer);
				TDas._setDoubleItem('new_version_check',_newVer);
				onErrorUpate('客户端更新失败,请下载完整版客户端.');
			}
			System.disposeXML(data);
		}
		protected function OnFileCompleteEvent(target : String) : void
		{
			if(TFileLoader._taskCount() == 0)
			{
				if(_downloading) {
					onStartMain();
					_downloading = false;
				}
			}
		}
		protected function OnFileErrorEvent(err : String) : void
		{
			onErrorUpate('更新下载失败,请关闭客户端或联系客服.');
		}
		protected function OnFileProgEvent(index : uint,currentBytes : int,totalbytes : int) : void
		{
			checkProgress =  (currentBytes/totalbytes) * (100/_taskCount) + ( (_taskCount-TFileLoader._taskCount()-1) *  (100/_taskCount));
		}
		protected function OnErrorEvent(err : String = '') : void
		{
			TDas._setDoubleItem('new_version_check',999);
			onErrorUpate('更新下载失败,请关闭客户端或联系客服.');
		}
		private function onErrorUpate(str : String,field : Boolean = false) : void
		{
			//开启跳过更新失败 键值  0x000010
			if( (TConst.TC_SERVICE & 0x000010) != 0 && !field )
			{
				_downloading = false;
				onStartMain(false);
			}else {
				progress['CloseBtn'].visible = true;
				progress['CloseBtn'].addEventListener(MouseEvent.CLICK,onStop);
			}
			progress.stop();
			progressInfo = str;
			progress.removeEventListener(Event.ENTER_FRAME,onProEnterFrame);
		}
		private function onStartMain(bUpdateComplete : Boolean = true) : void
		{
			if(bUpdateComplete) { TDas._setDoubleItem(TConst.VER,_newVer); }
			progress.removeEventListener(Event.ENTER_FRAME,onProEnterFrame);
			progress.stop();
			var sFile : String = StartFile + (TConst.TC_DEUBG == 1?'.swf':'.cxc');
			if(  !TPather._exist( TPather._fullPath(sFile) )  )
			{
				onErrorUpate('更新文件错误,请尝试重新启动或安装客户端.',true);
				return;
			}
			TDas._setDoubleItem('check_update',NEW_CHECK_VER);
			progressInfo =  "更新下载完成,启动登录.";
			var bytes : ByteArray = TPather._readFile(sFile,'bytes') as ByteArray;
			var loader : Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext();
			loaderContext.allowLoadBytesCodeExecution = true; 
			loaderContext.applicationDomain = ApplicationDomain.currentDomain;
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoadLogonComplete);
			loader.loadBytes(bytes,loaderContext);
		}
		
		protected function onProEnterFrame(e : Event) : void
		{
			if(progress.currentFrame>=_checkProgress) {
				progress.stop();
				if( progress.currentLabel == 'complete') {
					progress.removeEventListener(Event.ENTER_FRAME,onProEnterFrame);
					if(!_downloading) { 
						onStartMain();
					}
				}
			}
			progressInfo = '正在下载,请耐心等待('+progress.currentFrame+'/100/'+( TFileLoader._taskCount()+1 )+').'
		}
		protected function onStop(event : Event) : void
		{
			stage.nativeWindow.close();
		}
		protected function onLoadLogonComplete(e : Event,bChangeAccounts : Boolean = false) : void
		{
			var contentInfo : LoaderInfo = e.target as LoaderInfo;
			contentInfo.removeEventListener(Event.COMPLETE,onLoadLogonComplete);
			var c : Class = ApplicationDomain.currentDomain.getDefinition('LogonSprite') as Class;
			var _pCxClient : ICxKernelClient = new c() as ICxKernelClient;
			if(_pCxClient == null) {
				onErrorUpate('文件错误,无法启动,请尝试重新启动或安装客户端.',true);	
				return; 
			}
			if(progress != null) {
				progress.gotoAndStop(1);
				if( this.contains(progress) ) {
					this.removeChild(progress);
				}
				progress.removeEventListener(Event.ENTER_FRAME,onProEnterFrame);
			}
			if(updatebackgroundmc!=null)  {
				if( this.contains(updatebackgroundmc) ) {
					this.removeChild(updatebackgroundmc);
				}
			}
			if(updatebackgroundbmp!=null) {
				if( this.contains(updatebackgroundbmp) ) {
					this.removeChild(updatebackgroundbmp);
				}
			}
			onDestroyLoad();
			SystemEx._froceGC();
			stage.nativeWindow.activate();
			stage.nativeWindow.orderToFront();
			showWindow(_pCxClient);
		}
		private function showWindow(pIClient : ICxKernelClient) : Boolean
		{
			if(pIClient == null)  { return false; }
			
			var mDos : DisplayObject = pIClient.CxGetDisplayObject();
			if(mDos == null) { return false; }
			try {
				var winType : String = pIClient.CxShowType(this).toLowerCase();
				var wh : Point = pIClient.CxGetWH();
				var i : int= 0 ,pTempClient : ICxKernelClient,theParent : NativeWin;
				switch(winType)
				{
					case '_main2d':
					{
						for( i =0;i<_pWindows.length;i++ ) {
							if(_pWindows[i] != null && _pWindows[i].pICxClient.CxShowType(this).toLowerCase() == '_main2d' )
							{
								var destroyDos : DisplayObject = _pWindows[i].pICxClient.CxGetDisplayObject();
								if(this.contains(destroyDos)) { this.removeChild(destroyDos); }
								destroyDos['CxClientDestroy'](3);
								destroyDos = null;
								_pWindows[i].pICxClient = null;
								_pWindows[i] = null;
								
								_pWindows.splice(i,1);
							}
						}
						stage.nativeWindow.visible = true;
						theParent = new NativeWin(stage.nativeWindow);
						theParent.pWindow.width  = wh.x;
						theParent.pWindow.height = wh.y;
						this.addChild(mDos);
						break;
					}
					case '_pop2dwindow':
					{
						theParent = createWindow(true,pIClient.CxIcon());
						if(theParent) {
							theParent.pWindow.alwaysInFront = true;
						}
						break;
					}
					case '_game2d':
					{
						stage.nativeWindow.visible = false;
						theParent = createWindow(true,pIClient.CxIcon(),true,pIClient.CxWindowTitle());
						break;
					}
					case '_game3d':
					{
						stage.nativeWindow.visible = false;
						theParent = createWindow(false,pIClient.CxIcon(),false,pIClient.CxWindowTitle(),NativeWindowRenderMode.DIRECT,false);
						break;
					}
					default:
					{
						throw new Error("show window type is Null");
						return false;	
					}
				}
				
				if(theParent != null) {
					theParent.pICxClient = pIClient;
					_pWindows.push(theParent);
					if(winType != '_main2d') {
						theParent.pWindow.bounds = new Rectangle(0,0,wh.x,wh.y);
						theParent.pWindow.stage.addChild(mDos);
						if(winType != '_pop2dwindow')
						{
							var bMax : String = TDas._getCookie('cookie_game','max');
							if(winType !='_game3d' && bMax != null && bMax == '1') { 
								theParent.pWindow.maximize();
							} else {
								mDos.scaleX = theParent.pWindow.stage.stageWidth / pIClient.CxGetWH().x;
								mDos.scaleY = theParent.pWindow.stage.stageHeight/ pIClient.CxGetWH().y;
								
								if(isNaN(_windowX) ==false && isNaN(_windowY) ==false)
								{
									theParent.pWindow.x = _windowX;
									theParent.pWindow.y = _windowY;
								}else {
									TCenterPostion._CenterWindow(theParent.pWindow);
									theParent.pWindow.addEventListener(NativeWindowBoundsEvent.MOVE,onWindowMove);
								}
							}
						}
					}else {
						TCenterPostion._CenterWindow(theParent.pWindow);
					}
					theParent.pWindow.visible = true;
					theParent.pWindow.activate();
					theParent.pWindow.orderToFront();
					
				}else {
					throw new Error(' theParent is null');
				}
			}catch(e : Error) {
				trace('[showWindow error]:' + e);
			}
			return false;
		}
		private function createWindow(trans : Boolean = true,icon : Array = null,Chrome : Boolean = false,title: String='',render : String='auto',bAllowMax : Boolean = true) : NativeWin
		{
			var options:NativeWindowInitOptions = new NativeWindowInitOptions();
			options.renderMode = render;
			options.transparent = trans;
			if(Chrome) {
				options.systemChrome = NativeWindowSystemChrome.STANDARD;
			}else {
				options.systemChrome = NativeWindowSystemChrome.NONE;
			}
			options.type = NativeWindowType.NORMAL;
			options.maximizable = bAllowMax;
			options.resizable = false;
			var newWindow : NativeWindow = new NativeWindow(options);
			newWindow.stage.align = StageAlign.TOP_LEFT;
			newWindow.stage.scaleMode = StageScaleMode.NO_SCALE;
			newWindow.addEventListener(Event.CLOSING,onCloseWindow);
			newWindow.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,onNativeDisplayChange);
			newWindow.title = title;
			var nativeWin : NativeWin = new NativeWin(newWindow);
			return nativeWin;
		}
		private function onWindowMove(e : NativeWindowBoundsEvent) : void
		{
			_windowX = e.target.x;
			_windowY = e.target.y;
		}
		private function onCloseWindow(e : Event) : void
		{
			var window : NativeWindow = e.target as NativeWindow;
			for(var i : uint = 0;i < _pWindows.length ;i++)
			{
				if(_pWindows[i] != null && _pWindows[i].pWindow == window)
				{
					if(_pWindows[i].pICxClient.CxClientDestroy(10)) {
						_pWindows.splice(i,1);
						window.removeEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,onNativeDisplayChange);
						window.removeEventListener(NativeWindowBoundsEvent.MOVE,onWindowMove);
						window.removeEventListener(Event.CLOSING,onCloseWindow);
						_pWindows[i].pICxClient = null;
						window.close();
						window = null;
					}else{
						e.preventDefault();
					}
					break;
				}
			}	
		}
		private function onNativeDisplayChange(e : NativeWindowDisplayStateEvent) : void
		{
			var native : NativeWindow = e.target as NativeWindow;
			for each(var nav : NativeWin in _pWindows)
			{
				if(nav.pWindow == native)
				{
					var dos : DisplayObject = nav.pICxClient.CxGetDisplayObject();
					var wh : Point = nav.pICxClient.CxGetWH();
					dos.scaleX = native.stage.stageWidth / wh.x;
					dos.scaleY = native.stage.stageHeight/ wh.y;
					TDas._setCookie('cookie_game','max',native.displayState=='normal'?'0':'1');
					break;
				}
			}
		}
		protected function onDestroyLoad() : void
		{
			
		}
		protected function get StartFile() : String
		{
			return '';
		}
		protected function get UpdateFile() : String
		{
			return '';
		}
		/**
		 * 应用图标
		 * */
		protected function get producticon() : BitmapData
		{
			return null;
		}
		/**
		 * 加载背景图片 MovieClip
		 * */
		protected function get updatebackgroundmc() : MovieClip
		{
			return null;
		}
		/**
		 * 加载背景图片 Bitmap
		 * */
		protected function get updatebackgroundbmp() : Bitmap
		{
			return null;
		}
		
		/**
		 * 加载进度条
		 * */
		protected function get progress() : MovieClip
		{
			return null;
		}
		protected function set progressInfo(val : String) : void
		{
			if(progress != null) { progress['InfoTxt'].text = val; }
		}
		/**
		 *内核对象 
		 * */
		protected function get CCModule() : Object
		{
			return null;
		}
		/**------------------------------------------------------------------------------------------------
		 * 实例化接口函数
		 * 
		 * ------------------------------------------------------------------------------------------------ */
		
		public function CxTcpConnect(cbVersion:uint):uint
		{
			return theTcpConnect(cbVersion);
		}
		protected function get theTcpConnect() : Function
		{
			return null;
		}
		public function CxTcpEncrypt(wMainCMD:uint, wSubCMD:uint, pData:ByteArray, wDataSize:uint):uint
		{
			var pNewData : ByteArray = Memory._newLiEndianBytes();
			pNewData.writeDouble(0);
			Memory._copyMemory(pNewData,pData,wDataSize,8);
			
			pNewData.position = 0;
			var bytesPtr:int = CCModule.malloc(pNewData.bytesAvailable);
			
			CCModule.writeBytes(bytesPtr,pNewData.bytesAvailable,pNewData);
			pNewData.position = 0;
			var result : uint = theTcpEncrypt(wMainCMD,wSubCMD,bytesPtr,pNewData.bytesAvailable);
			CCModule.readBytes(bytesPtr,pNewData.bytesAvailable,pNewData);
			CCModule.free(bytesPtr);
			Memory._copyMemory(pData,pNewData,pNewData.length);
			return result;
		}
		protected function get theTcpEncrypt() : Function
		{
			return null;
		}
		public function CxTcpCrevasse(pData:ByteArray, wDataSize:uint):uint
		{
			pData.position = 0;
			var bytesPtr:int = CCModule.malloc(pData.bytesAvailable);
			CCModule.writeBytes(bytesPtr,pData.length,pData);
			var result : uint = theTcpCrevasse(bytesPtr,wDataSize);
			pData.position = 0;
			CCModule.readBytes(bytesPtr,pData.bytesAvailable,pData);
			CCModule.free(bytesPtr);
			return result;
		}
		protected function get theTcpCrevasse() : Function
		{
			return null;
		}
		public function CxTcpClose():uint
		{
			return theTcpClose();
		}
		protected function get theTcpClose() : Function
		{
			return null;
		}
		public function CxFileCrevasse(pData:ByteArray, wDataSize:uint):uint
		{
			return 0;
		}
		
		public function CxGetKeyValue(key:String):*
		{
			return null;
		}
		
		public function CxSetKeyValue(key:String, value:*):Boolean
		{
			return false;
		}
		
		public function CxSetWH(w:Number, h:Number, pos:String="center"):Boolean
		{
			return false;
		}
		
		public function CxMaxWnd(pCxClient:ICxKernelClient):Boolean
		{
			return false;
		}
		
		public function CxMinWnd(pCxClient:ICxKernelClient):Boolean
		{
			var pWind : NativeWin;
			for(var i : uint = 0;i<_pWindows.length;i++) {
				pWind = _pWindows[i];
				if(pWind && pWind.pICxClient == pCxClient) {
					pWind.pWindow.minimize();
					return true;
				}
			}
			return false;
		}
		
		public function CxResTore(pCxClient:ICxKernelClient):Boolean
		{
			var pWind : NativeWin;
			for(var i : uint = 0;i<_pWindows.length;i++) {
				pWind = _pWindows[i];
				if(pWind && pWind.pICxClient == pCxClient) {
					pWind.pWindow.restore();
					return true;
				}
			}
			return false;
		}
		public function CxCenterWindow( pCxClient : ICxKernelClient ) : Boolean
		{
			var pWind : NativeWin;
			for(var i : uint = 0;i<_pWindows.length;i++) {
				pWind = _pWindows[i];
				if(pWind && pWind.pICxClient == pCxClient) {
					TCenterPostion._CenterWindow(pWind.pWindow);
					pWind.pWindow.restore();
					pWind.pWindow.orderToFront();
					return true;
				}
			}
			return false;
		}
		public function CxNotifyUser(type:String="critical"):Boolean
		{
			return false;
		}
		
		public function CxExit(pCxClient:ICxKernelClient, bExitCode:uint=0):Boolean
		{
			if(pCxClient != null)  {
				if(bExitCode == 999) { EncryptedLocalStore.reset(); }
				var pWind : NativeWin;
				var i : int = 0;
				for( i = _pWindows.length-1;i>=0;i-- ) {
					pWind = _pWindows[i];
					if(pWind && pWind.pICxClient == pCxClient) {
						_pWindows.splice(i,1);
						pWind.Destroy(bExitCode);
						pWind = null;
						break;
					}
				}
				for( i = 0;i<_pWindows.length;i++)
				{
					pWind = _pWindows[i];
					if(pWind.pICxClient.CxShowType().toLowerCase()=='_main2d')
					{
						pWind.pWindow.visible = true;
						TCenterPostion._CenterWindow(pWind.pWindow);
						pWind.pWindow.activate();
						pWind.pICxClient.CXShowed(bExitCode);
						break;
					}
				}
				if( _pWindows.length == 0) {
					CxCloseBrowser();
				}else {
					if(bExitCode == 100) { onStartMain(false);}
				}
			}
			return true;
		}
		
		public function CxShowWindow(pClient:ICxKernelClient):Boolean
		{
			return showWindow(pClient);
		}
		private var _html : HtmlSprite;
		public function CxGetHtmlContiner() : IHtmlContiner
		{
			if(_html == null) { _html = new HtmlSprite(); }
			return _html;
		}
		public function CxCreateHtmlContiner() : IHtmlContiner
		{
			return new HtmlSprite();
		}
		
		public function CxStartMove():void
		{
			if(stage) { stage.nativeWindow.startMove(); }
		}
		public function CxGetIpInfo(ip:String):String
		{
			return null;
		}
		
		//创建一个 browser 窗口
		private var browserProcess:NativeProcess;
		public function CxCreateBrowser( url : String,title : String = '' ) : void
		{
			var file:File = new File(File.applicationDirectory.nativePath + '\\CBrowser.exe');
			if(file.exists)
			{
				if(browserProcess == null) { browserProcess = new NativeProcess(); }
				if( !browserProcess.running ) {
					var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
					nativeProcessStartupInfo.executable = file;
					var processArgs:Vector.<String> = new Vector.<String>();
					processArgs.push( url );
					nativeProcessStartupInfo.arguments = processArgs;
					browserProcess.start( nativeProcessStartupInfo );
				}
			}else {
				var request:URLRequest = new URLRequest(url);
				navigateToURL(request,"_blank");
			}
		}
		public function CxCloseBrowser() : void
		{
			if( browserProcess!=null && browserProcess.running ) {
				browserProcess.exit();
			}
		}
	}
}
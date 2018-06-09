package com
{
	import base.NavigateURL;
	
	import com.plaza.MsgManager;
	
	import cx.net.NetConst;
	
	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.display.MovieClip;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.system.System;
	
	import t.cx.air.TConst;
	import t.cx.air.TDas;
	import t.cx.air.controller.Controller;
	import t.cx.air.file.TFileLoadVO;
	import t.cx.air.file.TFileLoader;
	import t.cx.air.file.TPather;
//	import t.cx.air.load.TURLLoader;
	import t.cx.air.load.UrlloaderVO;
	
	public class CheckAndUpdate extends Sprite
	{
		[Embed(source="assets/loading_PJ.swf",symbol="loading")]
		private var _loading : Class;
		private var _loadMC:MovieClip;
		
//		[Embed(source="assets/loading_PJ.swf",symbol="OnlyStart")]
//		private var OnlyStart:Class;
//		private var _bmpBg:Bitmap;
		
		private var _screenWidth 	: Number;						//屏幕宽度
		private var _screenHeight 	: Number;						//屏幕高度
		
		protected var NEW_CHECK_VER : int = 100;
		protected var _newVer		: Number;
		private var _downloading	: Boolean = false;				//是否下载
		
		
		//更新
		private var _checkProgress 	: uint;
		private var _taskCount		: uint;
		
		
		private var loader : URLLoader;
		private var loaderStatic : URLLoader;
		protected function get checkProgress() : uint
		{
			return _checkProgress;
		}
		protected function set checkProgress(val : uint) : void
		{
			_checkProgress = val;
		}
		public function CheckAndUpdate()
		{
			if( stage ) {
				addToStageEvent(); 
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,addToStageEvent);
			}
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
				onUpdate();
			}
		}
		protected function onConfigUpdate() : Boolean
		{
			NEW_CHECK_VER = 100;
			TConst.TC_LASTVER = 135;
			TConst.TC_RUTIME = 'desktop';
			TConst.TC_DEUBG = 0;
			TConst.TC_IDCONVER = 0;
			TConst.TC_SOCKET_VER = 0x01;
			TConst.TC_SERVICE |= 0x000010;
			TConst.TC_PUBLISHNAME = 'pujing';
			
			_loadMC = new _loading() as MovieClip;
			this.addChild( _loadMC );
			
			_loadMC['tname'].text = '';
			_loadMC['tpro'].text = '';
			_loadMC['loadtype'].gotoAndStop(2);
			return true;
		}
		
		protected function onDrawLoad() : Boolean
		{
			if(_loadMC)
			{
				_loadMC.mouseChildren = false;
				_loadMC.mouseEnabled  = false;
				this.addChild( _loadMC );
				
			}
			
			return false;
		}
		
		
		protected function onUpdate() : void
		{
			checkProgress = 10;
			if(loader==null) loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,GetNetXml);
			loader.addEventListener(IOErrorEvent.IO_ERROR,OnErrorEvent);
			loader.load(new URLRequest(UpdateFile));
			//TURLLoader.load(new UrlloaderVO(UpdateFile,'update',OnCompleteEvent,OnErrorEvent));
		}
		
		//销毁loader
		private function unRegisterListern(target : URLLoader) : void
		{
			if(target!=null){
				target.removeEventListener(Event.COMPLETE,GetNetXml);
				target.removeEventListener(IOErrorEvent.IO_ERROR,OnErrorEvent);
				target = null;
			}
		}
		protected function GetNetXml(e : Event) : void
		{
			var loader : URLLoader = e.target as URLLoader;
			var localXML : XML = XML( loader.data );
			unRegisterListern(loader);
			OnCompleteEvent(localXML);
		}
		protected function OnCompleteEvent(data : XML) : void
		{
			//			progressInfo = '正在下载,请耐心等待(10/100).';
			//获取版本
			var oldVer : Number = TDas._getDoubleItem(TConst.VER);
			_newVer = parseFloat(data.@ver);
			TDas._setDoubleItem('new_version_check',_newVer);
			
			if(isNaN(oldVer) || oldVer != TConst.TC_LASTVER)
			{
				oldVer = TConst.TC_LASTVER;
			}
			
			TDas._setStringItem('gameRollString', data.message, 5120);
			
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
			
			//			trace(TDas._getStringItem('def_url', 256));
			NavigateURL.plaza_navigate = TDas._getStringItem('def_url', 256);
			NavigateURL.plaza_active   = TDas._getStringItem('act_url', 256);
			
			
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
				writeLocalConfig(data);
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
				onErrorUpate('客户端更新失败，请重新下载完整版客户端！如未能解决，请联系客服');
			}
			
			
			writeLocalConfig(data);
			System.disposeXML(data);
		}
		protected function writeLocalConfig(data : XML) : void
		{
			var file : File = new File(File.applicationDirectory.nativePath+"/assets/html/Ybupdate.xml");
			var fileStream : FileStream = new FileStream();
			fileStream.openAsync(file,FileMode.WRITE);
			fileStream.writeMultiByte(data.toString(),"utf-8");
			fileStream.close();
		}
		
		private var _mainUpdated:Boolean = false;
		protected function OnFileCompleteEvent(target : String) : void
		{
			_loadMC['loadtype'].gotoAndStop(2);
			if(target.indexOf('TYPlazaAir') != -1)
				_mainUpdated = true;
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
			_loadMC['loadtype'].gotoAndStop(1);
			
			
			trace(_taskCount + '  ****  ' + TFileLoader._taskCount() + '  ****  ' + currentBytes + '  ****  ' + totalbytes);
			
			if(_loadMC)
			{
				_loadMC['tname'].text = '下载' + index + '个更新';
				_loadMC['tpro'].text = checkProgress + '%';
			}
		}
		protected function OnErrorEvent(e : ErrorEvent) : void
		{
			checkProgress = 10;
			//TURLLoader.load(new UrlloaderVO('./assets/html/Ybupdate.xml','update',OnCompleteEvent,OnErrorStaticXML));
			if(loaderStatic == null) loaderStatic = new URLLoader();
			loaderStatic.addEventListener(Event.COMPLETE,GetStaticXml);
			loaderStatic.addEventListener(IOErrorEvent.IO_ERROR,OnErrorStaticXML);
			loaderStatic.load(new URLRequest("./assets/html/Ybupdate.xml"));
		}
		private function unRegisterListern1(target : URLLoader) : void
		{
			if(target!=null){
				target.removeEventListener(Event.COMPLETE,GetStaticXml);
				target.removeEventListener(IOErrorEvent.IO_ERROR,OnErrorStaticXML);
				target = null;
			}
		}
		protected function GetStaticXml(e : Event) : void
		{
			var loader : URLLoader = e.target as URLLoader;
			var localXML : XML = XML( loader.data);
			unRegisterListern1(loader);
			OnCompleteEvent(localXML);
		}
		protected function OnErrorStaticXML(e : ErrorEvent) : void
		{
			TDas._setDoubleItem('new_version_check',999);
			//			onErrorUpate('更新下载失败,请关闭客户端或联系客服.');
			onErrorUpate('客户端数据更新失败，请检查网络或重试打开客户端！如未能解决，请联系客服');
		}
		private function natvigatoKefu():void
		{
			var url:String = 'http://www15.53kf.com/webCompany.php?arg=10102711&style=1';
			navigateToURL( new URLRequest(url) );
		}
		
		private function onErrorUpate(str : String,field : Boolean = false) : void
		{
			//开启跳过更新失败 键值  0x000010
			if( (TConst.TC_SERVICE & 0x000010) != 0 && !field )
			{
				_downloading = false;
				//				onStartMain(false);
			}else {
				//				progress['CloseBtn'].visible = true;
				//				progress['CloseBtn'].addEventListener(MouseEvent.CLICK,onStop);
			}
			
			onStartMain(false);
			
			if(str == '')
				MsgManager.getInstance().showMessage1('您的游戏版本过低，请重新下载客户端！', closeAir);
			else
				MsgManager.getInstance().showMessage1(str, closeAir);
			
			
//			natvigatoKefu();
		}
		
		private function closeAir():void
		{
			Controller.dispatchEvent("close_window_over", 1);
		}
		
		protected function onStop(event : Event) : void
		{
			stage.nativeWindow.close();
		}
		
		private function onStartMain(bUpdateComplete : Boolean = true) : void
		{
			Controller.dispatchEvent("checkUpdateComplete");
			
			if(bUpdateComplete) { TDas._setDoubleItem(TConst.VER,_newVer); }
			TDas._setDoubleItem('check_update',NEW_CHECK_VER);
			
			if(_mainUpdated)
				MsgManager.getInstance().showMessage1('客户端更新成功，点击确定后程序将会重新启动！', restartAir);
		}
		
		
		private function restartAir():void
		{
			//CxDesktopRuntime
			var exeUrl:String = File.applicationDirectory.nativePath + "/xpjpoker.exe";
			if( TPather._exist(exeUrl) )
			{
				closeAir();
				
				var file:File = new File(exeUrl);
				var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
				nativeProcessStartupInfo.executable = file;
				
				var arguments:Vector.<String> = new Vector.<String>();
				arguments[0] = "cx";
				
				nativeProcessStartupInfo.arguments = arguments;
				var process:NativeProcess = new NativeProcess();
				
				process.start(nativeProcessStartupInfo);
			}
			else
			{
				MsgManager.getInstance().showMessage1('对不起！未找到当前客户端目录，请手动重新启动程序！', closeAir);
			}
		}
		
		
		protected function get UpdateFile() : String
		{
			
//			var url : String   = 'http://192.168.5.134:8080/download/YBupdate.xml';
			
		//	var url : String   = 'http://103.232.87.232:8888/download/update.xml';
			//var url : String   = 'http://120.27.41.163:8888/download/YBupdate.xml';	//	演示平台
			var url : String   = 'http://xpjadmin.zhenqian22.com/download/update.xml';				//葡京
			
			return url + '?randCode=' + (new Date().time);
		}
		
	}
}
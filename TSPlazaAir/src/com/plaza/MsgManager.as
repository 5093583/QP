package com.plaza
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.system.Capabilities;
	import flash.system.System;
	
	import mx.core.UIComponent;
	
	import spark.components.Group;

	public class MsgManager
	{
		public function MsgManager()
		{
		}
		
		private var _gp:Group;
		private var _popgp:Group;
		
		
		private static var _instance:MsgManager;
		public static function getInstance():MsgManager
		{
			if(!_instance)
				_instance = new MsgManager;
			return _instance;
		}
		
		public function init(gp:Group):void
		{
			_gp = gp;
		}
		
		public function setPopgp(popgp:Group):void
		{
			_popgp = popgp;
		}
		
		public function remPopgp():void
		{
			if(_popgp && _popgp.numElements)
				_popgp.removeAllElements();
			if(_popgp)
				_popgp = null;
			System.gc();
		}
		
		private function get GP():Group
		{
			if(_popgp)
				return _popgp;
			return _gp;
		}
		
		
		public function removeTopPop():void
		{
			if(_gp && _gp.numElements > 1)
			{
				_gp.removeElementAt( _gp.numElements-1 );
				_sp.visible = false;
			}
			
			if(_popgp && _popgp.numElements)
			{
				_popgp.removeAllElements();
				_popgp.graphics.clear();
				if(_sp)	_sp.visible = false;
				System.gc();
			}
		}
		
		public function removeCurrectPop(pop:PopMessage):void
		{
			if( _gp && pop && _gp.contains(pop) )
			{
				_gp.removeElement( pop );
				_sp.visible = false;
			}
			
			if(_popgp && _popgp.numElements)
			{
				_popgp.removeAllElements();
				_popgp.graphics.clear();
				if(_sp)	_sp.visible = false;
				System.gc();
			}
		}
		
		
		public function showMessage1(msg:String, callback:Function=null, hor:int=0, ver:int=-50, isRemove:Boolean=false,val : uint = 0):void
		{
			addBackground();
			
			var	popmsg:PopMessage = new PopMessage;
			popmsg.init(msg, callback, isRemove,val);
			
//			PopUpManager.addPopUp(popmsg, FlexGlobals.topLevelApplication as DisplayObject, true);
//			PopUpManager.centerPopUp(popmsg);
			
			popmsg.horizontalCenter	= hor;
			popmsg.verticalCenter	= ver;
			
			GP.addElement(popmsg);
		}
		
		public function showMessage2(msg:String, callback1:Function=null, callback2:Function=null, hor:int=0, ver:int=-50 ,val : uint = 0):void
		{
			addBackground();
			
			var	popmsg:PopMessage2 = new PopMessage2;
			popmsg.init(msg, callback1, callback2,val);
			
//			PopUpManager.addPopUp(popmsg, FlexGlobals.topLevelApplication as DisplayObject, true);
//			PopUpManager.centerPopUp(popmsg);
			
			popmsg.horizontalCenter	= hor;
			popmsg.verticalCenter	= ver;
			
			GP.addElement(popmsg);
		}
		
		
		private var _ui:UIComponent;
		private var _sp:Sprite;
		
		private function addBackground():void
		{
			if(_popgp)
			{
				var Sheight:Number = flash.system.Capabilities.screenResolutionY;  
				var Swidth:Number = flash.system.Capabilities.screenResolutionX;
				_popgp.graphics.clear();
				_popgp.graphics.beginFill(0x333333, .6);
				_popgp.graphics.drawRect(0, 0, Swidth, Sheight);
				_popgp.graphics.endFill();
				return;
			}
			
			if(!_sp)
			{
				var Stageheight:Number = flash.system.Capabilities.screenResolutionY;  
				var Stagewidth:Number = flash.system.Capabilities.screenResolutionX;
				_sp = new Sprite;
				_sp.graphics.clear();
				_sp.graphics.beginFill(0x333333, .6);
				_sp.graphics.drawRect(0, 0, Stagewidth, Stageheight);
				_sp.graphics.endFill();
			}
			else
			{
				_sp.visible = true;
				return;
			}
			if(!_ui)
			{
				_ui = new UIComponent;
				_ui.addChildAt(_sp, 0);
				_gp.addElement(_ui);
			}
		}
	}
}
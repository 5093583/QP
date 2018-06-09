package com
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.system.Capabilities;
	import flash.system.System;
	
	import mx.core.FlexGlobals;
	import mx.core.UIComponent;
	
	import spark.components.Group;
	
	public class PopManager
	{
		public function PopManager()
		{
		}
		
		public static var _instance:PopManager;
		public static function getInstance():PopManager
		{
			if(!_instance)
				_instance = new PopManager;
			return _instance;
		}
		
		private var _ui:UIComponent;
		private var _sp:Sprite;
		
		
		private var _gp:Group;
		
		public function init(gp:Group):void
		{
			_gp = gp;
		}
		
		
		
		public function addPop( target:Group, position:Point):void
		{
			addBackground();
			target.x = position.x;
			target.y = position.y;
			
			_ui.addChild(target);
		}
		
		public function removePop():void
		{
			if(_ui)
			{
				var length:int = _ui.numChildren - 1;
				if(length <= 0)	return;
				for(length ; length>0 ; length--)
				{
					_ui.removeChildAt(length);
				}
				_sp.visible = false;
			}
			
			System.gc();
		}
		
		private function addBackground():void
		{
			if(!_sp)
			{
				var Stageheight:Number = flash.system.Capabilities.screenResolutionY;  
				var Stagewidth:Number = flash.system.Capabilities.screenResolutionX;
				_sp = new Sprite;
				_sp.graphics.clear();
				//				_sp.graphics.beginFill(0xb3b3b3, .5);
				_sp.graphics.beginFill(0x000000, .3);
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
package cx.client.logon.view
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import t.cx.air.skin.ButtonEx;
	
	public class Combox extends Sprite
	{
		private var _popSprite  : Sprite;
		private var _popFieldVec: Vector.<TextField>;
		
		private var _historyVec : Vector.<String>;
		
		public function insetHistory(val : String) : void
		{
			if(_historyVec == null) { _historyVec = new Vector.<String>(); }
			if(_historyVec.length == 0)
			{
				theSelectBtn.enable = true;
				theSelectBtn.addEventListener(MouseEvent.CLICK,onShowSelectView)
			}
			_historyVec.push(val);
		}
		public function insetHistoryEx(val : String) : void
		{
			
		}
		
		private var _passCallBack : Function;
		public function set passwordCall(val : Function) : void
		{
			_passCallBack = val;
		}
		
		private function inputCallPack(str : String) : void
		{
			var arr : Array = str.split(',');
			if(arr!= null && str.length>=2 && str[1] != 'null')
			{
				text =arr[1];
			}
		}
		public function get InCall() : Function
		{
			return inputCallPack;
		}
		public function get text() : String
		{
			return theTxtField.text;
		}
		public function set text( value : String ) : void
		{
			theTxtField.text = value;
		}
		
		public function set displayAsPassword(value : Boolean) : void
		{
			theTxtField.displayAsPassword = value;
		}
		public function set restrict(value : String) : void
		{
			theTxtField.restrict = value;
		}
		
		public function Combox()
		{
			super();
			theSelectBtn.enable = false;
			theTxtField.addEventListener(FocusEvent.FOCUS_IN,onTextFocusIn);
		}
		public function ClearHistory() : void
		{
			if(_historyVec != null) {
				_historyVec = null;
			}
			destroyPop();
			theSelectBtn.enable = false;
			theSelectBtn.removeEventListener(MouseEvent.CLICK,onShowSelectView)
		}
		private function onTextFocusIn(e : FocusEvent) : void
		{
			destroyPop();
		}
		private function onShowSelectView(e : MouseEvent) : void
		{
			if(_historyVec == null) return;
			if(_historyVec.length == 0) return;
			if(_popSprite != null) 
			{
				destroyPop();
				return;
			}
			_popSprite = new Sprite();
			_popFieldVec = new Vector.<TextField>;
			var i : uint = 0;
			for( i = 0;i<_historyVec.length;i++)
			{
				var txt : TextField = new TextField();
				txt.text = String(_historyVec[i]).split(',')[0];
				txt.y = i * 15;
				txt.x = 3;
				txt.selectable = false;
				txt.addEventListener(MouseEvent.CLICK,onSelectText);
				txt.addEventListener(MouseEvent.MOUSE_OVER,onTextOverEvent);
				_popFieldVec.push(txt);
				_popSprite.addChild(txt);
			}
			OnDrawPopSprite(_popSprite,i);
			this.addChild(_popSprite);
		}
		protected function OnDrawPopSprite(pop : Sprite,len : uint) : void
		{
			pop.y = theSelectBtn.height + 2;
			pop.x = 10;
			pop.graphics.clear();
			pop.graphics.beginFill(0xaaaaaa,0.8);
			pop.graphics.drawRect(0,0,100,len*16);
			pop.graphics.endFill();
		}
		
		private function destroyPop() : void
		{
			if(_popSprite != null)
			{
				_popSprite.removeChildren();
				if(this.contains(_popSprite)) {
					this.removeChild(_popSprite);
				}
				_popSprite = null;
			}
			if(_popFieldVec != null) {
				for(var i : uint = 0;i<_popFieldVec.length;i++)
				{
					if(_popFieldVec[i] != null) { 
						_popFieldVec[i].removeEventListener(MouseEvent.CLICK,onSelectText);
						_popFieldVec[i].removeEventListener(MouseEvent.MOUSE_OVER,onTextOverEvent);
						_popFieldVec[i].removeEventListener(MouseEvent.MOUSE_OUT,onTextOutEvent);
						_popFieldVec[i] = null; 
					}
				}
				_popFieldVec = null;
			}
		}
		private function onSelectText(e : MouseEvent) : void
		{
			var txt : TextField = e.target as TextField;
			if(txt) {
				theTxtField.text = txt.text;
				if(_passCallBack != null) {
					
					for(var i : uint = 0;i<_historyVec.length;i++)
					{
						if( _historyVec[i].indexOf(txt.text)!=-1	) {
							_passCallBack(_historyVec[i]);
							break;
						}
					}
				}
				destroyPop();
			}
		}
		private function onTextOverEvent(e : MouseEvent) : void
		{
			e.target.alpha = 0.8;
			e.target.addEventListener(MouseEvent.MOUSE_OUT,onTextOutEvent);
		}
		private function onTextOutEvent(e : MouseEvent) : void
		{
			e.target.alpha = 1;
			e.target.removeEventListener(MouseEvent.MOUSE_OUT,onTextOutEvent);
		}
		private function get theTxtField() : TextField
		{
			return this['InputTxt'];
		}
		private function get theSelectBtn() : ButtonEx
		{
			return this['SelectBtn'];
		}
	}
}
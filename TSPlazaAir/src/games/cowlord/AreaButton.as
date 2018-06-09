package games.cowlord
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import gameAssets.baccarat.BaccaratSkinClass;
	import gameAssets.chip.YBChipEmbed;
	import gameAssets.cowcowBattle.CCBattleSkinClass;
	
	import games.cowlord.model.CowModle;
	
	import mx.core.UIComponent;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.controller.Controller;
	
	public class AreaButton extends UIComponent
	{
		private var _theModel : CowModle;
		private var _chips : Array;
		private var _rect  : Rectangle;
		
		public function AreaButton(c:Class=null)
		{
			if(c){ targetClass = c; }
			_theModel = CowModle._getInstance();
		}
		
		public function Destroy():Boolean
		{
			_theModel = null;
			return true;
		}
		
		private var _targetClass:Class;
		public function get targetClass():Class
		{
			return _targetClass;
		}
		
		public function set targetClass(value:Class):void
		{
			targetMc = new value() as MovieClip;
		}
		
		private var _targetMc:MovieClip;
		public function get targetMc():MovieClip
		{
			return _targetMc;
		}
		public function set targetMc(mc:MovieClip):void
		{
			_targetMc = mc;
			this.addChild(_targetMc);
			init();
		}
		
		private var _index:int;
		public function get index():int
		{
			return _index;
		}
		
		public function set index(value:int):void
		{
			_index = value;
		}
		private function init():void
		{
			_targetMc.mouseChildren = false;
			_targetMc.tabChildren = false;
			_targetMc.tabEnabled = false;
			_targetMc.gotoAndStop(1);
		}
		
		public function setMouseEnabled(enable:Boolean):void
		{
			if(enable) {
				_targetMc.addEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
			} else {
				_targetMc.removeEventListener(MouseEvent.MOUSE_OVER, OnMouseOver);
				_targetMc.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
				_targetMc.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
				_targetMc.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
			}
			_targetMc.gotoAndStop(1);
			this.buttonMode = enable;
		}
		protected function OnMouseOver(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(2);
			_targetMc.addEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.addEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.addEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		protected function OnMouseOut(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(1); 
			_targetMc.removeEventListener(MouseEvent.MOUSE_OUT,OnMouseOut);
			_targetMc.removeEventListener(MouseEvent.MOUSE_DOWN,OnMouseDown);
			_targetMc.removeEventListener(MouseEvent.MOUSE_UP,OnMouseUp);
		}
		protected function OnMouseUp(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(1); 
		}
		
		protected function OnMouseDown(event : MouseEvent) : void
		{
			_targetMc.gotoAndStop(3);
		}
		public function AddChip(AreaID : int,chipindex : int) : void
		{
			if(index > 7 || index<0) return;
			var model : CowModle = CowModle._getInstance();
//			if(model.m_wBankerID==TConst.INVALID_CHAIR && model.m_bEnableSysBanker==0) 
//			{
//				Controller.dispatchEvent('WAINING_TEXT',1,"当前无人坐庄!");
//				return;
//			}
			//			var rands : Array  = YBChipEmbed.GetChips(TScore.toFloatEx(_theModel.m_wlChipScore[chipindex]));
			//			for(var i : uint=0;i<rands.length;i++)
			//			{
			////				rands[i].mouseEnabled = false;
			////				rands[i].mouseChildren= false;
			//				AddChipHandler(AreaID,rands[i]);
			//			}
			var dos : InteractiveObject  = CCBattleSkinClass.GetChipSource(chipindex) as InteractiveObject;
			AddChipHandler(AreaID,dos);
		}
		public function AddChipHandler(wChardViewID : uint,_dos : DisplayObject) : void
		{
			var dos : DisplayObject = _dos;
			this.addChild(dos);
			if(_rect == null){
				_rect = new Rectangle(40,40,100,100);
			}
			var cx:Number = Math.round(Math.random()*((_rect.x + _rect.width)-_rect.x))+_rect.x;
			var cy:Number = Math.round(Math.random()*((_rect.y + _rect.height)-_rect.y))+_rect.y;
			dos.x = cx - dos.width + 20; 
			dos.y = cy - 20;
			if(_chips == null){
				_chips = new Array();
			}
			_chips.push(dos);
		}
		public function ClearTableChip() : void
		{
			var dos : DisplayObject;
			if(_chips==null)return;
			for(var i : int = _chips.length-1;i>=0;i--){
				dos = _chips[i];
				if(dos){
					if(this.contains(dos)){
						this.removeChild(dos);
					}
					_chips.splice(i,1);
				}
			}
			_chips = null;
		}
		private function playSoundEffect(wChairID : uint,action : String, type : int=-1,value : int=-1,rand : int = -1):void
		{
			if(_theModel == null)	return;
			try
			{
				_theModel.m_Sound.PlayEffect(wChairID, action, type, value, rand);
			}
			catch(e:Error){};
		}
	}
}
package cx.admin
{
	import cx.gamebase.sturuct.CMD_GR_UserStatus;
	import cx.gamebase.sturuct.tagUserInfoHead;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import t.cx.air.TConst;
	import t.cx.air.TScore;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.skin.CheckBoxEx;
	import t.cx.air.utils.IDConvert;
	
	public class AideUserItem extends Sprite
	{
		private var _index : int = -1;
		public function set index(val : int) : void
		{
			_index = val;
			redrawbg(false);
			this.y = val * 32;
		}
		public function get index() : int
		{
			return _index;
		}
		
		
		private var _userInfo : tagUserInfoHead;
		public function get id() : Number
		{
			if(_userInfo == null) return 0;
			return _userInfo.dwUserID;
		}
		public function get score() : Number
		{
			if(_userInfo == null) return 0;
			return _userInfo.UserScoreInfo.lScore;
		}
		public function get table() : uint
		{
			if(_userInfo == null) return TConst.INVALID_TABLE;
			return _userInfo.wTableID;
		}
		public function get chair() : uint
		{
			if(_userInfo == null) return TConst.INVALID_CHAIR;
			return _userInfo.wChairID;
		}
		public function get isAide() : Boolean
		{
			if(_userInfo == null) return false;
			return _userInfo.dwUserRight!=0;
		}
		public function get isAndroid() : Boolean
		{
			if(_userInfo == null) return false;
			return _userInfo.cbGender>2;
		}
		public function AideUserItem()
		{
			super();
			if(stage) {
				onAddStage(null);
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onAddStage);
			}
		}
		private function redrawbg(mouseIn : Boolean) : void
		{
			var color : uint = 0x00000;
			var fontColor : uint = 0xffffff;
			var alp : Number = 0.5;
			if(mouseIn) {
				color = 0xff0000;
			}else {
				color = _index%2==0?0x000000:0x898989;
				fontColor = _index%2==0?0xffffff:0x000000;
				alp = 0.2;
			}
			this.graphics.clear();
			this.graphics.beginFill(color,alp);
			this.graphics.drawRect(0,0,this.width,this.height);
			this.graphics.endFill();
			for(var i : uint = 0;i<4;i++)
			{
				this['txt_'+i].textColor = fontColor;
			}
		}
		public function UpdateUserInfor(userInfo : tagUserInfoHead) : void
		{
			_userInfo = userInfo;
			redrawInfo();
		}
		public function UpdateUserStatus(userStatus : CMD_GR_UserStatus) : void
		{
			_userInfo.cbUserStatus = userStatus.cbUserStatus;
			_userInfo.wChairID = userStatus.wChairID;
			_userInfo.wTableID = userStatus.wTableID;
			redrawInfo();
		}
		private function redrawInfo() : void
		{
			if(_userInfo != null)
			{
				this['txt_0'].text = IDConvert.Id2View(_userInfo.dwUserID);
				this['txt_1'].text = TScore.toStringEx(_userInfo.UserScoreInfo.lScore);
				this['txt_2'].text = '--';
				if( _userInfo.wTableID== TConst.INVALID_TABLE ) {
					this['txt_3'].text = '等待...'
				}else {
					this['txt_3'].text = _userInfo.wTableID + '|' + _userInfo.wChairID;
				}
				if(_userInfo.cbGender > 2 ) {
					theLockCheck.enabled = false;
					theLockCheck.visible = false;
					if( !theKickBtn.hasEventListener(MouseEvent.CLICK) ) {
						theKickBtn.addEventListener(MouseEvent.CLICK,onButtonExEvent);
					}
					this['AideType'].gotoAndStop(2);
				}else if(_userInfo.dwUserRight != 0) {
					theKickBtn.enable = false;
					theKickBtn.visible = false;
					theLockCheck.enabled = false;
					theLockCheck.visible = false;
					this['AideType'].gotoAndStop(3);
				}else {
					
					if( !theLockCheck.hasEventListener('SelectChanged') ) {
						theLockCheck.addEventListener('SelectChanged',onSelectLockEvent);
					}
					if( !theKickBtn.hasEventListener(MouseEvent.CLICK) ) {
						theKickBtn.addEventListener(MouseEvent.CLICK,onButtonExEvent);
					}
					this['AideType'].gotoAndStop(1);
				}
			}else {
				for(var i : uint = 0;i<4;i++)
				{
					this['txt_'+i].text = '';
				}
				this['AideType'].gotoAndStop(1);
			}
			
			
		}
		private function onAddStage(e : Event) : void
		{
			if( e != null ) {
				this.removeEventListener(Event.ADDED_TO_STAGE,onAddStage);
			}
			this.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverEvent);
			this.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutEvent);
		}
		
		private function onMouseOverEvent(e : MouseEvent) : void
		{
			redrawbg(true);
		}
		private function onMouseOutEvent(e : MouseEvent) : void
		{
			redrawbg(false);
		}
		
		private function onButtonExEvent(e : MouseEvent) : void
		{
			if(_userInfo == null) return;
			if(isAide) return;
			this.parent.parent['SendKickUser'](_userInfo.dwUserID);
		}
		private function onSelectLockEvent(e : Event) : void
		{
			if(_userInfo == null) return;
			if(isAide) return;
			this.parent.parent['SendLockUser'](theLockCheck.select,_userInfo.dwUserID);
		}
		private function get theKickBtn() : ButtonEx
		{
			return this['KickBtn'];
		}
		private function get theLockCheck() : CheckBoxEx
		{
			return this['LockCheck'];
		}
		public function Destroy() : Boolean
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutEvent);
			this.removeEventListener(MouseEvent.MOUSE_OVER,onMouseOverEvent);
			for(var i : uint = 0;i<4;i++)
			{
				this['txt_'+i] = null;
			}
			this['AideType'] = null;
			
			theKickBtn.removeEventListener(MouseEvent.CLICK,onButtonExEvent);
			theKickBtn.Destroy();
			this['KickBtn'] = null;
			
			theLockCheck.removeEventListener( 'SelectChanged',onSelectLockEvent);
			theLockCheck.Destroy();
			this['LockCheck'] = null;
			return true;
		}
	}
}
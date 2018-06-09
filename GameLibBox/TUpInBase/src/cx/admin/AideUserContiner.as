package cx.admin
{
	import com.greensock.TweenMax;
	
	import cx.gamebase.events.GameEvent;
	import cx.gamebase.sturuct.CMD_GR_UserStatus;
	import cx.gamebase.sturuct.tagUserInfoHead;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.ApplicationDomain;
	
	import t.cx.air.controller.Controller;
	import t.cx.air.controller.TEvent;
	import t.cx.air.skin.ButtonEx;
	import t.cx.air.utils.Memory;
	
	public class AideUserContiner extends Sprite
	{
		private var _mark : Shape;
		private var _thum : Sprite;
		private var _continer : Sprite;
		
		private var _userPackage : Vector.<AideUserItem>;
		private var _userCount : Array;
		
		private var _showListType : uint = 0x04 | 0x02 | 0x8;
		public function AideUserContiner()
		{
			super();
			if(stage) {
				onInit(null);
			}else {
				this.addEventListener(Event.ADDED_TO_STAGE,onInit);
			}
		}
		
		private function onInit(e : Event) : void
		{
			if(e != null) {
				this.removeEventListener(Event.ADDED_TO_STAGE,onInit);
			}
			_userPackage = new Vector.<AideUserItem>();
			_userCount = Memory._newArrayAndSetValue(3,0);
			//创建 遮罩
			_mark = new Shape();
			_mark.graphics.clear();
			_mark.graphics.beginFill(0x000000,0);
			_mark.graphics.drawRect(0,0,this.width,this.height);
			_mark.graphics.endFill();
			this.addChild(_mark);
			//创建容器
			_continer = new Sprite();
			this.addChild(_continer);
			_continer.mask = _mark;
			Controller.addEventListener(GameEvent.USER_COME,onUserComeEvent);
			Controller.addEventListener('AIDE_USER_STATUS',onUserStatusEvent);
			Controller.addEventListener('AIDE_USER_LEAVE',onUserLeaveEvent);
		}
		
		private var SendLock : CMD_GF_AideLock;
		public function SendLockUser(block : Boolean,userID : Number) : void
		{
			if( SendLock==null ) { SendLock = new CMD_GF_AideLock(); }
			
			var existIndex : int = SendLock.dwLockUserID.indexOf(userID);
			if(existIndex != -1) {
				if(!block) { SendLock.dwLockUserID[existIndex] = 0; }
			}else {
				if(block) {
					var i : uint = 0;
					for(i = 0;i<8;i++)
					{
						if(SendLock.dwLockUserID[i] == 0) { 
							SendLock.dwLockUserID[i] = userID; 
							break;
						}
					}
				}
			}
			SendLock.dwChangeID = userID;
			SendLock.cbLock = block?1:0;
			this.parent['SendLock']( SendLock.ToByteArray() );
		}
		public function SendKickUser(userID : Number) : void
		{
			this.parent['SendKick']( userID );
		}
		
		private function onUserComeEvent(e : TEvent) : void
		{
			switch(e.m_nMsg)
			{
				case 3:
				{
					var userItem : tagUserInfoHead = e.nWParam as tagUserInfoHead;
					var oldUserItem : AideUserItem = existUserID(userItem.dwUserID);
					if( oldUserItem == null)
					{
						var nUItem : AideUserItem = createUserItem();
						_userPackage.push( nUItem );
						//nUItem.index = _userPackage.length - 1;
						nUItem.UpdateUserInfor( userItem );
						_continer.addChild( nUItem );
						RedawUserList( _showListType );
						if(userItem.cbGender > 2) {
							_userCount[1]++;
						}else if(userItem.dwUserRight!=0) {
							_userCount[2]++;
						}else {
							_userCount[0]++;
						}
						this.parent['UpdateCount'](_userCount);
					}else {
						oldUserItem.UpdateUserInfor( userItem );
					}
					break;
				}
			}
		}
		
		private function existUserID(id : Number) : AideUserItem
		{
			var uItem : AideUserItem;
			for each(uItem in _userPackage)
			{
				if(uItem != null && uItem.id == id) { return uItem; }
			}
			return null;
		}
		private function onUserStatusEvent(e : TEvent) : void
		{
			var userStatus : CMD_GR_UserStatus = e.nWParam as CMD_GR_UserStatus;
			var oldUserItem : AideUserItem = existUserID(userStatus.dwUserID);
			if( oldUserItem!= null ) {
				oldUserItem.UpdateUserStatus( userStatus );
			}
			RedawUserList( _showListType );
		}
		private function onUserLeaveEvent(e : TEvent) : void
		{
			var uItem : AideUserItem;
			for(var i : uint = 0;i<_userPackage.length;i++)
			{
				if(_userPackage[i] != null && _userPackage[i].id == e.nWParam) 
				{
					uItem = _userPackage.splice(i,1)[0];
					
					if(uItem.isAndroid) {
						_userCount[1]--;
					}else if(uItem.isAide) {
						_userCount[2]--;
					}else {
						_userCount[0]--;
					}
					if( _continer.contains(  uItem ) )
					{
						_continer.removeChild( uItem );
					}
					uItem.Destroy();
					uItem = null;
					break;
				}
			}
			RedawUserList( _showListType );
		}
		public function RedawUserList(showType : uint) : void
		{
			var index : uint = 0;
			_userPackage.sort(onSortUserList);
			for each(var utime : AideUserItem in _userPackage)
			{
				if( (utime.isAide && (showType&0x02)==0) || (utime.isAndroid && (showType&0x08)==0) || (!utime.isAide && !utime.isAndroid && (showType&0x04)==0)) {
					utime.visible = false;
					continue;
				}else {
					if(utime.index<0) { TweenMax.from(utime,0.3,{x:(index%2==0)?-50:50}); }
					utime.index = index;
					utime.visible = true;
					index++;
				}
			}
			_showListType = showType;
		}
		private function onSortUserList(item0 : AideUserItem,item1 : AideUserItem) : int
		{
			if( item0.isAide && item1.isAide) 
			{
				return item0.score>item1.score?-1:1;
			}else if(item0.isAide) {
				return -1;
			}else if(item1.isAide) {
				return 1;
			}else if(item0.isAndroid && item1.isAndroid) {
				return item0.score>item1.score?-1:1;
			}else if(item0.isAndroid) {
				return 1;
			}else if(item1.isAndroid) {
				return -1;
			}else {
				return item0.score>item1.score?-1:1;
			}
			return 0;
		}
		public function ResetList() : void
		{
			for each(var utime : AideUserItem in _userPackage)
			{
				if(utime != null) {
					if(_continer.contains(utime)) { _continer.removeChild(utime); }
					utime.Destroy();
					utime = null;
				}
			}
			_userPackage.splice(0,_userPackage.length);
			Memory._zeroArray(_userCount,0);
			RedawUserList(_showListType);
		}
		private function createUserItem() : AideUserItem
		{
			var c : Class = ApplicationDomain.currentDomain.getDefinition('AideUserItemClass') as Class;
			return new c();
		}
		private function onMouseWheel(e : MouseEvent) : void
		{
			if( (_continer.y + e.delta * 3) >=0 ) {
				_continer.y = 0;
			}else {
				_continer.y += e.delta * 3;
			}
		}
	}
}
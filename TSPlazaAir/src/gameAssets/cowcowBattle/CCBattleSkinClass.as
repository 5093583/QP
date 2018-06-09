package gameAssets.cowcowBattle
{
	import com.minimalcomps.components.Calendar;
	
	import flash.display.DisplayObject;

	public class CCBattleSkinClass
	{
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="cowcowBattle_bg")]
		public static var ccb_bg:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="cowcowBattle_bg1")]
		public static var ccb_bg1:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="cowcowBattle_bg2")]
		public static var ccb_bg2:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="cowcowBattle_bg3")]
		public static var ccb_bg3:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="cowcowBattle_bg4")]
		public static var ccb_bg4:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="cowcowBattle_bgnn")]
		public static var ccb_bgnn:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="showmsg_bg1")]
		public static var showmsg_bg1:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="showmsg_sure")]
		public static var showmsg_sure:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="view_chipTotal")]
		public static var view_chipTotal:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="view_top")]
		public static var view_top:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="view_bottom")]
		public static var view_bottom:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="tryplay")]
		public static var tryplay:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="head_bg")]
		public static var head_bg:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="head_male")]
		public static var head_male:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="head_female")]
		public static var head_female:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="head_normal")]
		public static var head_normal:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_bg")]
		public static var chip_bg:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_left")]
		public static var btn_left:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_right")]
		public static var btn_right:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="DownChipArea")]
		public static var DownChipArea:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="Dice")]
		public static var Dice:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip1")]
		public static var btn_chip1:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip2")]
		public static var btn_chip2:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip5")]
		public static var btn_chip5:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip10")]
		public static var btn_chip10:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip30")]
		public static var btn_chip30:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip50")]
		public static var btn_chip50:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip100")]
		public static var btn_chip100:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip1000")]
		public static var btn_chip1000:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_chip10000")]
		public static var btn_chip10000:Class;
		
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="clock")]
		public static var clock:Class;
//		[Embed(source="gameAssets/clock.swf", symbol="clock")]
//		public static var clock:Class;
		
		public static function GetClock() : DisplayObject
		{
			return new clock();
		}
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="endView")]
		public static var endView:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="record_bg")]
		public static var record_bg:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_scroll")]
		public static var btn_scroll:Class;
		
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="record_yes")]
		public static var record_yes1:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="record_yes1")]
		public static var record_yes:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="record_no")]
		public static var record_no:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="Hand")]
		public static var Hand:Class;
		
		public static function getUserSelect(selected:int):Class
		{
			if(selected == 2)
				return record_no;
			if(selected == 1)
				return record_yes1;
			return record_yes;
		}
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="land_apply")]
		public static var land_apply:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="btn_ludan")]
		public static var btn_ludan:Class;
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="land_cancel")]
		public static var land_cancel:Class;
		
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_00")]
		public static var show_0:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_01")]
		public static var show_1:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_02")]
		public static var show_2:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_03")]
		public static var show_3:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_04")]
		public static var show_4:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_05")]
		public static var show_5:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_06")]
		public static var show_6:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_07")]
		public static var show_7:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_08")]
		public static var show_8:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_09")]
		public static var show_9:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="show_10")]
		public static var show_10:Class;
		
		[Bindable]
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_noSelect")]
		public static var chip_noSelect:Class;
		
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_1")]
		public static var chip_1:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_2")]
		public static var chip_2:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_5")]
		public static var chip_5:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_10")]
		public static var chip_10:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_30")]
		public static var chip_30:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_50")]
		public static var chip_50:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_100")]
		public static var chip_100:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_1000")]
		public static var chip_1000:Class;
		[Embed(source="gameAssets/cowcowBattle/CowCowBattle.swf", symbol="chip_10000")]
		public static var chip_10000:Class;
		
		
		public static var shipSource:CCBattleSkinClass;
		private var typeAry:Array;
		public static function GetChipSource(index:int) : DisplayObject
		{
			if(shipSource == null)	shipSource = new CCBattleSkinClass;
			return shipSource.getChip(index);
		}
		
		public static function getChipClass(index:int) : Class
		{
			if(shipSource == null)	shipSource = new CCBattleSkinClass;
			return shipSource.getChipCursor(index);
		}
		public static function GetCowTypeTxt(index:int) : DisplayObject
		{
			if(shipSource == null)	shipSource = new CCBattleSkinClass;
			return shipSource.getCowCowType(index);
		}
		private function getChipCursor(index:int):Class
		{
			if(typeAry == null)
				typeAry = [	
//					chip_1, chip_2, chip_5, chip_10, chip_50, chip_100, chip_1000
					chip_1, chip_5, chip_10, chip_50, chip_100, chip_1000, chip_10000
				];
			return typeAry[index];
		}
		
		private function getChip(index:int):DisplayObject
		{
			if(typeAry == null)
				typeAry = [	
//					chip_1, chip_2, chip_5, chip_10, chip_50, chip_100, chip_1000
					chip_1, chip_5, chip_10, chip_50, chip_100, chip_1000, chip_10000
				];
			return new typeAry[index];
		}
		private var cowTypeArrs : Array;
		private function getCowCowType(index : int) : DisplayObject
		{
			if(cowTypeArrs == null)
				cowTypeArrs = [	
					show_0, show_1, show_2, show_3, show_4, show_5, show_6, show_7, show_8, show_9, show_10
				];
			return new cowTypeArrs[index];
		}
	}
}
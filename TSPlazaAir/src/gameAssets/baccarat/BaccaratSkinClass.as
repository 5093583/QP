package gameAssets.baccarat
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;

	public class BaccaratSkinClass
	{
		public function BaccaratSkinClass()
		{
		}
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_up")]
		public static var btn_up:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_down")]
		public static var btn_down:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="bjl_bg")]
		public static var bjl_bg:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="bjl_bg1")]
		public static var bjl_bg1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="bjl_bg2")]
		public static var bjl_bg2:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="bjl_bg3")]
		public static var bjl_bg3:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="bjl_bg4")]
		public static var bjl_bg4:Class;
//		[Bindable]
//		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="view_top")]
//		public static var view_top:Class;
//		[Bindable]
//		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="view_bottom")]
//		public static var view_bottom:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_0")]
		public static var win_0:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_1")]
		public static var win_1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_2")]
		public static var win_2:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="tryplay")]
		public static var tryplay:Class;
//		[Bindable]
//		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_bg")]
//		public static var chip_bg:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="showmsg_bg1")]
		public static var showmsg_bg1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="showmsg_sure")]
		public static var showmsg_sure:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="head_system")]
		public static var head_system:Class;
		
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="head_bg")]
		public static var head_bg:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="head_male")]
		public static var head_male:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="head_female")]
		public static var head_female:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="head_normal")]
		public static var head_normal:Class;
		
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_getRecord")]
		public static var btn_getRecord:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_closeRecord")]
		public static var btn_closeRecord:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="view_record")]
		public static var view_record:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="land_apply")]
		public static var land_apply:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="land_cancel")]
		public static var land_cancel:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="skinHistory")]
		public static var skinHistory:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_left0")]
		public static var btn_left0:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_left1")]
		public static var btn_left1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_left2")]
		public static var btn_left2:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_center1")]
		public static var btn_center1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_center2")]
		public static var btn_center2:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_right0")]
		public static var btn_right0:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_right1")]
		public static var btn_right1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_right2")]
		public static var btn_right2:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_scroll")]
		public static var btn_scroll:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_sure")]
		public static var btn_sure:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="hisbtn_1")]
		public static var hisbtn_1:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="hisbtn_0")]
		public static var hisbtn_0:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="history_doubleline")]
		public static var history_doubleline:Class;
		
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_ConfirmBtn")]
		public static var btn_ConfirmBtn:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_CancelBtn")]
		public static var btn_CancelBtn:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip1")]
		public static var btn_chip1:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip2")]
		public static var btn_chip2:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip5")]
		public static var btn_chip5:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip10")]
		public static var btn_chip10:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip50")]
		public static var btn_chip50:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip100")]
		public static var btn_chip100:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip1000")]
		public static var btn_chip1000:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="btn_chip10000")]
		public static var btn_chip10000:Class;
		
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_noSelect")]
		public static var chip_noSelect:Class;
		
		
		
		
		
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="HistoryLabelMovie")]
		public static var HistoryLabelMovie:Class;
		
		
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="HistoryPointMovie")]
		public static var HistoryPointMovie:Class;
		
		
		
//		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="record_bg")]
//		public static var record_bg:Class;
		
		
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="record_yes1")]
		public static var record_yes1:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="record_yes")]
		public static var record_yes:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="record_no")]
		public static var record_no:Class;
		
		public static function getUserSelect(selected:int):Class
		{
			if(selected == 2)
				return record_no;
			if(selected == 1)
				return record_yes1;
			
			return record_yes;
		}
		
		
		
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="clock")]
		public static var clock:Class;
		
//		[Embed(source="gameAssets/clock.swf", symbol="clock")]
//		public static var clock:Class;
		
		public static function GetClock() : DisplayObject
		{
			return new clock();
		}
		
		
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_1")]
		public static var chip_1:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_2")]
		public static var chip_2:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_5")]
		public static var chip_5:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_10")]
		public static var chip_10:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_50")]
		public static var chip_50:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_100")]
		public static var chip_100:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_1000")]
		public static var chip_1000:Class;
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="chip_10000")]
		public static var chip_10000:Class;
		
		
		public static var shipSource:BaccaratSkinClass;
		private var typeAry:Array;
		public static function GetChipSource(index:int) : DisplayObject
		{
			if(shipSource == null)	shipSource = new BaccaratSkinClass;
			return shipSource.getChip(index);
		}
		
		public static function getChipClass(index:int) : Class
		{
			if(shipSource == null)	shipSource = new BaccaratSkinClass;
			return shipSource.getChipCursor(index);
		}
		private function getChipCursor(index:int):Class
		{
			if(typeAry == null)
				typeAry = [	
					chip_1, chip_5, chip_10, chip_50, chip_100, chip_1000, chip_10000
				];
			return typeAry[index];
		}

		private function getChip(index:int):DisplayObject
		{
			if(typeAry == null)
				typeAry = [	
					chip_1, chip_5, chip_10, chip_50, chip_100, chip_1000, chip_10000
				];
			return new typeAry[index];
		}
		
		private static var _arrs : Array;
		private static var _keys : Array;
		
		private static var _bitmapArrs:Array;
		
		private static function onInit() : void
		{
			_arrs = [chip_1, chip_5, chip_10, chip_50, chip_100, chip_1000, chip_10000];
			
			createBitmapDataArrs();
		}
		private static function createBitmapDataArrs():void
		{
			_bitmapArrs = new Array(_arrs.length);
			
			var ds:DisplayObject;
			var bit:BitmapData;
			for(var i:int=0, len:int=_arrs.length; i<len; i++)
			{
				ds = new _arrs[i] as DisplayObject;
				bit = new BitmapData(ds.width, ds.height, true, 0);
				bit.draw(ds, new Matrix(), new ColorTransform(), null, new Rectangle(0, 0, ds.width, ds.height) );
				
				_bitmapArrs[i] = bit;
			}
		}
		public static function GetClipIdea(index : Number) : DisplayObject
		{
			if(_arrs == null)	onInit();
			return new Bitmap( _bitmapArrs[index] );
			//			return new _arrs[index];
		}
		
		
		
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="view_ChipStorge")]
		public static var view_ChipStorge:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="view_chipTotal")]
		public static var view_chipTotal:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="txt_totalscore")]
		public static var txt_totalscore:Class;
		
		
		//------------------------------GameEnd 相关素材------------------------------
		//发牌背景
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="end_vs")]
		public static var end_vs:Class;
		
		//结算框背景
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="end_bg")]
		public static var end_bg:Class;
		
//		[Bindable]
//		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="ping")]
//		public static var ping:Class;
		
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_ping")]
		public static var win_ping:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_pingall")]
		public static var win_pingall:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_xianD")]
		public static var win_xianD:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_zhuang")]
		public static var win_zhuang:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_zhuangT")]
		public static var win_zhuangT:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_xian")]
		public static var win_xian:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_xianT")]
		public static var win_xianT:Class;
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="win_zhuangD")]
		public static var win_zhuangD:Class;
		
		
		//庄赢动画
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="xWin")]
		public static var xWin:Class;
		
		//闲赢动画
		[Bindable]
		[Embed(source="gameAssets/baccarat/assetsBaccarat.swf", symbol="zWin")]
		public static var zWin:Class;
		
		public static function GetWin(xz : uint) : MovieClip
		{
			switch(xz)
			{
				case 0:{return new xWin();};
				case 1:{return new zWin();};
			}
			return null;
		}

	}
}
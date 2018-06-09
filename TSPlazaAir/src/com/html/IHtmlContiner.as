package com.html
{
	import flash.display.Sprite;
	
	public interface IHtmlContiner
	{
		function GetDisplay() : Sprite;
		function SetHost(val : String,bPaint : Boolean=false,completeCallBack:Function=null,showLoad : Boolean = false) : void;
		function LoadString(val : String) : void;
		function SetWH(w : Number,h : Number) : void;
		
		function CancelLoad() : void;
		function RelLoad() : void;
		function set CallBack(val : Function) : void;
		function set JsGetValue(val : Function) : void;
		function get timeCode() : String;
		function SendToWeb(type : int,val : String) : void;
		function checkCode(val : String) : Boolean;
	}
}
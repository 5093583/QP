package base
{
	public interface IModuleGame
	{
		function updateGameNum():void;
		
		function logonSuccess():void;		
		function onDestroyAllDos():void;
		
		function changeBackground(val:int):void;
	}
}
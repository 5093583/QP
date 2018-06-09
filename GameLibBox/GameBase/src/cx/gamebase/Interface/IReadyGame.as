package cx.gamebase.Interface
{
	import t.cx.air.controller.TEvent;

	public interface IReadyGame
	{
		function ReadyGameEvent(e : TEvent) : Boolean;
	}
}
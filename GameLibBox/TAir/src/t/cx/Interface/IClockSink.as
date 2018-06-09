package t.cx.Interface
{
	public interface IClockSink
	{
		function ClockCountDown(current : int,total : int) : void;
		function Start(timeLine : Number,cbVoice : Boolean = false) : void;
		function Stop() : void;
		function Destroy() : void;
	}
}
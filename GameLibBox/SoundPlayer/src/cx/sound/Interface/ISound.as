package cx.sound.Interface
{
	public interface ISound
	{
		/**
		 * 播放音频
		 * */
		function play(label : String,bRepeat : Boolean = false,completeFun : Function = null) : Boolean;
		/**
		 * 停止音频
		 * */
		function stop(label : String = 'p_all') : Boolean;
		/**
		 * 设置声音
		 * */
		function SetValume(value : Number,type : uint = 0) : Boolean;
		/**
		 * 
		 * */
		function getValume(type : uint) : Number;
		/**
		 * 是否静音
		 * */
		function get mute() : Boolean;
		/**
		 * 设置静音
		 * */
		function set mute(value : Boolean) : void;
	
		/**
		 * 查找是否含有特地音频
		 * */
		function exists(label : String) : Boolean;
		/**
		 * 获取音频文件列表
		 * */
		function get SoundMaps() : Array;
		
		/**
		 * 压音乐入栈
		 *	暂时不允许外部函数管理
		 *	function put(label : String,sound : SoundBase) : Boolean;
		 *  */
		function Destroy() : void;
	}
}
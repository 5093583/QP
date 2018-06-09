package t.cx.Interface
{
	import flash.utils.ByteArray;

	public interface IKernelFile
	{
		/**-------------------------------------------------
		 * 文件解密接口
		 * 
		 * -------------------------------------------------*/
		function CxFileCrevasse(pData : ByteArray,wDataSize : uint) : uint;
		function CxGetKeyValue(key : String) : *;
		function CxSetKeyValue(key : String,value : *) : Boolean;
	}
}
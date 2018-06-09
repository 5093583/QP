package t.cx.Interface
{
	/**-------------------------------------------------
	 * 程序接口
	 * -------------------------------------------------*/
	public interface IKernelWin
	{
		/**
		 * 设置主窗口宽高
		 * @param
		 * w		:	宽</p>
		 * h		:	高</p>
		 * <p>pos	:	'center'/'left'/'right'/'auto'</p> 
		 * */
		function CxSetWH(w : Number,h : Number,pos : String = 'center') : Boolean;
		/**
		 * 最大/小化 回复窗口
		 * */
		function CxMaxWnd(pCxClient : ICxKernelClient) : Boolean;
		function CxMinWnd(pCxClient : ICxKernelClient) : Boolean;
		function CxResTore(pCxClient : ICxKernelClient) : Boolean;
		function CxCenterWindow( pCxClient : ICxKernelClient ) : Boolean;
		/**
		 * 通知提醒用户
		 * @param
		 * type : critical/informational
		 * */
		function CxNotifyUser(type : String='critical') : Boolean;
		/**
		 * 关闭
		 * @param bExitCode 0 退出程序 1 退出当前窗口
		 * */
		function CxExit(pCxClient : ICxKernelClient,bExitCode : uint = 0) : Boolean;
		
		function CxShowWindow(pClient : ICxKernelClient) : Boolean;
		
		function CxGetHtmlContiner() : IHtmlContiner;
		function CxCreateHtmlContiner() : IHtmlContiner;
		
		function CxStartMove() : void;
		function CxGetIpInfo(ip : String) : String;
		
		/**
		 * 创建一个Browser窗口
		 * */
		function CxCreateBrowser(url : String,title : String = '') : void;
		function CxCloseBrowser() : void;
	}
}
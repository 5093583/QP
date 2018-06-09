#include <stdlib.h>
#include "CXTcpEncrypt.h"
#include "AS3/AS3.h"

//映射发送数据
BYTE MapSendByte(BYTE const cbData)
{
	return g_SendByteMap[cbData];
}
//映射接收数据
BYTE MapRecvByte(BYTE const cbData)
{
	return g_RecvByteMap[cbData];
}
//-----------------------------------------------------------------------------
void TcpConnect() __attribute__((used,
								annotate("as3sig:public function TcpConnect(cbVersion:int):int"),
								annotate("as3package:cx.kernel.Tcp")));
//链接
void TcpConnect()
{
	int Result = 0;
	AS3_GetScalarFromVar(Result,cbVersion);
	Result = SOCKET_VER == Result?1:0;
	AS3_Return(Result);
}
//加密
void TcpEncrypt() __attribute__((used,
								annotate("as3sig:public function TcpEncrypt(wMainCMD : uint,wSubCMD : uint,buffer : int,wDataSize : uint):uint"),
								annotate("as3package:cx.kernel.Tcp")));
void TcpEncrypt()
{
	WORD mainCMD = 0;
	WORD subCMD	 = 0;
	BYTE *pBuffer = (BYTE *)0;
	WORD dataSize = 0;
	AS3_GetScalarFromVar(mainCMD,wMainCMD);
	AS3_GetScalarFromVar(subCMD,wSubCMD);
	AS3_GetScalarFromVar(pBuffer,buffer);
	AS3_GetScalarFromVar(dataSize,wDataSize);
	if(dataSize > SOCKET_BUFFER)
	{
		AS3_Return(1);					//数据包发送过大
	}
	if(dataSize < 8)
	{
		AS3_Return(2);					//数据包小于数据包头
	}
	CMD_Head * Head = (CMD_Head *)pBuffer;
	Head->CommandInfo.wMainCmdID = mainCMD;
	Head->CommandInfo.wSubCmdID = subCMD;
	
	BYTE cbCheckCode = 0;
	for (int i = DWORD_SIZE;i<dataSize;i++)
	{
		cbCheckCode -= pBuffer[i];
		pBuffer[i] = MapSendByte(pBuffer[i]);
	}
	Head->CmdInfo.wPacketSize = dataSize;
	Head->CmdInfo.cbCheckCode = cbCheckCode;
	Head->CmdInfo.cbVersion = SOCKET_VER;
	AS3_Return(0);
}
//加密
void TcpCrevasse() __attribute__((used,
								annotate("as3sig:public function TcpCrevasse(buffer : int,wDataSize : uint):uint"),
								annotate("as3package:cx.kernel.Tcp")));
void TcpCrevasse()
{
	BYTE *pBuffer = (BYTE *)0;
	WORD dataSize = 0;

	AS3_GetScalarFromVar(pBuffer,buffer);
	AS3_GetScalarFromVar(dataSize,wDataSize);
	
	CMD_Head * Head = (CMD_Head *)pBuffer;
	if (Head->CmdInfo.wPacketSize != dataSize)
	{
		AS3_Return(1);				//数据包大小错误
	}

	if(Head->CmdInfo.cbVersion != SOCKET_VER)
	{
		AS3_Return(2);	//接收数据包版本错误	返回2
	}
	BYTE cbCheckCode = Head->CmdInfo.cbCheckCode;
	for(int i = DWORD_SIZE;i<dataSize;i++)
	{
		pBuffer[i] = MapRecvByte(pBuffer[i]);
		cbCheckCode +=pBuffer[i];
	}	
	if (cbCheckCode != 0)
	{
		AS3_Return(3);	//接收数据包解密错误	返回3
	}
	AS3_Return(0);
}
//断开链接
void TcpClose() __attribute__((used,
								annotate("as3sig:public function TcpClose():uint"),
								annotate("as3package:cx.kernel.Tcp")));
void TcpClose()
{
	AS3_Return(0);
}
#include <stdlib.h>
#include "CXFileEncrypt.h"
#include "AS3/AS3.h"
#include "AS3/AS3++.h"
//º”√‹
void FileEncrypt() __attribute__((used,
								 annotate("as3sig:public function FileEncrypt(type : String,name:String,ver:int,fileVer:int,option:int,buffer : int,wDataSize : Number,width:Number,height:Number):Number"),
								annotate("as3package:cx.kernel.File")));
void FileEncrypt()
{
	int cbVersion = 0;
	AS3_GetScalarFromVar(cbVersion,ver);
	if (FILE_VER != cbVersion) { AS3_Return(0); }

	int cbFileVer = 0;
	AS3_GetScalarFromVar(cbFileVer,fileVer);
	int cbOptin = 0;
	AS3_GetScalarFromVar(cbOptin,option);

	AS3::local::var pType;
	AS3_GetVarxxFromVar(pType,type);
	char *szType = AS3::local::internal::utf8_toString(pType);

	AS3::local::var pName;
	AS3_GetVarxxFromVar(pName,name);
	char *szName = AS3::local::internal::utf8_toString(pName);

	BYTE *pBuffer = (BYTE *)0;
	AS3_GetScalarFromVar(pBuffer,buffer);

	double dataSize = 0;
	AS3_GetScalarFromVar(dataSize,wDataSize);
	
	double pWidth=0;
	AS3_GetScalarFromVar(pWidth,width);

	double pHeight=0;
	AS3_GetScalarFromVar(pHeight,height);
	memcpy(pBuffer,szType,16);
	memcpy(pBuffer+16,szName,16);
	memcpy(pBuffer+32,&cbVersion,4);
	memcpy(pBuffer+36,&cbFileVer,4);
	memcpy(pBuffer+40,&cbOptin,4);
	memcpy(pBuffer+44,&dataSize,8);
	memcpy(pBuffer+52,&pWidth,8);
	memcpy(pBuffer+60,&pHeight,8);
	for(int i = 0;i<dataSize;i++) {
		pBuffer[68 + i] = g_WriteByteMap[ pBuffer[68 + i] ];
	}
	free(szType);
	free(szName);
	free(pBuffer);
	AS3_Return(dataSize + 68);
}
//Ω‚√‹
void FileCrevasse() __attribute__((used,
								  annotate("as3sig:public function FileCrevasse(ver:int,buffer : int,wDataSize : Number):Number"),
								 annotate("as3package:cx.kernel.File")));
void FileCrevasse()
{
	int cbVersion = 0;
	AS3_GetScalarFromVar(cbVersion,ver);
	if (FILE_VER != cbVersion) {AS3_Return(0); }
	double dataSize = 0;
	AS3_GetScalarFromVar(dataSize,wDataSize);
	if (dataSize<=68) { AS3_Return(2); }

	BYTE *pBuffer = (BYTE *)0;
	AS3_GetScalarFromVar(pBuffer,buffer);
	for (int i = 0;i<(dataSize-68);i++)
	{
		pBuffer[68 + i] = g_ReadByteMap[ pBuffer[68 + i] ];
	}
	free(pBuffer);
	AS3_Return(dataSize-68);
}
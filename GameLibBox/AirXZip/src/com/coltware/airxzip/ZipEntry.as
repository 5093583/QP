/**
 *  Copyright (c)  2009 coltware@gmail.com
 *  http://www.coltware.com 
 *
 *  License: LGPL v3 ( http://www.gnu.org/licenses/lgpl-3.0-standalone.html )
 *
 * @author coltware@gmail.com
 */
package com.coltware.airxzip {
        
        import flash.events.*;
        import flash.utils.*;
        
        use namespace zip_internal;
        /**
        *  Zip�ե��������
        */
        public class ZipEntry extends EventDispatcher{
                
                public static var METHOD_NONE:int    = 0;
                public static var METHOD_DEFLATE:int = 8;
                
                zip_internal var _header:ZipHeader;
                zip_internal var _headerLocal:ZipHeader;
                private var _content:ByteArray;
                
                private var _stream:IDataInput;
                
                public function ZipEntry(stream:IDataInput) {
                        _stream = stream;
                }
                
                /**
                *  @private
                */
                public function setHeader(h:ZipHeader):void{
                        _header = h;
                }
                
                public function getHeader():ZipHeader{
                        return _header;
                }
                
                /**
                *  �R�s��ʽ�򷵤�
                *
                */
                public function getCompressMethod():int{
                        return _header.getCompressMethod();
                }
                
                public function isCompressed():Boolean{
                        var method:int = _header.getCompressMethod();
                        if(method == 0){
                                return false;
                        }
                        else{
                                return true;
                        }
                }
                
                /**
                *  �ե���������ȡ�ä���.
                *
                *  ���֥��`�ɤ�ָ�����ʤ����Ϥˤϡ��ԄӵĤ��жϤ��롣
                *  �������������ޤ�Zip�ե�������ձ��ĤʑT���ˤΤäȤ��Ԅ��Єe���ޤ���
                *  �ʤΤǡ�utf-8 �⤷���� shift_jis �Τɤ��餫���ԄӵĤˤ��жϤ���ޤ���
                *
                */
                public function getFilename(charset:String = null):String{
                        return _header.getFilename(charset);
                }
                
                /**
                *  
                *  �ǥ��쥯�ȥ꤫?
                */
                public function isDirectory():Boolean{
                        return _header.isDirectory();
                }
                /**
                *  �R�s�ʤ򷵤�.
                *
                */
                public function getCompressRate():Number{
                        return _header.getCompressRate();
                }
                
                public function getUncompressSize():int{
                        return _header.getUncompressSize();
                }
                
                public function getCompressSize():int{
                        return _header.getCompressSize();
                }
                
                /**
                *  �ո����򷵤�
                *
                */
                public function getDate():Date{
                        return _header.getDate();
                }
                
                /**
                 *  �R�s�Щ`������ȡ�ä���.
                 * 
                 * unzip���ޥ�ɤǤ�"minimum software version required to extract:"��ӛ������Ƥ��롣
                 * 
                 */
                public function getVersion():int{
                        return _header._version;
                }  
                
                /**
                 *  �R�s�ۥ��ȤΥЩ`������ȡ�ä���
                 * 
                 * unzip���ޥ�ɤǤ�"version of encoding software:"��ӛ������Ƥ���
                 * 
                 */
                public function getHostVersion():int{
                        return _header.getVersion();
                }
                /**
                 *  CRC32 �΂���ȡ�ä���
                 */
                public function getCrc32():String{
                        return _header._crc32.toString(16);
                }
                
                public function isEncrypted():Boolean{
                        if(_header._bitFlag & 1){
                                return true;
                        }
                        else{
                                return false;
                        }
                }
                
                /**
                *
                *  LOCAL HEADER�Υ��ե��å�λ�ä�ȡ�ä���
                *
                * @private
                */
                public function getLocalHeaderOffset():int{
                        return _header.getLocalHeaderOffset();
                }
                
                
                
                /**
                 * @private
                 */
                public function getLocalHeaderSize():int{
                        return _header.getLocalHeaderSize();
                }
                
                
                
                zip_internal function dumpLogInfo():void{
                        _header.dumpLogInfo();
                }

        }

}
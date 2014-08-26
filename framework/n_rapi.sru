HA$PBExportHeader$n_rapi.sru
$PBExportComments$(LEC) Funciones para manejar el dispositivo m$$HEX1$$f300$$ENDHEX$$vil
forward
global type n_rapi from nonvisualobject
end type
type osversioninfo from structure within n_rapi
end type
type memorystatus from structure within n_rapi
end type
type store_information from structure within n_rapi
end type
type system_power_status_ex from structure within n_rapi
end type
type security_attributes from structure within n_rapi
end type
type filetime from structure within n_rapi
end type
type systemtime from structure within n_rapi
end type
type win32_find_data from structure within n_rapi
end type
type rapiinit from structure within n_rapi
end type
end forward

type osversioninfo from structure
	long		dwosversioninfosize
	long		dwmajorversion
	long		dwminorversion
	long		dwbuildnumber
	long		dwplatformid
	string		szcsdversion
end type

type memorystatus from structure
	long		dwlength
	long		dwmemoryload
	long		dwtotalphys
	long		dwavailphys
	long		dwtotalpagefile
	long		dwavailpagefile
	long		dwtotalvirtual
	long		dwavailvirtual
end type

type store_information from structure
	long		dwstoresize
	long		dwfreesize
end type

type system_power_status_ex from structure
	character		aclinestatus
	character		batteryflag
	character		batterylifepercent
	character		reserved1
	long		batterylifetime
	long		batteryfulllifetime
	character		reserved2
	character		backupbatteryflag
	character		backupbatterylifepercent
	character		reserved3
	long		backupbatterylifetime
	long		backupbatteryfulllifetime
end type

type security_attributes from structure
	long		nlength
	long		lpsecuritydescriptor
	boolean		binherithandle
end type

type filetime from structure
	unsignedlong		dwlowdatetime
	unsignedlong		dwhighdatetime
end type

type systemtime from structure
	unsignedinteger		wyear
	unsignedinteger		wmonth
	unsignedinteger		wdayofweek
	unsignedinteger		wday
	unsignedinteger		whour
	unsignedinteger		wminute
	unsignedinteger		wsecond
	unsignedinteger		wmilliseconds
end type

type win32_find_data from structure
	unsignedlong		dwfileattributes
	filetime		ftcreationtime
	filetime		ftlastaccesstime
	filetime		ftlastwritetime
	unsignedlong		nfilesizehigh
	unsignedlong		nfilesizelow
	unsignedlong		dwoid
	character		cfilename[255]
end type

type rapiinit from structure
	long		cbsize
	long		herapiinit
	long		hrrapiinit
end type

global type n_rapi from nonvisualobject autoinstantiate
end type

type prototypes
Function boolean FileTimeToSystemTime ( &
	Ref filetime lpFileTime, &
	Ref systemtime lpSystemTime &
	) Library "kernel32.dll"

Function boolean FileTimeToLocalFileTime ( &
	Ref filetime lpFileTime, &
	Ref filetime lpLocalFileTime &
	) Library "kernel32.dll"

Function uLong FormatMessage ( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias for "FormatMessageW"

Function long WaitForSingleObject ( &
	long hHandle, &
	long dwMilliseconds &
	) Library "kernel32.dll"

Function uLong CeGetLastError ( &
	) Library "rapi.dll"

Function Long CeRapiInit ( &
	) Library "rapi.dll"

Function Long CeRapiInitEx ( &
	Ref RAPIINIT pRapiInit &
	) Library "rapi.dll"

Function Long CeRapiUninit ( &
	) Library "rapi.dll"

Function Boolean CeGetVersionEx ( &
	Ref osversioninfo lpVersionInformation &
	) Library "rapi.dll"

Subroutine CeGlobalMemoryStatus ( &
	Ref memorystatus lpmst &
	) Library "rapi.dll"

Function Boolean CeGetStoreInformation ( &
	Ref store_information lpsi &
	) Library "rapi.dll"

Function Boolean CeGetSystemPowerStatusEx ( &
	Ref system_power_status_ex pstatus, &
	boolean fUpdate &
	) Library "rapi.dll"

Function uLong CeCreateFile ( &
    string lpFileName, &
    uLong dwDesiredAccess, &
    uLong dwShareMode, &
    Ref SECURITY_ATTRIBUTES lpSecurityAttributes, &
    uLong dwCreationDistribution, &
    uLong dwFlagsAndAttributes, &
    uLong hTemplateFile &
	 ) Library "rapi.dll"

Function Boolean CeCloseHandle ( &
	uLong hObject &
	) Library "rapi.dll"

Function Boolean CeCreateDirectory ( &
    string lpPathName, &
    Ref SECURITY_ATTRIBUTES lpSecurityAttributes &
	 ) Library "rapi.dll"

Function Boolean CeRemoveDirectory ( &
    string lpPathName &
	 ) Library "rapi.dll"

Function Boolean CeReadFile ( &
    uLong hFile, &
    Ref Blob lpBuffer, &
    uLong nNumberOfBytesToRead, &
    Ref uLong lpNumberOfBytesRead, &
    Long lpOverlapped &
	 ) Library "rapi.dll"
    
Function Boolean CeWriteFile ( &
    uLong hFile, &
    Ref Blob lpBuffer, &
    uLong nNumberOfBytesToWrite, &
    Ref uLong lpNumberOfBytesWritten, &
    Long lpOverlapped &
	 ) Library "rapi.dll"

Function Boolean CeDeleteFile ( &
    string lpFileName &
	 ) Library "rapi.dll"

Function uLong CeGetTempPath ( &
    uLong nBufferLength, &
    Ref string lpBuffer &
	 ) Library "rapi.dll"

Function Long CeRegOpenKeyEx ( &
    uLong hKey, &
    Ref string lpSubKey, &
    Long ulOptions, &
    Long samDesired, &
    Ref uLong phkResult &
	 ) Library "rapi.dll"
	 
Function Long CeRegCloseKey ( &
    uLong hKey &
	 ) Library "rapi.dll"

Function Long CeRegCreateKeyEx ( &
    uLong hKey, &
    Ref string lpszSubKey, &
    Long Reserved, &
    String lpszClass, &
    Long dwOptions, &
    Long samDesired, &
    Long lpSecurityAttributes, &
    Ref uLong phkResult, &
    Ref uLong lpdwDisposition &
	 ) Library "rapi.dll"

Function Long CeRegQueryValueEx ( &
    uLong hKey, &
    string lpValueName, &
    Long lpReserved, &
    Ref Long lpType, &
    Ref Blob lpData, &
    Ref Long lpcbData &
	 ) Library "rapi.dll"

Function Long CeRegSetValueEx ( &
    uLong hKey, &
    string lpValueName, &
    Long Reserved, &
    Long dwType, &
    Blob lpData, &
    Long cbData &
	 ) Library "rapi.dll"

Function Long CeRegDeleteValue ( &
    uLong hKey, &
    string lpszValueName &
	 ) Library "rapi.dll"

Function Long CeRegDeleteKey ( &
    uLong hKey, &
    string lpszSubKey &
	 ) Library "rapi.dll"

Function Boolean CeGetFileTime ( &
    uLong hFile, &
    filetime lpCreationTime, &
    filetime lpLastAccessTime, &
    filetime lpLastWriteTime &
	 ) Library "rapi.dll"

Function uLong CeGetFileSize ( &
    uLong hFile, &
    Ref uLong lpFileSizeHigh &
	 ) Library "rapi.dll"

Function uLong CeFindFirstFile ( &
    string lpFileName, &
    Ref win32_find_data lpFindFileData &
	 ) Library "rapi.dll"

Function Boolean CeFindNextFile ( &
    uLong hFindFile, &
    Ref win32_find_data lpFindFileData &
	 ) Library "rapi.dll"

Function uLong CeFindClose ( &
    uLong hFindFile &
	 ) Library "rapi.dll"

Function ulong CeGetFileAttributes ( &
	string lpFileName &
	) Library "rapi.dll"

Function Boolean CeSetFileAttributes ( &
	string lpFileName, &
	ulong dwFileAttributes &
	) Library "rapi.dll"

end prototypes

type variables
// file access constants
CONSTANT ulong GENERIC_READ  = 2147483648		// H80000000
CONSTANT ulong GENERIC_WRITE = 1073741824		// H40000000
CONSTANT ulong FILE_SHARE_READ	= 1
CONSTANT ulong FILE_SHARE_WRITE	= 2
CONSTANT long INVALID_HANDLE_VALUE = -1
CONSTANT ulong FILE_ATTRIBUTE_NORMAL = 128	// H80
CONSTANT integer CREATE_NEW = 1
CONSTANT integer CREATE_ALWAYS = 2
CONSTANT integer OPEN_EXISTING = 3
CONSTANT integer OPEN_ALWAYS = 4

// registry keys
CONSTANT ulong HKEY_CLASSES_ROOT  = 2147483648 	// H80000000
CONSTANT ulong HKEY_CURRENT_USER  = 2147483649 	// H80000001
CONSTANT ulong HKEY_LOCAL_MACHINE = 2147483650 	// H80000002

// registry types
CONSTANT long REG_NONE					= 0 // No value type
CONSTANT long REG_SZ						= 1 // RegString!
CONSTANT long REG_EXPAND_SZ			= 2 // RegExpandString!
CONSTANT long REG_BINARY				= 3 // RegBinary!
CONSTANT long REG_DWORD					= 4 // ReguLong!
CONSTANT long REG_DWORD_BIG_ENDIAN	= 5 // ReguLongBigEndian!
CONSTANT long REG_LINK					= 6 // RegLink!
CONSTANT long REG_MULTI_SZ				= 7 // RegMultiString!

// waitforsingleobject
CONSTANT long INFINITE			= -1
CONSTANT long WAIT_ABANDONED	= 128
CONSTANT long WAIT_COMPLETE	= 0
CONSTANT long WAIT_OBJECT_0	= 0
CONSTANT long WAIT_TIMEOUT		= 258

end variables

forward prototypes
public function string of_getversion ()
public function decimal of_getmemorystatus ()
public function decimal of_getstorestatus ()
public subroutine of_getpowerstatus (ref boolean aclinestatus, ref string batterystatus, ref integer batterypct)
public function unsignedlong of_openfile (string as_filename, fileaccess ae_access, writemode ae_createdisp)
public function unsignedlong of_openfile (string as_filename, fileaccess ae_access)
public function boolean of_copyfile_topc (string as_cefilename, string as_pcfilename)
public function boolean of_copyfile_toce (string as_pcfilename, string as_cefilename)
public function boolean of_writefile (unsignedlong al_handle, blob abl_buffer)
public function long of_getlasterror ()
public function string of_formatmessage (unsignedlong aul_error)
public function boolean of_createdirectory (string as_dirname)
public function boolean of_removedirectory (string as_dirname)
public function string of_gettemppath ()
public function unsignedlong of_registryhandle (string as_key)
public function boolean of_deletefile (string as_filename)
public function datetime of_getfiletime (string as_filename)
public function boolean of_checkbit (unsignedlong aul_number, integer ai_bit)
public function longlong of_getfilesize (string as_filename)
public function integer of_get_dirlist (string as_filespec, ref s_dirlist astr_dirlist[])
public function datetime of_convertfiledatetimetopb (filetime astr_filetime)
public function long of_disconnect ()
public function boolean of_closefile (unsignedlong aul_handle)
public function long of_readfile (unsignedlong aul_handle, ref blob abl_buffer)
public function integer of_getfileattributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdir, ref boolean ab_archive)
private function unsignedlong of_calcfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
public function unsignedlong of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive)
public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref long valuevariable)
public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref string valuevariable)
public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, string value)
public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, long value)
public function integer of_registrydelete (string key, string valuename)
public function integer of_registrydeletekey (string key, string deletekey)
public function boolean of_connect ()
public function boolean of_connect (integer ai_timeout)
public function decimal of_getmainfreespace ()
public function ulong of_createdirectory (string as_dirname, ref string as_error)
public function long of_connect (integer ai_timeout, ref string as_error)
public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref string valuevariable, ref string as_error)
end prototypes

public function string of_getversion ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetVersion
//
// PURPOSE:    This function returns OS version information.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

OSVERSIONINFO osvi
String ls_version
    
osvi.dwOSVersionInfoSize = 50

If CeGetVersionEx(osvi) Then
	ls_version =	String(osvi.dwMajorVersion) + "." + &
						String(osvi.dwMinorVersion) + "." + &
						String(osvi.dwBuildNumber)
End If

Return ls_version

end function

public function decimal of_getmemorystatus ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetMemoryStatus
//
// PURPOSE:    This function returns program memory usage percent.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

MEMORYSTATUS mst
Decimal{4} ldec_pct
    
CeGlobalMemoryStatus(mst)

ldec_pct = mst.dwAvailPhys / mst.dwTotalPhys

Return ldec_pct

end function

public function decimal of_getstorestatus ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetStoreStatus
//
// PURPOSE:    This function returns storage memory usage percent.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

STORE_INFORMATION lpsi
Decimal{4} ldec_pct
    
CeGetStoreInformation(lpsi)

ldec_pct = lpsi.dwFreeSize / lpsi.dwStoreSize

Return ldec_pct

end function

public subroutine of_getpowerstatus (ref boolean aclinestatus, ref string batterystatus, ref integer batterypct);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetPowerStatus
//
// PURPOSE:    This function returns system power information.
//
// ARGUMENTS:  aclinestatus  - True if plugged into AC power
//             batterystatus - Description of battery status
//             batterypct    - Percent battery charge
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

SYSTEM_POWER_STATUS_EX pstatus

CeGetSystemPowerStatusEx(pstatus, True)

// is the device plugged into AC power
If Asc(pstatus.ACLineStatus) = 1 Then
	aclinestatus = True
Else
	aclinestatus = False
End If

// determine battery status
choose case Asc(pstatus.BatteryFlag)
	case 1
		batterystatus = "High"
	case 2
		batterystatus = "Low"
	case 4
		batterystatus = "Critical"
	case 8
		batterystatus = "Charging"
	case 128
		batterystatus = "No system battery"
	case 255
		batterystatus = "Unknown status"
end choose

// battery percent charged
batterypct = Asc(pstatus.BatteryLifePercent)
If batterypct > 100 And batterystatus = "" Then
	batterystatus = "Unknown status"
End If

end subroutine

public function unsignedlong of_openfile (string as_filename, fileaccess ae_access, writemode ae_createdisp);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_OpenFile
//
// PURPOSE:    This function opens a file on the device.
//
// ARGUMENTS:  as_filename		- Name of the file to open
//             ae_access		- Read/Write
//             ae_writemode	- Append/Replace on write
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_handle, lul_access, lul_createdisp, lul_sharemode
SECURITY_ATTRIBUTES sa

choose case ae_access
	case Read!
		lul_access		= GENERIC_READ
		lul_createdisp	= OPEN_EXISTING
		lul_sharemode	= FILE_SHARE_READ
	case Write!
		lul_access = GENERIC_WRITE
		choose case ae_createdisp
			case Append!
				lul_createdisp = OPEN_ALWAYS
			case Replace!
				lul_createdisp = CREATE_ALWAYS
		end choose
		lul_sharemode	= FILE_SHARE_WRITE
end choose
 
lul_handle = CeCreateFile(as_filename, lul_access, &
			lul_sharemode, sa, lul_createdisp, FILE_ATTRIBUTE_NORMAL, 0)

Return lul_handle

end function

public function unsignedlong of_openfile (string as_filename, fileaccess ae_access);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_OpenFile
//
// PURPOSE:    This function opens a file on the device.
//
// ARGUMENTS:  as_filename		- Name of the file to open
//             ae_access		- Read/Write
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Return this.of_OpenFile(as_filename, ae_access, Append!)

end function

public function boolean of_copyfile_topc (string as_cefilename, string as_pcfilename);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_CopyFile_ToPC
//
// PURPOSE:    This function copies a file on the device to a
//					file on the PC.
//
// ARGUMENTS:  as_cefilename	- Name of input file on device
//             as_pcfilename	- Name of output file on PC
//
// RETURN:		True = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hFile, lul_error
Integer li_fnum
Long ll_bytes
Blob lbl_data

lul_hFile = this.of_OpenFile(as_cefilename, Read!)
If lul_hFile > 0 Then
	ll_bytes = this.of_ReadFile(lul_hFile, lbl_data)
	If ll_bytes = 0 Then
		this.of_CloseFile(lul_hFile)
		MessageBox(	"Function of_CopyFile_ToPC Error", &
						"The CE file was not found or was locked!")
		Return False
	Else
		li_fnum = FileOpen(as_pcfilename, &
			StreamMode!, Write!, Shared!, Replace!)
		If li_fnum > 0 Then
			do while ll_bytes > 0
				FileWrite(li_fnum, BlobMid(lbl_data, 1, ll_bytes))
				ll_bytes = this.of_ReadFile(lul_hFile, lbl_data)
			loop
			FileClose(li_fnum)
			this.of_CloseFile(lul_hFile)
		Else
			this.of_CloseFile(lul_hFile)
			MessageBox(	"Function of_CopyFile_ToPC Error", &
							"The PC file could not be opened!")
			Return False
		End If
	End If
Else
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_CopyFile_ToPC Error", &
					this.of_FormatMessage(lul_error))
	Return False
End If

Return True

end function

public function boolean of_copyfile_toce (string as_pcfilename, string as_cefilename);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_CopyFile_ToCE
//
// PURPOSE:    This function copies a file on the PC to a
//					file on the device.
//
// ARGUMENTS:  as_pcfilename	- Name of input file on PC
//             as_cefilename	- Name of output file on device
//
// RETURN:		True = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hFile, lul_error
Integer li_bytes, li_fnum
Blob lbl_data
Boolean lb_rc = True

li_fnum = FileOpen(as_pcfilename, StreamMode!, Read!)
If li_fnum > 0 Then
	lul_hFile = this.of_OpenFile(as_cefilename, Write!, Replace!)
	If lul_hFile > 0 Then
		li_bytes = FileRead(li_fnum, lbl_data)
		do while li_bytes > 0 and lb_rc
			lb_rc = this.of_WriteFile(lul_hFile, lbl_data)
			li_bytes = FileRead(li_fnum, lbl_data)
		loop
		this.of_CloseFile(lul_hFile)
		FileClose(li_fnum)
	Else
		lul_error = this.of_GetLastError()
		MessageBox(	"Function of_CopyFile_ToCE Error", &
						this.of_FormatMessage(lul_error))
		Return False
	End If
Else
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_CopyFile_ToCE Error", &
					this.of_FormatMessage(lul_error))
	Return False
End If

Return True

end function

public function boolean of_writefile (unsignedlong al_handle, blob abl_buffer);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_WriteFile
//
// PURPOSE:    This function writes to a file on the device.
//
// ARGUMENTS:  al_handle  - File handle from of_openfile
//             abl_buffer - Buffer to hold data for the file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Boolean lb_result
ULong lul_buflen, lul_bytes, lul_error

lul_buflen = Len(abl_buffer)

lb_result = CeWriteFile(al_handle, abl_buffer, lul_buflen, lul_bytes, 0)
If lb_result = False Then
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_WriteFile Error", &
					this.of_FormatMessage(lul_error))
End If

Return lb_result

end function

public function long of_getlasterror ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetLastError
//
// PURPOSE:    This function returns last error number.
//
// RETURN:		The most recent error number
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Return CeGetLastError()

end function

public function string of_formatmessage (unsignedlong aul_error);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_FormatMessage
//
// PURPOSE:    This function returns the error message that goes
//					with the error code from GetLastError.
//
// ARGUMENTS:  aul_error - Error code from GetLastError
//
// RETURN:		Text of the error message
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
String ls_buffer
ULong lul_rtn

ls_buffer = Space(200)

lul_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				aul_error, LANG_NEUTRAL, ls_buffer, 200, 0)

Return ls_buffer

end function

public function boolean of_createdirectory (string as_dirname);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_CreateDirectory
//
// PURPOSE:    This function creates a directory on the device.
//
// ARGUMENTS:  as_dirname - Name of the directory to create
//
// RETURN:		True = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

SECURITY_ATTRIBUTES sa
ULong lul_error

If CeCreateDirectory(as_dirname, sa) = False Then
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_createdirectory Error", &
					this.of_FormatMessage(lul_error))
	Return False
End If

Return True

end function

public function boolean of_removedirectory (string as_dirname);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RemoveDirectory
//
// PURPOSE:    This function removes a directory on the device.
//
// ARGUMENTS:  as_dirname - Name of the directory to create
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_error

If CeRemoveDirectory(as_dirname) = False Then
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_RemoveDirectory Error", &
					this.of_FormatMessage(lul_error))
	Return False
End If

Return True

end function

public function string of_gettemppath ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetTempPath
//
// PURPOSE:    This function returns the temp directory
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_directory
ULong lul_rtn, lul_buflen

lul_buflen = 255
ls_directory = Space(lul_buflen)

lul_rtn = CeGetTempPath(lul_buflen, ls_directory)

Return ls_directory

end function

public function unsignedlong of_registryhandle (string as_key);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistryHandle
//
// PURPOSE:    This function returns the handle for the registry.
//
// ARGUMENTS:  as_key	- Registry Key
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey

If Left(as_key, 18) = "HKEY_CLASSES_ROOT\" Then
	lul_hKey = HKEY_CLASSES_ROOT
Else
	If Left(as_key, 18) = "HKEY_CURRENT_USER\" Then
		lul_hKey = HKEY_CURRENT_USER
	Else
		If Left(as_key, 19) = "HKEY_LOCAL_MACHINE\" Then
			lul_hKey = HKEY_LOCAL_MACHINE
		Else
			MessageBox(	"Function of_RegistryHandle Error", &
							"Invalid Key Name: " + as_key)
			Return -1
		End If
	End If
End If

Return lul_hKey

end function

public function boolean of_deletefile (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_DeleteFile
//
// PURPOSE:    This function deletes a file on the device.
//
// ARGUMENTS:  as_filename		- Name of the file to delete
//
// RETURN:		True = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Boolean lb_rc
ULong lul_error

lb_rc = CeDeleteFile(as_filename)
If lb_rc = False Then
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_DeleteFile Error", &
					this.of_FormatMessage(lul_error))
	Return False
End If

Return True

end function

public function datetime of_getfiletime (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetFiletime
//
// PURPOSE:    This function gets the files datetime.
//
// ARGUMENTS:  as_filename		- Name of the file
//
// RETURN:		File LastWrite datetime
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

DateTime				ldt_datetime
ULong					lul_Handle
WIN32_FIND_DATA	lstr_FindData
FILETIME				lstr_LocalTime

// Get the file information
lul_Handle = CeFindFirstFile(as_FileName, lstr_FindData)
If lul_Handle < 0 Then
	SetNull(ldt_datetime)
	Return ldt_datetime
End If
CeFindClose(lul_Handle)

// convert to a PB datetime
ldt_datetime = this.of_ConvertFileDateTimeToPB(lstr_FindData.ftLastWriteTime)

Return ldt_datetime

end function

public function boolean of_checkbit (unsignedlong aul_number, integer ai_bit);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_Checkbit
//
// PURPOSE:    This function determines if a certain bit is on or off within
//					the number.
//
// ARGUMENTS:  al_number	- Number to check bits
//             ai_bit		- Bit number ( starting at 1 )
//
// RETURN:		True = On, False = Off
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

If Int(Mod(aul_number / (2 ^(ai_bit - 1)), 2)) > 0 Then
	Return True
End If

Return False

end function

public function longlong of_getfilesize (string as_filename);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetFileSize
//
// PURPOSE:    This function gets file size.
//
// ARGUMENTS:  as_filename		- Name of the file
//
// RETURN:		File size
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hFile, lul_error, lul_low, lul_high
LongLong lll_filesize

lul_hFile = this.of_OpenFile(as_filename, Read!)
If lul_hFile > 0 Then
	lul_low = CeGetFileSize(lul_hFile, lul_high)
	lll_filesize = LongLong(lul_low, lul_high)
	this.of_CloseFile(lul_hFile)
Else
	lul_error = this.of_GetLastError()
	MessageBox(	"Function of_getfilesize Error", &
					this.of_formatmessage(lul_error))
End If

Return lll_filesize

end function

public function integer of_get_dirlist (string as_filespec, ref s_dirlist astr_dirlist[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_Get_Dirlist
//
// PURPOSE:    This function returns a list of files in a directory.
//
// ARGUMENTS:  as_filespec		- Directory\file wildcard
//					astr_dirlist	- Directory list (by ref)
//
// RETURN:		Teh number of files returned in the structure
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

WIN32_FIND_DATA lstr_FindData
Integer li_cnt
Boolean lb_Found
ULong lul_Handle

// get first file
lul_Handle = CeFindFirstFile(as_filespec, lstr_FindData)
Do
	// populate output array
	li_cnt++
	astr_dirlist[li_cnt].s_filename = String(lstr_FindData.cFileName)
	astr_dirlist[li_cnt].dt_filedate = this.of_ConvertFileDateTimeToPB(lstr_FindData.ftLastWriteTime)
	astr_dirlist[li_cnt].ll_filesize = LongLong(lstr_FindData.nFileSizeLow, lstr_FindData.nFileSizeHigh)
	astr_dirlist[li_cnt].b_readonly = this.of_checkbit(lstr_FindData.dwFileAttributes, 1)
	astr_dirlist[li_cnt].b_hidden = this.of_checkbit(lstr_FindData.dwFileAttributes, 2)
	astr_dirlist[li_cnt].b_system = this.of_checkbit(lstr_FindData.dwFileAttributes, 3)
	astr_dirlist[li_cnt].b_subdirectory = this.of_checkbit(lstr_FindData.dwFileAttributes, 5)
	astr_dirlist[li_cnt].b_archive = this.of_checkbit(lstr_FindData.dwFileAttributes, 6)
	// get next file
	lb_Found = CeFindNextFile(lul_Handle, lstr_FindData)
Loop Until Not lb_Found

CeFindClose(lul_Handle)

Return UpperBound(astr_dirlist)

end function

public function datetime of_convertfiledatetimetopb (filetime astr_filetime);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_ConvertFileDateTimeToPB
//
// PURPOSE:    This function converts filetime to a
//					PowerBuilder datetime variable
//
// ARGUMENTS:  astr_filetime - filetime of a file
//
// RETURN:		Datetime value
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

FILETIME		lstr_Local
SYSTEMTIME	lstr_System
Date ld_FileDate
Time lt_FileTime
String ls_time

// determine the date
FileTimeToLocalFileTime(astr_FileTime, lstr_Local)
FileTimeToSystemTime(lstr_Local, lstr_System)
ld_FileDate = Date(	lstr_System.wYear, &
							lstr_System.wMonth, &
							lstr_System.wDay)

// determine the time
ls_time =	String(lstr_System.wHour) + ":" + &
				String(lstr_System.wMinute) + ":" + &
				String(lstr_System.wSecond) + ":" + &
				String(lstr_System.wMilliseconds)
lt_FileTime = Time(ls_Time)

Return DateTime(ld_FileDate, lt_FileTime)

end function

public function long of_disconnect ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_Disconnect
//
// PURPOSE:    This function disconnects the desktop computer from the
//					Windows CE device and performs general cleanup.
//
// RETURN:		0 = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Return CeRapiUninit()

end function

public function boolean of_closefile (unsignedlong aul_handle);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_CloseFile
//
// PURPOSE:    This function closes a file on the device.
//
// ARGUMENTS:  aul_handle - File handle from of_openfile
//
// RETURN:		True = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Return CeCloseHandle(aul_handle)

end function

public function long of_readfile (unsignedlong aul_handle, ref blob abl_buffer);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_readfile
//
// PURPOSE:    This function reads from a file on the device.
//
// ARGUMENTS:  aul_handle - File handle from of_openfile
//             abl_buffer - Buffer to hold data from file
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

Boolean lb_result
ULong lul_buflen, lul_bytes, lul_error

lul_buflen = 32765
abl_buffer = Blob(Space(lul_buflen))

lb_result = CeReadFile(aul_handle, abl_buffer, lul_buflen, lul_bytes, 0)
abl_buffer = BlobMid(abl_buffer, 1, lul_bytes)

If lb_result And lul_bytes = 0 Then
	// end of file reached
	Return -100
Else
	Return Long(lul_bytes)
End If

end function

public function integer of_getfileattributes (string as_filename, ref boolean ab_readonly, ref boolean ab_hidden, ref boolean ab_system, ref boolean ab_subdir, ref boolean ab_archive);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetFileAttributes
//
// PURPOSE:    This function returns attributes of the specified file.
//
// ARGUMENTS:  as_filename	- Name of the file
//             ab_readonly	- Read Only attribute (By Ref)
//             ab_hidden	- Hidden attribute (By Ref)
//             ab_system	- System attribute (By Ref)
//             ab_subdir	- Subdirectory attribute (By Ref)
//             ab_archive	- Archive attribute (By Ref)
//
// RETURN:		1 = Success, -1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/20/2007	RolandS		Initial Coding
// -----------------------------------------------------------------------------

ULong ll_attribs

ll_attribs = CeGetFileAttributes(as_filename)

// Return file attributes in by reference arguments
ab_ReadOnly = this.of_checkbit(ll_attribs, 1)
ab_Hidden   = this.of_checkbit(ll_attribs, 2)
ab_System   = this.of_checkbit(ll_attribs, 3)
ab_SubDir   = this.of_checkbit(ll_attribs, 5)
ab_Archive  = this.of_checkbit(ll_attribs, 6)

Return 1

end function

private function unsignedlong of_calcfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_CalcFileAttributes
//
// PURPOSE:    This function is called by of_SetFileAttributes to calculate
//             numeric attribute from the boolean values.
//
// ARGUMENTS:  as_filename	- Name of the file
//             ab_readonly	- Read Only attribute
//             ab_hidden	- Hidden attribute
//             ab_system	- System attribute
//             ab_archive	- Archive attribute
//
// RETURN:		Numeric attribute
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/20/2007	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Boolean	lb_ReadOnly, lb_Hidden, lb_System, lb_Subdirectory, lb_Archive
ULong		lul_Attrib

// Get the current attribute values
If this.of_GetFileAttributes(as_FileName, lb_ReadOnly, lb_Hidden, &
		lb_System, lb_Subdirectory, lb_Archive) = -1 Then 
	Return -1
End If

// Preserve the Subdirectory attribute
If lb_Subdirectory Then
	lul_Attrib = 16
Else
	lul_Attrib = 0
End If

// Set Read-Only
If Not IsNull(ab_ReadOnly) Then
	If ab_ReadOnly Then lul_Attrib = lul_Attrib + 1
Else
	If lb_ReadOnly Then lul_Attrib = lul_Attrib + 1
End If

// Set Hidden
If Not IsNull(ab_Hidden) Then
	If ab_Hidden Then lul_Attrib = lul_Attrib + 2
Else
	If lb_Hidden Then lul_Attrib = lul_Attrib + 2
End If

// Set System
If Not IsNull(ab_System) Then
	If ab_System Then lul_Attrib = lul_Attrib + 4
Else
	If lb_System Then lul_Attrib = lul_Attrib + 4
End If

// Set Archive
If Not IsNull(ab_Archive) Then
	If ab_Archive Then lul_Attrib = lul_Attrib + 32
Else
	If lb_Archive Then lul_Attrib = lul_Attrib + 32
End If

Return lul_Attrib

end function

public function unsignedlong of_setfileattributes (string as_filename, boolean ab_readonly, boolean ab_hidden, boolean ab_system, boolean ab_archive);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_SetFileAttributes
//
// PURPOSE:    This function determines if any files exist with the
//					passed path.
//
// ARGUMENTS:  as_filename	- Name of the file
//             ab_readonly	- Read Only attribute
//             ab_hidden	- Hidden attribute
//             ab_system	- System attribute
//             ab_archive	- Archive attribute
//
// RETURN:		1 = Success, -1 = Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/22/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Integer li_rc
ULong lul_attrib

// Calculate the new attribute byte for the file
lul_attrib = of_CalcFileAttributes(as_FileName, ab_ReadOnly, ab_Hidden, ab_System, ab_Archive)
If lul_attrib = -1 Then Return -1

If CeSetFileAttributes(as_FileName, lul_attrib) Then
	li_rc = 1
Else
	li_rc = -1
End If

Return li_rc

end function

public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref long valuevariable);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistryGet
//
// PURPOSE:    This function gets a numeric from the registry.
//
// ARGUMENTS:  key				- The key in the registry whose value you want
//             valuename		- The name of a value in the registry
//					valuetype		- The value type: ReguLong!
//					valuevariable	- By ref output variable
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle
Long ll_rc, ll_buflen, ll_regtype
Blob lbl_data
String ls_subkey

SetNull(valuevariable)

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegOpenKeyEx(lul_hKey, ls_subkey, 0, 0, lul_handle)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryGet Error", &
					"CeRegOpenKeyEx: " + this.of_formatmessage(ll_rc))
	Return -1
End If

ll_buflen = 1024
lbl_data = Blob(Space(ll_buflen))

// get the registry value
ll_rc = CeRegQueryValueEx(lul_handle, valuename, &
				0, ll_regtype, lbl_data, ll_buflen)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryGet Error", &
					"CeRegQueryValueEx: " + this.of_formatmessage(ll_rc))
	CeRegCloseKey(lul_handle)
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

// numeric value
valuevariable = Long(String(lbl_data))

Return 1

end function

public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref string valuevariable);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistryGet
//
// PURPOSE:    This function gets a string from the registry.
//
// ARGUMENTS:  key				- The key in the registry whose value you want
//             valuename		- The name of a value in the registry
//					valuetype		- The value type: RegString!
//					valuevariable	- By ref output variable
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle
Long ll_rc, ll_buflen, ll_regtype
Blob lbl_data
String ls_subkey

SetNull(valuevariable)

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegOpenKeyEx(lul_hKey, ls_subkey, 0, 0, lul_handle)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryGet Error", &
					"CeRegOpenKeyEx: " + this.of_formatmessage(ll_rc))
	Return -1
End If

ll_buflen = 1024
lbl_data = Blob(Space(ll_buflen))

// get the registry value
ll_rc = CeRegQueryValueEx(lul_handle, valuename, &
				0, ll_regtype, lbl_data, ll_buflen)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryGet Error", &
					"CeRegQueryValueEx: " + this.of_formatmessage(ll_rc))
	CeRegCloseKey(lul_handle)
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

// string value
valuevariable = Trim(String(lbl_data))

Return 1

end function

public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, string value);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistrySet
//
// PURPOSE:    This function sets a string value in the registry. The key is
//					created if it does not exist.
//
// ARGUMENTS:  key			- The key in the registry whose value you want to set
//             valuename	- The name of a value in the registry
//					valuetype	- The value type: RegString!
//					value			- The value to be set
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/20/2007	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle, lul_disp
Long ll_rc
Blob lbl_data
String ls_subkey

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegCreateKeyEx(lul_hKey, ls_subkey, 0, "", &
				0, 0, 0, lul_handle, lul_disp)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistrySet Error", &
					"CeRegCreateKeyEx: " + this.of_formatmessage(ll_rc))
	Return -1
End If

// convert value to blob
lbl_data = Blob(value)

// get the registry value
ll_rc = CeRegSetValueEx(lul_handle, valuename, &
				0, REG_SZ, lbl_data, Len(lbl_data))
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistrySet Error", &
					"CeRegSetValueEx: " + this.of_formatmessage(ll_rc))
	CeRegCloseKey(lul_handle)
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

Return 1

end function

public function integer of_registryset (string key, string valuename, registryvaluetype valuetype, long value);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistrySet
//
// PURPOSE:    This function sets a numeric value in the registry. The key is
//					created if it does not exist.
//
// ARGUMENTS:  key			- The key in the registry whose value you want to set
//             valuename	- The name of a value in the registry
//					valuetype	- The value type: ReguLong!
//					value			- The value to be set
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/20/2007	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle, lul_disp
Long ll_rc
Blob lbl_data
String ls_subkey

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegCreateKeyEx(lul_hKey, ls_subkey, 0, "", &
				0, 0, 0, lul_handle, lul_disp)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistrySet Error", &
					"CeRegCreateKeyEx: " + this.of_formatmessage(ll_rc))
	Return -1
End If

// convert value to blob
lbl_data = Blob(String(value))

// get the registry value
ll_rc = CeRegSetValueEx(lul_handle, valuename, &
				0, REG_SZ, lbl_data, Len(lbl_data))
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistrySet Error", &
					"CeRegSetValueEx: " + this.of_formatmessage(ll_rc))
	CeRegCloseKey(lul_handle)
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

Return 1

end function

public function integer of_registrydelete (string key, string valuename);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistryDelete
//
// PURPOSE:    This function deletes a value from the registry.
//
// ARGUMENTS:  key			- The key in the registry that the value is under
//             valuename	- The name of a value to be deleted
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/20/2007	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle
Long ll_rc
String ls_subkey

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegOpenKeyEx(lul_hKey, ls_subkey, 0, 0, lul_handle)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryDelete Error", &
					"CeRegOpenKeyEx: " + this.of_formatmessage(ll_rc))
	Return -1
End If

// delete the value
ll_rc = CeRegDeleteValue(lul_handle, valuename)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryDelete Error", &
					"CeRegDeleteValue: " + this.of_formatmessage(ll_rc))
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

Return 1

end function

public function integer of_registrydeletekey (string key, string deletekey);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistryDeleteKey
//
// PURPOSE:    This function deletes a value from the registry.
//
// ARGUMENTS:  key			- The key in the registry that the subkey is under
//             deletekey	- The subkey to be deleted
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 04/20/2007	RolandS		Initial coding
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle
Long ll_rc
String ls_subkey

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegOpenKeyEx(lul_hKey, ls_subkey, 0, 0, lul_handle)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryDeleteKey Error", &
					"CeRegOpenKeyEx: " + this.of_formatmessage(ll_rc))
	Return -1
End If

// delete the key
ll_rc = CeRegDeleteKey(lul_handle, deletekey)
If ll_rc > 0 Then
	MessageBox(	"Function of_RegistryDeleteKey Error", &
					"CeRegDeleteKey: " + this.of_formatmessage(ll_rc))
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

Return 1

end function

public function boolean of_connect ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_Connect
//
// PURPOSE:    This function calls of_Connect with a default timeout.
//
// RETURN:		True=Success, False=Error
// -----------------------------------------------------------------------------

Return of_Connect(1000)

end function

public function boolean of_connect (integer ai_timeout);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_Connect
//
// PURPOSE:    This function performs routine initialization and sets up the
//					communications link between the desktop computer and the
//					Windows CE device.
//
// ARGUMENTS:  ai_timeout	- Timeout period in milliseconds
//
// RETURN:		True=Success, False=Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// 05/10/2007	RolandS		Changed to asynchronous connect 
// -----------------------------------------------------------------------------

RAPIINIT lstr_RI
Long ll_rc, ll_init

lstr_RI.cbSize = 12

// start connection
ll_rc = CeRapiInitEx(lstr_RI)
If ll_rc > 0 Then
	MessageBox(	"Function of_Connect Error", &
					"CeRapiInitEx: " + this.of_formatmessage(ll_rc))
	Return False
End If

// wait for connection to complete
ll_init = WaitForSingleObject(lstr_RI.heRapiInit, ai_timeout);
choose case ll_init
	case WAIT_OBJECT_0
		// success
		Return True
	case WAIT_TIMEOUT
		MessageBox(	"Function of_Connect Error", &
						"The timeout period was reached without success!")
	case else
		MessageBox(	"Function of_Connect Error", &
						"WaitForSingleObject: " + this.of_formatmessage(ll_rc))
end choose

Return False

end function

public function decimal of_getmainfreespace ();// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_GetStoreStatus
//
// PURPOSE:    This function returns storage memory usage percent.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// -----------------------------------------------------------------------------

STORE_INFORMATION lpsi
//Decimal{4} ldec_pct
    
CeGetStoreInformation(lpsi)

//ldec_pct = lpsi.dwFreeSize / lpsi.dwStoreSize

Return lpsi.dwFreeSize

end function

public function ulong of_createdirectory (string as_dirname, ref string as_error);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_CreateDirectory
//
// PURPOSE:    This function creates a directory on the device.
//
// ARGUMENTS:  as_dirname - Name of the directory to create
//
// RETURN:		True = Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// 21/05/2010	LEC
// -----------------------------------------------------------------------------

SECURITY_ATTRIBUTES sa
ULong lul_error

If CeCreateDirectory(as_dirname, sa) = False Then
	lul_error = this.of_GetLastError()
	as_error = this.of_FormatMessage(lul_error)
	Return lul_error
End If

Return 0

end function

public function long of_connect (integer ai_timeout, ref string as_error);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_Connect
//
// PURPOSE:    This function performs routine initialization and sets up the
//					communications link between the desktop computer and the
//					Windows CE device.
//
// ARGUMENTS:  ai_timeout	- Timeout period in milliseconds
//
// RETURN:		True=Success, False=Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// 05/10/2007	RolandS		Changed to asynchronous connect 
// 21/05/2010	LEC
// -----------------------------------------------------------------------------

RAPIINIT lstr_RI
Long ll_rc, ll_init

lstr_RI.cbSize = 12

// start connection
ll_rc = CeRapiInitEx(lstr_RI)
If ll_rc > 0 Then
	as_error = this.of_formatmessage(ll_rc)
	Return ll_rc
End If

// wait for connection to complete
ll_init = WaitForSingleObject(lstr_RI.heRapiInit, ai_timeout);
choose case ll_init
	case WAIT_OBJECT_0
		// success
	case WAIT_TIMEOUT
		as_error = "The timeout period was reached without success!"
	case else
		as_error = this.of_formatmessage(ll_rc)
end choose

Return ll_init

end function

public function integer of_registryget (string key, string valuename, registryvaluetype valuetype, ref string valuevariable, ref string as_error);// -----------------------------------------------------------------------------
// SCRIPT:     n_rapi.of_RegistryGet
//
// PURPOSE:    This function gets a string from the registry.
//
// ARGUMENTS:  key				- The key in the registry whose value you want
//             valuename		- The name of a value in the registry
//					valuetype		- The value type: RegString!
//					valuevariable	- By ref output variable
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 06/23/2003	RolandS		Initial coding
// 21/05/2010	LEC
// -----------------------------------------------------------------------------

ULong lul_hKey, lul_handle
Long ll_rc, ll_buflen, ll_regtype
Blob lbl_data
String ls_subkey

SetNull(valuevariable)

lul_hKey = this.of_RegistryHandle(key)
If lul_hKey = -1 Then Return -1

ls_subkey = Mid(key, Pos(key, "\") + 1)

// open the registry key
ll_rc = CeRegOpenKeyEx(lul_hKey, ls_subkey, 0, 0, lul_handle)
If ll_rc > 0 Then
	as_error = this.of_formatmessage(ll_rc)
	Return -1
End If

ll_buflen = 1024
lbl_data = Blob(Space(ll_buflen))

// get the registry value
ll_rc = CeRegQueryValueEx(lul_handle, valuename, &
				0, ll_regtype, lbl_data, ll_buflen)
If ll_rc > 0 Then
	as_error = this.of_formatmessage(ll_rc)
	CeRegCloseKey(lul_handle)
	Return -1
End If

// close the registry key
CeRegCloseKey(lul_handle)

// string value
valuevariable = Trim(String(lbl_data))

Return 1

end function

on n_rapi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_rapi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


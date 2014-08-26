HA$PBExportHeader$n_cst_uuid.sru
forward
global type n_cst_uuid from n_base
end type
type s_uuid from structure within n_cst_uuid
end type
end forward

type s_uuid from structure
	unsignedlong		data1
	unsignedinteger		data2
	unsignedinteger		data3
	unsignedinteger		data4[4]
end type

global type n_cst_uuid from n_base
end type
global n_cst_uuid n_cst_uuid

type prototypes
FUNCTION long uuidCreate(ref s_uuid astr_uuid) LIBRARY "Rpcrt4.dll"  &
  ALIAS FOR "UuidCreate"
  
  
FUNCTION long UuidCreateSequential(ref s_uuid astr_uuid) LIBRARY "Rpcrt4.dll"  &
  ALIAS FOR "UuidCreateSequential"
  
FUNCTION long GetComputerNameA (ref string ComputerName, ref ulong BufferLength) LIBRARY "KERNEL32.DLL"

FUNCTION long GetUserNameA(ref string UserName, ref ulong BufferLength) LIBRARY "ADVAPI32.DLL"

FUNCTION boolean GetVolumeInformation(string lpRootPathName,ref string lpVolumeNameBuffer,ulong nVolumeNameSize, &
                                ref long lpVolumeSerialNumber,ref ulong lpMaximumComponentLength,  &
                                ref ulong lpFileSystemFlags,ref string lpFileSystemNameBuffer,  &
                                ulong nFileSystemNameSize) Library "kernel32.dll" ALIAS FOR "GetVolumeInformationA;Ansi"
end prototypes

forward prototypes
public function string of_hex (unsignedlong aul_decimal)
public function string of_generateuuid ()
public function integer of_getcpuinfo ()
public function integer of_getdriveinfo ()
public function integer of_getnetworkinfo ()
public function integer of_getbiosinfo ()
public function string of_getprocessorid ()
public function string of_gethdserialnumber ()
public function string of_gethardwareid ()
public function integer of_getlogin (ref string as_computername, ref string as_username)
end prototypes

public function string of_hex (unsignedlong aul_decimal);//[powerscript function string of_hex(unsignedlong aul_decimal)]
String ls_hex
Character lch_hex[0 TO 15] = &
 {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', &
  'c', 'd', 'e', 'f'}

// Check parameters
IF IsNull(aul_decimal) THEN
 SetNull(ls_hex)
 RETURN ls_hex
END IF
 
DO
 ls_hex = lch_hex[Mod(aul_decimal, 16)] + ls_hex
 aul_decimal /= 16
LOOP UNTIL aul_decimal = 0
 
RETURN ls_hex
end function

public function string of_generateuuid ();long  ll_rc
s_uuid lstr_uuid
string ls_guid = ""

constant long RPC_S_OK = 0
constant long RPC_S_UUID_LOCAL_ONLY = 1824
constant long RPC_S_UUID_NO_ADDRESS = 1739

//ll_rc = uuidCreate(lstr_uuid)
ll_rc = UuidCreateSequential(lstr_uuid)
//  returns 
//   RPC_S_OK - The call succeeded.
//   RPC_S_UUID_LOCAL_ONLY - 
//     The UUID is guaranteed to be unique to this computer only.
//   RPC_S_UUID_NO_ADDRESS - 
//     Cannot get Ethernet/token-ring hardware address for this computer.
IF ll_rc <> RPC_S_OK THEN
    setNull(ls_GUID)
    // MessageBox("", "uuid create not ok ?!?")
ELSE
    ls_GUID = right("00000000" + of_hex(lstr_uuid.data1), 8)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data2), 4)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data3), 4)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data4[1]), 4)
    ls_GUID += "-" + right("0000" + of_hex(lstr_uuid.data4[2]), 4) &
          + right("0000" + of_hex(lstr_uuid.data4[3]), 4) &
          + right("0000" + of_hex(lstr_uuid.data4[4]), 4)
    ls_GUID = upper(ls_GUID)
    // MessageBox("", ls_guid)
    // output example : 00003B93-2641-477A-C99E-A2FFEBEB214A
END IF

RETURN ls_GUID


end function

public function integer of_getcpuinfo ();

OLEObject ole_wsh
Any la_processor[]
string ls_message

 ole_wsh = CREATE OLEObject
 ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
 ole_wsh.Language = "vbscript"
 ole_wsh.AddCode('Function rtnProcessor()~r~n' &
 + 'DIM objProcessor(3)~r~n'  &
 + 'strComputer = "."~r~n'  &
 + 'Set objWMIService ='  &
 + '   GetObject("winmgmts:\\" & strComputer & "\root\cimv2")~r~n' &
 + 'Set colItems =' &
 + '    objWMIService.ExecQuery("Select * from Win32_Processor")~r~n' &
 + 'For Each objItem in colItems~r~n' &
 + 'objProcessor(0) = objItem.ProcessorId~r~n' &
 + 'objProcessor(1) = objItem.MaxClockSpeed~r~n' &
 + 'objProcessor(2) = objItem.Name~r~n' &
 + 'objProcessor(3) = objItem.Description~r~n' &
 + 'Next~r~n' &
 + 'rtnProcessor = objProcessor~r~n' &
 + 'End Function')
 la_processor[] = ole_wsh.Eval("rtnProcessor")
 ole_wsh.DisconnectObject()
 DESTROY ole_wsh

ls_message = "Processor Id: " + string(la_processor[1]) + "~r~n" + &
+ "Maximum Clock Speed: " + string(la_processor[2]) + "~r~n" + &
+ "Name : " +string(la_processor[3]) + "~r~n" + &
+ "Description : " + string(la_processor[4])
MessageBox("Win32 Processor",ls_message)

RETURN 1
end function

public function integer of_getdriveinfo ();OLEObject ole_wsh
Any la_processor[]
string ls_message
//http://msdn.microsoft.com/en-us/library/aa394132(v=VS.85).aspx
 ole_wsh = CREATE OLEObject
 ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
 ole_wsh.Language = "vbscript"
 ole_wsh.AddCode('Function rtnProcessor()~r~n' &
 + 'DIM objProcessor(5)~r~n'  &
 + 'strComputer = "."~r~n'  &
 + 'Set objWMIService ='  &
 + '   GetObject("winmgmts:\\" & strComputer & "\root\cimv2")~r~n' &
 + 'Set colItems =' &
 + '    objWMIService.ExecQuery("Select * from Win32_DiskDrive")~r~n' &
 + 'For Each objItem in colItems~r~n' &
 + 'objProcessor(0) = objItem.DeviceID~r~n' &
 + 'objProcessor(1) = objItem.Description~r~n' &
  + 'objProcessor(2) = objItem.Model~r~n' &
   + 'objProcessor(3) = objItem.Name~r~n' &
   + 'objProcessor(4) = objItem.SerialNumber~r~n' &
   + 'objProcessor(5) = objItem.CapabilityDescriptions~r~n' &
 + 'Next~r~n' &
 + 'rtnProcessor = objProcessor~r~n' &
 + 'End Function')
 la_processor[] = ole_wsh.Eval("rtnProcessor")
 ole_wsh.DisconnectObject()
 DESTROY ole_wsh

ls_message = "device Id: " + string(la_processor[1]) + "~r~n" + &
"description Id: " + string(la_processor[2]) + "~r~n" + &
"model Id: " + string(la_processor[3]) + "~r~n" + &
"name Id: " + string(la_processor[4]) + "~r~n" + &
+ "onpdevice : " + string(la_processor[5])
MessageBox("Win32 Processor",ls_message)

RETURN 1
end function

public function integer of_getnetworkinfo ();OLEObject ole_wsh
Any la_processor[]
string ls_message
//http://msdn.microsoft.com/en-us/library/aa394132(v=VS.85).aspx
 ole_wsh = CREATE OLEObject
 ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
 ole_wsh.Language = "vbscript"
 ole_wsh.AddCode('Function rtnProcessor()~r~n' &
 + 'DIM objProcessor(3)~r~n'  &
 + 'strComputer = "."~r~n'  &
 + 'Set objWMIService ='  &
 + '   GetObject("winmgmts:\\" & strComputer & "\root\cimv2")~r~n' &
 + 'Set colItems =' &
 + '    objWMIService.ExecQuery("Select * from Win32_NetworkAdapter")~r~n' &
 + 'For Each objItem in colItems~r~n' &
 + 'objProcessor(0) = objItem.MACAddress~r~n' &
  + 'objProcessor(1) = objItem.DeviceID~r~n' &
  + 'objProcessor(2) = objItem.PermanentAddress~r~n' & 
  + 'objProcessor(3) = objItem.NetworkAddresses~r~n' & 
 + 'Next~r~n' &
 + 'rtnProcessor = objProcessor~r~n' &
 + 'End Function')
 la_processor[] = ole_wsh.Eval("rtnProcessor")
 ole_wsh.DisconnectObject()
 DESTROY ole_wsh

ls_message = "device Id: " + string(la_processor[1]) + "~r~n" 
MessageBox("Win32 Processor",ls_message)

RETURN 1
end function

public function integer of_getbiosinfo ();//Hello, try this, is a combination of vbscript and WMI inside your PBScript.

OleObject wsh
Integer  li_rc



wsh = CREATE OleObject
li_rc = wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" )
wsh.language = "vbscript"
/**/
wsh.addcode("function bios_info() " + &
                    "Dim strComputer, colItems, objItem, BiosInf ~n" + &
                    "strComputer = ~".~" ~n" + &
                    "Set objWMIService = GetObject(~"winmgmts:\\~" & strComputer & ~"\root\cimv2~") ~n" + &
                    "Set colItems = objWMIService.ExecQuery(~"Select * from Win32_BIOS~",,48) ~n" + &
                    "For Each objItem in colItems ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"BiosCharacteristics: ~" & objItem.BiosCharacteristics ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"BuildNumber: ~" & objItem.BuildNumber ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"Caption: ~" & objItem.Caption ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"CodeSet: ~" & objItem.CodeSet ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"CurrentLanguage: ~" & objItem.CurrentLanguage ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"Description: ~" & objItem.Description ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"IdentificationCode: ~" & objItem.IdentificationCode ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"InstallableLanguages: ~" & objItem.InstallableLanguages ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"InstallDate: ~" & objItem.InstallDate ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"LanguageEdition: ~" & objItem.LanguageEdition ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"ListOfLanguages: ~" & objItem.ListOfLanguages ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"Manufacturer: ~" & objItem.Manufacturer ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"Name: ~" & objItem.Name ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"OtherTargetOS: ~" & objItem.OtherTargetOS ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"PrimaryBIOS: ~" & objItem.PrimaryBIOS ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"ReleaseDate: ~" & objItem.ReleaseDate ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SerialNumber: ~" & objItem.SerialNumber ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SMBIOSBIOSVersion: ~" & objItem.SMBIOSBIOSVersion ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SMBIOSMajorVersion: ~" & objItem.SMBIOSMajorVersion ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SMBIOSMinorVersion: ~" & objItem.SMBIOSMinorVersion ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SMBIOSPresent: ~" & objItem.SMBIOSPresent ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SoftwareElementID: ~" & objItem.SoftwareElementID ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"SoftwareElementState: ~" & objItem.SoftwareElementState ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"Status: ~" & objItem.Status ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"TargetOperatingSystem: ~" & objItem.TargetOperatingSystem ~n" + &
                    "      BiosInf = BiosInf & ~",  ~" & ~"Version: ~" & objItem.Version  ~n" + &
                    "Next ~n" + &
                    "BIOS_Info = BiosInf ~n" + &
                    "end function")
string ls_1
ls_1 = String(wsh.Eval('bios_info') )
MessageBox("Ortograf$$HEX1$$ed00$$ENDHEX$$a", ls_1)

wsh.DisconnectObject()
Destroy wsh

RETURN 1
end function

public function string of_getprocessorid ();
//of_getProcessorId



OLEObject ole_wsh
Any la_processor[]
string ls_message

 ole_wsh = CREATE OLEObject
 ole_wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
 ole_wsh.Language = "vbscript"
 ole_wsh.AddCode('Function rtnProcessor()~r~n' &
 + 'DIM objProcessor(0)~r~n'  &
 + 'strComputer = "."~r~n'  &
 + 'Set objWMIService ='  &
 + '   GetObject("winmgmts:\\" & strComputer & "\root\cimv2")~r~n' &
 + 'Set colItems =' &
 + '    objWMIService.ExecQuery("Select * from Win32_Processor")~r~n' &
 + 'For Each objItem in colItems~r~n' &
 + 'objProcessor(0) = objItem.ProcessorId~r~n' &
 + 'Next~r~n' &
 + 'rtnProcessor = objProcessor~r~n' &
 + 'End Function')
 la_processor[] = ole_wsh.Eval("rtnProcessor")
 ole_wsh.DisconnectObject()
 DESTROY ole_wsh


RETURN UPPER(string(la_processor[1]))
end function

public function string of_gethdserialnumber ();
boolean rtn 
string lprootpathname = "C:\"
string lpVolumeNameBuffer = space(30)
ulong nVolumeNameSize = 30
long lpVolumeSerialNumber
ulong lpMaximumComponentLength = 30
ulong lpFileSystemFlags
string lpFileSystemNameBuffer = space(256)
ulong nFileSystemNameSize = 256

rtn = GetVolumeInformation(lpRootPathName, lpVolumeNameBuffer, nVolumeNameSize, &
                                                lpVolumeSerialNumber, lpMaximumComponentLength, lpFileSystemFlags, &
                                                lpFileSystemNameBuffer, nFileSystemNameSize)
// ls volbuffer  - volume name
// ll_serial     - hard disk serial number
// ls_fsname     - file system name ex. NTFS

RETURN UPPER(of_hex(lpVolumeSerialNumber))

end function

public function string of_gethardwareid ();
string ls_cpuId, ls_ddserial
string ls_hardwareid

ls_cpuId = of_getProcessorID()
ls_ddserial = of_gethdSerialNumber()

//Mix them up and remove some useless 0's
//return cpuID.Substring(13) + cpuID.Substring(1, 4) + volumeSerial + cpuID.Substring(4, 4);

ls_hardwareid = Mid(ls_cpuId,14)
ls_hardwareid += Mid(ls_cpuId,2,4)
ls_hardwareid += ls_ddserial
ls_hardwareid += Mid(ls_cpuId,5,4)

RETURN ls_hardwareid


end function

public function integer of_getlogin (ref string as_computername, ref string as_username);long ll_ret
string ls_ComputerName, ls_UserName
ulong BufferLength = 250  // you may need to adjust this. see Note
blob lb_blob1, lb_blob2

ls_ComputerName = Space(BufferLength)
ls_UserName     = Space(BufferLength)

ll_ret = GetComputerNameA(ls_ComputerName, BufferLength)
ll_ret = GetUserNameA(ls_UserName, BufferLength)

lb_blob1 = blob(ls_ComputerName) //EncodingUTF16LE! is default
lb_blob2 = blob(ls_UserName) //EncodingUTF16LE! is default

as_computername = string(lb_blob1, EncodingANSI!)
as_username = string(lb_blob2, EncodingANSI!)

//as_computername = ls_ComputerName
//as_username = ls_UserName

RETURN 1
end function

on n_cst_uuid.create
call super::create
end on

on n_cst_uuid.destroy
call super::destroy
end on


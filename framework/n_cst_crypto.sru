HA$PBExportHeader$n_cst_crypto.sru
forward
global type n_cst_crypto from nonvisualobject
end type
end forward

global type n_cst_crypto from nonvisualobject autoinstantiate
end type

type prototypes
Function long GetLastError( ) Library "kernel32.dll"

Function long FormatMessage( &
	long dwFlags, &
	long lpSource, &
	long dwMessageId, &
	long dwLanguageId, &
	Ref string lpBuffer, &
	long nSize, &
	long Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"

Function long CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileW"

Function boolean CloseHandle ( &
	long hObject &
	) Library "kernel32.dll"

Function boolean ReadFile ( &
	long hFile, &
	Ref Blob lpBuffer, &
	ulong nNumberOfBytesToRead, &
	Ref ulong lpNumberOfBytesRead, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function boolean WriteFile ( &
	long hFile, &
	blob lpBuffer, &
	ulong nNumberOfBytesToWrite, &
	Ref ulong lpNumberOfBytesWritten, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function Boolean CryptAcquireContext ( &
	Ref ulong phProv, &
	string pszContainer, &
	string pszProvider, &
	ulong dwProvType, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptAcquireContextW"

Function Boolean CryptCreateHash ( &
	ulong hProv, &
	ulong Algid, &
	ulong hKey, &
	ulong dwFlags, &
	Ref ulong phHash &
	) Library "advapi32.dll" Alias For "CryptCreateHash"

Function Boolean CryptDecrypt ( &
	ulong hKey, &
	ulong hHash, &
	boolean Final, &
	ulong dwFlags, &
	Ref blob pbData, &
	Ref ulong pdwDataLen &
	) Library "advapi32.dll" Alias For "CryptDecrypt"

Function Boolean CryptDeriveKey ( &
	ulong hProv, &
	ulong Algid, &
	ulong hBaseData, &
	ulong dwFlags, &
	Ref ulong phKey &
	) Library "advapi32.dll" Alias For "CryptDeriveKey"

Function Boolean CryptDestroyHash ( &
	ulong hHash &
	) Library "advapi32.dll" Alias For "CryptDestroyHash"

Function Boolean CryptDestroyKey ( &
	ulong hKey &
	) Library "advapi32.dll" Alias For "CryptDestroyKey"

Function Boolean CryptEncrypt ( &
	ulong hKey, &
	ulong hHash, &
	boolean Final, &
	ulong dwFlags, &
	Ref blob pbData, &
	Ref ulong pdwDataLen, &
	ulong dwBufLen &
	) Library "advapi32.dll" Alias For "CryptEncrypt"

Function Boolean CryptHashData ( &
	ulong hHash, &
	string pbData, &
	ulong dwDataLen, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptHashData;Ansi"

Function Boolean CryptReleaseContext ( &
	ulong hProv, &
	ulong dwFlags &
	) Library "advapi32.dll" Alias For "CryptReleaseContext"

Function Boolean CryptGetDefaultProvider ( &
	ulong dwProvType, &
	ulong pdwReserved, &
	ulong dwFlags, &
	Ref string pszProvName, &
	Ref ulong pcbProvName &
	) Library "advapi32.dll" Alias For "CryptGetDefaultProviderW"

Function Boolean CryptEnumProviders ( &
	ulong dwIndex, &
	ulong pdwReserved, &
	ulong dwFlags, &
	Ref ulong pdwProvType, &
	Ref string pszProvName, &
	Ref ulong pcbProvName &
	) Library "advapi32.dll" Alias For "CryptEnumProvidersW"

Function Boolean CryptEnumProviders ( &
	ulong dwIndex, &
	ulong pdwReserved, &
	ulong dwFlags, &
	Ref ulong pdwProvType, &
	ulong pszProvName, &
	Ref ulong pcbProvName &
	) Library "advapi32.dll" Alias For "CryptEnumProvidersW"

Function boolean CryptBinaryToString ( &
	Blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringW"

Function boolean CryptStringToBinary ( &
	string pszString, &
	ulong cchString, &
	ulong dwFlags, &
	Ref blob pbBinary, &
	Ref ulong pcbBinary, &
	Ref ulong pdwSkip, &
	Ref ulong pdwFlags &
	) Library "crypt32.dll" Alias For "CryptStringToBinaryW"

end prototypes

type variables
Private:

// constants for CreateFile API function
Constant Long INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_READ		= 2147483648
Constant ULong GENERIC_WRITE		= 1073741824
Constant ULong FILE_SHARE_READ	= 1
Constant ULong FILE_SHARE_WRITE	= 2
Constant ULong CREATE_NEW			= 1
Constant ULong CREATE_ALWAYS		= 2
Constant ULong OPEN_EXISTING		= 3
Constant ULong OPEN_ALWAYS			= 4
Constant ULong TRUNCATE_EXISTING = 5

// constants for cypto api
Constant String KEY_CONTAINER			= "00-1E-C9-05-C3-C2"
Constant ULong CRYPT_NEWKEYSET		= 8
Constant ULong ERROR_MORE_DATA		= 234
Constant ULong CRYPT_STRING_BASE64	= 1

Public:

// Encryption Algorithms
Constant ULong CALG_3DES			= 26115
Constant ULong CALG_3DES_112		= 26121
Constant ULong CALG_AES				= 26129
Constant ULong CALG_AES_128		= 26126
Constant ULong CALG_AES_192		= 26127
Constant ULong CALG_AES_256		= 26128
Constant ULong CALG_CYLINK_MEK	= 26124
Constant ULong CALG_DES				= 26113
Constant ULong CALG_DESX			= 26116
Constant ULong CALG_DH_EPHEM		= 43522
Constant ULong CALG_DH_SF			= 43521
Constant ULong CALG_DSS_SIGN		= 8704
Constant ULong CALG_RC2				= 26114
Constant ULong CALG_RC4				= 26625
Constant ULong CALG_RC5				= 26125
Constant ULong CALG_RSA_KEYX		= 41984
Constant ULong CALG_RSA_SIGN		= 9216

// Hashing Algorithms
Constant ULong CALG_HUGHES_MD5	= 40963
Constant ULong CALG_HMAC			= 32777
Constant ULong CALG_MAC				= 32773
Constant ULong CALG_MD2				= 32769
Constant ULong CALG_MD5				= 32771
Constant ULong CALG_SHA				= 32772
Constant ULong CALG_SHA1			= 32772
Constant ULong CALG_SHA_256		= 32780
Constant ULong CALG_SHA_384		= 32781
Constant ULong CALG_SHA_512		= 32782

// Provider Types
Constant ULong PROV_RSA_FULL			= 1
Constant ULong PROV_RSA_SIG			= 2
Constant ULong PROV_DSS					= 3
Constant ULong PROV_FORTEZZA			= 4
Constant ULong PROV_MS_EXCHANGE		= 5
Constant ULong PROV_SSL					= 6
Constant ULong PROV_RSA_SCHANNEL		= 12
Constant ULong PROV_DSS_DH				= 13
Constant ULong PROV_EC_ECDSA_SIG		= 14
Constant ULong PROV_EC_ECNRA_SIG		= 15
Constant ULong PROV_EC_ECDSA_FULL	= 16
Constant ULong PROV_EC_ECNRA_FULL	= 17
Constant ULong PROV_DH_SCHANNEL		= 18
Constant ULong PROV_SPYRUS_LYNKS		= 20
Constant ULong PROV_RNG					= 21
Constant ULong PROV_INTEL_SEC			= 22
Constant ULong PROV_REPLACE_OWF		= 23
Constant ULong PROV_RSA_AES			= 24

// current settings
String iCryptoService		= ""					// current Crypto Service
ULong iProviderType			= PROV_RSA_FULL	// current Provider Type
ULong iEncryptAlgorithm		= CALG_RC4			// current Encryption Algorithm
ULong iHashAlgorithm			= CALG_MD5			// current Hash Algorithm

end variables

forward prototypes
private function blob of_encryptdecrypt (blob ablob_data, string as_password, boolean ab_encrypt)
public function string of_getdefaultprovider ()
public function blob of_encrypt (blob ablob_data, string as_password)
public function blob of_decrypt (blob ablob_data, string as_password)
public function string of_encrypt (string as_data, string as_password, boolean ab_removebad)
public function string of_decrypt (string as_data, string as_password, boolean ab_removebad)
public function unsignedlong of_readfile (string as_filename, ref blob ablob_contents)
public function integer of_writefile (string as_filename, blob ablob_filedata)
public function string of_encrypt (string as_data, string as_password)
public function string of_decrypt (string as_data, string as_password)
public function integer of_enumproviders (ref string as_provider[])
public function blob of_decode64 (string as_encoded)
public function string of_encode64 (blob ablob_data)
public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace)
public subroutine of_getlasterror (ref long al_error, ref string as_msgtext)
end prototypes

private function blob of_encryptdecrypt (blob ablob_data, string as_password, boolean ab_encrypt);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_EncryptDecrypt
//
// PURPOSE:    This function will encrypt/decrypt the blob passed to it. Both
//					encrypt/decrypt have the same api calls except one so they
//					are combined to save coding.
//
// ARGUMENTS:  ablob_data	- The blob to be decrypted
//					as_password	- The secret password
//
// RETURN:		Blob containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// 03/17/2010	RolandS		Enhanced to allow choice of CryptoService,
//									Provider Type & Algorithm
// -----------------------------------------------------------------------------

ULong hCryptProv, hHash, hKey
ULong lul_datalen, lul_buflen
Blob lblob_buffer, lblob_value
String ls_msgtext
Long ll_error

// Get handle to CSP
If Not CryptAcquireContext(hCryptProv, &
				KEY_CONTAINER, iCryptoService, iProviderType, 0) Then
	If Not CryptAcquireContext(hCryptProv, &
					KEY_CONTAINER, iCryptoService, iProviderType, CRYPT_NEWKEYSET) Then
		of_GetLastError(ll_error, ls_msgtext)
		SignalError(ll_error, "CryptAcquireContext:~r~n~r~n" + ls_msgtext)
	End If
End If

// Create a hash object
If Not CryptCreateHash(hCryptProv, iHashAlgorithm, 0, 0, hHash) Then
	of_GetLastError(ll_error, ls_msgtext)
	SignalError(ll_error, &
		"CryptCreateHash:~r~n~r~n" + ls_msgtext)
End If

// Hash the password
If Not CryptHashData(hHash, as_password, Len(as_password), 0) Then
	of_GetLastError(ll_error, ls_msgtext)
	SignalError(ll_error, &
		"CryptHashData:~r~n~r~n" + ls_msgtext)
End If

// Derive a session key from the hash object
If Not CryptDeriveKey(hCryptProv, iEncryptAlgorithm, hHash, 0, hKey) Then
	of_GetLastError(ll_error, ls_msgtext)
	SignalError(ll_error, &
		"CryptDeriveKey:~r~n~r~n" + ls_msgtext)
End If

// allocate buffer space
lul_datalen = Len(ablob_data)
lblob_buffer = ablob_data + Blob(Space(8))
lul_buflen = Len(lblob_buffer)

If ab_encrypt Then
	// Encrypt data
	If CryptEncrypt(hKey, 0, True, 0, &
				lblob_buffer, lul_datalen, lul_buflen) Then
		lblob_value = BlobMid(lblob_buffer, 1, lul_datalen)
	Else
		of_GetLastError(ll_error, ls_msgtext)
		SignalError(ll_error, &
			"CryptEncrypt:~r~n~r~n" + ls_msgtext)
	End If
Else
	// Decrypt data
	If CryptDecrypt(hKey, 0, True, 0, lblob_buffer, lul_datalen) Then
		lblob_value = BlobMid(lblob_buffer, 1, lul_datalen)
	Else
		of_GetLastError(ll_error, ls_msgtext)
		SignalError(ll_error, &
			"CryptDecrypt:~r~n~r~n" + ls_msgtext)
	End If
End If

// Destroy session key
If hKey > 0 Then
	CryptDestroyKey(hKey)
End If

// Destroy hash object
If hHash > 0 Then
	CryptDestroyHash(hHash)
End If

// Release CSP handle
If hCryptProv > 0 Then
	CryptReleaseContext(hCryptProv, 0)
End If

Return lblob_value

end function

public function string of_getdefaultprovider ();// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_GetDefaultProvider
//
// PURPOSE:    This function will return the name of the default provider.
//
// RETURN:		String containing CSP name
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant ULong CRYPT_USER_DEFAULT = 2
String ls_provider, ls_msgtext
ULong lul_datalen = 256
Long ll_error

ls_provider = Space(lul_datalen)

If Not CryptGetDefaultProvider(iProviderType, &
					0, CRYPT_USER_DEFAULT, ls_provider, lul_datalen) Then
	of_GetLastError(ll_error, ls_msgtext)
	SignalError(ll_error, &
		"CryptGetDefaultProvider:~r~n~r~n" + ls_msgtext)
End If

Return ls_provider

end function

public function blob of_encrypt (blob ablob_data, string as_password);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encrypt
//
// PURPOSE:    This function will encrypt the blob passed to it.
//
// ARGUMENTS:  ablob_data	- The blob to be encrypted
//					as_password	- The secret password
//
// RETURN:		Blob containing the encrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

// This function will encrypt the blob passed to it.

Blob lblob_encrypted

// encrypt the data
lblob_encrypted = this.of_EncryptDecrypt( &
								ablob_data, as_password, True)

Return lblob_encrypted

end function

public function blob of_decrypt (blob ablob_data, string as_password);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Decrypt
//
// PURPOSE:    This function will decrypt the blob passed to it.
//
// ARGUMENTS:  ablob_data	- The blob to be decrypted
//					as_password	- The secret password
//
// RETURN:		Blob containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Blob lblob_decrypted

// decrypt the data
lblob_decrypted = this.of_EncryptDecrypt( &
								ablob_data, as_password, False)

Return lblob_decrypted

end function

public function string of_encrypt (string as_data, string as_password, boolean ab_removebad);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encrypt
//
// PURPOSE:    This function will encrypt the string passed to it.
//
// ARGUMENTS:  as_data			- The string to be decrypted
//					as_password		- The secret password
//					ab_removebad	- True = remove TAB, LF, CR from encrypted result
//										  by adding a number to the password and
//										  prepending it to the result.
//
// RETURN:		String containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant Char TAB = Char(9)	// Tab
Constant Char LF  = Char(10)	// Linefeed
Constant Char CR  = Char(13)	// Carriage Return
String ls_encrypted, ls_newpass, ls_msgtext
Blob lblob_data, lblob_encrypted
Integer li_count = 1

// encrypt the data
lblob_data = Blob(as_data, EncodingAnsi!)
lblob_encrypted = this.of_EncryptDecrypt( &
								lblob_data, as_password, True)
ls_encrypted = String(lblob_encrypted, EncodingAnsi!)

If ab_removebad Then
	// try again if result contains a bad character
	Do While Pos(ls_encrypted, LF,  1) > 0 &
			Or Pos(ls_encrypted, CR,  1) > 0 &
			Or Pos(ls_encrypted, TAB, 1) > 0 &
			Or Len(ls_encrypted) <> Len(as_data)
		// append counter to password
		If li_count = 1 Then
			li_count = 14
		Else
			If li_count = 255 Then
				ls_msgtext = "Unable to successfully encrypt this data"
				SignalError(999, &
					"of_EncryptData:~r~n~r~n" + ls_msgtext)
			Else
				li_count++
			End If
		End If
		ls_newpass = as_password + String(li_count)
		// try again to encrypt
		lblob_data = Blob(as_data, EncodingAnsi!)
		lblob_encrypted = this.of_EncryptDecrypt( &
										lblob_data, ls_newpass, True)
		ls_encrypted = String(lblob_encrypted, EncodingAnsi!)
	Loop
	// prepend attempt count
	If Len(ls_encrypted) > 0 Then
		ls_encrypted = Char(li_count) + ls_encrypted
	End If
End If

Return ls_encrypted

end function

public function string of_decrypt (string as_data, string as_password, boolean ab_removebad);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Decrypt
//
// PURPOSE:    This function will decrypt the string passed to it.
//
// ARGUMENTS:  as_data			- The string to be decrypted
//					as_password		- The secret password
//					ab_removebad	- True = 1st character is a number to be
//										  added on to the password
//
// RETURN:		String containing the decrypted data.
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

String ls_decrypted, ls_data, ls_newpass
Blob lblob_data, lblob_decrypted
Integer li_count

If ab_removebad Then
	// first char is attempt count
	ls_data = Mid(as_data, 2)
	// get attempt count
	li_count = Asc(Left(as_data, 1))
	If li_count = 1 Then
		// decrypt the data
		lblob_data = Blob(ls_data, EncodingAnsi!)
		lblob_decrypted = this.of_EncryptDecrypt( &
										lblob_data, as_password, False)
		ls_decrypted = String(lblob_decrypted, EncodingAnsi!)
	Else
		ls_newpass = as_password + String(li_count)
		// decrypt the data
		lblob_data = Blob(ls_data, EncodingAnsi!)
		lblob_decrypted = this.of_EncryptDecrypt( &
										lblob_data, ls_newpass, False)
		ls_decrypted = String(lblob_decrypted, EncodingAnsi!)
	End If
Else
	// decrypt the data
	lblob_data = Blob(as_data, EncodingAnsi!)
	lblob_decrypted = this.of_EncryptDecrypt( &
									lblob_data, as_password, False)
	ls_decrypted = String(lblob_decrypted, EncodingAnsi!)
End If

Return ls_decrypted

end function

public function unsignedlong of_readfile (string as_filename, ref blob ablob_contents);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_ReadFile
//
// PURPOSE:    This function reads a file from disk.
//
// ARGUMENTS:  as_filename		- Name of the file
//					ablob_contents	- File contents (by ref)
//
// RETURN:		>0		= Number of bytes read
//					-1		= Error occurred
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long ll_file
ULong lul_bytes, lul_length
Boolean lb_result

// get file length
lul_length = FileLength(as_filename)

// open file for read
ll_file = CreateFile(as_filename, GENERIC_READ, &
					FILE_SHARE_READ, 0, OPEN_EXISTING, 0, 0)
If ll_file = INVALID_HANDLE_VALUE Then
	Return -1
End If

// read the entire file contents in one shot
ablob_contents = Blob(Space(lul_length), EncodingAnsi!)
lb_result = ReadFile(ll_file, ablob_contents, &
					lul_length, lul_bytes, 0)

// close the file
CloseHandle(ll_file)

Return lul_bytes

end function

public function integer of_writefile (string as_filename, blob ablob_filedata);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_WriteFile
//
// PURPOSE:    This function writes a blob to a file on disk.
//
// ARGUMENTS:  as_filename		- The name of the file
//					ablob_filedata	- The blob data of the file
//
// RETURN:		0	= Success
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/01/2005	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Long ll_file
ULong lul_length, lul_written
Boolean lb_rtn

// open file for write
ll_file = CreateFile(as_filename, GENERIC_WRITE, &
					FILE_SHARE_WRITE, 0, CREATE_ALWAYS, 0, 0)
If ll_file = INVALID_HANDLE_VALUE Then
	Return -999
End If

// write file to disk
lul_length = Len(ablob_filedata)
lb_rtn = WriteFile(ll_file, ablob_filedata, &
					lul_length, lul_written, 0)

// close the file
CloseHandle(ll_file)

Return 0

end function

public function string of_encrypt (string as_data, string as_password);// encrypt string defaulting last argument
Return of_Encrypt(as_data, as_password, False)

end function

public function string of_decrypt (string as_data, string as_password);// decrypt string defaulting last argument
Return of_Decrypt(as_data, as_password, False)

end function

public function integer of_enumproviders (ref string as_provider[]);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_EnumProviders
//
// PURPOSE:    This function will return a list of providers
//
// ARGUMENTS:  as_Provider	- Array of providers ( by ref )
//
// RETURN:		The number of returned providers
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 05/01/2008	RolandS		Initial Coding
// 03/17/2010	RolandS		Removed aul_dwType argument - now uses iProviderType
// -----------------------------------------------------------------------------

ULong lul_dwIndex, lul_dwType, lul_cbName
String ls_provider, ls_msgtext
Integer li_index
Long ll_error

lul_dwIndex = 0
do while CryptEnumProviders(lul_dwIndex, 0, 0, &
							lul_dwType, 0, lul_cbName)
	ls_provider = Space(lul_cbName)
	If CryptEnumProviders(lul_dwIndex, 0, 0, &
						lul_dwType, ls_provider, lul_cbName) Then
		If lul_dwType = iProviderType Then
			li_index = UpperBound(as_provider) + 1
			as_Provider[li_index] = ls_provider
		End If
	Else
		of_GetLastError(ll_error, ls_msgtext)
		SignalError(ll_error, &
			"CryptEnumProviders:~r~n~r~n" + ls_msgtext)
	End If
	lul_dwIndex++
loop

Return UpperBound(as_provider)

end function

public function blob of_decode64 (string as_encoded);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Decode64
//
// PURPOSE:    This function converts a Base64 encoded string to binary.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  as_encoded - String containing encoded data
//
// RETURN:     Blob containing decoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/29/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

Blob lblob_data
ULong lul_len, lul_buflen, lul_skip, lul_pflags
Boolean lb_rtn

lul_len = Len(as_encoded)
lul_buflen = lul_len
lblob_data = Blob(Space(lul_len))

lb_rtn = CryptStringToBinary(as_encoded, &
					lul_len, CRYPT_STRING_BASE64, lblob_data, &
					lul_buflen, lul_skip, lul_pflags)

Return BlobMid(lblob_data, 1, lul_buflen)

end function

public function string of_encode64 (blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_Encode64
//
// PURPOSE:    This function converts binary data to a Base64 encoded string.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  ablob_data - Blob containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/29/2006	RolandS		Initial coding
// -----------------------------------------------------------------------------

String ls_encoded
ULong lul_len, lul_buflen
Boolean lb_rtn

lul_len = Len(ablob_data)

lul_buflen = lul_len * 2

ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(ablob_data, &
				lul_len, CRYPT_STRING_BASE64, &
				ls_encoded, lul_buflen)

If lb_rtn Then
	ls_encoded = of_ReplaceAll(ls_encoded, "~r~n", "")
Else
	ls_encoded = ""
End If

Return ls_encoded

end function

public function string of_replaceall (string as_oldstring, string as_findstr, string as_replace);String ls_newstring
Long ll_findstr, ll_replace, ll_pos

// get length of strings
ll_findstr = Len(as_findstr)
ll_replace = Len(as_replace)

// find first occurrence
ls_newstring = as_oldstring
ll_pos = Pos(ls_newstring, as_findstr)

Do While ll_pos > 0
	// replace old with new
	ls_newstring = Replace(ls_newstring, ll_pos, ll_findstr, as_replace)
	// find next occurrence
	ll_pos = Pos(ls_newstring, as_findstr, (ll_pos + ll_replace))
Loop

Return ls_newstring

end function

public subroutine of_getlasterror (ref long al_error, ref string as_msgtext);// -----------------------------------------------------------------------------
// SCRIPT:     n_cryptoapi.of_GetLastError
//
// PURPOSE:    This function returns the most recent API error message.
//
// ARGUMENTS:  al_error		- The error number ( by ref )
//					as_msgtext	- The error text ( by ref )
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 12/26/2006	RolandS		Initial Coding
// -----------------------------------------------------------------------------

Constant Long FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant Long LANG_NEUTRAL = 0
Long ll_rtn

al_error = GetLastError()

as_msgtext = Space(200)

ll_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				al_error, LANG_NEUTRAL, as_msgtext, 200, 0)

end subroutine

on n_cst_crypto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_crypto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


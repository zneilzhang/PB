HA$PBExportHeader$n_cst_inifile.sru
$PBExportComments$Extension INIFile service
forward
global type n_cst_inifile from pfc_n_cst_inifile
end type
end forward

global type n_cst_inifile from pfc_n_cst_inifile
end type

forward prototypes
public function integer of_delete (string as_file, string as_section, boolean ab_string)
end prototypes

public function integer of_delete (string as_file, string as_section, boolean ab_string);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Delete
//
//	Access:  		public
//
//	Arguments:		
//	as_file			The .ini file.
//	as_section		The section name to remove from the INI file.
//						(Do not include the brackets with this argument.)
//
//	Returns:  		Integer
//						 1	success
//						 0	section does not exist in the INI file.
//						-1	error
//						-2 if .INI file does not exist or has not been specified.
//
//	Description:  	Removes the specified section and all entries for 
//						that section from the INI file.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//	5.0.03	Function is now case-insensitive
//
//////////////////////////////////////////////////////////////////////////////
//
/*
 * Open Source PowerBuilder Foundation Class Libraries
 *
 * Copyright (c) 2004-2005, All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted in accordance with the GNU Lesser General
 * Public License Version 2.1, February 1999
 *
 * http://www.gnu.org/copyleft/lesser.html
 *
 * ====================================================================
 *
 * This software consists of voluntary contributions made by many
 * individuals and was originally based on software copyright (c) 
 * 1996-2004 Sybase, Inc. http://www.sybase.com.  For more
 * information on the Open Source PowerBuilder Foundation Class
 * Libraries see http://pfc.codexchange.sybase.com
*/
//
//////////////////////////////////////////////////////////////////////////////
string			ls_newfile
blob			lblb_newfile
boolean		lb_skipline
boolean		lb_sectionfound
integer		li_file
integer		li_rc = 1
integer		li_filewriterc
long			ll_length
long			ll_first
long			ll_last
long			ll_pos
string		ls_line
string		ls_section
string		ls_temp
n_cst_string 	lnv_string
n_cst_filesrv 	lnv_filesrv

SetPointer (Hourglass!)

// Determine if file exists.
if not FileExists (as_file) then
	return -2
end if

// Open file for reading (check rc).
ll_length = FileLength (as_file)
li_file = FileOpen (as_file)
if li_file = -1 then	return li_file

//////////////////////////////////////////////////////////////////////////////
// Read the file and locate the desired section that should be removed.
//////////////////////////////////////////////////////////////////////////////
do while li_rc >= 0
	
	// Read one line from the file (validate the rc).
	li_rc = FileRead (li_file, ls_line)
	if li_rc = -1 then
		return -1
	end if

	// Check that at least one character was read.
	if li_rc >= 1 then
		// Look for a section header components (the OpenBracket and CloseBracket (if any)).
		ll_first = Pos (ls_line, "[")
		ll_last = Pos (ls_line, "]")
		
		// Was section header found?
		if ll_first >0 and ll_last >0 then
			// Yes, a section has been found.
			// Get the name of the section.
			ls_temp = lnv_string.of_LeftTrim (ls_line, true, true)
			if Left (ls_temp, 1) = "[" then
				ll_pos = Pos (ls_temp, "]")
				ls_section = Mid (ls_temp, 2, ll_pos - 2)
				// Determine if this is the section being searched for.				
				if Lower (ls_section) = Lower (as_section) then
					// The search for section has been found.
					lb_sectionfound = true
					// Skip ALL lines until a new section is found.
					lb_skipline = true
				else
					// Do not skip this section or just simply Stop skipping.
					lb_skipline = false
				end if
			end if
		end if
	end if

	// Add the carriage control.
	ls_line = ls_line + of_GetLineEnding()

	// Create the output file by including all lines not
	// marked to be skipped.
	if li_rc >= 0 and not lb_skipline then
		IF ab_string THEN
			ls_newfile = ls_newfile + ls_line
		ELSE
			lblb_newfile = lblb_newfile + Blob (ls_line)
		END IF
	end if
loop 

// Close the input file
FileClose (li_file)

//If the section was not found, return
if not lb_sectionfound then
	return 0
end if

//Replace the file with the section removed.
li_rc = f_SetFilesrv(lnv_filesrv, True)
If li_rc <> 1 Then Return -1
IF ab_string THEN
	li_filewriterc = lnv_filesrv.of_FileWrite (as_file, ls_newfile, False)
ELSE
	li_filewriterc = lnv_filesrv.of_FileWrite (as_file, lblb_newfile, False)
END IF
li_rc = f_SetFilesrv(lnv_filesrv, False)

return li_filewriterc

end function

on n_cst_inifile.create
call super::create
end on

on n_cst_inifile.destroy
call super::destroy
end on


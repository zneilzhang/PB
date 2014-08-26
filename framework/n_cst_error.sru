HA$PBExportHeader$n_cst_error.sru
$PBExportComments$Extension Message (error) service
forward
global type n_cst_error from pfc_n_cst_error
end type
end forward

global type n_cst_error from pfc_n_cst_error
end type
global n_cst_error n_cst_error

type variables

constant string	DATASTORE='datastore'

n_ds 	ids_mensajes
end variables

forward prototypes
public function integer of_loadpredefinedmsg ()
public function integer of_setpredefinedsource (n_ds ads_mensajes)
end prototypes

public function integer of_loadpredefinedmsg ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_LoadPredefinedMsg
//
//	Access:  		public
//
//	Arguments: 		none
//
//	Returns:  		Integer
//						1 - retrieved messages.
//						-1 - did not retrieve messages.
//
//	Description:  	This function is used to Load or ReLoad the predefined 
//						messages into a cache using a datastore.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
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

// If appropriate, create the datastore cache.
If IsNull(ids_messages) Or Not IsValid(ids_messages) Then
	ids_messages = Create n_ds
	ids_messages.dataobject = 'd_definedmessages'
End If

// Reset the datastore.
ids_messages.Reset()

// Retrieve data into the datastore using the appropriate input source.
If is_msgsrc = DATABASE Then
	ids_messages.setTransObject(itr_msgdb)
	If ids_messages.Retrieve() >0 Then
		Return 1
	End If
ElseIf is_msgsrc = FILE Then
	If ids_messages.ImportFile(is_msgfile) >0 Then
		Return 1
	End If
ElseIf is_msgsrc = DATASTORE Then
//	n_ds lds_temp
//	lds_temp = CREATE n_ds
//	lds_temp.dataobject = 'd_definedmessages2'
//	lds_temp.retrieve()
	IF ids_mensajes.Rowscopy(1, ids_mensajes.RowCount(), Primary!, ids_messages, 1, Primary!) = 1 THEN RETURN 1
End If

Return -1

end function

public function integer of_setpredefinedsource (n_ds ads_mensajes);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetPredefinedSource
//
//	Access:  		public
//
//	Arguments:
//	as_file   		Filename used to read pre-defined messages
//
//	Returns:  		integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:  	This function is called to set the file, including path, to use
//						read pre-defined messages.  It will also perform an
//						initial loading of the messages.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
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

Integer	li_rc

// Check arguments.
If IsNull(ads_mensajes) or Not IsValid(ads_mensajes) Then
	Return -1
End If

// Invalidate the Transaction.
setnull(itr_msgdb)

// Set the file information.
is_msgsrc = DATASTORE
//is_msgfile = as_file
ids_mensajes = ads_mensajes

//// Load the predefined messages.
li_rc = of_LoadPredefinedMsg()

If IsValid(ids_mensajes) Then
	DESTROY ids_mensajes
End If

Return li_rc
end function

on n_cst_error.create
call super::create
end on

on n_cst_error.destroy
call super::destroy
end on


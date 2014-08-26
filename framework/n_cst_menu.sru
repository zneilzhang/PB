HA$PBExportHeader$n_cst_menu.sru
$PBExportComments$Extension Menu service
forward
global type n_cst_menu from pfc_n_cst_menu
end type
end forward

global type n_cst_menu from pfc_n_cst_menu
end type

forward prototypes
public function integer of_getmdiframe (menu am_source, ref window aw_frame)
end prototypes

public function integer of_getmdiframe (menu am_source, ref window aw_frame);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetMDIFrame
//
//	Access:  		public
//
//	Arguments:		none
//	am_source		The menu for which to find the MDI frame
//	aw_frame			The frame window found (if any) passed by reference.
//						Returns a NULL value if the MDI frame window could not be
//						obtained.
//
//	Returns:  		Integer.
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//
//	Description:  	Returns the MDI frame window (if any).
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

window	lw_obj
boolean	lb_foundframe=False

//Check arguments
If Not IsValid(am_source) or IsNull(am_source) Then
	SetNull (aw_frame)
	Return -1
End If

//Get the window that owns the Menu object.
lw_obj = am_source.ParentWindow

//Search until no more windows or a MDI type window is found.
Do While IsValid (lw_obj)
	IF lw_obj.Typeof() <> window! THEN
		lb_foundframe = false
		Exit		
	END IF
	If lw_obj.windowtype = mdi! or lw_obj.windowtype = mdihelp! Then
		//Found a MDI Frame
		lb_foundframe = true
		Exit
	Else
		//Look in the window's parent (if any)
		lw_obj = lw_obj.ParentWindow()
	End if
Loop

If Not lb_foundframe Then
	//MDI Frame was not found
	SetNull (aw_frame)
	Return -1
End If

//MDI Frame was found
aw_frame = lw_obj
Return 1

end function

on n_cst_menu.create
call super::create
end on

on n_cst_menu.destroy
call super::destroy
end on


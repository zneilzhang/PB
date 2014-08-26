HA$PBExportHeader$u_lvs.sru
$PBExportComments$Extension Service Based ListView class
forward
global type u_lvs from pfc_u_lvs
end type
end forward

global type u_lvs from pfc_u_lvs
end type
global u_lvs u_lvs

forward prototypes
public function integer of_getparentwindow (ref window aw_parent)
end prototypes

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_GetParentWindow
//	Arguments:		aw_parent   The Parent window for this object (passed by reference).
//	   								If a parent window is not found, aw_parent is NULL
//	Returns:			Integer - 1 if it succeeds and -1 if an error occurs
//	Description:	Calculates the parent window of a window object
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
powerobject	lpo_parent
oleobject lole_dw
integer	result

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) or not IsValid (lpo_parent) then lpo_parent = gw_frame
if IsNull(lpo_parent) or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end if

aw_parent = lpo_parent

return 1
end function

on u_lvs.create
call super::create
end on

on u_lvs.destroy
call super::destroy
end on

event contextmenu;//////////////////////////////////////////////////////////////////////////////
//	Event:				contextmenu
//	Description:			Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History			Version
//							8.0   Initial version
//////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////
boolean	lb_frame
integer	li_rc
integer	li_index, li_width, li_selected
string		ls_label
alignment	le_align
window		lw_parent
window		lw_frame
window		lw_sheet
window		lw_childparent
m_lvs			lm_view

// Determine if RMB popup menu should occur
if not ib_rmbmenu then
	return 1
end if

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)

If Not IsValid(lw_parent) or IsNull(lw_parent) Then lw_parent = gw_frame
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		IF lw_frame.Typeof() <> window! THEN
			lb_frame = false
			Exit		
		END IF
		
		if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		else
			lw_parent = gw_frame
		end if
	end if
else
	return 1
end if

// Create popup menu
if IsNull(lm_view) Or not IsValid (lm_view) then
	lm_view = create m_lvs
	lm_view.of_SetParent (this)
end if

// Set the values of the Arrange Items submenu
If isvalid(inv_sort) then
	li_index = 1
	li_rc = GetColumn (li_index, ls_label, le_align, li_width)
	do while li_rc = 1
		if li_index >=1 and li_index <= 10 then
			lm_view.m_viewitem.m_arrangeicons.item[li_index].text = "by " + ls_label
			lm_view.m_viewitem.m_arrangeicons.item[li_index].microhelp = "Sorts items by " + ls_label
			lm_view.m_viewitem.m_arrangeicons.item[li_index].visible = true
		end if
		li_index++
		li_rc = GetColumn (li_index, ls_label, le_align, li_width)
	loop
else
	lm_view.m_viewitem.m_arrangeicons.enabled = false
end if


// Determine if the Auto Arrange Icons item should be enabled
if this.view = ListViewLargeIcon! or this.view = ListViewSmallIcon! then
	lm_view.m_viewitem.m_arrangeicons.m_autoarrange.enabled = true
	lm_view.m_viewitem.m_arrangeicons.m_autoarrange.checked = this.autoarrange
else
	lm_view.m_viewitem.m_arrangeicons.m_autoarrange.enabled = false
	lm_view.m_viewitem.m_arrangeicons.m_autoarrange.checked = false
end if

li_selected = this.totalselected()
// we have clicked on an item
If li_selected > 0 Then
	lm_view.m_viewitem.m_delete.visible = True
	lm_view.m_viewitem.m_dash15.visible = True
	If li_selected > 1 Then
		lm_view.m_viewitem.m_rename.visible = False
	Else
		If this.editlabels Then
			lm_view.m_viewitem.m_rename.visible = True
		Else
			lm_view.m_viewitem.m_rename.visible = False
		End IF
	End If
Else
	// We are not on an item
	lm_view.m_viewitem.m_delete.visible = False
	lm_view.m_viewitem.m_rename.visible = False
End IF
	
this.event pfc_prermbmenu (lm_view)

lm_view.m_viewitem.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

If IsValid(lm_view) Then Destroy lm_view

return 1

end event


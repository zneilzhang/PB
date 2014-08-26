HA$PBExportHeader$w_message.srw
$PBExportComments$Extension Message Service "MessageBox Window".
forward
global type w_message from pfc_w_message
end type
end forward

global type w_message from pfc_w_message
boolean center = true
end type
global w_message w_message

on w_message.create
call super::create
end on

on w_message.destroy
call super::destroy
end on

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  pfc_w_master
//
//	Description:
//	The ancestor to all PFC window classes
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0   Added MRU and Logical Unit of Work service code
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

Integer li_rc

// Allow for pre and post open events to occur
This.Event pfc_preopen()
This.Post Event pfc_postopen()

// Default window title is application title
If Len (This.title) = 0 Then
	If IsValid (gnv_app.iapp_object) Then
		This.title = gnv_app.iapp_object.DisplayName
	End If
End If

//// Allow preference service to restore settings if necessary
//If IsValid(inv_preference) Then
//	If gnv_app.of_IsRegistryAvailable() Then
//		If Len(gnv_app.of_GetUserKey())> 0 Then 
//			li_rc = inv_preference.of_Restore( &
//				gnv_app.of_GetUserKey()+'\'+this.ClassName()+'\Preferences')
//		ElseIf IsValid(gnv_app.inv_debug) Then				
//			of_MessageBox ("pfc_master_open_preferenceregistrydebug", &
//				"PowerBuilder Foundation Class Library", "The PFC User Preferences service" +&
//				" has been requested but The UserRegistrykey property has not" +&
//				" been Set on The application manager Object.~r~n~r~n" + &
//  				"Call of_SetRegistryUserKey on The Application Manager" +&
//				" to Set The property.", &
//				Exclamation!, OK!, 1)
//		End If
//	Else
//		If Len(gnv_app.of_GetUserIniFile()) > 0 Then
//			li_rc = inv_preference.of_Restore (gnv_app.of_GetUserIniFile(), This.ClassName()+' Preferences')
//		ElseIf IsValid(gnv_app.inv_debug) Then		
//			of_MessageBox ("pfc_master_open_preferenceinidebug", &
//				"PowerBuilder Class Library", "The PFC User Preferences service" +&
//				" has been requested but The UserINIFile property has not" +&
//				" been Set on The application manager Object.~r~n~r~n" + &
//  				"Call of_SetUserIniFile on The Application Manager" +&
//				" to Set The property.", &
//				Exclamation!, OK!, 1)		
//		End If
//	End If
//End If

//// Allow MRU service to restore settings if necessary
//If IsValid(gnv_app.inv_mru) Then
//	this.event pfc_mrurestore()
//End if

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			open
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Open the window with the appropriate information.
//						Call the function to Size and Move controls around to
//						match the window information.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0		Initial version
//	5.0.02	Move Picture Icon to left past the window border.
//	5.0.03	Code formerly in pfc_preopen event
// 5.0.04	Correct Tab Order and added focus to default button.
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

//Integer			li_rc
Integer			li_index
Integer			li_bmp
ListViewItem	llvi_item

//Get the PowerObjectParm.
inv_errorattrib = Message.powerobjectparm

// Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

// Set the titlebar.
This.title = inv_errorattrib.is_title

// Set the Message MLE.
mle_message.Text =  inv_errorattrib.is_text

// As requested, set the Picture Icon.
Choose Case inv_errorattrib.ie_icon
	Case information!
			li_bmp = 1
	Case stopsign!
			li_bmp = 2			
	Case exclamation!
			li_bmp = 3			
	Case question!
			li_bmp = 4
	Case Else
			li_bmp = 0			
End Choose
If li_bmp > 0 Then
	lv_bmp.X = lv_bmp.X - 30
	llvi_item.PictureIndex = li_bmp
	li_Index = lv_bmp.AddItem(llvi_item)
	lv_bmp.SetItem(1, llvi_item)
	llvi_item.ItemX = -100
	llvi_item.ItemY = 5	
Else
	lv_bmp.Visible = False
End If

// As requested, Enable/Disable Print.
cb_print.enabled = inv_errorattrib.ib_print
cb_print.visible = inv_errorattrib.ib_print

// As requested, Enable/Disable User input.
cb_userinput.enabled = inv_errorattrib.ib_userinput
cb_userinput.visible = inv_errorattrib.ib_userinput

// As requested, set the timer.
If inv_errorattrib.ii_timeout > 0 Then 
	// Automatically close this response window after ii_timeout seconds.
	timer(inv_errorattrib.ii_timeout)
End If

// As requested, display/enable the appropriate button(s).
Choose Case inv_errorattrib.ie_buttonstyle
	Case ok!
			//-- An (OK) button has been requested. --
		
			// Set the text attribute(s).
			cb_1.Text = "Aceptar"
			
			// Set the default attribute(s).			
			cb_1.Default = True
			cb_1.SetFocus()
			
			// Make button(s) visible or invisible.
			cb_1.Visible = True
			cb_2.Visible = False
			cb_3.Visible = False
			
	Case okcancel!, yesno!, retrycancel!
			//-- An (OK and Cancel) or (Yes and No) or (Retry and Cancel) --
			//-- buttons have been requested. --
		
			// Set the text attribute(s).
			If inv_errorattrib.ie_buttonstyle = okcancel! Then
				// An OK and Cancel buttons have been requested. 
				cb_1.Text = "Aceptar"
				cb_2.Text = "Cancelar"
			ElseIf inv_errorattrib.ie_buttonstyle = yesno! Then
				// A Yes and No buttons have been requested. 				
				cb_1.Text = "&S$$HEX1$$ed00$$ENDHEX$$"
				cb_2.Text = "&No"				
			Else
				// A Retry and Cancel buttons have been requested. 		
				cb_1.Text = "Reintentar"
				cb_2.Text = "Cancelar"				
			End If
			
			// Set the default attribute(s).						
			If inv_errorattrib.ii_default = 2 Then
				cb_2.default = True
				cb_2.SetFocus()
			Else
				// Default value.
				cb_1.default = True
				cb_1.SetFocus()				
			End If
			
			// Make button(s) visible or invisible.
			cb_1.visible = True
			cb_2.visible = True
			cb_3.Visible = False				

	Case yesnocancel!, abortretryignore!
			//-- A (Yes, No, and Cancel) or (Abort, Retry, and Ignore) --
			//-- buttons have been requested. --
				
			// Set the text attribute(s).			
			If inv_errorattrib.ie_buttonstyle = yesnocancel! Then		
				// A Yes, No, and Cancel buttons have been requested. 						
				cb_1.Text = "&S$$HEX1$$ed00$$ENDHEX$$"
				cb_2.Text = "&No"
				cb_3.Text = "Cancelar"
			Else
				// An Abort, Retry, and Ignore buttons have been requested. 	
				cb_1.Text = "Abortar"
				cb_2.Text = "Reintentar"
				cb_3.Text = "Ignorar"				
			End If
				
			// Set the default attribute(s).							
			If inv_errorattrib.ii_default = 3 Then
				cb_3.default = True
				cb_3.SetFocus()
			ElseIf inv_errorattrib.ii_default = 2 Then
				cb_2.default = True
				cb_2.SetFocus()
			Else
				// Default value.
				cb_1.default = True
				cb_1.SetFocus()
			End If			

			// Make button(s) visible or invisible.
			cb_1.visible = True
			cb_2.visible = True
			cb_3.visible = True
End Choose

// Size and Move controls around to	match the window information.
li_rc = of_PaintInitialWindow()

end event

type gb_userinput from pfc_w_message`gb_userinput within w_message
end type

type mle_userinput from pfc_w_message`mle_userinput within w_message
end type

type st_userinput from pfc_w_message`st_userinput within w_message
string text = "Entrada de Usuario:"
end type

type cb_1 from pfc_w_message`cb_1 within w_message
end type

type cb_2 from pfc_w_message`cb_2 within w_message
end type

type cb_3 from pfc_w_message`cb_3 within w_message
end type

type cb_print from pfc_w_message`cb_print within w_message
string text = "&Imprimir"
end type

type cb_userinput from pfc_w_message`cb_userinput within w_message
string text = "&Entrada >>"
end type

type mle_message from pfc_w_message`mle_message within w_message
end type

type lv_bmp from pfc_w_message`lv_bmp within w_message
string largepicturename[] = {"ico\information.bmp","ico\error.bmp","ico\exclamation.bmp","ico\information.bmp"}
end type


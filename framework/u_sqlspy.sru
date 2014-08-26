HA$PBExportHeader$u_sqlspy.sru
forward
global type u_sqlspy from u_base
end type
type cb_clear from u_cb within u_sqlspy
end type
type mle_history from u_mle within u_sqlspy
end type
type cbx_batchmode from u_cbx within u_sqlspy
end type
type cb_save from u_cb within u_sqlspy
end type
type cb_print from u_cb within u_sqlspy
end type
type gb_sqlhistory from u_gb within u_sqlspy
end type
type st_history from u_st within u_sqlspy
end type
end forward

global type u_sqlspy from u_base
integer width = 1961
integer height = 1316
cb_clear cb_clear
mle_history mle_history
cbx_batchmode cbx_batchmode
cb_save cb_save
cb_print cb_print
gb_sqlhistory gb_sqlhistory
st_history st_history
end type
global u_sqlspy u_sqlspy

forward prototypes
public function integer of_updatehistory ()
public function integer of_updatebatchmode ()
end prototypes

public function integer of_updatehistory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_updatehistory
//
//	Access:  		public
//
//	Arguments:		<None>
//
//	Returns:  		integer
//						Returns 1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//						
//	Description:  	Determine what the current history should be and set it 
//						visually on this window.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Prevent flickering
mle_history.SetRedraw(False)

//Get the current History from the SQLspy service.
mle_history.text = gnv_app.inv_debug.inv_sqlspy.of_GetHistory()

//Scroll to the bottom
mle_history.Scroll (999999) 

mle_history.SetRedraw(True)

Return 1

end function

public function integer of_updatebatchmode ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_updatebatchmode
//
//	Access:  		public
//
//	Arguments:		<None>
//
//	Returns:  		integer
//						Returns 1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//						
//	Description:  	Determine what the BatchMode should be and set it visually
//						on this window.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

boolean lb_inspecteachSQL

//Get the current BatchMode from the SQLspy service.
lb_inspecteachSQL = Not gnv_app.inv_debug.inv_sqlspy.of_GetBatchmode()

//If it doesn't match the visual setting, update it.
If lb_inspecteachSQL <> cbx_batchmode.Checked Then
	cbx_batchmode.Checked = lb_inspecteachSQL
End If

Return 1

end function

on u_sqlspy.create
int iCurrent
call super::create
this.cb_clear=create cb_clear
this.mle_history=create mle_history
this.cbx_batchmode=create cbx_batchmode
this.cb_save=create cb_save
this.cb_print=create cb_print
this.gb_sqlhistory=create gb_sqlhistory
this.st_history=create st_history
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clear
this.Control[iCurrent+2]=this.mle_history
this.Control[iCurrent+3]=this.cbx_batchmode
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.gb_sqlhistory
this.Control[iCurrent+7]=this.st_history
end on

on u_sqlspy.destroy
call super::destroy
destroy(this.cb_clear)
destroy(this.mle_history)
destroy(this.cbx_batchmode)
destroy(this.cb_save)
destroy(this.cb_print)
destroy(this.gb_sqlhistory)
destroy(this.st_history)
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_preopen
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Handle processing that occurs before the open event.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Added code to appropriately force or not force this window to always
//		be on top.
//	6.0	Added groupbox, close and help buttons.  Adjust minimum size & resize 
//		of window to accomodate controls.  Made st_history not visible.  
//		Removed all code relating to st_history.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


//Determine what controls should be visible/enabled
If Not gnv_app.inv_debug.inv_sqlspy.of_GetAllowInspect() Then
	//Hide all controls that relate to the default functionality.
	cbx_batchmode.Visible = False
	
	//Move the History controls to fill up the entire window.
	//The window's resize event will then take take of resizing them correctly.
	gb_sqlhistory.Move (gb_sqlhistory.X, gb_sqlhistory.Y - 100)
	gb_sqlhistory.Resize (gb_sqlhistory.Width, gb_sqlhistory.Height + 100)
	mle_history.Move (mle_history.X, mle_history.Y - 100)
	mle_history.Resize (mle_history.Width, mle_history.Height + 100)
Else
	//Syncronize the visual BatchMode checkbox.
	of_updatebatchmode()
End If

//Get the current history
of_updatehistory()

//Start the resize service
of_SetResize(True)

//Set the minimum size of the window
inv_resize.of_SetMinSize( cbx_batchmode.X + cb_clear.Width *3 + 145, &
								  mle_history.Y + cb_clear.Height *3 + 90)
	
//Register each control that needs to move or resize after the window resizes
inv_resize.of_Register (cb_clear, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register (cb_save, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register (cb_print, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register (gb_sqlhistory, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register (mle_history, inv_resize.SCALERIGHTBOTTOM)



end event

type cb_clear from u_cb within u_sqlspy
integer x = 722
integer y = 1144
integer width = 375
integer taborder = 20
string text = "&Borrar"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	(Arguments:	<None>)
//
//	(Returns:  <None>)
//
//	Description:	Notify the service the user has elected to clear all the 
//						visual history. 
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Notify the servie to clear the history
gnv_app.inv_debug.inv_sqlspy.of_ClearHistory ()

end event

type mle_history from u_mle within u_sqlspy
integer x = 69
integer y = 212
integer width = 1806
integer height = 904
integer taborder = 20
boolean vscrollbar = true
boolean displayonly = true
end type

type cbx_batchmode from u_cbx within u_sqlspy
integer x = 73
integer y = 36
integer width = 1856
integer height = 68
integer taborder = 10
string text = "&Inspecciona cada sentencia SQL antes de que se ejecute"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked
//
//	(Arguments:
//	<None>)
//
//	(Returns:  <data type>
//	<description of possible return values>)
//
//	Description:  Notify the service the current status of the BatchMode
//						checkbox
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

gnv_app.inv_debug.inv_sqlspy.of_SetBatchMode (not this.Checked)

end event

type cb_save from u_cb within u_sqlspy
integer x = 1111
integer y = 1144
integer width = 375
integer taborder = 10
string text = "&Guardar"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:	Notify the servie the user wants to save the current history.
//						Service opens the GetFileSaveName dialog window, gets a 
//						filename, and allows for the saving of the SQL history to 
//						the file.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Notify the service to Save the history to a file
gnv_app.inv_debug.inv_sqlspy.of_SaveHistoryToFile ()

end event

type cb_print from u_cb within u_sqlspy
integer x = 1499
integer y = 1144
integer width = 375
integer taborder = 10
string text = "Im&primir"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  Clicked!
//
//	(Arguments: None)
//
//	(Returns:  None)
//
//	Description:	Prints the SQL history.
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
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

//Notify the service to Print the history
gnv_app.inv_debug.inv_sqlspy.of_PrintHistory ()

end event

type gb_sqlhistory from u_gb within u_sqlspy
integer x = 14
integer y = 136
integer width = 1920
integer height = 1140
integer taborder = 20
string text = "Historial en SQL"
end type

type st_history from u_st within u_sqlspy
boolean visible = false
integer x = 23
integer y = 136
integer width = 343
boolean bringtotop = true
string text = "st_history"
end type


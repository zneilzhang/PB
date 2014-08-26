HA$PBExportHeader$u_debuglog.sru
forward
global type u_debuglog from u_base
end type
type dw_debuglog from u_dw within u_debuglog
end type
type cb_print from u_cb within u_debuglog
end type
type cb_clear from u_cb within u_debuglog
end type
end forward

global type u_debuglog from u_base
integer width = 2843
integer height = 608
dw_debuglog dw_debuglog
cb_print cb_print
cb_clear cb_clear
end type
global u_debuglog u_debuglog

type variables
Protected:
integer	ii_initcolwidth	//Initial column width
integer	ii_initdwwidth	//Initial datawindow widht

end variables

forward prototypes
public function integer of_dwsetredraw (boolean ab_switch)
public function integer of_dwscrolltorow (long al_row)
end prototypes

public function integer of_dwsetredraw (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_DwSetRedraw
//
//	Access:  		public
//
//	Arguments:		
//	ab_switch		Switch to turn Redraw True or False.
//
//	Returns:  		Integer
//						Returns 1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//						If argument is NULL, function returns NULL.
//
//	Description:  	Set Redraw on dw_debuglog as requested.
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

Return dw_debuglog.SetRedraw(ab_switch)
end function

public function integer of_dwscrolltorow (long al_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_DwScrollToRow
//
//	Access:  		public
//
//	Arguments:		
//	al_row			Row to scroll to.
//
//	Returns:  		Integer
//						Returns 1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Scroll dw_debuglog to the requested row.
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

Return dw_debuglog.ScrollToRow(al_row)
end function

on u_debuglog.create
int iCurrent
call super::create
this.dw_debuglog=create dw_debuglog
this.cb_print=create cb_print
this.cb_clear=create cb_clear
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_debuglog
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.cb_clear
end on

on u_debuglog.destroy
call super::destroy
destroy(this.dw_debuglog)
destroy(this.cb_print)
destroy(this.cb_clear)
end on

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:	pfc_w_debuglog
//
//	Description:	A utility object used to display messages that are embedded
//						into an applicaiotn by the developer.
//						Use the n_cst_debug service to call this object.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Added code to appropriately force or not force this window to always
//		be on top.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc

//Start the resize service
of_SetResize(True)

//Set the minimum size of the window on the resize service
inv_resize.of_SetMinSize( 1500, (cb_clear.Height + 30) * 3)
	
//Register each control that needs to move or resize after the window resizes
inv_resize.of_Register (cb_print, inv_resize.FIXEDRIGHT)
inv_resize.of_Register (cb_clear, inv_resize.FIXEDRIGHT)
inv_resize.of_Register (dw_debuglog, inv_resize.SCALERIGHTBOTTOM)

//Save off the initial widths of the datawindow and message column as
//they will be needed later.
ii_initcolwidth = integer(dw_debuglog.object.msg.width)
ii_initdwwidth = dw_debuglog.Width

// Make sure that PFC does not report updates pending for this window.
dw_debuglog.of_SetUpdateable(false)

// The information displayed is kept on the Debug service.
li_rc = gnv_app.inv_debug.ids_debuglog.ShareData (dw_debuglog)
If li_rc <> 1 Then
	of_MessageBox ("pfc_debuglog_failedsharedata", "Biblioteca PowerBuilder Classes", &
		"Se ha recibido un c$$HEX1$$f300$$ENDHEX$$digo de error ShareData() en evento Open de pfc_w_debuglog.  "+ &
		"No es posible procesar la funcionalidad de ShareData().", &
		Information!, OK!, 1)
End If

end event

type dw_debuglog from u_dw within u_debuglog
integer x = 18
integer y = 20
integer width = 2400
integer height = 564
integer taborder = 10
string dataobject = "d_debuglog"
end type

event constructor;call super::constructor;ib_rmbmenu = false
end event

type cb_print from u_cb within u_debuglog
integer x = 2464
integer y = 24
integer taborder = 10
string text = "Im&primir"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		Clicked	
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Print the contents of the datawindow.
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

gnv_app.inv_debug.of_PrintLog()

end event

type cb_clear from u_cb within u_debuglog
integer x = 2464
integer y = 136
integer taborder = 10
string text = "&Borrar"
end type

event clicked;call u_cb::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		Clicked	
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:	Clear the contents of the datawindow.
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

gnv_app.inv_debug.of_ClearLog()

end event


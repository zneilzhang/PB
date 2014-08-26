HA$PBExportHeader$n_cst_debug.sru
$PBExportComments$Extension Debug service
forward
global type n_cst_debug from pfc_n_cst_debug
end type
end forward

global type n_cst_debug from pfc_n_cst_debug
end type
global n_cst_debug n_cst_debug

forward prototypes
public function integer of_openlog (boolean ab_switch)
public function integer of_message (string as_message)
end prototypes

public function integer of_openlog (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_OpenLog
//
//	Access:  		public
//
//	ab_switch	True to open DebugLog window.
//					False to close DebugLog window.
//
//	Returns:  	integer
//					Return value of Open or Close PowerBuilder call.
//					0 if no action to open or close the window is taken.
//					If any argument's value is NULL, function returns -1.
//
//	Description:	Open or Close the DebugLog window.
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
u_base luo_debulog

//Check arguments
If IsNull(ab_switch) Then
	Return -1
End If

luo_debulog = gw_frame.of_getdockobject( "u_debuglog")

//uo_PowerDock.TOP = 1
//uo_PowerDock.BOTTOM = 2
//uo_PowerDock.LEFT = 3
//uo_PowerDock.RIGHT = 4
If ab_switch Then
	IF NOT isValid(gw_frame.uo_powerdock) THEN RETURN -1
	gw_frame.event ue_anclar(TRUE, "u_debuglog", "Depuraci$$HEX1$$f300$$ENDHEX$$n",'debug!', 2)
	gw_frame.uo_PowerDock.of_SetDockSize(gw_frame.uo_PowerDock.BOTTOM, 1000)
	Return 1
Else
	If IsValid(luo_debulog) Then
		gw_frame.event ue_anclar(FALSE, "u_debuglog", "",'', 0)
		Return 1
	End If
End If

Return 0



end function

public function integer of_message (string as_message);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Message
//
//	Access:  		public
//
//	Arguments:
//	as_message		Message to be displayed
//
//	Returns:  		Integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs. 
//
//	Description: 	Enters a new entry into the Debug Log.
//						If visible portion of the service is available, 
//						scroll it to the newly added row.
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

long 		ll_row
boolean	lb_visible=False
u_base	luo_debulog
//Determine if the Visible portion of the service is "open".
luo_debulog = gw_frame.of_getdockobject( "u_debuglog")
IF NOT isValid(luo_debulog) THEN RETURN -1

lb_visible = IsValid(luo_debulog)

//Prevent flickering
If lb_visible Then luo_debulog.dynamic of_DwSetRedraw(False)

//Add the new row
ll_row = ids_debuglog.InsertRow(0)
If ll_row > 0 Then
	ids_debuglog.Object.msg [ll_row] = as_message

	//Syncronize the Visible portion of the service.
	If lb_visible Then 

		luo_debulog.dynamic of_DwScrollToRow(ll_row)
	END IF
End If
	
If lb_visible Then luo_debulog.dynamic of_DwSetRedraw(True)

If ll_row > 0 Then
	Return 1
End If

Return -1
end function

on n_cst_debug.create
call super::create
end on

on n_cst_debug.destroy
call super::destroy
end on


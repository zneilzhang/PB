HA$PBExportHeader$n_cst_sqlspy.sru
$PBExportComments$Extension SQL Spy service
forward
global type n_cst_sqlspy from pfc_n_cst_sqlspy
end type
end forward

global type n_cst_sqlspy from pfc_n_cst_sqlspy
end type
global n_cst_sqlspy n_cst_sqlspy

type variables
u_sqlspy iuo_sqlspy
end variables

forward prototypes
public function integer of_opensqlspy (boolean ab_switch)
protected function integer of_addtohistory (string as_heading, string as_syntax)
public function integer of_clearhistory ()
public function boolean of_isopen ()
public function integer of_setbatchmode (boolean ab_batchmode)
end prototypes

public function integer of_opensqlspy (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_OpenSQLSpy
//
//	Access:  	public
//
//	Arguments:
//	ab_switch	True to open SQLSpy window.
//					False to close SQLSpy window.
//
//	Returns:  	integer
//					Return value of Open or Close PowerBuilder call.
//					0 if no action to open or close a window is taken.
//					If any argument's value is NULL, function returns -1.
//					
//
//	Description:	Open or Close the SQLSpy window.
//						If opening the SQLSpy window then immediately update
//						the current history on the SQLSpy window.
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

integer li_rc
u_base luo_sqlspy

//Check arguments
If IsNull(ab_switch) Then
	Return -1
End If

luo_sqlspy = gw_frame.of_getdockobject( "u_sqlspy")

If ab_switch Then
	IF NOT isValid(gw_frame.uo_powerdock) THEN RETURN -1
	gw_frame.event ue_anclar(TRUE, "u_sqlspy", "SQL spy",'sql!', 4)
	gw_frame.uo_PowerDock.of_SetDockSize(gw_frame.uo_PowerDock.RIGHT, 1500)
	iuo_sqlspy = gw_frame.of_getdockobject( "u_sqlspy")
	Return 1
Else
	If IsValid(luo_sqlspy) Then
		gw_frame.event ue_anclar(FALSE, "u_sqlspy", "",'', 0)
		setnull(iuo_sqlspy)
	End If
End If

Return 0

end function

protected function integer of_addtohistory (string as_heading, string as_syntax);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_AddToHistory
//
//	Access:  		protected
//
//	Arguments:
//	as_heading		The header information to be added.
//	as_syntax		The detail information to be added.
//
//	Returns:  		integer
//						1 if it succeeds.
//						-1 if an error occurs.
//						If any argument's value is NULL, function returns NULL.
//
//	Description:  	Add a history entry into the RichTextControl.
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

string	ls_newentry
string	ls_spacing
long		ll_rc
datetime ldm_current

//Check parameters
If IsNull(as_heading) or IsNull(as_syntax) Then
	integer li_null
	SetNull (li_null)
	Return li_null
End If

//Add a datetime stamp to the heading
ldm_current = DateTime( Today(), Now())
as_heading = as_heading + '    Indicador de fecha-hora: ' + string(ldm_current,'dd/mm/yy hh:mm:ss:ff')

//Make the heading a comment
as_heading = '/*** ' + as_heading + ' ***/'

//Determine the needed spacing 
If Len(is_history) > 0 Then
	ls_spacing = '~r~n~r~n'
End If

//Determine what information was passed to function
//  Header and Detail, Header only, or Detail only
If Len(as_heading) > 0 and Len(as_syntax) > 0 Then
	ls_newentry =	ls_spacing + as_heading + '~r~n' + as_syntax
ElseIf Len(as_heading) > 0 Then
	ls_newentry =	ls_spacing + as_heading 
Else
	ls_newentry =	ls_spacing + as_syntax
End If

//Update the history string
is_history = is_history + ls_newentry

//Depending on operating system - prevent the history string from
//getting too long
is_history = of_PreventHistoryOverflow (is_history, ls_newentry)

//If available, Notify visual to update the current history.
If IsValid(iuo_sqlspy) Then
	ll_rc = iuo_sqlspy.of_UpdateHistory()
End If 

//If available, update the log file
of_AddToLogfile(ls_newentry)

Return 1

end function

public function integer of_clearhistory ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_AddToHistory
//
//	Access:  		public
//
//	Arguments:		<None>
//
//	Returns:  		integer
//						1 if it succeeds.
//						-1 if an error occurs.
//
//	Description:  	Clear the visual history.
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

integer li_rc =1

//Update the history string
is_history = ''

//If available, Notify that the history has changed.
If IsValid(iuo_sqlspy) Then
	li_rc = iuo_sqlspy.of_UpdateHistory()
End If 

Return li_rc

end function

public function boolean of_isopen ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_IsOpen
//
//	Access:  		public
//
//	Returns:  	boolean
//					True if the SQLSpy window is currently opened.
//					False otherwise.
//
//	Description:	Reports if the SQLSpy window is currently opened.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Return IsValid(iuo_sqlspy)

end function

public function integer of_setbatchmode (boolean ab_batchmode);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetBatchmode
//
//	Access:  		public
//
//	Arguments:
//	ab_batchmode   Mode of the service.
//
//	Returns:  		integer
//						Returns 1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//						
//	Description:  	Sets the mode of the SQLSpy service.
//						Notifies the visual part of SQLSpy for it to correctly
//						reflect the appropriate mode.
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

If IsNull(ab_batchmode) Then
	Return -1
End If

//Set the BatchMode
ib_batchmode = ab_batchmode

// Make sure the Visual part of SQLSpy reflects the BatchMode
If IsValid(iuo_sqlspy) Then
	iuo_sqlspy.of_UpdateBatchMode()
End If

Return 1

end function

on n_cst_sqlspy.create
call super::create
end on

on n_cst_sqlspy.destroy
call super::destroy
end on


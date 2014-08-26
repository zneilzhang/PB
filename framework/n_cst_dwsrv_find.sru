HA$PBExportHeader$n_cst_dwsrv_find.sru
$PBExportComments$Extension DataWindow Find/Replace service
forward
global type n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
end type
end forward

global type n_cst_dwsrv_find from pfc_n_cst_dwsrv_find
event pfc_finddlg_response ( )
end type
global n_cst_dwsrv_find n_cst_dwsrv_find

forward prototypes
protected function integer of_findstartandendrows (ref long al_startrow, ref long al_endrow)
end prototypes

event pfc_finddlg_response();//////////////////////////////////////////////////////////////////////////////
// ADECUADO LAC
//	- Adecuaci$$HEX1$$f300$$ENDHEX$$n para que ponga la columna actual seleccionada por default en el w_find
//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_finddlg_response
//
//	(Arguments:		None)
//
//	(Returns:  		None)
//
//	Description:  	Begin a search based on current settings
//						of the nvo-structure inv_findattrib with the find dialog. 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Close existing Dialog window prior to displaying the new Dlg window.
// 6.0	Enhanced with pfc_prefinddlg capabilities.
// 6.0	Ehnanced to use new Allow Dialog attribute.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc

//Make sure is allowed to open dialog.
If Not of_IsAllowFindDlg() Then Return

//Validate required reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then Return

//Close existing Dialog window prior to displaying the new Dlg window.
If IsValid(w_replace) Then Close(w_replace)
If IsValid(w_find) Then Close(w_find)
If IsValid(w_find_response) Then Close(w_find_response)

//Set this object as the requestor.
inv_findattrib.ipo_requestor = this

//Look Options are required for Column Searches.
inv_findattrib.ib_lookvisible = True
inv_findattrib.ib_lookenabled = True

//Whole word capabilities are not supported on column searches.
inv_findattrib.ib_wholewordvisible =False
inv_findattrib.ib_wholewordenabled =False
inv_findattrib.ib_wholeword = False

//Build the Column List for the Find operation.
//The Find list is build everytime to catch for possible manipulation of the
//columns.  i.e., columns changing between visible and not visible.
li_rc = of_BuildColumnNames (False)

inv_findattrib.idw_requestor = idw_requestor

//Pfc_prefinddlg capabilities.
idw_requestor.Event pfc_prefinddlg(inv_findattrib)

//Open find window.
OpenWithParm(w_find_response, inv_findattrib)
end event

protected function integer of_findstartandendrows (ref long al_startrow, ref long al_endrow);//////////////////////////////////////////////////////////////////////////////
//
//	Function: 		of_FindStartAndEndRows
//
//	Access:  		protected
//
//	Arguments: 		
//	al_startrow		The row the find should start looking in. (by Reference)
//	al_endrow		The row the find will stop looking in.	(by Reference)
//
//	Returns:  		Integer
//						1 if it succeeds and$$HEX1$$a000$$ENDHEX$$-1 if an error occurs.
//						0 if the point of no more searches has been reached.
//
//	Description:  	Determine what the Starting row and the Ending row should
//						be for the Find statement.
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

//Validate the direction attribute.
If Lower(inv_findattrib.is_direction) <> "arriba" And &
	Lower(inv_findattrib.is_direction) <> "abajo" Then
	inv_findattrib.is_direction = "Abajo"
End If

//Check required.
If IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then
	Return -1
end If

//Get the current row.
al_startrow = idw_requestor.GetRow()

//Determine the start and end rows for the find.
CHOOSE CASE Lower(inv_findattrib.is_direction)
	CASE "arriba"
		al_endrow = 1
		If ib_ongoingfind Then 
			//For ongoing finds do not search on the current row.
			If al_startrow - 1 >= al_endrow Then
				al_startrow --
			Else
				Return 0
			End If
		End If
	CASE Else 
		// "down"
		al_endrow = idw_requestor.RowCount()		
		If ib_ongoingfind Then		
			//For ongoing finds do not search on the current row.			
			If al_startrow + 1 <= al_endrow Then
				al_startrow ++
			Else
				Return 0
			End If
		End If
END CHOOSE

Return 1
end function

on n_cst_dwsrv_find.create
call super::create
end on

on n_cst_dwsrv_find.destroy
call super::destroy
end on

event pfc_finddlg();//////////////////////////////////////////////////////////////////////////////
//	OJO! OVERRIDE
// ADECUADO LAC
//	- Adecuaci$$HEX1$$f300$$ENDHEX$$n para que ponga la columna actual seleccionada por default en el w_find
//////////////////////////////////////////////////////////////////////////////
//	Event:				pfc_finddlg
//	Arguments:			None
//	Returns:  			None
//	Description:			Begin a search based on current settings
//							of the nvo-structure inv_findattrib with the find dialog. 
//////////////////////////////////////////////////////////////////////////////
//	Rev. History			Version
//							5.0			Initial version
// 							5.0.02		Close existing Dialog window prior to displaying the new Dlg window.
// 							6.0			Enhanced with pfc_prefinddlg capabilities.
// 							6.0			Enhanced to use new Allow Dialog attribute.
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer li_rc

//Make sure is allowed to open dialog.
If Not of_IsAllowFindDlg() Then Return

//Validate required reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then Return

//Close existing Dialog window prior to displaying the new Dlg window.
If IsValid(w_replace) Then Close(w_replace)
If IsValid(w_find) Then Close(w_find)

//Set this object as the requestor.
inv_findattrib.ipo_requestor = this

//Look Options are required for Column Searches.
inv_findattrib.ib_lookvisible = True
inv_findattrib.ib_lookenabled = True

//Whole word capabilities are not supported on column searches.
inv_findattrib.ib_wholewordvisible =False
inv_findattrib.ib_wholewordenabled =False
inv_findattrib.ib_wholeword = False

//Build the Column List for the Find operation.
//The Find list is build everytime to catch for possible manipulation of the
//columns.  i.e., columns changing between visible and not visible.
li_rc = of_BuildColumnNames (False)

inv_findattrib.idw_requestor = idw_requestor
//Pfc_prefinddlg capabilities.
idw_requestor.Event pfc_prefinddlg(inv_findattrib)

//Open find window.
OpenWithParm(w_find, inv_findattrib)
end event


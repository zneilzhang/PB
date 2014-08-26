HA$PBExportHeader$n_cst_dwsrv_linkage.sru
$PBExportComments$Extension DataWindow Linkage service
forward
global type n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
end type
end forward

global type n_cst_dwsrv_linkage from pfc_n_cst_dwsrv_linkage
string is_displayunits = "filas"
string is_displayitem = "este fila"
end type
global n_cst_dwsrv_linkage n_cst_dwsrv_linkage

forward prototypes
public function integer of_deleterows (boolean ab_delete, string as_masterkeys[], string as_mastervalues[])
public function integer of_setkeyvalues (long al_row)
protected function integer of_save (long al_validaterow, boolean ab_prompt)
end prototypes

public function integer of_deleterows (boolean ab_delete, string as_masterkeys[], string as_mastervalues[]);//////////////////////////////////////////////////////////////////////////////
// ADECUADO POR LAC:
//	04/MAY/04 : Para que no marque error al borrar en un linkage con un crosstab
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_DeleteRows
//
//	Access:    		public
//
//	Arguments:
//	  ab_delete				Switch which determines if Deletes or Discard operations
//								will be performed.
//   as_masterkeys[]		Column Names from the master row that was deleted.
//	  as_mastervalues[]	Column Values from the master row that was deleted.
//
//	Returns:   		Integer
// 					The number of rows deleted/discarded.
//						-1 if an error occurs.
//
//	Description: 
// Delete the rows that match the master row information.
//	These passed in arrays contain all the relevant information about the
//	master row that was deleted. 	The master dw knows which columns
//	are key values for all its detail datawindows, but it does not know
//	which go with which detail.  So it just passes all the information
//	and lets the detail datawindow figure out which values it needs.
//
//	Note:
// This function is not typically called by the developer.  
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
Integer	li_i
Integer	li_x
Integer	li_upperbound
integer	li_masterupperbound
integer	li_rc
long		ll_deletecount
String	ls_find
Long		ll_row
Long		ll_toprow
boolean	lb_keyfound
string	ls_filter
string	ls_expression

// Validate the arguments.
li_masterupperbound = UpperBound (as_masterkeys)
if li_masterupperbound <> UpperBound (as_mastervalues) or &
	li_masterupperbound = 0 then
	return FAILURE
end if

// Not a valid operation for a root datawindow. 
If of_IsRoot ( ) Then Return FAILURE

// Create the Find expression to match the rows that need to be deleted.
li_upperbound = UpperBound (inv_linkargs.is_mastercolarg)
For li_i = 1 to li_upperbound
	// Get the column data value from the master row that was deleted.  This is found
	// on the arrays that were passed in.
	lb_keyfound = False
	for li_x = 1 to li_masterupperbound
		If inv_linkargs.is_mastercolarg[li_i] = as_masterkeys[li_x] then
			lb_keyfound = True
			ls_expression = as_mastervalues[li_x]
			Exit
		end if
	next	
	if not lb_keyfound Then
		// Required data not found.
		Return FAILURE
	End If
	
	If IsNull(ls_expression) Then ls_expression = ""
	If Not Len(Trim(ls_expression))=0 Then
		// Construct the Find expression.
		If (ls_find <> "") Then ls_find += " And "
		If Pos(Lower(ls_expression), 'null') > 0 Then
			ls_find += 'IsNull('+ inv_linkargs.is_detailcolarg[li_i]+')'
		Else
			ls_find += inv_linkargs.is_detailcolarg[li_i] + " = " + ls_expression	
		End If
	End If
Next 

// Clear out any filter currently on the dw.
If of_GetStyle() = FILTER Then
	ls_filter = idw_requestor.Object.DataWindow.Table.Filter
	If ls_filter <> '' And ls_filter <> '?' Then
		is_filterexp = ""
		idw_requestor.SetFilter("")
		idw_requestor.Filter()
	End If
End If

// -- Loop around the rows that need to be deleted.
ib_cascadingdelete = True
DO
	//LAC: 04/MAY/04
	if len(idw_Requestor.describe("DataWindow.Crosstab.Rows")) > 1 then
		ll_row = 0
	else
		ll_row = idw_Requestor.Find (ls_find, ll_row, idw_Requestor.RowCount())
	end if
	if ll_row > 0 then
		// Notify that the row is going to be deleted.
		li_rc = this.Trigger Event pfc_predeleterow(ll_row)

		// Delete or Discard the row.
		ib_allowfocuschange = True
		If ab_delete Then
			li_rc = idw_requestor.DeleteRow(ll_row)
		Else
			li_rc = idw_requestor.RowsDiscard(ll_row, ll_row, Primary!)
		End If
		ib_allowfocuschange = False
		If li_rc >0 Then ll_deletecount++
		
		// Continue the Delete opearation.
		li_rc = of_DeleteDetailRows()
		If li_rc >0  Then ll_deletecount += li_rc
		
	end if
LOOP WHILE ll_row > 0
ib_cascadingdelete = False

//If IsValid(gnv_app.inv_debug) then
//	gnv_app.inv_debug.of_Message (idw_requestor.ClassName()+'.Linkage.of_DeleteRows'+&
//		' ls_find('+ls_find+')'+' RowCount='+string(idw_requestor.RowCount()) + &
//		' ll_deletecount='+string(ll_deletecount))
//End If

Return ll_deletecount
end function

public function integer of_setkeyvalues (long al_row);//////////////////////////////////////////////////////////////////////////////
// MODIFICADO POR LAC
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_SetKeyValues
//
//	Access:    		Public
//
//	Arguments: 		
//	 al_row			Row number.
//
//	Returns:   		Integer
//   					1 if it succeeds and -1 if an error occurs.
//
//	Description:  	
//		Gets key column values from the master and sets the value in row.
//
//	   *Note:	This function is not typically called by the developer.  
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Replaced of_GetItem(...) call with of_GetItemAny(...) to get the column
//			data from the master.
// 6.0	Enhanced to use the Status On InsertRow functionality.
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
Integer	li_i
Integer	li_numlinks
String	ls_coldata
Long		ll_currrow
dwItemStatus le_rowstatus

// This operation is not valid for the root datawindow.
If Of_IsRoot() Then Return -1

// Verify that master has started the linkage service.
If IsNull(idw_master.inv_linkage) Or &
	Not IsValid(idw_master.inv_linkage) Then Return -1

// Validate the current row of the master datawindow.
//...adecuado por LAC ya que no devolv$$HEX1$$ed00$$ENDHEX$$a el getrow seleccionado
ll_currrow = idw_master.GetRow()
If ll_currrow <= 0 Then 
	ll_currrow = idw_master.getselectedrow(0)
	if isnull(ll_currrow) or ll_currrow <= 0 Then Return -1
end if

// Loop thru all the link columns.
li_numlinks = UpperBound ( inv_linkargs.is_mastercolarg ) 
For li_i = 1 to li_numlinks

	// Get the column data value from the master.
	ls_coldata =  string( idw_master.inv_Linkage.of_GetItemAny (ll_currrow, &
									inv_linkargs.is_mastercolarg[li_i] ) )
	
	If IsNull(ls_coldata) or Len(Trim(ls_coldata))=0 Then 
		// Skip to the next loop.
		Continue
	Else
		// Set the master key column value in the Detail row.
		If idw_Requestor.inv_Linkage.of_SetItem ( al_row, &
			inv_linkargs.is_detailcolarg[li_i], ls_coldata ) = -1 Then Return -1
	End If

Next 

// Check if the row flag should be marked New!
If ib_statusoninsertrow or of_UpdateOnRowChange() Then
	le_rowstatus = idw_Requestor.GetItemStatus(al_row, 0, Primary!)
	If le_rowstatus = NewModified! Then
		// This will convert NewModified! row to New!.
		idw_requestor.SetItemStatus(al_row, 0, Primary!, NotModified!)
	End If
End If

Return 1
end function

protected function integer of_save (long al_validaterow, boolean ab_prompt);//////////////////////////////////////////////////////////////////////////////
// ADECUADO POR LAC: 24-ABR-08: Traducci$$HEX1$$f300$$ENDHEX$$n
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_Save
//
//	Access:    		protected
//
//	Arguments:
//	 al_validaterow	If >0 then the row to be tested.
//							if <=0 then there is no row to be tested.
//	 ab_prompt	If the user should be prompted.
//
//	Returns:   		Integer
//		3 if the save operation was cancelled for any reason.
//		2 if the user choose to not have an update and loose 
//			any pending changes.
//		1 if the save operation was successful.
//		0 if there are no updates pending.
//		-1 if an error occurs.
//
//	Description: 
//	Perform the save process.
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

//constant	integer	NO_ACTION = 0
constant	integer	NO_UPDATE = 2
constant	integer	CANCEL = 3

Integer 	li_rc
integer 	li_i
integer	li_option
string	ls_msgparm[]
string	ls_option
long		ll_checkrow
integer	li_checkcolumn
string	ls_checkcolname
boolean	lb_updateonly = True
integer	li_upper
integer	li_cnt
w_master	lw_obj
u_dw		ldw_root
powerobject lpo_saveobjects[]

// Validate the arguments.
If IsNull(al_validaterow) or IsNull(ab_prompt) Then
	Return FAILURE
End if

// Validate the required reference.
If IsNull(idw_requestor) or Not IsValid(idw_requestor) Then
	Return FAILURE
End If

// Get the root datawindow.
of_FindRoot(ldw_root) 		
If IsNull(ldw_root) or NOt IsValid(ldw_root) Then 
	Return FAILURE
End If
		
// Get the parent window.		
idw_requestor.Function of_GetParentWindow(lw_obj)
If IsNull(lw_obj) or Not IsValid(lw_obj) Then
	Return FAILURE
End If

// Make sure all data has been accepted.
li_rc = of_AcceptText (True)
If li_rc <=0 Then 
	Return CANCEL
End If

// Determine if there are any updates pending.
li_rc = of_GetUpdatesPending ()
If li_rc <0 Then 
	Return CANCEL
End If

// Check if there are updates pending.
If li_rc = 0 Then 
	Return NO_ACTION
End If

// -- Updates are pending. --

// Determine, if there is a specific row that needs to be validated.
If al_validaterow > 0 Then
	// Check for Missing Required Fields on the row.
	ll_checkrow = al_validaterow
	li_checkcolumn = 1
	li_rc = of_CheckRequired &
			(primary!, ll_checkrow, li_checkcolumn, ls_checkcolname, lb_updateonly)
	if (li_rc < 0) or (ll_checkrow = al_validaterow) Then
		// There was an error or missing data.
		Return CANCEL
	End If

	// Perform dw specific validation.
	li_rc = idw_requestor.Event pfc_RowValidation (al_validaterow) 
	If li_rc <= 0 Then 
		// There was an error validating the data. 
		Return CANCEL
	End If
End If

// Prompt the user about the change?
If ab_prompt Then
	If of_ConfirmOnRowChange() Then
		If IsValid(gnv_app.inv_error) Then
			li_option = gnv_app.inv_error.of_Message('pfc_dwlinkage_rowchanging', ls_msgparm, &
							gnv_app.iapp_object.DisplayName)
		Else
			li_option = of_MessageBox('pfc_linkage_savenow', gnv_app.iapp_object.DisplayName, &
							'Hay cambios pendientes ~r~n$$HEX1$$bf00$$ENDHEX$$Desea grabarlos ahora?', Exclamation!, YesNoCancel!, 1)
		End If
	Else
		li_option = 1
	End If
	
	If li_option = 2 Then 
		// 'No button'  No update wanted, loose all pending updates.
		Return NO_UPDATE
	ElseIf li_option >= 3 Then
		// 'Cancel button' Don't want to save but  keep all pending updates.
		Return CANCEL
	End If
End If
	
// Set the objects to be saved by the Window save process.
lpo_saveobjects[1] = ldw_root

// Add any other objects which have been requested for the save.
li_upper = UpperBound (ipo_othersaveobjects)
For li_cnt = 1 to li_upper
	lpo_saveobjects[li_cnt +1] = ipo_othersaveobjects[li_cnt]
Next

// Save the requested objects.
li_rc = lw_obj.Event pfc_SaveObjects (lpo_saveobjects)
If li_rc < 0 Then
	Return FAILURE
ElseIf li_rc = 0 Then
	Return NO_ACTION
End If

// Successfulsave was performed.
If Len(is_savesound) > 0 Then
	If IsNull(inv_platform) or Not IsValid(inv_platform) Then
		// Start the appropriate platform service.
		f_SetPlatform (inv_platform, True)
	End If
	If IsValid(inv_platform) Then
		inv_platform.of_PlaySound(is_savesound, True)
	End If	
End If

Return SUCCESS
end function

on n_cst_dwsrv_linkage.create
call super::create
end on

on n_cst_dwsrv_linkage.destroy
call super::destroy
end on

event type long pfc_predeleterow(long al_row);/////////////////////////////////////////
// OJO !  SE ESTA BRINCANDO EL ANCESTRO 
/////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			pfc_predeleterow
//
//	Arguments:
//	 al_row: 		A long identifying the row which may be being deleted.
//						If no row is passed in, use the current row.
//
//	Returns:  		Integer
//	 1 if it succeeds and the deleterow should continue.
//	 0 if the delete should be prevented.
//	-1 If an error is encountered.
//
//	Description:  
//	Notification that the row may be deleted.  Depending on the attributes,
//	a cancel of the delete operation is possible through the dialog window.
//
//	Note:
//	This is a Continue or Prevent event.
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
integer	li_i
integer	li_upperbound
string	ls_reset[]
string	ls_msgparm[]
integer 	li_option

// Validate required references.
If IsNull(idw_requestor) Or Not IsValid(idw_requestor) Then 
	Return FAILURE
End If

// If no row is passed in, use the current row.
if IsNull(al_row) or al_row = 0 then
	al_row = idw_requestor.GetRow()
end if

// Reset the key value information.
is_keycolsvalue = ls_reset

// Determine by looking at the linked dws, if current dw requires
//	Updates to occur on RowChange. Do not perform the check if this
// is a cascading delete.
If Not ib_cascadingdelete And of_UpdateOnRowChange() Then 
	If of_ConfirmOnDelete() Then
		If IsValid(gnv_app.inv_error) Then
			li_option = gnv_app.inv_error.of_Message('pfc_dwlinkage_predelete', ls_msgparm, &
							gnv_app.iapp_object.DisplayName)
		Else
			li_option = of_MessageBox('pfc_linkage_deleterow', &
							gnv_app.iapp_object.DisplayName, &
							'$$HEX1$$bf00$$ENDHEX$$Desea borrar el registro?', Exclamation!, OkCancel!, 1)
		End If
		If li_option <> 1 Then
			// Prevent the delete from taking place.
			Return PREVENT_ACTION
		End If
	End If	
End If

// Store key value information about the row which is being considered
// for deletion.
li_upperbound = UpperBound(is_keycols)
for li_i = 1 to li_upperbound
	is_keycolsvalue[li_i] = of_BuildComparison (al_row, is_keycols[li_i] )
Next

If al_row = idw_requestor.RowCount() Then
	// Set the prevent focus change functionality.
	// This will delay the rowfocuschanged until all desired action can be
	// completed.
	ib_preventfocuschanged = True
End If

// Allow delete to take place.
Return CONTINUE_ACTION
end event


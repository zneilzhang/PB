HA$PBExportHeader$n_cst_lvsrv_datasource.sru
$PBExportComments$Extension ListView Datasource service
forward
global type n_cst_lvsrv_datasource from pfc_n_cst_lvsrv_datasource
end type
end forward

global type n_cst_lvsrv_datasource from pfc_n_cst_lvsrv_datasource
end type
global n_cst_lvsrv_datasource n_cst_lvsrv_datasource

forward prototypes
public function integer of_registerreportcolumn (n_ds ads_obj)
end prototypes

public function integer of_registerreportcolumn (n_ds ads_obj);//////////////////////////////////////////////////////////////////////////////
//	Public Function:	of_RegisterReportColumn
//	Arguments:		ads_obj		The datastore which holds the column information to add to the listview
//	Returns:			Integer
//						The number of columns added if successful
//						-1 if an error occurred
//	Description:	Add a column to the ListView control for all visible columns in
//						the Datastore.  They will be displayed in Report View only.
//						This function overloads the of_RegisterReportColumn function to allow 
//						the last 4 arguments to be optional.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						6.0   Initial version
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
Integer	li_NumObj, li_Cnt, li_Cols
string	ls_Columns[], ls_rtn

// Validate required reference.
if IsNull(ads_obj) or not IsValid(ads_obj) then return -1
if IsNull(ads_obj.inv_base) or not IsValid(ads_obj.inv_base) then return -1

// Get all the visible objects in the DataWindow
li_NumObj = ads_obj.inv_base.of_GetObjects(ls_Columns, "*", "*", true)

// Add each column to the ListView
for li_Cnt = 1 to li_NumObj
	// Only add objects that are columns or computed fields
	if ads_obj.Describe(ls_Columns[li_Cnt] + ".Type") = "column" or &
		ads_obj.Describe(ls_Columns[li_Cnt] + ".Type") = "compute" then

		ls_rtn = ads_obj.Describe(ls_Columns[li_Cnt] + ".visible")
		
		li_Cols++
		if of_RegisterReportColumn(ads_obj, ls_Columns[li_Cnt]) < 0 then return -1
	end if
Next

return li_Cols
end function

on n_cst_lvsrv_datasource.create
call super::create
end on

on n_cst_lvsrv_datasource.destroy
call super::destroy
end on


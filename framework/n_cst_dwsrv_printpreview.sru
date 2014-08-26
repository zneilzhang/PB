HA$PBExportHeader$n_cst_dwsrv_printpreview.sru
$PBExportComments$Extension DataWindow  PrintPreview service
forward
global type n_cst_dwsrv_printpreview from pfc_n_cst_dwsrv_printpreview
end type
end forward

global type n_cst_dwsrv_printpreview from pfc_n_cst_dwsrv_printpreview
end type
global n_cst_dwsrv_printpreview n_cst_dwsrv_printpreview

forward prototypes
public function integer of_getzoom ()
public function integer of_setzoom (integer ai_zoom)
end prototypes

public function integer of_getzoom ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetZoom
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 the current zoom level
//	-1 = error
//
//	Description:  Returns the current zoom factor
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

string		ls_rc
integer	li_rc = -1

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

ls_rc = idw_requestor.object.datawindow.zoom
if IsNumber (ls_rc) then
	li_rc = Integer (ls_rc)
end if
return li_rc
end function

public function integer of_setzoom (integer ai_zoom);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetZoom
//
//	Access:  public
//
//	Arguments:
//	ai_zoom   Zoom level
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Sets the zoom level of print preview
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

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

if IsNull(ai_zoom) then 
	return -1
end if

//LAC: Adecuado para que aplique para todas las dw's
if of_getenabled() then
	idw_requestor.object.datawindow.print.preview.zoom = ai_zoom
else
	idw_requestor.object.datawindow.zoom = ai_zoom
end if
return 1
end function

on n_cst_dwsrv_printpreview.create
call super::create
end on

on n_cst_dwsrv_printpreview.destroy
call super::destroy
end on


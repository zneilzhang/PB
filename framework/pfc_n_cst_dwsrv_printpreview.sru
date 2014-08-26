HA$PBExportHeader$pfc_n_cst_dwsrv_printpreview.sru
$PBExportComments$PFC DataWindow PrintPreview service
forward
global type pfc_n_cst_dwsrv_printpreview from n_cst_dwsrv
end type
end forward

global type pfc_n_cst_dwsrv_printpreview from n_cst_dwsrv
end type
global pfc_n_cst_dwsrv_printpreview pfc_n_cst_dwsrv_printpreview

forward prototypes
public function integer of_page ()
public function integer of_pagecount ()
public function integer of_pageacross ()
public function integer of_pagecountacross ()
public function integer of_firstpage ()
public function integer of_lastpage ()
public function boolean of_getenabled ()
public function integer of_setenabled (boolean ab_enabled)
public function integer of_setzoom (integer ai_zoom)
public function integer of_getzoom ()
public function boolean of_getruler ()
public function integer of_setruler (boolean ab_display)
public function integer of_setzoom ()
public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib)
public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib)
end prototypes

public function integer of_page ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_Page
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	the current page
//	-1 = error
//
//	Description:  Returns the number of the current page
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
string	ls_rc

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

ls_rc = idw_requestor.Describe ("evaluate ('Page()', 1)")
if IsNumber (ls_rc) then
 	return Integer (ls_rc)
end if

return -1
end function

public function integer of_pagecount ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PageCount
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	total number of pages
//	-1 = error
//
//	Description:  Returns the total number of pages
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
string	ls_rc

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

ls_rc = idw_requestor.Describe ("evaluate ('PageCount()', 1)")
if IsNumber (ls_rc) then
 	return Integer (ls_rc)
end if

return -1
end function

public function integer of_pageacross ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PageAcross
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	the number of the current horizontal page
//	-1 = error
//
//	Description:  Returns the number of the current horizontal page
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
string	ls_rc

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

ls_rc = idw_requestor.Describe ("evaluate ('PageAcross()', 1)")
if IsNumber (ls_rc) then
 	return Integer (ls_rc)
end if

return -1

end function

public function integer of_pagecountacross ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_PageCountAcross
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	total number of horizontal pages
//	-1 = error
//
//	Description:  Returns the total number of horizontal pages
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
string	ls_rc

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

ls_rc = idw_requestor.Describe ("evaluate ('PageCountAcross()', 1)")
if IsNumber (ls_rc) then
 	return Integer (ls_rc)
end if

return -1

end function

public function integer of_firstpage ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_FirstPage
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Scrolls to the first page
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

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

return idw_requestor.ScrollToRow (0)
end function

public function integer of_lastpage ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_LastPage
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 ending page number that was scrolled to
//	-1 = error
//
//	Description:  Scrolls to the last page
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

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

return idw_requestor.ScrollToRow (2147483647)
end function

public function boolean of_getenabled ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetEnabled
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  boolean
//	true = printpreview is currently enabled (DW is in preview mode)
//	false = printpreview is not currently enabled
//	NULL = error
//
//	Description:  Gets whether printpreview is currently enabled
//	(DW is in preview mode)
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

boolean	lb_rc
string		ls_printpreview
n_cst_conversion	lnv_conversion

//////////////////////////////////////////////////////////////////////////////
// Check for valid requestor
//////////////////////////////////////////////////////////////////////////////
if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	SetNull (lb_rc)
	return lb_rc
end if

//////////////////////////////////////////////////////////////////////////////
// Get printpreview mode
//////////////////////////////////////////////////////////////////////////////
ls_printpreview = idw_requestor.object.datawindow.print.preview
if ls_printpreview = "?" then
	SetNull (lb_rc)
	return lb_rc
end if

return lnv_conversion.of_Boolean (ls_printpreview)

end function

public function integer of_setenabled (boolean ab_enabled);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetEnabled
//
//	Access:  public
//
//	Arguments:  ab_enabled
//	true = display DW in printpreview mode
//	false = Do not display in printpreview mode
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Sets whether printpreview mode is currently enabled
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0.01 Prevent error condition when datawindow is nested.
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

// Check for valid requestor
if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

// Check argument
if IsNull(ab_enabled) then
	return -1
end if

// Prevent error condition when datawindow is nested.
If Lower(idw_requestor.Describe("DataWindow.Nested")) = 'yes' Then
	Return -1
End If

// Set printpreview mode
idw_requestor.object.datawindow.print.preview = ab_enabled
return 1

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

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

if IsNull(ai_zoom) then 
	return -1
end if

idw_requestor.object.datawindow.print.preview.zoom = ai_zoom
return 1
end function

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

string		ls_rc
integer	li_rc = -1

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

ls_rc = idw_requestor.object.datawindow.print.preview.zoom
if IsNumber (ls_rc) then
	li_rc = Integer (ls_rc)
end if
return li_rc
end function

public function boolean of_getruler ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetRuler
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  boolean
//	true = rulers are currently being displayed
//	false = rulers are not being displayed
//	NULL = error
//
//	Description:  Gets whether rulers are currently being displayed
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

boolean	lb_rc
string		ls_rulers
n_cst_conversion	lnv_conversion

//////////////////////////////////////////////////////////////////////////////
// Check for valid requestor
//////////////////////////////////////////////////////////////////////////////
if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	SetNull (lb_rc)
	return lb_rc
end if

//////////////////////////////////////////////////////////////////////////////
// Get ruler display
//////////////////////////////////////////////////////////////////////////////
ls_rulers = idw_requestor.object.datawindow.print.preview.rulers
if ls_rulers = "?" then
	SetNull (lb_rc)
	return lb_rc
end if

return lnv_conversion.of_Boolean (ls_rulers)

end function

public function integer of_setruler (boolean ab_display);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRuler
//
//	Access:  public
//
//	Arguments:  ab_display
//	true = display rulers
//	false = Do not display rulers
//
//	Returns:  integer
//	 1 = success
//	-1 = error
//
//	Description:  Sets whether rulers are displayed
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

//////////////////////////////////////////////////////////////////////////////
// Check for valid requestor
//////////////////////////////////////////////////////////////////////////////
if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

//////////////////////////////////////////////////////////////////////////////
// Check argument
//////////////////////////////////////////////////////////////////////////////
if IsNull(ab_display) then
	return -1
end if

//////////////////////////////////////////////////////////////////////////////
// Set ruler display
//////////////////////////////////////////////////////////////////////////////
idw_requestor.object.datawindow.print.preview.rulers = ab_display
return 1
end function

public function integer of_setzoom ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetZoom
//
//	Access:  public
//
//	Arguments:  none
//
//	Returns:  integer
//	 Zoom level that the user selected
//	 0 = User cancelled from zoom dialog
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

integer	li_zoom
n_cst_zoomattrib	lnv_zoomattrib

if IsNull(idw_requestor) Or not IsValid (idw_requestor) then
	return -1
end if

lnv_zoomattrib.idw_obj = idw_requestor
lnv_zoomattrib.ii_zoom = of_GetZoom()
if lnv_zoomattrib.ii_zoom = -1 then
	return -1
end if

OpenWithParm (w_zoom, lnv_zoomattrib)
li_zoom = message.DoubleParm
return li_zoom

end function

public function integer of_getinfo (ref n_cst_infoattrib anv_infoattrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_infoattrib	(By reference) The Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Service Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
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

// Populate Information.
anv_infoattrib.is_name = 'PrintPreview'
anv_infoattrib.is_description = 'Provide PrintPreview functionality.'

Return 1
end function

public function integer of_getpropertyinfo (ref n_cst_propertyattrib anv_attrib);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetPropertyInfo
//
//	Access:   		Public
//
//	Arguments:		
//		anv_attrib	(By ref.) The Property Information attributes.
//
//	Returns:  		Integer
//	 1 for success.
//	-1 for error.
//
//	Description:  
//	 Gets the Service Property Information.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0    Initial version
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

n_cst_infoattrib lnv_infoattrib

// Get the first two attributes from the Main Information attributes.
of_GetInfo(lnv_infoattrib)
anv_attrib.is_name = lnv_infoattrib.is_name
anv_attrib.is_description = lnv_infoattrib.is_description

// Set the rest of the attributes.
anv_attrib.is_propertypage = {'u_tabpg_dwproperty_srvprintpreview'}
anv_attrib.ib_switchbuttons = True

Return 1
end function

on pfc_n_cst_dwsrv_printpreview.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_dwsrv_printpreview.destroy
TriggerEvent( this, "destructor" )
end on


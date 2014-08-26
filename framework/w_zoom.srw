HA$PBExportHeader$w_zoom.srw
$PBExportComments$Extension Zoom dialog window
forward
global type w_zoom from pfc_w_zoom
end type
end forward

global type w_zoom from pfc_w_zoom
integer height = 1040
end type
global w_zoom w_zoom

on w_zoom.create
call super::create
end on

on w_zoom.destroy
call super::destroy
end on

event open;//////////////////////////////////////////////////////////////////////////////
// OJO!, SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event: 			open
//	Description:		Gets the zoom object passed to this window and initializes the zoom window
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						6.0		Added support for datastores
// 						7.0		Fix problem with dynamically created datawindow
//						8.0		Fix problem with initial default settings
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer	li_initialzoom
blob lbl_dw

ib_disableclosequery = true

//////////////////////////////////////////////////////////////////////////////
// Get the zoom object from the message object
//////////////////////////////////////////////////////////////////////////////
inv_zoomattrib = message.PowerObjectParm

ib_dwrequestor = not (isNull (inv_zoomattrib.idw_obj) or not isValid (inv_zoomattrib.idw_obj))
if not ib_dwrequestor then
	if (isNull (inv_zoomattrib.ids_obj) or not isValid (inv_zoomattrib.ids_obj)) then
		inv_zoomattrib.ii_zoom = -1
		close (this)
	end if
end if

li_initialzoom = inv_zoomattrib.ii_zoom
inv_zoomattrib.ii_zoom = 0

//////////////////////////////////////////////////////////////////////////////
// Initialize preview area
//////////////////////////////////////////////////////////////////////////////
if ib_dwrequestor then
	inv_zoomattrib.idw_obj.GetFullState ( lbl_dw )
	dw_preview.SetFullState ( lbl_dw )
else
	inv_zoomattrib.ids_obj.GetFullState ( lbl_dw )
	dw_preview.SetFullState ( lbl_dw )
end if

//dw_preview.object.datawindow.print.preview = true

//////////////////////////////////////////////////////////////////////////////
// Initialize zoom percentages
//////////////////////////////////////////////////////////////////////////////
choose case li_initialzoom

	case 200
		rb_200.checked = true

	case 100
		rb_100.checked = true

	case 75
		rb_75.checked = true

	case 50
		rb_50.checked = true

	case 25
		rb_25.checked = true
		
	case else
		rb_custom.checked = true

end choose

em_zoom.Text = String ( li_initialzoom ) 

dw_preview.object.datawindow.zoom = li_initialzoom
end event

event pfc_apply();//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			pfc_apply
//	Description:		Apply zoom factor to requesting DataWindow
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						6.0		Added support for datastores
// 						8.0		Fixed problem getting setting from editmask
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
decimal {2} ldc_zoom
string ls_zoom, ls_estatus
n_cst_string	lnv_string

em_zoom.GetData ( ldc_zoom ) 
inv_zoomattrib.ii_zoom =  Round ( ldc_zoom, 0 ) 

if ib_dwrequestor then
	//Determina si est$$HEX2$$e1002000$$ENDHEX$$en printpreview o no
	ls_estatus = upper(inv_zoomattrib.idw_obj.object.datawindow.print.preview)
	if ls_estatus = '?' then 
		messagebox(gs_nombreapp, "No se pudo aplicar el zoom", exclamation!)
		return
	end if
	if  ls_estatus = 'YES' or ls_estatus = 'Y' then
		inv_zoomattrib.idw_obj.object.datawindow.print.preview.zoom = inv_zoomattrib.ii_zoom
	else
		inv_zoomattrib.idw_obj.object.datawindow.zoom = inv_zoomattrib.ii_zoom
	end if
else
	inv_zoomattrib.ids_obj.object.datawindow.zoom = inv_zoomattrib.ii_zoom	
end if

ii_rc = inv_zoomattrib.ii_zoom
cb_apply.enabled = false
end event

type rb_custom from pfc_w_zoom`rb_custom within w_zoom
boolean visible = true
string text = "Personalizado"
end type

type rb_200 from pfc_w_zoom`rb_200 within w_zoom
end type

event rb_200::clicked;//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			clicked
//	Description:		Enable apply button and update percentage
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						8.0		Removed percent sign.  Now part of mask
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
cb_apply.enabled = true

dw_preview.object.datawindow.zoom = 200

em_zoom.Text = "200"
end event

type rb_100 from pfc_w_zoom`rb_100 within w_zoom
end type

event rb_100::clicked;//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			clicked
//	Description:		Enable apply button and update percentage
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						8.0		Removed percent sign.  Now part of mask
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
cb_apply.enabled = true

dw_preview.object.datawindow.zoom = 100

em_zoom.Text = "100"
end event

type rb_75 from pfc_w_zoom`rb_75 within w_zoom
end type

event rb_75::clicked;//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			clicked
//	Description:		Enable apply button and update percentage
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						8.0		Removed percent sign.  Now part of mask
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
cb_apply.enabled = true

dw_preview.object.datawindow.zoom = 75

em_zoom.Text = "75"
end event

type rb_50 from pfc_w_zoom`rb_50 within w_zoom
end type

event rb_50::clicked;//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			clicked
//	Description:		Enable apply button and update percentage
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						8.0		Removed percent sign.  Now part of mask
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
cb_apply.enabled = true

dw_preview.object.datawindow.zoom = 50

em_zoom.Text = "50"
end event

type rb_25 from pfc_w_zoom`rb_25 within w_zoom
end type

event rb_25::clicked;//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			clicked
//	Description:		Enable apply button and update percentage
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
//						8.0		Removed percent sign.  Now part of mask
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
cb_apply.enabled = true

dw_preview.object.datawindow.zoom = 25

em_zoom.Text = "25"
end event

type st_1 from pfc_w_zoom`st_1 within w_zoom
integer y = 584
string text = "Porcentaje:"
end type

type em_zoom from pfc_w_zoom`em_zoom within w_zoom
integer y = 656
string mask = "###"
end type

type cb_ok from pfc_w_zoom`cb_ok within w_zoom
integer y = 840
string text = "Aceptar"
end type

type cb_cancel from pfc_w_zoom`cb_cancel within w_zoom
integer y = 840
string text = "Cancelar"
end type

type cb_apply from pfc_w_zoom`cb_apply within w_zoom
integer y = 840
string text = "&Aplicar"
end type

type dw_preview from pfc_w_zoom`dw_preview within w_zoom
integer height = 684
end type

type gb_1 from pfc_w_zoom`gb_1 within w_zoom
integer height = 788
string text = "Preliminar"
end type

type gb_3 from pfc_w_zoom`gb_3 within w_zoom
integer height = 788
string text = "Zoom"
end type

type cb_dlghelp from pfc_w_zoom`cb_dlghelp within w_zoom
integer y = 840
string text = "A&yuda"
end type


HA$PBExportHeader$w_catalogo_ok.srw
$PBExportComments$(LAC) Ancestro para las ventanas tipo cat$$HEX1$$e100$$ENDHEX$$logo
forward
global type w_catalogo_ok from w_main
end type
type tab_ficha from tab within w_catalogo_ok
end type
type tabpage_generales from userobject within tab_ficha
end type
type dw_cat_ficha from u_dw within tabpage_generales
end type
type tabpage_generales from userobject within tab_ficha
dw_cat_ficha dw_cat_ficha
end type
type tab_ficha from tab within w_catalogo_ok
tabpage_generales tabpage_generales
end type
type st_split from u_st_splitbar within w_catalogo_ok
end type
type uo_header from u_cst_xpheader within w_catalogo_ok
end type
type dw_cat_ficha2 from u_dw within w_catalogo_ok
end type
type dw_cat_listado from u_dw within w_catalogo_ok
end type
end forward

global type w_catalogo_ok from w_main
integer width = 2382
integer height = 1452
string title = "Cat$$HEX1$$e100$$ENDHEX$$logos"
boolean toolbarvisible = false
event ue_cambia_vista ( )
event ue_actualizar ( )
event ue_resize_on ( )
event ue_resize_off ( )
tab_ficha tab_ficha
st_split st_split
uo_header uo_header
dw_cat_ficha2 dw_cat_ficha2
dw_cat_listado dw_cat_listado
end type
global w_catalogo_ok w_catalogo_ok

type variables
boolean ib_nuevo = FALSE
n_cst_resize	inv_resize_tab

u_dw idw_cat_ficha
end variables

forward prototypes
public function integer of_setresize_tab (boolean ab_switch)
end prototypes

event ue_actualizar();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_header.of_setTheme(gs_temaactual)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.LEFT)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.RIGHT)
uo_header.of_setText(this.title, uo_header.LEFT)
uo_header.of_setImage(this.icon, uo_header.LEFT)
uo_header.of_setText(string(dw_cat_listado.rowcount()) + " Registros", uo_header.RIGHT)
end event

event ue_resize_on();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF isvalid(gnv_app.inv_debug) THEN  gnv_app.inv_debug.of_message( "RESIZE ON" )

//Inicializa el servicio de resize
of_setresize(true)
inv_resize.of_setorigsize( this.width, this.height)

of_setResize_TAB(TRUE)
inv_resize_tab.of_setorigsize( this.width, this.height)

//Registra los objetos
inv_resize.of_register(dw_cat_listado, 0,0,0,100)
inv_resize.of_register(tab_ficha, 0,0,0,100)
inv_resize.of_register(uo_header, 0,0,100,0)
inv_resize.of_register(st_split, 0,0,0,100)


st_split.of_Register(dw_cat_listado, st_split.LEFT)
st_split.of_Register(tab_ficha, st_split.RIGHT)

inv_resize_tab.of_register(idw_cat_ficha, 0,0,100,100)

post event ue_ajusta_objetos()

end event

event ue_resize_off();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF isvalid(gnv_app.inv_debug) THEN  gnv_app.inv_debug.of_message( "RESIZE OFF" )

//st_split.of_reset()
//Inicializa el servicio de resize
inv_resize_tab.of_unregister(idw_cat_ficha)
inv_resize.of_unregister(dw_cat_listado)
inv_resize.of_unregister(tab_ficha)
inv_resize.of_unregister(uo_header)

of_setResize_TAB(FALSE)
of_setresize(FALSE)



end event

public function integer of_setresize_tab (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetResize
//
//	Access:  public
//
//	Arguments:		
//	ab_switch   starts/stops the window resize service
//
//	Returns:  integer
//	 1 = success
//	 0 = no action necessary
//	-1 = error
//
//	Description:
//	Starts or stops the window resize service
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

Integer	li_rc

// Check arguments
If IsNull (ab_switch) Then
	Return -1
End If

If ab_Switch Then
	If IsNull(inv_resize_tab) Or Not IsValid (inv_resize_tab) Then
		inv_resize_tab = Create n_cst_resize
		inv_resize_tab.of_SetOrigSize (This.Width, This.Height)
		li_rc = 1
	End If
Else
	If IsValid (inv_resize_tab) Then
		Destroy inv_resize_tab
		li_rc = 1
	End If
End If

Return li_rc

end function

on w_catalogo_ok.create
int iCurrent
call super::create
this.tab_ficha=create tab_ficha
this.st_split=create st_split
this.uo_header=create uo_header
this.dw_cat_ficha2=create dw_cat_ficha2
this.dw_cat_listado=create dw_cat_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_ficha
this.Control[iCurrent+2]=this.st_split
this.Control[iCurrent+3]=this.uo_header
this.Control[iCurrent+4]=this.dw_cat_ficha2
this.Control[iCurrent+5]=this.dw_cat_listado
end on

on w_catalogo_ok.destroy
call super::destroy
destroy(this.tab_ficha)
destroy(this.st_split)
destroy(this.uo_header)
destroy(this.dw_cat_ficha2)
destroy(this.dw_cat_listado)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//Liga la dw de listado y de ficha
dw_cat_listado.sharedata(idw_cat_ficha)

event ue_resize_on()

////Inicializa el servicio de resize
//of_setresize(true)
//
////Registra los objetos
//inv_resize.of_register(dw_cat_listado, 0,0,0,100)
////inv_resize.of_register(idw_cat_ficha, 0,0,100,100)
//inv_resize.of_register(tab_ficha, 0,0,0,100)
//inv_resize.of_register(uo_header, 0,0,100,0)
//
//inv_resize_tab.of_register(idw_cat_ficha, 0,0,100,100)
//

end event

event pfc_controlgotfocus;call super::pfc_controlgotfocus;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombredw

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if not isvalid(m_apppfc_catalogo) then return

m_apppfc_catalogo.m_edit.m_agregar.enabled = false
m_apppfc_catalogo.m_edit.m_borrar.enabled = false
	
if adrg_control.typeof() <> datawindow! then 
	m_apppfc_catalogo.m_view.m_cambiavista.enabled = false
	m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
else
	m_apppfc_catalogo.m_edit.m_agregar.enabled = true
	m_apppfc_catalogo.m_view.m_cambiavista.enabled = true
	ls_nombredw = idw_active.classname( )
	if pos(ls_nombredw,'dw_cat_ficha') > 0 then m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
	if pos(ls_nombredw,'dw_cat_listado') > 0 then m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = false
	
	//Valida si hay registros
	if idw_active.rowcount() > 0 then m_apppfc_catalogo.m_edit.m_borrar.enabled = true

	//Si el servicio de guardacomo est$$HEX2$$e1002000$$ENDHEX$$activado habilita la opci$$HEX1$$f300$$ENDHEX$$n saveas
//	m_apppfc_frame.m_file.m_saveas.visible =  idw_active.ib_guardarcomo
//	m_apppfc_frame.m_file.m_saveas.enabled =  idw_active.ib_guardarcomo
//	m_apppfc_frame.m_file.m_saveas.toolbaritemvisible =  idw_active.ib_guardarcomo

end if

////Actualiza la barra de herramientas
//of_ActualizaToolbar(gw_frame.menuid)
//
//IF isvalid(gnv_app.inv_debug) THEN
//	gnv_app.inv_debug.of_message("pfc_controlgotFocus w_catalogo")
//END IF



end event

event ue_define_menu;call super::ue_define_menu;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Asigna el menu por default para los catalogos
of_setMenu(m_apppfc_catalogo)


end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_header.of_setTheme(gs_temaactual)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.LEFT)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.RIGHT)
uo_header.of_setText(this.title, uo_header.LEFT)
uo_header.of_setImage(this.icon, uo_header.LEFT)
uo_header.of_setText(string(dw_cat_listado.rowcount()) + " Registros", uo_header.RIGHT)
end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
uo_header.x = 5
uo_header.width = this.width
uo_header.y = 1

dw_cat_listado.x = 5
dw_cat_listado.y = uo_header.height + 5
dw_cat_listado.height = height - dw_cat_listado.y - 20
//dw_cat_listado.width = width - 20

st_split.x = dw_cat_listado.x + dw_cat_listado.width + 5
st_split.y = dw_cat_listado.y
st_split.height = dw_cat_listado.height

//dw_cat_ficha.x = st_split.x + st_split.width + 5
//dw_cat_ficha.y = dw_cat_listado.y
//dw_cat_ficha.height = dw_cat_listado.height
//dw_cat_ficha.width = width - dw_cat_ficha.x - 20

tab_ficha.x = st_split.x + st_split.width + 5
tab_ficha.y = dw_cat_listado.y
tab_ficha.height = dw_cat_listado.height
tab_ficha.width = width - tab_ficha.x - 20

idw_cat_ficha.x = 5
idw_cat_ficha.y = 5
idw_cat_ficha.width = tab_ficha.tabpage_generales.width - 20
idw_cat_ficha.height = tab_ficha.tabpage_generales.height - 20


end event

event resize;call super::resize;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF isvalid(gnv_app.inv_debug) THEN  gnv_app.inv_debug.of_message( "EVENTO RESIZE" )
end event

type tab_ficha from tab within w_catalogo_ok
event create ( )
event destroy ( )
event resize pbm_size
integer x = 320
integer y = 220
integer width = 1248
integer height = 752
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_generales tabpage_generales
end type

on tab_ficha.create
this.tabpage_generales=create tabpage_generales
this.Control[]={this.tabpage_generales}
end on

on tab_ficha.destroy
destroy(this.tabpage_generales)
end on

event resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  resize
//
//	Description:
//	Send resize notification to services
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

// Notify the resize service that the object size has changed.
If IsValid (inv_resize_tab) Then
	inv_resize_tab.Event pfc_Resize (sizetype, This.Width, This.Height)
End If

IF isvalid(gnv_app.inv_debug) THEN  gnv_app.inv_debug.of_message( "TAB RESIZE "+string(idw_cat_ficha.height) )



end event

event constructor;
//of_setResize_TAB(TRUE)


end event

type tabpage_generales from userobject within tab_ficha
event create ( )
event destroy ( )
integer x = 18
integer y = 104
integer width = 1211
integer height = 632
long backcolor = 79741120
string text = "Generales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_cat_ficha dw_cat_ficha
end type

on tabpage_generales.create
this.dw_cat_ficha=create dw_cat_ficha
this.Control[]={this.dw_cat_ficha}
end on

on tabpage_generales.destroy
destroy(this.dw_cat_ficha)
end on

type dw_cat_ficha from u_dw within tabpage_generales
integer width = 978
integer height = 476
integer taborder = 30
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

idw_cat_ficha = this

ib_rmbmenu = FALSE

//Asigna el objeto de transacci$$HEX1$$f300$$ENDHEX$$n
of_settransobject(sqlca)

//Define como no actualizable esta dw
of_Setupdateable(FALSE)
of_setReqColumn(TRUE)

of_setbloqueascrollff( TRUE)
of_setindicacampoactual( TRUE )
end event

event itemchanged;call super::itemchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
datetime	ldt_hoy
string	ls_lista_objetos

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

//ldt_hoy = gf_fechaservidor()
ldt_hoy = SQLCA.of_fechaservidor()

//Asigna el usuario y fecha de movimiento
ls_lista_objetos = describe("datawindow.objects")

if pos(ls_lista_objetos, 'usuario_modifica') > 0 then setitem(row, 'usuario_modifica', gs_id_usuario)
if pos(ls_lista_objetos, 'fecha_movimiento') > 0 then setitem(row, 'fecha_movimiento', ldt_hoy)

return dw_cat_listado.event itemchanged(row, dwo, data)

end event

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

RETURN 3
end event

event rowfocuschanging;call super::rowfocuschanging;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombre_dw
dwItemStatus ldwis_curr_estatus, ldwis_new_estatus

//------------------------------------------------------------------
// CODIGO DE LA RUTINA LUIS
//------------------------------------------------------------------
if isnull(currentrow) or currentrow = 0 then return
if ancestorreturnvalue = 1 then return 1

ls_nombre_dw = classname()
ldwis_curr_estatus = GetItemStatus(currentrow, 0, Primary!)
ldwis_new_estatus = GetItemStatus(newrow, 0, Primary!)

////previene el cambio de registro si es nuevo y tipo ficha
//if visible and describe("DataWindow.Processing") = "0" then
//	
//	if ldwis_new_estatus = new! or ldwis_new_estatus = newmodified! then return
//	if ldwis_curr_estatus = new! or ldwis_curr_estatus = newmodified! then return
//	
//	setredraw(false)
//	//ejecuta el post para scrollear a este registro, ya que como quiera al prevenir el
//	//cambio de rengl$$HEX1$$f300$$ENDHEX$$n la dw scrollea a ese rengl$$HEX1$$f300$$ENDHEX$$n
//	post scrolltorow(currentrow)
//	post setredraw(true)
//	return 1
//end if

return
end event

type st_split from u_st_splitbar within w_catalogo_ok
integer x = 1330
integer y = 8
integer width = 18
integer height = 168
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//of_Register(dw_cat_listado, LEFT)
//of_Register(tab_ficha, RIGHT)

BackColor = 78682240
end event

event lbuttonup;call super::lbuttonup;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

BackColor = 78682240
end event

type uo_header from u_cst_xpheader within w_catalogo_ok
integer taborder = 20
end type

on uo_header.destroy
call u_cst_xpheader::destroy
end on

type dw_cat_ficha2 from u_dw within w_catalogo_ok
integer x = 334
integer y = 300
integer width = 1673
integer height = 920
integer taborder = 20
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
visible = FALSE
//Asigna el objeto de transacci$$HEX1$$f300$$ENDHEX$$n
of_settransobject(sqlca)

//Define como no actualizable esta dw
of_Setupdateable(FALSE)
of_setReqColumn(TRUE)

of_setbloqueascrollff( TRUE)
of_setindicacampoactual( TRUE )
end event

event editchanged;call super::editchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Extiende ejecuci$$HEX1$$f300$$ENDHEX$$n para el servicio de b$$HEX1$$fa00$$ENDHEX$$squeda en dddw
//if not IsNull(inv_DropDownSearch) AND IsValid (inv_DropDownSearch) then
//	inv_dropdownsearch.Event pfc_EditChanged (row, dwo, data)
//END IF
end event

event itemfocuschanged;call super::itemfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

////Extiende ejecuci$$HEX1$$f300$$ENDHEX$$n para el servicio de b$$HEX1$$fa00$$ENDHEX$$squeda en dddw
//if not IsNull(inv_DropDownSearch) AND IsValid (inv_DropDownSearch) then
//	inv_dropdownsearch.Event pfc_ItemFocusChanged (row, dwo)
//END IF
end event

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

RETURN 3
end event

event pfc_postinsertrow(long al_row);call super::pfc_postinsertrow;////------------------------------------------------------------------
//// DECLARACIONES LOCALES
////------------------------------------------------------------------
//
////------------------------------------------------------------------
//// CODIGO DE LA RUTINA
////------------------------------------------------------------------
////Mueve el scroll al registro nuevo
//This.ScrollToRow(al_row)
end event

event itemchanged;call super::itemchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
datetime	ldt_hoy
string	ls_lista_objetos

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

//ldt_hoy = gf_fechaservidor()
ldt_hoy = SQLCA.of_fechaservidor()

//Asigna el usuario y fecha de movimiento
ls_lista_objetos = describe("datawindow.objects")

if pos(ls_lista_objetos, 'usuario_modifica') > 0 then setitem(row, 'usuario_modifica', gs_id_usuario)
if pos(ls_lista_objetos, 'fecha_movimiento') > 0 then setitem(row, 'fecha_movimiento', ldt_hoy)

return dw_cat_listado.event itemchanged(row, dwo, data)

end event

event rowfocuschanging;call super::rowfocuschanging;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombre_dw
dwItemStatus ldwis_curr_estatus, ldwis_new_estatus

//------------------------------------------------------------------
// CODIGO DE LA RUTINA LUIS
//------------------------------------------------------------------
if isnull(currentrow) or currentrow = 0 then return
if ancestorreturnvalue = 1 then return 1

ls_nombre_dw = classname()
ldwis_curr_estatus = GetItemStatus(currentrow, 0, Primary!)
ldwis_new_estatus = GetItemStatus(newrow, 0, Primary!)

////previene el cambio de registro si es nuevo y tipo ficha
//if visible and describe("DataWindow.Processing") = "0" then
//	
//	if ldwis_new_estatus = new! or ldwis_new_estatus = newmodified! then return
//	if ldwis_curr_estatus = new! or ldwis_curr_estatus = newmodified! then return
//	
//	setredraw(false)
//	//ejecuta el post para scrollear a este registro, ya que como quiera al prevenir el
//	//cambio de rengl$$HEX1$$f300$$ENDHEX$$n la dw scrollea a ese rengl$$HEX1$$f300$$ENDHEX$$n
//	post scrolltorow(currentrow)
//	post setredraw(true)
//	return 1
//end if

return
end event

type dw_cat_listado from u_dw within w_catalogo_ok
integer x = 5
integer y = 176
integer width = 2354
integer height = 1180
integer taborder = 10
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(True)
inv_rowselect.of_SetStyle(inv_rowselect.SINGLE)

of_setguardarcomo(true)

//Asigna el objeto de transacci$$HEX1$$f300$$ENDHEX$$n
of_settransobject(sqlca)

//Servicio de ordenamiento por columnas
of_setsort(true)
inv_sort.of_setstyle(inv_sort.dragdrop)
inv_sort.of_setcolumnheader(true)

//Pobla la dw
event pfc_retrieve()

//Pone visible el dw
visible = true
end event

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF currentrow = 0 THEN RETURN 

//Coordina el cambio de rengl$$HEX1$$f300$$ENDHEX$$n
idw_cat_ficha.ScrollToRow (currentrow)
end event

event pfc_postinsertrow(long al_row);call super::pfc_postinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Mueve el scroll al registro nuevo
This.ScrollToRow(al_row)

//Habilita el boton de borrar
m_apppfc_catalogo.m_edit.m_borrar.enabled = true
end event

event editchanged;call super::editchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

////Extiende ejecuci$$HEX1$$f300$$ENDHEX$$n para el servicio de b$$HEX1$$fa00$$ENDHEX$$squeda en dddw
//if not IsNull(inv_DropDownSearch) AND IsValid (inv_DropDownSearch) then
//	inv_dropdownsearch.Event pfc_EditChanged (row, dwo, data)
//END IF
end event

event itemfocuschanged;call super::itemfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

////Extiende ejecuci$$HEX1$$f300$$ENDHEX$$n para el servicio de b$$HEX1$$fa00$$ENDHEX$$squeda en dddw
//if not IsNull(inv_DropDownSearch) AND IsValid (inv_DropDownSearch) then
//	inv_dropdownsearch.Event pfc_ItemFocusChanged (row, dwo)
//END IF
end event

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

RETURN 3
end event

event type long pfc_retrieve();call super::pfc_retrieve;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

return retrieve()
end event

event itemchanged;call super::itemchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
datetime	ldt_hoy
string	ls_lista_objetos

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

ldt_hoy = SQLCA.of_fechaservidor()

//Asigna el usuario y fecha de movimiento
ls_lista_objetos = describe("datawindow.objects")

if pos(ls_lista_objetos, 'usuario_modifica') > 0 then setitem(row, 'usuario_modifica', gs_id_usuario)
if pos(ls_lista_objetos, 'fecha_movimiento') > 0 then setitem(row, 'fecha_movimiento', ldt_hoy)

end event

event pfc_deleterow;call super::pfc_deleterow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 1 then return ancestorreturnvalue

//Inhabilita el boton de borrar
if rowcount() = 0 then m_apppfc_catalogo.m_edit.m_borrar.enabled = false

return 1
end event

event pfc_predeleterow;call super::pfc_predeleterow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

if ancestorreturnvalue = PREVENT_ACTION then return PREVENT_ACTION

//IF Messagebox(gs_nombreapp,"$$HEX1$$bf00$$ENDHEX$$Est$$HEX2$$e1002000$$ENDHEX$$seguro de eliminar este elemento del cat$$HEX1$$e100$$ENDHEX$$logo?",exclamation!,yesno!,2) = 2 THEN RETURN PREVENT_ACTION

RETURN CONTINUE_ACTION
end event


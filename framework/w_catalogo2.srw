HA$PBExportHeader$w_catalogo2.srw
$PBExportComments$(LAC) Ancestro para las ventanas tipo cat$$HEX1$$e100$$ENDHEX$$logo
forward
global type w_catalogo2 from w_main
end type
type uo_header from u_cst_xpheader within w_catalogo2
end type
type dw_cat_ficha from u_dw within w_catalogo2
end type
type dw_cat_listado from u_dw within w_catalogo2
end type
end forward

global type w_catalogo2 from w_main
integer width = 2382
integer height = 1464
string title = "Cat$$HEX1$$e100$$ENDHEX$$logos"
boolean toolbarvisible = false
event ue_ajusta_objetos ( )
event ue_cambia_vista ( )
event ue_actualizar ( )
uo_header uo_header
dw_cat_ficha dw_cat_ficha
dw_cat_listado dw_cat_listado
end type
global w_catalogo2 w_catalogo2

type variables
boolean ib_nuevo = FALSE
w_catalogo_captura iw_captura
string is_window_response
end variables

event ue_ajusta_objetos;//------------------------------------------------------------------
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
//dw_cat_listado.height = height - 150
//dw_cat_listado.width = width - 80
dw_cat_listado.height = height - dw_cat_listado.y - 20
dw_cat_listado.width = width - 20

dw_cat_ficha.x = dw_cat_listado.x
dw_cat_ficha.y = dw_cat_listado.y
dw_cat_ficha.height = dw_cat_listado.height
dw_cat_ficha.width = dw_cat_listado.width

end event

event ue_cambia_vista();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_columna
long ll_renglon
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if not isvalid(m_apppfc_catalogo) then return

m_apppfc_catalogo.m_view.m_cambiavista.enabled = true

//Obtiene la columna activa
li_columna = idw_active.GetColumn()
If li_columna <= 0 Then li_columna = 1

if idw_active.classname() = 'dw_cat_ficha' then
	dw_cat_listado.setfocus()
	m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = false
	dw_cat_listado.SetColumn(li_columna)
	dw_cat_listado.scrolltorow( dw_cat_ficha.getrow())
	dw_cat_ficha.visible = false
	dw_cat_listado.visible = true
else
	//Valida si tiene dataobject asignado
	if trim(dw_cat_ficha.dataobject) <> "" then
		dw_cat_ficha.setfocus()
		m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
		dw_cat_ficha.setcolumn(li_columna)
		dw_cat_ficha.scrolltorow( dw_cat_listado.getrow())
		dw_cat_listado.visible = false
		dw_cat_ficha.visible = true
	end if
end if


end event

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

on w_catalogo2.create
int iCurrent
call super::create
this.uo_header=create uo_header
this.dw_cat_ficha=create dw_cat_ficha
this.dw_cat_listado=create dw_cat_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_header
this.Control[iCurrent+2]=this.dw_cat_ficha
this.Control[iCurrent+3]=this.dw_cat_listado
end on

on w_catalogo2.destroy
call super::destroy
destroy(this.uo_header)
destroy(this.dw_cat_ficha)
destroy(this.dw_cat_listado)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//Liga la dw de listado y de ficha
dw_cat_listado.sharedata(dw_cat_ficha)

//Inicializa el servicio de resize
of_setresize(true)

//Registra los objetos
inv_resize.of_register(dw_cat_listado, 0,0,100,100)
inv_resize.of_register(dw_cat_ficha, 0,0,100,100)
inv_resize.of_register(uo_header, 0,0,100,0)
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

type uo_header from u_cst_xpheader within w_catalogo2
integer taborder = 20
end type

on uo_header.destroy
call u_cst_xpheader::destroy
end on

type dw_cat_ficha from u_dw within w_catalogo2
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

//Asigna el objeto de transacci$$HEX1$$f300$$ENDHEX$$n
of_settransobject(sqlca)

//Define como no actualizable esta dw
of_setupdateable(false)

//Pone invisible el dw
visible = false
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

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Coordina el cambio de rengl$$HEX1$$f300$$ENDHEX$$n
//dw_cat_listado.ScrollToRow (currentrow)
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
// CODIGO DE LA RUTINA
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

type dw_cat_listado from u_dw within w_catalogo2
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

//Coordina el cambio de rengl$$HEX1$$f300$$ENDHEX$$n
//dw_cat_ficha.ScrollToRow (currentrow)
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

event doubleclicked;call super::doubleclicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rtn
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF row = 0 THEN RETURN

parent.ib_nuevo = FALSE
openWithParm(iw_captura, parent, is_window_response)

li_rtn = integer(message.stringparm)




end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rtn
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

parent.ib_nuevo = TRUE
openWithParm(iw_captura, parent, is_window_response)

li_rtn = integer(message.stringparm)

RETURN PREVENT_ACTION


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


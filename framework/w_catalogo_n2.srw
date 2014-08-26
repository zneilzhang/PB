HA$PBExportHeader$w_catalogo_n2.srw
$PBExportComments$(LAC) Ancestro para las ventanas tipo cat$$HEX1$$e100$$ENDHEX$$logo de dos niveles
forward
global type w_catalogo_n2 from w_main
end type
type dw_cat_ficha_detalle from u_dw within w_catalogo_n2
end type
type dw_cat_listado_detalle from u_dw within w_catalogo_n2
end type
type dw_cat_ficha_maestro from u_dw within w_catalogo_n2
end type
type dw_cat_listado_maestro from u_dw within w_catalogo_n2
end type
type st_split_horizontal from u_st_splitbar within w_catalogo_n2
end type
type gb_maestro from u_gb within w_catalogo_n2
end type
type gb_detalle from u_gb within w_catalogo_n2
end type
end forward

global type w_catalogo_n2 from w_main
integer width = 3255
integer height = 2168
string title = "Cat$$HEX1$$e100$$ENDHEX$$logos"
event ue_ajusta_objetos ( )
event ue_cambia_vista ( )
dw_cat_ficha_detalle dw_cat_ficha_detalle
dw_cat_listado_detalle dw_cat_listado_detalle
dw_cat_ficha_maestro dw_cat_ficha_maestro
dw_cat_listado_maestro dw_cat_listado_maestro
st_split_horizontal st_split_horizontal
gb_maestro gb_maestro
gb_detalle gb_detalle
end type
global w_catalogo_n2 w_catalogo_n2

type variables
//Arreglo para definir los campos linkage
String	isarr_liga_maestro[5], isarr_liga_detalle[5]

boolean ib_borrando = false

//Var. para indicar si se realiza el retrieve al cargar
boolean ib_retrieve_inicio = true
end variables

event ue_ajusta_objetos();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Acomoda los objetos del maestro
gb_maestro.x = 20
gb_maestro.y = 0
gb_maestro.width = width - 70

dw_cat_listado_maestro.x = gb_maestro.x + 30
dw_cat_listado_maestro.y = gb_maestro.y + 65
dw_cat_listado_maestro.width = gb_maestro.width - 60
dw_cat_listado_maestro.height = gb_maestro.height - 90

dw_cat_ficha_maestro.x = dw_cat_listado_maestro.x
dw_cat_ficha_maestro.y = dw_cat_listado_maestro.y
dw_cat_ficha_maestro.width = dw_cat_listado_maestro.width
dw_cat_ficha_maestro.height = dw_cat_listado_maestro.height

//Acomoda el split horizontal
st_split_horizontal.x = 0
st_split_horizontal.y = gb_maestro.y + gb_maestro.height + 20
st_split_horizontal.height = 25
st_split_horizontal.width = width - 35

//Acomoda los objetos del detalle
gb_detalle.x = 20
gb_detalle.y = st_split_horizontal.y + 20
gb_detalle.width = gb_maestro.width
gb_detalle.height = height - gb_detalle.y - 120

dw_cat_listado_detalle.x = gb_detalle.x + 30
dw_cat_listado_detalle.y = gb_detalle.y + 65
dw_cat_listado_detalle.width = gb_detalle.width - 60
dw_cat_listado_detalle.height = gb_detalle.height - 90

dw_cat_ficha_detalle.x = dw_cat_listado_detalle.x
dw_cat_ficha_detalle.y = dw_cat_listado_detalle.y
dw_cat_ficha_detalle.width = dw_cat_listado_detalle.width
dw_cat_ficha_detalle.height = dw_cat_listado_detalle.height

end event

event ue_cambia_vista();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_dw_activa
integer	li_columna

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
ls_dw_activa = idw_active.classname()
if not isvalid(m_apppfc_catalogo) then return

//Obtiene la columna activa
li_columna = idw_active.GetColumn()
If li_columna <= 0 Then li_columna = 1

m_apppfc_catalogo.m_view.m_cambiavista.enabled = true

//Procesa los dw del maestro
if ls_dw_activa = 'dw_cat_listado_maestro' or ls_dw_activa = 'dw_cat_ficha_maestro' then
	if pos(ls_dw_activa,'dw_cat_ficha') > 0 then
		dw_cat_ficha_maestro.visible = false
		dw_cat_listado_maestro.visible = true
		dw_cat_listado_maestro.setfocus()
		m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = false
		dw_cat_listado_maestro.SetColumn(li_columna)
		dw_cat_listado_maestro.scrolltorow( dw_cat_ficha_maestro.getrow())
	else
		dw_cat_ficha_maestro.visible = true
		dw_cat_listado_maestro.visible = false
		dw_cat_ficha_maestro.setfocus()
		m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
		dw_cat_ficha_maestro.SetColumn(li_columna)
		dw_cat_ficha_maestro.scrolltorow( dw_cat_listado_maestro.getrow())
	end if
end if

//Procesa los dw del detalle
if ls_dw_activa = 'dw_cat_listado_detalle' or ls_dw_activa = 'dw_cat_ficha_detalle' then
	if pos(ls_dw_activa,'dw_cat_ficha') > 0 then
		dw_cat_ficha_detalle.visible = false
		dw_cat_listado_detalle.visible = true
		dw_cat_listado_detalle.setfocus()
		m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = false
		dw_cat_listado_detalle.SetColumn(li_columna)
		dw_cat_listado_detalle.scrolltorow( dw_cat_ficha_detalle.getrow())
	else
		dw_cat_ficha_detalle.visible = true
		dw_cat_listado_detalle.visible = false
		dw_cat_ficha_detalle.setfocus()
		m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
		dw_cat_ficha_detalle.SetColumn(li_columna)
		dw_cat_ficha_detalle.scrolltorow(dw_cat_listado_detalle.getrow())
	end if
end if
end event

on w_catalogo_n2.create
int iCurrent
call super::create
this.dw_cat_ficha_detalle=create dw_cat_ficha_detalle
this.dw_cat_listado_detalle=create dw_cat_listado_detalle
this.dw_cat_ficha_maestro=create dw_cat_ficha_maestro
this.dw_cat_listado_maestro=create dw_cat_listado_maestro
this.st_split_horizontal=create st_split_horizontal
this.gb_maestro=create gb_maestro
this.gb_detalle=create gb_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cat_ficha_detalle
this.Control[iCurrent+2]=this.dw_cat_listado_detalle
this.Control[iCurrent+3]=this.dw_cat_ficha_maestro
this.Control[iCurrent+4]=this.dw_cat_listado_maestro
this.Control[iCurrent+5]=this.st_split_horizontal
this.Control[iCurrent+6]=this.gb_maestro
this.Control[iCurrent+7]=this.gb_detalle
end on

on w_catalogo_n2.destroy
call super::destroy
destroy(this.dw_cat_ficha_detalle)
destroy(this.dw_cat_listado_detalle)
destroy(this.dw_cat_ficha_maestro)
destroy(this.dw_cat_listado_maestro)
destroy(this.st_split_horizontal)
destroy(this.gb_maestro)
destroy(this.gb_detalle)
end on

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer	li_contador
string	ls_campo_maestro, ls_campo_detalle

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
////Ajusta los objetos
//event ue_ajusta_objetos()

//	Liga las dw de listados y fichas
dw_cat_listado_maestro.ShareData(dw_cat_ficha_maestro)
dw_cat_listado_detalle.ShareData(dw_cat_ficha_detalle)

// Aqu$$HEX2$$ed002000$$ENDHEX$$se activa el servicio de Linkage para el dw maestro
if dw_cat_listado_maestro.of_SetLinkage(true) < 0 then messagebox (gs_nombreapp, "Maestro no encadenado", Exclamation!)

// Se define la forma de accesar (RETRIEVE, SCROLL, FILTER)
dw_cat_listado_maestro.inv_linkage.of_SetStyle(dw_cat_listado_maestro.inv_linkage.RETRIEVE)
dw_cat_listado_maestro.inv_linkage.of_SetUpdateOnRowChange (FALSE)
dw_cat_listado_maestro.inv_linkage.of_SetConfirmOnRowChange (FALSE)
dw_cat_listado_maestro.inv_linkage.of_SetConfirmOnDelete(TRUE)
dw_cat_listado_maestro.inv_linkage.of_SetSyncOnKeyChange(TRUE)


// Aqu$$HEX2$$ed002000$$ENDHEX$$se activa el servicio de Linkage para el dw detalle
if dw_cat_listado_detalle.of_SetLinkage(TRUE) < 0 then messagebox (gs_nombreapp, "Detalle no encadenado", Exclamation!)

// Aqu$$HEX2$$ed002000$$ENDHEX$$se establece la relacion Maestro-Detalle
if dw_cat_listado_detalle.inv_linkage.of_SetMaster(dw_cat_listado_maestro) <> 1 then messagebox (gs_nombreapp, "No se encontr$$HEX2$$f3002000$$ENDHEX$$el dw master", Exclamation!)

// Se definen los campos liga de cada DW
for li_contador = 1 to Upperbound(isarr_liga_maestro)
	dw_cat_listado_detalle.inv_linkage.of_Register(isarr_liga_maestro[li_contador], isarr_liga_detalle[li_contador])
next

// Se define la forma de accesar (RETRIEVE, SCROLL, FILTER)
dw_cat_listado_detalle.inv_linkage.of_SetStyle(dw_cat_listado_detalle.inv_linkage.RETRIEVE)

dw_cat_listado_detalle.inv_linkage.of_SetUpdateOnRowChange (FALSE)
dw_cat_listado_detalle.inv_linkage.of_SetConfirmOnRowChange (FALSE)

// Se establece el objeto de transacci$$HEX1$$f300$$ENDHEX$$n
dw_cat_listado_maestro.inv_linkage.of_SetTransObject(SQLCA)

// Se realiza el Retrieve para el maestro
if ib_retrieve_inicio then
	if dw_cat_listado_maestro.inv_linkage.of_Retrieve( ) = -1 then 
		messagebox(gs_nombreapp,"Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de cargar los datos", Exclamation!)
	else
		dw_cat_listado_maestro.SetFocus( )
	end if
end if
end event

event open;call super::open;// *** ATENCI$$HEX1$$d300$$ENDHEX$$N DESCENDIENTES ***//
/*
	1)	isarr_liga_maestro[5] Recibe los campos del maestro que se ligan con el detalle
		isarr_liga_detalle[5] Recibe los campos del detalle que se ligan con el maestro
	
	2)	Los servicios no necesarios se apagan en el constructor descendiente
*/

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//	Habilita el servicio de resize
of_setresize(true)

//	Registra los objetos para el resize
inv_resize.of_Register(gb_maestro, 0, 0, 100, 0)
inv_resize.of_Register(dw_cat_listado_maestro,0,0,100,0)
inv_resize.of_Register(dw_cat_ficha_maestro,0,0,100,0)

inv_resize.of_Register (st_split_horizontal, 0, 0, 100, 0)

inv_resize.of_Register(gb_detalle, 0, 0, 100, 100)
inv_resize.of_Register(dw_cat_listado_detalle, 0, 0, 100, 100)
inv_resize.of_Register(dw_cat_ficha_detalle, 0, 0, 100, 100)
end event

event pfc_controlgotfocus(dragobject adrg_control);call super::pfc_controlgotfocus;//------------------------------------------------------------------
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
	m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
	m_apppfc_catalogo.m_view.m_cambiavista.enabled = false
else
	m_apppfc_catalogo.m_view.m_cambiavista.enabled = true
	m_apppfc_catalogo.m_edit.m_agregar.enabled = true
	
	ls_nombredw = idw_active.classname( )
	if pos(ls_nombredw,'dw_cat_ficha') > 0 then m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = true
	if pos(ls_nombredw,'dw_cat_listado') > 0 then m_apppfc_catalogo.m_view.m_cambiavista.toolbaritemdown = false
	
	//Valida si hay registros
	if idw_active.rowcount() > 0 then m_apppfc_catalogo.m_edit.m_borrar.enabled = true
	
	//Si el servicio de guardacomo est$$HEX2$$e1002000$$ENDHEX$$activado habilita la opci$$HEX1$$f300$$ENDHEX$$n saveas
	m_apppfc_frame.m_file.m_saveas.visible =  idw_active.ib_guardarcomo
	m_apppfc_frame.m_file.m_saveas.enabled =  idw_active.ib_guardarcomo
	m_apppfc_frame.m_file.m_saveas.toolbaritemvisible =  idw_active.ib_guardarcomo
end if

end event

event ue_define_menu;call super::ue_define_menu;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//En este evento se define el menu a usar para la ventana
of_setMenu(m_apppfc_catalogo)
end event

type dw_cat_ficha_detalle from u_dw within w_catalogo_n2
integer x = 293
integer y = 1180
integer width = 2624
integer height = 764
integer taborder = 40
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//** AQU$$HEX2$$cd002000$$ENDHEX$$SE DEBEN DE HABILITAR TODOS LO SERVICIOS NECESARIOS **//

//Apaga el servicio de no modificado
of_setupdateable(false)

//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(false)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(True)

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Servicio de ordenamiento por columnas
of_SetSort(True)
inv_sort.of_SetStyle (inv_sort.DRAGDROP)
inv_sort.of_SetColumnHeader(TRUE)

//Servicio para validar los campos requeridos
of_SetReqColumn(TRUE)


//Asigna los valores default para el usuario que modifica
Modify("usuario_modifica.Initial='" + Upper(gs_id_usuario) + "'")

//Asigna los valores default para la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
Modify("fecha_movimiento.Initial='" + String(SQLCA.of_fechaservidor(), "dd/mm/yyyy hh:mm") + "'")

//	Pone visible el dw
Visible = False
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

return dw_cat_listado_detalle.event itemchanged(row, dwo, data)

end event

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Evita que se desplieguen los mensajes de error
Return 2
end event

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
////------------------------------------------------------------------
//if ancestorreturnvalue <> 0 then return ancestorreturnvalue
//if isnull(currentrow) or currentrow <= 0 then return -1
//
////	Camnbia el renglon para el dw de ficha
//dw_cat_listado_detalle.scrolltorow(currentrow)
//
end event

event type integer pfc_preinsertrow();call super::pfc_preinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 1 then return ancestorreturnvalue

//Valida que haya registros en el maestro
if dw_cat_listado_maestro.rowcount() = 0 then return PREVENT_ACTION

return CONTINUE_ACTION
end event

type dw_cat_listado_detalle from u_dw within w_catalogo_n2
integer x = 50
integer y = 1112
integer width = 3118
integer height = 904
integer taborder = 30
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//** AQU$$HEX2$$cd002000$$ENDHEX$$SE DEBEN DE HABILITAR TODOS LO SERVICIOS NECESARIOS **//
//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(True)
inv_rowselect.of_SetStyle(inv_rowselect.SINGLE)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(True)

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Servicio de ordenamiento por columnas
of_SetSort(True)
inv_sort.of_SetStyle (inv_sort.DRAGDROP)
inv_sort.of_SetColumnHeader(TRUE)

//Servicio para validar los campos requeridos
of_SetReqColumn(TRUE)

//Asigna los valores default para el usuario que modifica
Modify("usuario_modifica.Initial='" + Upper(gs_id_usuario) + "'")

//Asigna los valores default para la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
Modify("fecha_movimiento.Initial='" + String(SQLCA.of_fechaservidor(), "dd/mm/yyyy hh:mm") + "'")

//	Pone visible el dw
Visible = True


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

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Evita que se desplieguen los mensajes de error
Return 2
end event

event postconstructor();call super::postconstructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


end event

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//if ancestorreturnvalue <> 0 then return ancestorreturnvalue
//if isnull(currentrow) or currentrow <= 0 then return -1
//
////	Camnbia el renglon para el dw de ficha
//dw_cat_ficha_detalle.ScrollToRow(currentrow)
end event

event type integer pfc_preinsertrow();call super::pfc_preinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 1 then return ancestorreturnvalue

//Valida que haya registros en el maestro
if dw_cat_listado_maestro.rowcount() = 0 then return PREVENT_ACTION

return CONTINUE_ACTION
end event

type dw_cat_ficha_maestro from u_dw within w_catalogo_n2
integer x = 293
integer y = 196
integer width = 2592
integer height = 676
integer taborder = 20
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//** AQU$$HEX2$$cd002000$$ENDHEX$$SE DEBEN DE HABILITAR TODOS LO SERVICIOS NECESARIOS **//

//Apaga el servicio de no modificado
of_setupdateable(false)

//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(false)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(true)

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Servicio de ordenamiento por columnas
of_SetSort(True)
inv_sort.of_SetStyle (inv_sort.DRAGDROP)
inv_sort.of_SetColumnHeader(TRUE)

//Servicio para validar los campos requeridos
of_SetReqColumn(TRUE)

//Habilita el men$$HEX2$$fa002000$$ENDHEX$$contextual
ib_rmbmenu = true

//Asigna los valores default para el usuario que modifica
Modify("usuario_modifica.Initial='" + Upper(gs_id_usuario) + "'")

//Asigna los valores default para la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
Modify("fecha_movimiento.Initial='" + String(SQLCA.of_fechaservidor(), "dd/mm/yyyy hh:mm") + "'")

//	Pone visible el dw
Visible = False
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

return dw_cat_listado_maestro.event itemchanged(row, dwo, data)


end event

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Evita que se desplieguen los mensajes de error
Return 2
end event

event postconstructor();call super::postconstructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

////Define el servicio de dddw search para TODOS los campos
//of_setdddwsearch("")

end event

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue
if isnull(currentrow) or currentrow <= 0 then return -1

////	Camnbia el renglon para el dw de ficha
//if not ib_borrando then dw_cat_listado_maestro.ScrollToRow(currentrow)
end event

event type integer pfc_predeleterow();call super::pfc_predeleterow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Valida que no existan registros asociados en el detalle
if dw_cat_listado_detalle.rowcount() > 0 then
	messagebox(gs_nombreapp, "No es posible borrar ya que hay registros relacionados", exclamation!)
	return PREVENT_ACTION
end if

return CONTINUE_ACTION
end event

type dw_cat_listado_maestro from u_dw within w_catalogo_n2
integer x = 50
integer y = 64
integer width = 3118
integer height = 912
integer taborder = 10
boolean hscrollbar = true
boolean border = false
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//** AQU$$HEX2$$cd002000$$ENDHEX$$SE DEBEN DE HABILITAR TODOS LO SERVICIOS NECESARIOS **//
//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(True)
inv_rowselect.of_SetStyle(inv_rowselect.SINGLE)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(True)

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Servicio de ordenamiento por columnas
of_SetSort(True)
inv_sort.of_SetStyle (inv_sort.DRAGDROP)
inv_sort.of_SetColumnHeader(TRUE)

//Servicio para validar los campos requeridos
of_SetReqColumn(TRUE)

//Asigna los valores default para el usuario que modifica
Modify("usuario_modifica.Initial='" + Upper(gs_id_usuario) + "'")

//Asigna los valores default para la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
Modify("fecha_movimiento.Initial='" + String(SQLCA.of_fechaservidor(), "dd/mm/yyyy hh:mm") + "'")

//	Pone visible el dw
Visible = True


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

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Evita que se desplieguen los mensajes de error
Return 2
end event

event type long pfc_retrieve();call super::pfc_retrieve;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

return retrieve()
end event

event postconstructor();call super::postconstructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Define el servicio de dddw search para TODOS los campos
//of_setdddwsearch("")
end event

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue
if isnull(currentrow) or currentrow <= 0 then return -1

//	Camnbia el renglon para el dw de ficha
dw_cat_ficha_maestro.ScrollToRow(currentrow)
end event

event type integer pfc_predeleterow();call super::pfc_predeleterow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long	ll_renglon

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue = PREVENT_ACTION then return PREVENT_ACTION

//Valida que no existan registros asociados en el detalle
ll_renglon = dw_cat_listado_detalle.rowcount()
if ll_renglon > 0 then
	messagebox(gs_nombreapp, "No es posible borrar ya que hay registros relacionados", exclamation!)
	return PREVENT_ACTION
end if

ib_borrando = true
return CONTINUE_ACTION
end event

event type integer pfc_deleterow();call super::pfc_deleterow;if ancestorreturnvalue <> 1 then return ancestorreturnvalue

ib_borrando = false

return 1
end event

type st_split_horizontal from u_st_splitbar within w_catalogo_n2
integer y = 1020
integer width = 3227
integer height = 24
integer weight = 700
fontcharset fontcharset = ansi!
long backcolor = 268435456
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_Register(gb_maestro, ABOVE)
of_Register(dw_cat_listado_maestro, ABOVE)
of_Register(dw_cat_ficha_maestro, ABOVE)

of_Register(gb_detalle, BELOW)
of_Register(dw_cat_listado_detalle, BELOW)
of_Register(dw_cat_ficha_detalle, BELOW)
end event

type gb_maestro from u_gb within w_catalogo_n2
integer x = 18
integer width = 3182
integer height = 1000
integer taborder = 0
string text = "Maestro"
end type

type gb_detalle from u_gb within w_catalogo_n2
integer x = 18
integer y = 1052
integer width = 3182
integer height = 996
integer taborder = 0
string text = "Detalle"
end type


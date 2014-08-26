HA$PBExportHeader$w_consulta.srw
$PBExportComments$(LAC) Ancestro para las ventanas tipo cat$$HEX1$$e100$$ENDHEX$$logo de dos niveles
forward
global type w_consulta from w_main
end type
type dw_consulta from u_dw within w_consulta
end type
type dw_parametros from u_dw within w_consulta
end type
type st_split_horizontal from u_st_splitbar within w_consulta
end type
type gb_maestro from u_gb within w_consulta
end type
type gb_detalle from u_gb within w_consulta
end type
end forward

global type w_consulta from w_main
integer width = 3255
integer height = 2168
string title = "Consultas"
boolean toolbarvisible = false
event ue_ajusta_objetos ( )
event ue_cambia_vista ( )
event type long ue_procesar ( )
event type integer ue_valida_parametros ( )
event type long ue_retrieve_consulta ( )
event ue_post_procesa_consulta ( )
dw_consulta dw_consulta
dw_parametros dw_parametros
st_split_horizontal st_split_horizontal
gb_maestro gb_maestro
gb_detalle gb_detalle
end type
global w_consulta w_consulta

type variables
//Arreglo para definir los campos linkage
String	isarr_liga_maestro[5], isarr_liga_detalle[5]

boolean ib_borrando = false

//Var. para indicar si se realiza el retrieve al cargar
boolean ib_retrieve_inicio = true
end variables

event ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Acomoda los objetos del maestro
gb_maestro.x = 20
gb_maestro.y = 0
gb_maestro.width = width - 70

dw_parametros.x = gb_maestro.x + 30
dw_parametros.y = gb_maestro.y + 65
dw_parametros.width = gb_maestro.width - 60
dw_parametros.height = gb_maestro.height - 90

//Acomoda el split horizontal
st_split_horizontal.x = 0
st_split_horizontal.y = gb_maestro.y + gb_maestro.height + 20
st_split_horizontal.height = 25
st_split_horizontal.width = width - 35

//Acomoda los objetos del detalle
gb_detalle.x = 20
gb_detalle.y = st_split_horizontal.y + 20
gb_detalle.width = gb_maestro.width
gb_detalle.height = height - gb_detalle.y - 20

dw_consulta.x = gb_detalle.x + 30
dw_consulta.y = gb_detalle.y + 65 + 92
dw_consulta.width = gb_detalle.width - 60
dw_consulta.height = gb_detalle.height - (180)

//Ajusta el objeto de b$$HEX1$$fa00$$ENDHEX$$sqeuda de informaci$$HEX1$$f300$$ENDHEX$$n
dw_consulta.of_ajustadwbusqueda()

end event

event type long ue_procesar();//------------------------------------------------------------------
//  EVENTO/FUNCION	:	ue_procesa_reporte
//
//  DESCRIPCION		:	Evento que manda procesar el reporte con los
// 							argumentos dados
//  DEVUELVE			:
//		  1	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  29/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long	ll_renglon

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Valida los par$$HEX1$$e100$$ENDHEX$$metros
if event ue_valida_parametros() = -1 then return -1

//Carga el reporte
ll_renglon = event ue_retrieve_consulta()

//Ejecuta el post del proceso
post event ue_post_procesa_consulta()

return ll_renglon
end event

event type integer ue_valida_parametros();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if dw_parametros.dataobject <> '' then
	if dw_parametros.accepttext() = -1 then return -1
end if

return 0
end event

event type long ue_retrieve_consulta();//------------------------------------------------------------------
//  EVENTO/FUNCION	:	ue_retrieve_consulta
//
//  DESCRIPCION		:	Evento en el cual se deber$$HEX2$$e1002000$$ENDHEX$$realizar el retrieve
// 							al dw_consulta en los descendientes

//  DEVUELVE			:
//		  El n$$HEX1$$fa00$$ENDHEX$$mero de renglones resultante del retrieve
//			-1			: Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  29/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
return 0
end event

event ue_post_procesa_consulta();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------



end event

on w_consulta.create
int iCurrent
call super::create
this.dw_consulta=create dw_consulta
this.dw_parametros=create dw_parametros
this.st_split_horizontal=create st_split_horizontal
this.gb_maestro=create gb_maestro
this.gb_detalle=create gb_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_consulta
this.Control[iCurrent+2]=this.dw_parametros
this.Control[iCurrent+3]=this.st_split_horizontal
this.Control[iCurrent+4]=this.gb_maestro
this.Control[iCurrent+5]=this.gb_detalle
end on

on w_consulta.destroy
call super::destroy
destroy(this.dw_consulta)
destroy(this.dw_parametros)
destroy(this.st_split_horizontal)
destroy(this.gb_maestro)
destroy(this.gb_detalle)
end on

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
inv_resize.of_Register(dw_parametros,0,0,100,0)

inv_resize.of_Register (st_split_horizontal, 0, 0, 100, 0)

inv_resize.of_Register(gb_detalle, 0, 0, 100, 100)
inv_resize.of_Register(dw_consulta, 0, 0, 100, 100)
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
of_setMenu(m_apppfc_consulta)
end event

type dw_consulta from u_dw within w_consulta
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

of_setUpdateable(FALSE)
ib_rmbmenu = FALSE

of_SetTransObject(SQLCA)

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

of_setDWBusqueda(TRUE)
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

event pfc_preinsertrow;call super::pfc_preinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 1 then return ancestorreturnvalue

RETURN PREVENT_ACTION
end event

type dw_parametros from u_dw within w_consulta
integer x = 50
integer y = 68
integer width = 3099
integer height = 908
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

ib_rmbmenu = FALSE

//Apaga el servicio de no modificado
of_setupdateable(false)

//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(false)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(true)

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Servicio de ordenamiento por columnas
of_SetSort(FALSE)
//inv_sort.of_SetStyle (inv_sort.DRAGDROP)
//inv_sort.of_SetColumnHeader(TRUE)

//Servicio para validar los campos requeridos
of_SetReqColumn(TRUE)

//Asigna los valores default para el usuario que modifica
Modify("usuario_modifica.Initial='" + Upper(gs_id_usuario) + "'")

//Asigna los valores default para la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
Modify("fecha_movimiento.Initial='" + String(SQLCA.of_fechaservidor(), "dd/mm/yyyy hh:mm") + "'")

InsertRow(0)
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

event pfc_predeleterow;call super::pfc_predeleterow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


return PREVENT_ACTION
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


return PREVENT_ACTION
end event

type st_split_horizontal from u_st_splitbar within w_consulta
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
of_Register(dw_parametros, ABOVE)

of_Register(gb_detalle, BELOW)
of_Register(dw_consulta, BELOW)
end event

type gb_maestro from u_gb within w_consulta
integer x = 18
integer width = 3182
integer height = 1000
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Par$$HEX1$$e100$$ENDHEX$$metros"
end type

type gb_detalle from u_gb within w_consulta
integer x = 18
integer y = 1052
integer width = 3182
integer height = 996
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Resultado"
end type


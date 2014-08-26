HA$PBExportHeader$w_reportes.srw
$PBExportComments$(LAC) Ventana para los ancestros de los reportes
forward
global type w_reportes from w_main
end type
type tab_reporte from tab within w_reportes
end type
type tabpage_parametros from userobject within tab_reporte
end type
type dw_parametros from u_dw within tabpage_parametros
end type
type tabpage_parametros from userobject within tab_reporte
dw_parametros dw_parametros
end type
type tabpage_reporte from userobject within tab_reporte
end type
type dw_reporte from u_dw within tabpage_reporte
end type
type tabpage_reporte from userobject within tab_reporte
dw_reporte dw_reporte
end type
type tab_reporte from tab within w_reportes
tabpage_parametros tabpage_parametros
tabpage_reporte tabpage_reporte
end type
end forward

global type w_reportes from w_main
integer width = 2898
integer height = 1560
string title = "Reporte"
boolean toolbarvisible = false
boolean center = true
event ue_ajusta_objetos ( )
event type integer ue_valida_parametros ( )
event type integer ue_procesa_reporte ( )
event ue_post_procesa_reporte ( )
event type long ue_retrieve_reporte ( )
tab_reporte tab_reporte
end type
global w_reportes w_reportes

type variables
//Var. para la referencia a las dw
u_dw	idw_parametros, idw_reporte
end variables

event ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Ajusta el tab
tab_reporte.x = 5
tab_reporte.y = 5
tab_reporte.width = width - 60
tab_reporte.height = height - 20

//Ajusta el dw de reporte
idw_reporte.x = 5
idw_reporte.y = 5
idw_reporte.height = tab_reporte.tabpage_reporte.height - 10
idw_reporte.width = tab_reporte.tabpage_reporte.width - 10

//Ajusta el dw de reporte
idw_parametros.x = 5
idw_parametros.y = 5
idw_parametros.height = tab_reporte.tabpage_parametros.height - 10
idw_parametros.width = tab_reporte.tabpage_parametros.width - 10
end event

event type integer ue_valida_parametros();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if idw_parametros.dataobject <> '' then
	if idw_parametros.accepttext() = -1 then return -1
end if

return 0
end event

event type integer ue_procesa_reporte();//------------------------------------------------------------------
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
//  30/ABR/04	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
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
ll_renglon = event ue_retrieve_reporte()

//Ejecuta el post del proceso
post event ue_post_procesa_reporte()

return ll_renglon
end event

event ue_post_procesa_reporte();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if idw_reporte.rowcount() > 0 then
	//Asigna el titulo de la compania
	idw_reporte.modify("t_nombre_empresa.text='" + upper(gs_nombre_compania) + "'")

	//Asigna logo de la compa$$HEX1$$f100$$ENDHEX$$ia
//	idw_reporte.modify("p_logo_cliente.FileName='" + upper(gs_ruta_logo) + "'")
	idw_reporte.modify("p_logo_cliente.FileName='" + upper(gnv_app.of_getLogo()) + "'")
	gf_ajusta_logo(idw_reporte,"p_logo_cliente", gnv_app.is_logorep)
	
	//Cambia de tab al de reporte
	tab_reporte.tabpage_reporte.enabled = true
	tab_reporte.selecttab (2)
	idw_reporte.post setfocus()
	
	//Cambia a vista preview
	if not idw_reporte.inv_PrintPreview.of_GetEnabled() then idw_reporte.post event pfc_printpreview()

end if

end event

event type long ue_retrieve_reporte();//------------------------------------------------------------------
//  EVENTO/FUNCION	:	ue_retrieve_reporte
//
//  DESCRIPCION		:	Evento en el cual se deber$$HEX2$$e1002000$$ENDHEX$$realizar el retrieve
// 							al dw_reporte en los descendientes

//  DEVUELVE			:
//		  El n$$HEX1$$fa00$$ENDHEX$$mero de renglones resultante del retrieve
//			-1			: Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  30/ABR/04	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
return 0
end event

on w_reportes.create
int iCurrent
call super::create
this.tab_reporte=create tab_reporte
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_reporte
end on

on w_reportes.destroy
call super::destroy
destroy(this.tab_reporte)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Inicializa el servicio de resize
of_setresize(true)

//Registra los objetos
inv_resize.of_register(tab_reporte, 0,0,100,100)

// Deshabilita tabpage de Reportes
tab_reporte.tabpage_reporte.enabled = FALSE


end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if idw_parametros.dataobject <> '' then
	idw_parametros.post setfocus()
else 
	if idw_reporte.dataobject <> '' then idw_reporte.post setfocus()
end if
end event

event ue_define_menu;call super::ue_define_menu;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//En este evento se define el menu a usar para la ventana
of_setMenu(m_apppfc_reporte)


end event

type tab_reporte from tab within w_reportes
event create ( )
event destroy ( )
integer x = 9
integer y = 4
integer width = 2587
integer height = 1288
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
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_parametros tabpage_parametros
tabpage_reporte tabpage_reporte
end type

on tab_reporte.create
this.tabpage_parametros=create tabpage_parametros
this.tabpage_reporte=create tabpage_reporte
this.Control[]={this.tabpage_parametros,&
this.tabpage_reporte}
end on

on tab_reporte.destroy
destroy(this.tabpage_parametros)
destroy(this.tabpage_reporte)
end on

event selectionchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
choose case newindex
	case	1	//Par$$HEX1$$e100$$ENDHEX$$metros
		idw_parametros.post setfocus()
		// Deshabilita tabpage de reporte
		tab_reporte.tabpage_reporte.enabled = FALSE
	case	2	//Reporte
		idw_reporte.post setfocus()
		
end choose
end event

type tabpage_parametros from userobject within tab_reporte
integer x = 18
integer y = 104
integer width = 2551
integer height = 1168
long backcolor = 79741120
string text = "Par$$HEX1$$e100$$ENDHEX$$metros"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_parametros dw_parametros
end type

on tabpage_parametros.create
this.dw_parametros=create dw_parametros
this.Control[]={this.dw_parametros}
end on

on tabpage_parametros.destroy
destroy(this.dw_parametros)
end on

event constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Inicializa el servicio de resize
of_setresize(true)

//Registra los objetos
inv_resize.of_register(dw_parametros, 0,0,100,100)
end event

type dw_parametros from u_dw within tabpage_parametros
integer width = 2318
integer height = 1076
integer taborder = 20
boolean hscrollbar = true
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_settransobject(sqlca)
of_setupdateable(false)
ib_rmbmenu = false

//Inicializa las vars. de referencia
idw_parametros = this

//Servicio para poder ordenar mediante campos dddw
of_SetSort(FALSE)
end event

type tabpage_reporte from userobject within tab_reporte
integer x = 18
integer y = 104
integer width = 2551
integer height = 1168
long backcolor = 79741120
string text = "Reporte"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_reporte dw_reporte
end type

on tabpage_reporte.create
this.dw_reporte=create dw_reporte
this.Control[]={this.dw_reporte}
end on

on tabpage_reporte.destroy
destroy(this.dw_reporte)
end on

event constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Inicializa el servicio de resize
of_setresize(true)

//Registra los objetos
inv_resize.of_register(dw_reporte, 0,0,100,100)
end event

type dw_reporte from u_dw within tabpage_reporte
integer width = 2318
integer height = 1080
integer taborder = 11
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_settransobject(sqlca)
of_setupdateable(false)
ib_rmbmenu = false

of_setguardarcomo(true)
of_setprintpreview(true)
of_setzoom(true)

//Inicializa las vars. de referencia
idw_reporte = this
end event

event retrieveend;call super::retrieveend;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Asigna el titulo de la compania por si hubo cambio dinamico de dataobjects
modify("t_nombre_empresa.text='" + upper(gs_nombre_compania) + "'")

//Asigna logo de la compa$$HEX1$$f100$$ENDHEX$$ia
idw_reporte.modify("p_logo_cliente.FileName='" + upper(gnv_app.of_getLogo()) + "'")

////Pone en modo preview
//event pfc_printpreview()


end event


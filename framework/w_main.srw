HA$PBExportHeader$w_main.srw
$PBExportComments$Extension Main Window class
forward
global type w_main from pfc_w_main
end type
end forward

global type w_main from pfc_w_main
boolean visible = false
integer width = 2665
integer height = 1708
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
event ue_define_menu ( )
end type
global w_main w_main

type variables

boolean ib_cargando
dragobject lpo_actual
end variables

forward prototypes
public function integer of_setmenu (ref menu am_menu)
public function integer of_actualizatoolbar (menu am_menu)
public function integer of_closedocument ()
end prototypes

event ue_define_menu();//------------------------------------------------------------------
//  FUNCION/EVENTO	: ue_define_menu
//
//  DESCRIPCION		: 
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//En este evento se define el menu a usar para la ventana
//of_setMenu(m_apppfc_frame)
end event

public function integer of_setmenu (ref menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_SetMenu
//
//  DESCRIPCION		: Cambia el menu de la pantalla principal al correspondiente de la ventana
//
//  EVENTO/ARGUMENTOS: 
//				am_menu : menu que utilizara la ventana
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


RETURN gw_frame.of_SetMenu(am_menu)
end function

public function integer of_actualizatoolbar (menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_ActualizaToolBar
//
//  DESCRIPCION		: Actualiza el estaus de los botones de la barra de herramientas
//							Los unicos estatus que actualiza por el momento son el habilitado/deshabilitado
//							y el el toolbaritemdown, para esto primero hay que hacer los cambios en el menu
//							actual y despues llamar la funcion para actualizar la barra de herramientas
//
//  EVENTO/ARGUMENTOS: 
//					am_menu : menu ya modificado
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF not isvalid(am_menu) THEN RETURN 0

RETURN gw_frame.of_ActualizaToolBar(am_menu)
end function

public function integer of_closedocument ();

gw_frame.of_closeactivedocument()

RETURN 1
end function

on w_main.create
call super::create
end on

on w_main.destroy
call super::destroy
end on

event pfc_preopen;call super::pfc_preopen;//------------------------------------------------------------------
//  FUNCION/EVENTO	: pfc_preopen
//
//  DESCRIPCION		: 
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_cargando = TRUE
//En este evento se define el menu a usar para la ventana
event ue_define_menu()
end event

event pfc_controlgotfocus;call super::pfc_controlgotfocus;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombredw
boolean	lb_tbvisible = false, lb_cambiavista = false, lb_itemdown = false
m_apppfc_frame lm_menu
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

lpo_actual = adrg_control

IF NOT isvalid(gw_frame) THEN RETURN

IF isvalid(idw_active) AND isvalid(gw_frame.menuid) THEN
	lm_menu = gw_frame.menuid
	ls_nombredw = idw_active.classname()
	
	//Si el servicio de zoom est$$HEX2$$e1002000$$ENDHEX$$habilitado
	if isvalid(idw_active.inv_zoom) then
		lm_menu.m_view.m_zoom.enabled = true
//		lm_menu.m_view.m_zoom.toolbaritemvisible = true
	else
		lm_menu.m_view.m_zoom.enabled = false
//		lm_menu.m_view.m_zoom.toolbaritemvisible = false
	end if
	
	//////Habilita/inhabilita las opciones del men$$HEX2$$fa002000$$ENDHEX$$adecuadas
	////m_apppfc_frame.m_view.m_CambiarVista.Enabled = lb_cambiavista
	////m_apppfc_frame.m_view.m_CambiarVista.toolbaritemdown = lb_itemdown
	
	//Si el servicio de printpreview est$$HEX2$$e1002000$$ENDHEX$$activado habilita la opci$$HEX1$$f300$$ENDHEX$$n zoom
	if isvalid (idw_active.inv_PrintPreview) then
//		lm_menu.m_file.m_printpreview.visible = TRUE
		lm_menu.m_file.m_printpreview.enabled = TRUE
//		lm_menu.m_file.m_printpreview.toolbaritemvisible = TRUE
//		lm_menu.m_view.m_zoom.visible = TRUE//idw_active.inv_PrintPreview.of_GetEnabled()
		lm_menu.m_view.m_zoom.enabled = TRUE//idw_active.inv_PrintPreview.of_GetEnabled()
	else
//		lm_menu.m_file.m_printpreview.visible = FALSE
		lm_menu.m_file.m_printpreview.enabled = FALSE
//		lm_menu.m_file.m_printpreview.toolbaritemvisible = FALSE
	
//		lm_menu.m_view.m_zoom.visible = FALSE
		lm_menu.m_view.m_zoom.enabled = FALSE
	end if
	
	
	//Si el servicio de guardacomo est$$HEX2$$e1002000$$ENDHEX$$activado habilita la opci$$HEX1$$f300$$ENDHEX$$n saveas
	lm_menu.m_file.m_saveas.enabled =  idw_active.ib_guardarcomo
	
	IF IsValid(idw_active.inv_sort) THEN
		lm_menu.m_view.m_sort.enabled = TRUE
	ELSE
		lm_menu.m_view.m_sort.enabled = FALSE
	END IF


//	//Si el servicio de guardacomo est$$HEX2$$e1002000$$ENDHEX$$activado habilita la opci$$HEX1$$f300$$ENDHEX$$n saveas
//	m_apppfc_frame.m_edit.m_sep2.visible =  idw_active.ib_guardarcomo
//	m_apppfc_frame.m_edit.m_exportar.visible =  idw_active.ib_guardarcomo
//	m_apppfc_frame.m_edit.m_exportar.enabled =  idw_active.ib_guardarcomo
//	m_apppfc_frame.m_edit.m_exportar.toolbaritemvisible =  idw_active.ib_guardarcomo
//	m_apppfc_frame.m_edit.m_sep3.visible =  idw_active.ib_guardarcomo
END IF

//Actualiza la barra de herramientas
post of_ActualizaToolbar(gw_frame.menuid)


end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
//  FUNCION/EVENTO	: pfc_postopen
//
//  DESCRIPCION		: 
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_cargando = FALSE
end event

event activate;call super::activate;//------------------------------------------------------------------
//  FUNCION/EVENTO	: activate
//
//  DESCRIPCION		: 
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF not ib_cargando THEN
	Event ue_define_menu()
	IF isvalid(lpo_actual) THEN lpo_actual.SetFocus()
END IF
end event

event pfc_close;
of_CloseDocument()
end event


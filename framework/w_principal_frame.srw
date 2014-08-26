HA$PBExportHeader$w_principal_frame.srw
forward
global type w_principal_frame from w_frame
end type
type uo_opciones_menu from u_cst_shortcutbar within w_principal_frame
end type
type uo_toolbarstrip from u_cst_toolbarstrip within w_principal_frame
end type
type uo_powerdock from u_cst_powerdock within w_principal_frame
end type
end forward

global type w_principal_frame from w_frame
boolean visible = false
string title = "Princiapl"
string menuname = "m_apppfc_frame"
windowstate windowstate = maximized!
string icon = "AppIcon!"
boolean toolbarvisible = false
boolean center = true
event ue_anclar ( boolean ab_visible,  string as_objeto,  string as_texto,  string as_icono,  integer ai_posicion )
event ue_statusbardoubleclick ( integer ai_xpos,  integer ai_ypos,  string as_name )
event ue_statusbarclicked ( integer ai_xpos,  integer ai_ypos,  string as_name )
uo_opciones_menu uo_opciones_menu
uo_toolbarstrip uo_toolbarstrip
uo_powerdock uo_powerdock
end type
global w_principal_frame w_principal_frame

type variables

u_panel_opciones uo_panel[]
u_cst_buttonlistbar_menu uo_buttonlistbar[]

//Contiene los permisos del nivel de usuario
n_ds ids_permisos

boolean ib_multiplestab 

u_base iuo_paneles[]
end variables

forward prototypes
public function integer of_setmenu (ref menu am_menu)
public subroutine of_settheme (string as_color)
public function integer of_carga_opciones (menu am_menu)
public function integer of_actualizatoolbar (ref menu am_menu)
public function integer of_cargapermisosnivel (long al_nivel)
public function integer of_closeactivedocument ()
public function u_base of_getdockobject (string as_userobject)
end prototypes

event ue_anclar(boolean ab_visible, string as_objeto, string as_texto, string as_icono, integer ai_posicion);long ll_item

//uo_PowerDock.TOP = 1
//uo_PowerDock.BOTTOM = 2
//uo_PowerDock.LEFT = 3
//uo_PowerDock.RIGHT = 4

FOR ll_item = 1 TO UpperBound(iuo_paneles)
	IF IsValid(iuo_paneles[ll_item]) THEN
		IF iuo_paneles[ll_item].ClassName() = as_objeto AND NOT ab_visible THEN
			uo_PowerDock.of_RemoveDockItem(iuo_paneles[ll_item])
			DESTROY iuo_paneles[ll_item]
			RETURN
		END IF
	END IF
NEXT

ll_item = UpperBound(iuo_paneles) + 1

uo_PowerDock.of_AddDockItem(ai_posicion, iuo_paneles[ll_item], as_objeto, as_texto, as_icono)
end event

event ue_statusbardoubleclick(integer ai_xpos, integer ai_ypos, string as_name);
CHOOSE CASE as_name
	CASE "extra1", "extra2"

END CHOOSE


end event

event ue_statusbarclicked(integer ai_xpos, integer ai_ypos, string as_name);
RETURN
end event

public function integer of_setmenu (ref menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_setMenu
//
//  DESCRIPCION		: Asigna el menu correspondiente al Frame principal de la aplicacion
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  27/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//gw_frame.setredraw(FALSE)

//Cambia el menu de la ventana principal
ChangeMenu (am_menu) 

//Actualiza los botones de la barra de herramientas
uo_toolbarstrip.of_setEKMenu(this.menuid, TRUE)

//Carga los permisos para las opciones de la aplicacion
IF IsValid(ids_permisos) THEN gf_permisos_menu(this.menuid, ids_permisos)

//gw_frame.setredraw(TRUE)

RETURN 0


end function

public subroutine of_settheme (string as_color);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
userobject luo_objeto
n_cst_metaclass  lnv_metaclass
boolean lb_ancestro
string ls_classname
integer li_index
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_PowerDock.of_SetTheme(as_color)
uo_toolbarstrip.of_SetTheme(as_color)
uo_opciones_menu.of_SetTheme(as_color)


FOR li_index = 1 to UpperBound(Control[])
	IF IsValid(control[li_index]) THEN
		IF control[li_index].typeof() = userobject! THEN 
//			debugbreak()
			luo_objeto = control[li_index]
			ls_classname = luo_objeto.classname()
			
			IF lnv_metaclass.of_isAncestorClass(ls_classname ,'u_base') THEN
				Control[li_index].Dynamic of_SetTheme(as_color)
			END IF
		END IF	
	END IF
NEXT
end subroutine

public function integer of_carga_opciones (menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_Carga_Opciones
//
//  DESCRIPCION		: Carga la barra de accesos directos con el men$$HEX2$$fa002000$$ENDHEX$$de la aplicaci$$HEX1$$f300$$ENDHEX$$n
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  27/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_row, ll_row_find, ll_row_ini, ll_row_fin
n_ds lds_menu, lds_temp, lds_opciones
integer li_rtn, li_index, li_idx
string ls_nombre, ls_imagen, ls_tag

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Carga los permisos para el nivel de usuario
of_CargaPermisosNivel(gi_nivel)

//Carga el DS con el desglose de todo el men$$HEX1$$fa00$$ENDHEX$$
lds_menu = CREATE n_ds
lds_menu.dataobject = 'd_ex_gr_menu'

ll_row = lds_menu.InsertRow(0)
lds_menu.Object.nombre[ll_row] 			 = am_menu.classname()
lds_menu.Object.nivel[ll_row] 			    = 1
lds_menu.Object.orden[ll_row] 			    = 1
lds_menu.Object.texto[ll_row] 			    = 'Men$$HEX1$$fa00$$ENDHEX$$'
lds_menu.Object.ind_visible[ll_row] 	    = 0
lds_menu.Object.ind_habilitado[ll_row]   = 0

//li_rtn = gf_desglose_menu(am_menu, 1, 1, lds_menu)
li_rtn = gf_desglose_menu_ek(am_menu, 1, 1, lds_menu, ids_permisos)

//lds_menu.SaveAs("C:\lec"+string(li_index)+".xls",excel!, true)

lds_menu.SetFilter("ind_visible = 1")
lds_menu.Filter()
lds_menu.Sort()

lds_temp = CREATE n_ds
lds_temp.dataobject = lds_menu.dataobject
lds_menu.RowsCopy(1, lds_menu.RowCount(), Primary!, lds_temp, 1, Primary!)



lds_temp.SetFilter("nivel = 2 and nombre not in ('m_file', 'm_edit', 'm_view', 'm_insert', 'm_tools', 'm_window', 'm_help' )	")
lds_temp.Filter()

//IF lds_temp.RowCount() = 0 THEN RETURN -1

lds_opciones = CREATE n_ds
lds_opciones.dataobject = lds_menu.dataobject

FOR li_index = 1 TO lds_temp.RowCount()
	ll_row_ini = lds_menu.Find("nombre = '" + lds_temp.object.nombre[li_index] + "'", 1, lds_menu.RowCount())
	ll_row_fin = lds_menu.Find("nivel <= " + string(lds_menu.object.nivel[ll_row_ini]) , ll_row_ini + 1, lds_menu.RowCount())	 - 1
	
	IF ll_row_fin <= 0 THEN ll_row_fin = lds_menu.RowCount()
	
	lds_opciones.Reset()
	lds_opciones.SetSort("orden")
	lds_opciones.Sort()
	
	lds_menu.RowsCopy(ll_row_ini, ll_row_fin, Primary!, lds_opciones, 1, Primary!)
	
//	lds_opciones.SaveAs("C:\lec"+string(li_index)+".xls",excel!, true)

	ls_nombre = gnv_funciones_string.of_globalReplace(lds_temp.object.texto[li_index],"&","")
	ls_imagen = lds_temp.object.imagen[li_index]
	ls_tag = lds_temp.object.tag[li_index]
	IF isnull(ls_tag) THEN ls_tag = ""
	CHOOSE CASE ls_tag
		CASE 'BUTTON'
			li_idx = UpperBound(uo_buttonlistbar) + 1
			OpenUserObject( uo_buttonlistbar[li_idx],0 ,0)
			uo_buttonlistbar[li_idx].of_inicializar(am_menu, lds_opciones)
			uo_opciones_menu.of_addItem(uo_buttonlistbar[li_idx],	ls_nombre,	ls_imagen)
		CASE ELSE //'TREEVIEW'
			OpenUserObject( uo_panel[li_index],0 ,0)
			uo_panel[li_index].of_inicializar(am_menu, lds_opciones)
			uo_opciones_menu.of_addItem(uo_panel[li_index],	ls_nombre,	ls_imagen)
	END CHOOSE
	
NEXT

//-------------------------------------------------------------
lds_temp.SetFilter("nivel = 2 and nombre in ('m_tools' )	")
lds_temp.Filter()

IF lds_temp.RowCount() = 1 THEN
	ll_row_ini = lds_menu.Find("nombre = '" + lds_temp.object.nombre[1] + "'", 1, lds_menu.RowCount())
	ll_row_fin = lds_menu.Find("nivel <= " + string(lds_menu.object.nivel[ll_row_ini]) , ll_row_ini + 1, lds_menu.RowCount())	 - 1
	
	IF ll_row_fin <= 0 THEN ll_row_fin = lds_menu.RowCount()
	
	lds_opciones.Reset()
	lds_opciones.SetSort("orden")
	lds_opciones.Sort()
	
	lds_menu.RowsCopy(ll_row_ini, ll_row_fin, Primary!, lds_opciones, 1, Primary!)

	ls_nombre = gnv_funciones_string.of_globalReplace(lds_temp.object.texto[1],"&","")
	ls_imagen = lds_temp.object.imagen[1]
	
	li_index = UpperBound(uo_panel) + 1
	
	OpenUserObject( uo_panel[li_index],0 ,0)
	uo_panel[li_index].of_inicializar(am_menu, lds_opciones)
	uo_opciones_menu.of_addItem(uo_panel[li_index],	ls_nombre,	ls_imagen)
	
END IF
//--------------------------------------------------------------------

gf_permisos_menu(this.menuid, ids_permisos)

//lds_menu.SaveAs("C:\lec.xls",excel!, true)
uo_opciones_menu.of_selectItem(1)

DESTROY lds_opciones

RETURN li_rtn
end function

public function integer of_actualizatoolbar (ref menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_ActualizaToolBar
//
//  DESCRIPCION		: Actualiza el estatus de los botones de la barra de herramientas
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  27/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_toolbarStrip.of_actualizamenuek(am_menu)

RETURN 0
end function

public function integer of_cargapermisosnivel (long al_nivel);
IF IsValid(ids_permisos) THEN DESTROY ids_permisos

//Carga los permisos para el nivel de usuario
ids_permisos = CREATE n_ds
ids_permisos.of_Create("SELECT * FROM ek032ab " + &
								" WHERE nivel = "+string(al_nivel) + &
								" AND sistema = '"+gs_sistema+"'", SQLCA)
long ll_row
ll_row = ids_permisos.insertrow(0)
ids_permisos.object.nivel[ll_row] = 1
ids_permisos.object.menu[ll_row] = "m_isql"

RETURN ids_permisos.RowCount()
end function

public function integer of_closeactivedocument ();
uo_powerdock.of_closeactivedocument( )

RETURN 1
end function

public function u_base of_getdockobject (string as_userobject);long ll_item

//uo_PowerDock.TOP = 1
//uo_PowerDock.BOTTOM = 2
//uo_PowerDock.LEFT = 3
//uo_PowerDock.RIGHT = 4

FOR ll_item = 1 TO UpperBound(iuo_paneles)
	IF IsValid(iuo_paneles[ll_item]) THEN
		IF iuo_paneles[ll_item].ClassName() = as_userobject THEN
			RETURN iuo_paneles[ll_item]
		END IF
	END IF
NEXT

end function

on w_principal_frame.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_apppfc_frame" then this.MenuID = create m_apppfc_frame
this.uo_opciones_menu=create uo_opciones_menu
this.uo_toolbarstrip=create uo_toolbarstrip
this.uo_powerdock=create uo_powerdock
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_opciones_menu
this.Control[iCurrent+2]=this.uo_toolbarstrip
this.Control[iCurrent+3]=this.uo_powerdock
end on

on w_principal_frame.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_opciones_menu)
destroy(this.uo_toolbarstrip)
destroy(this.uo_powerdock)
end on

event closequery;call super::closequery;//------------------------------------------------------------------
//  FUNCION/EVENTO	: closequery
//
//  DESCRIPCION		: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------



//Valida si realmente se desa salir 
If Messagebox(gs_NombreApp, "$$HEX1$$bf00$$ENDHEX$$Desea salir de la aplicaci$$HEX1$$f300$$ENDHEX$$n?", Question!, YesNo!, 2) = 2 & 
		 Then Return 1 




end event

event open;call super::open;//------------------------------------------------------------------
//  FUNCION/EVENTO	: Open
//
//  DESCRIPCION		: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Pone el t$$HEX1$$ed00$$ENDHEX$$tulo de la ventana
title = gs_NombreApp //+ space(15) + gs_nombre_compania + space(5) + " - " + upper(gs_nombre_usuario)

// Configuraci$$HEX1$$f300$$ENDHEX$$n de los servicios de la ventana
of_SetResize( TRUE )

uo_toolbarstrip.X = 0
uo_toolbarstrip.Y = 0
//uo_toolbarstrip.Height = 122 //iconos chicos
//uo_toolbarstrip.Height = 142 //iconos medianos
uo_powerdock.X = 0
uo_powerdock.Y = uo_toolbarstrip.Height

//SMALL, MEDIUM, LARGE, XLARGE
uo_toolbarstrip.of_SetSize(uo_toolbarstrip.SMALL)
		
//SMALL, LARGE
uo_opciones_menu.of_SetSize(uo_opciones_menu.LARGE)

//uo_PowerDock.uo_powerdocktab.of_HideChevron()
uo_PowerDock.of_ShowCloseButton()
////uo_PowerDock.uo_powerTab.of_HideArrows()
uo_PowerDock.of_DisplayCloseButtonInTab(FALSE)

//Abre el visualizador como un documento en el TabControl
//uo_PowerDock.of_OpenDocument(w_default, 'Inicio',"AppIcon!")

//Activa el documento
//Agregar objetos a los paneles uo_PowerDock.LEFT. BOTTOM, TOP, RIGHT
uo_PowerDock.of_AddDockItem(uo_PowerDock.LEFT, uo_opciones_menu, gs_nombreapp, 'AppIcon!')

//Asigna el foco al explorador
uo_PowerDock.of_SetDockItemFocus(uo_opciones_menu)

//asigna el tama$$HEX1$$f100$$ENDHEX$$o inicial (ancho)
uo_PowerDock.of_SetDockSize(uo_PowerDock.LEFT, 1000)

//Auto dock the left dock window
uo_PowerDock.of_SetDock(uo_PowerDock.LEFT, TRUE)

//gs_temaactual = "Silver"
of_setTheme(gs_temaactual)

//Carga las opciones del menu en la barra tipo outlook
of_carga_opciones(this.menuid)

//uo_opciones_menu.of_hideall( )

//Carga el menu del ToolBar
of_SetMenu(this.menuid)

Show()

end event

event pfc_preopen;call super::pfc_preopen;//------------------------------------------------------------------
//  FUNCION/EVENTO	: pfc_preopen
//
//  DESCRIPCION		: Inicializa la ventana de la aplicacion
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_compania
integer li_rtn
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Inicializa la referencia de la ventana frame
gw_frame = this

//Inicializa los servicios de la ventana
of_SetStatusBar(True)

inv_statusbar.of_SetBorderType ( 6 )

inv_statusbar.of_SetBar(TRUE)
inv_statusbar.of_SetBarWidth(1800)
//inv_statusbar.of_SetBarAutoReset (TRUE)
//this.inv_statusbar.of_SetBarReset (TRUE)
//instancename.of_Modify ( id, newvalue )	
ls_compania = gs_num_cia + " - " + gs_nombre_compania 
ls_compania =  gnv_funciones_string.of_globalreplace(ls_compania, "'", "")
li_rtn = inv_statusbar.of_Register &
	("compania", "text",ls_compania, 1100)
li_rtn = inv_statusbar.of_Register &
	("extra1", "text","", 800)
li_rtn = inv_statusbar.of_Register &
	("extra2", "text","", 800)
inv_statusbar.of_Register &
	("imguser", "bitmap", "ico\usuarios.bmp", 64)
li_rtn = inv_statusbar.of_register &
	("username","text",gnv_app.of_GetUserID(),500)
inv_statusbar.of_Register &
	("imgfecha", "bitmap", "ico\fechahora.bmp", 64)
	
inv_StatusBar.of_SetTimer(True)



end event

event resize;call super::resize;//------------------------------------------------------------------
//  FUNCION/EVENTO	: Resize
//
//  DESCRIPCION		: Ajusta los objetos
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_toolbarstrip.Width = THIS.WorkSpaceWidth() - 12
uo_PowerDock.Resize(THIS.WorkSpaceWidth() - 8,THIS.WorkSpaceHeight() - MDI_1.MicroHelpHeight	- uo_toolbarstrip.Height - 10)

end event

event pfc_messagerouter;// SE ESTA SALTANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//
//	Event:  pfc_messagerouter
//
//	Arguments:
//	as_message   message (event notification) to send
//
//	Returns:  integer
//	 1 = message successfully sent
//	 0 = no receivers recognized the message
//	-1 = error
//
//	Description:	 
//	This event routes a message (event notification) 
//	to the appropriate object.
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

graphicobject lgo_focus
window lw_window

// Check argument
If IsNull (as_message) or Len (Trim (as_message)) = 0 Then
	Return -1
End If

//LEC Revisa cual es la ventana activa para rutear el evento a la ventana actual
lw_window  = uo_powerdock.of_getActiveWindow()
IF IsValid(lw_window) THEN
	If lw_window.TriggerEvent (as_message) = 1 Then Return 1
END IF

// Try sending the message to this window, if successful exit event.
If This.TriggerEvent (as_message) = 1 Then Return 1

// Try sending the message to the current control, if successful exit event.
lgo_focus = GetFocus()
If IsValid (lgo_focus) Then
	If lgo_focus.TriggerEvent (as_message) = 1 Then Return 1
End If

// Try sending the message to the last active datawindow, if successful exit event.
If IsValid (idw_active) Then
	If idw_active.TriggerEvent (as_message) = 1 Then Return 1
End If

// No objects recognized the message
Return 0
end event

type uo_opciones_menu from u_cst_shortcutbar within w_principal_frame
integer x = 1454
integer y = 364
integer taborder = 20
end type

on uo_opciones_menu.destroy
call u_cst_shortcutbar::destroy
end on

type uo_toolbarstrip from u_cst_toolbarstrip within w_principal_frame
integer taborder = 30
end type

event constructor;call super::constructor;//------------------------------------------------------------------
//  FUNCION/EVENTO	: Constructor
//
//  DESCRIPCION		: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

of_DisplayRaisedBorder(TRUE)
end event

on uo_toolbarstrip.destroy
call u_cst_toolbarstrip::destroy
end on

type uo_powerdock from u_cst_powerdock within w_principal_frame
integer y = 320
integer width = 1001
integer height = 740
integer taborder = 30
end type

event documentclosing;call super::documentclosing;
//IF index = 1 THEN 
////	Messagebox(gs_nombreapp, "No puede cerrar la pantalla principal", information!)
//	RETURN 0
//ELSE
//	RETURN 1
//END IF

RETURN 1
end event

event panelpinned;call super::panelpinned;//Parent.SetMicroHelp("Panel Pinned " + String(panel))
post SetRedraw(TRUE)
end event

on uo_powerdock.destroy
call u_cst_powerdock::destroy
end on

event documentclosed;call super::documentclosed;
IF this.uo_powerdocktab.of_gettabcount( ) = 0 THEN
	parent.of_setMenu(m_apppfc_frame)
END IF

end event

event resize;call super::resize;w_master lw_window 
IF isvalid(gnv_app.inv_debug) THEN  gnv_app.inv_debug.of_message( "RESIZE POWERDOCK" )

//lw_window = uo_powerdock.of_getActiveWindow()
//IF isvalid(lw_window) THEN lw_window.event resize(sizetype, 0, 0)

this.of_alldocumenttriggerevent( "ue_ajusta_objetos")


end event


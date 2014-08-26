HA$PBExportHeader$w_master.srw
$PBExportComments$Extension Master Window class
forward
global type w_master from pfc_w_master
end type
end forward

global type w_master from pfc_w_master
event type integer ue_busqueda ( )
event ue_ajusta_objetos ( )
end type
global w_master w_master

type variables
//Var. para obtener la columna activa
string	is_columna_activa

//Var. para el nombre del objeto
string	is_classname

//Var. para el handle de la ventana
long	il_handle
end variables

forward prototypes
protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default)
public subroutine of_settheme (string as_color)
end prototypes

event type integer ue_busqueda();//------------------------------------------------------------------
//  EVENTO/FUNCION	:	ue_busqueda
//
//  DESCRIPCION		:	Evento para realizar las b$$HEX1$$fa00$$ENDHEX$$squedas de datos por campo
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  16/FEB/04	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if idw_active.dataobject = '' then return -1

//Obtiene la columna activa
is_columna_activa = idw_active.getcolumnname()

if is_columna_activa = '' then return -1

//Ejemplo de como llamar la ayuda
////Clave, titulo, where(si aplica), regresa(numeros o nombres de columnas a regresar, separados por coma), sel.multiple, trans
//gf_f1("CC",'',ls_where,'1',FALSE,sqlca)

return 0





end event

event ue_ajusta_objetos();//------------------------------------------------------------------
// EVENTO PARA PROGRAMAR EL AJUSTE INICIAL DE OBJETOS PARA EL RESIZE
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

end event

protected function integer of_messagebox (string as_id, string as_title, string as_text, icon ae_icon, button ae_button, integer ai_default);//////////////////////////////////////////////////////////////////////////////
// LAC: No muestre mensajes vac$$HEX1$$ed00$$ENDHEX$$os
//////////////////////////////////////////////////////////////////////////////
//
//	Function:  			of_MessageBox
//
//	Access:  			protected
//
//	Arguments:
//	as_id			An ID for the Message.
//	as_title  	Text for title bar
//	as_text		Text for the actual message.
//	ae_icon 		The icon you want to display on the MessageBox.
//	ae_button	Set of CommandButtons you want to display on the MessageBox.
//	ai_default  The default button.
//
//	Returns:  integer
//	Return value of the MessageBox.
//
//	Description:
//	Display a PowerScript MessageBox.  
//	Allow PFC MessageBoxes to be manipulated prior to their actual display.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
if as_text = '' then return 0
Return MessageBox(as_title, as_text, ae_icon, ae_button, ai_default)
end function

public subroutine of_settheme (string as_color);// -----------------------------------------------------------------------------
// SCRIPT:		of_SetTheme
//
// PURPOSE:		This function can be called from the window object for
//					all tabpages. Within each tabpage, call of_SetTheme on
//					each advanced GUI control.
//
// ARGUMENTS:	as_color - Name of the theme
//
// RETURN:		None
// -----------------------------------------------------------------------------
//------------------------------------------------------------------
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


FOR li_index = 1 to UpperBound(Control[])
		IF control[li_index].typeof() = userobject! THEN 
			luo_objeto = control[li_index]
			ls_classname = luo_objeto.classname()
			
			IF lnv_metaclass.of_isAncestorClass(ls_classname ,'u_base') THEN
				Control[li_index].Dynamic of_SetTheme(as_color)
			END IF
		END IF	
NEXT
end subroutine

on w_master.create
call super::create
end on

on w_master.destroy
call super::destroy
end on

event type integer pfc_endtran(integer ai_update_results);call super::pfc_endtran;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//C$$HEX1$$f300$$ENDHEX$$digo para que revise y termine la transacci$$HEX1$$f300$$ENDHEX$$n
if ai_update_results = 1 then
	if sqlca.of_commit() <> -1 then
		return 1
	end if
else
	sqlca.of_rollback()
	return -1
end if
end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//...Ejecuta el evento para ajustes iniciales de objetos
post event ue_ajusta_objetos()
end event

event pfc_preopen;call super::pfc_preopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//...Ejecuta el evento para ajustes iniciales de objetos
post event ue_ajusta_objetos()
end event


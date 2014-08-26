HA$PBExportHeader$n_cst_dwutil.sru
$PBExportComments$(LEC) Engloba funciones para el dw
forward
global type n_cst_dwutil from n_base
end type
end forward

global type n_cst_dwutil from n_base autoinstantiate
end type

type variables


u_dw	idw_requestor

end variables

forward prototypes
public function integer of_setrequestor (u_dw adw_requestor)
public function integer of_actualiza_texto_dddw (string as_campo_hijo, string as_campo_descripcion)
public function integer of_asigna_dddw (string as_nombredw, string as_campo, string as_datacolumn, string as_displaycolumn)
public function integer of_asigna_param_dw (string as_nuevos_param)
public function integer of_asignaparam_dwchild (string as_campo_child, string as_nuevos_param)
public function integer of_busca_renglon_dwchild (string as_campo_hijo, string as_criterio, long al_renglon_inicial)
public function integer of_cambia_sqlselect_dw (string as_sqlselect_nuevo, boolean ab_recargar, boolean ab_iralprimero)
public function integer of_cambia_sqlselect_dwchild (string as_campo_child, string as_sqlselect_nuevo, boolean ab_iralprimero, n_tr atr_transaccion)
public function integer of_filtra_dwchild (string as_campo_child, string as_criterio)
public function integer of_findrow_dwchild (string as_campo_child, string as_criterio, long al_renglon_inicial)
public function integer of_genera_dddw (string as_campo, string as_sintaxis_sql, integer ai_campos, string as_registro_especial, boolean ab_reg_esp_inicio, n_tr atr_transaccion)
public function integer of_genera_dddw_char (string as_campo, string as_sintaxis_sql, integer ai_campos, string as_registro_especial, boolean ab_reg_esp_inicio, n_tr atr_transaccion)
public function integer of_habilita_deshabilita (string as_campos, integer ai_accion, long al_color)
public function integer of_habilita_deshabilita_dw (string as_campos, boolean ab_habilita, long al_color_habilitar, long al_color_inhabilitar)
public function any of_lee_campo_dwchild (string as_campo_child, string as_campo)
public function string of_lee_sqlselect_dw ()
public function string of_lee_sqlselect_dwchild (string as_campo_child, boolean ab_msgerror)
public function integer of_objetos_dw (ref string asarr_objetos[], string as_tipo, string as_banda)
public function integer of_propiedades_dddw (string as_campo_hijo, string as_propiedades)
public subroutine of_protect_dw (string as_tipo, string as_banda, string as_protect)
public function integer of_setrow_dwchild (string as_campo_hijo, long al_renglon)
public function integer of_setvisible (string as_campos, boolean ab_valor)
public function integer of_setvisible_child (string as_campo_hijo, string as_campos, boolean ab_mostrar, boolean ab_oculta_encabezado)
public function integer of_create (string as_sql, n_tr atr_conexion)
end prototypes

public function integer of_setrequestor (u_dw adw_requestor);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_SetRequestor
//
//	Access:    Public
//
//	Arguments:
//   adw_Requestor   The datawindow requesting the service
//
//	Returns:  None
//
//	Description:  Associates a datawindow control with a datawindow service NVO
//			        by setting the idw_Requestor instance variable.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Added function return code.
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

If IsNull(adw_requestor) or Not IsValid(adw_requestor) Then
	Return -1
End If

idw_Requestor = adw_Requestor
Return 1
end function

public function integer of_actualiza_texto_dddw (string as_campo_hijo, string as_campo_descripcion);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_actualiza_texto_dddw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que actualiza el texto que se muestra en el edit control de 
//		dddw del campo hijo para el dw padre dado
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor					: Referencia al DW padre
//		as_campo_hijo				: Nombre del campo hijo en el dw padre
//		as_campo_descripcion	: Nombre del campo de donde se va a obtener la descripci$$HEX1$$f300$$ENDHEX$$n (del dw child)
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  17/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_criterio, ls_desc, ls_tipodatos, ls_columna
Long	ll_renglon, ll_renglon_hijo
Integer	li_regresa, li_pos
Any	la_valor
Pointer	lp_original
Datawindowchild ldwch_child

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_hijo) Or Trim(as_campo_hijo) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_actualiza_texto_dddw', no se ha " + &
				"especificado el campo hijo", StopSign!)
	Return -1
End If

If IsNull(as_campo_descripcion) Or Trim(as_campo_descripcion) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_actualiza_texto_dddw', no se ha " + &
				"especificado el campo~r de donde se va a obtener la descripci$$HEX1$$f300$$ENDHEX$$n", StopSign!)
	Return -1
End If

ll_renglon = idw_requestor.GetRow()

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_hijo, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_actualiza_texto_dddw', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en el campo '" + as_campo_hijo + "'", StopSign!)
	Return -1
End If

//Obtiene el n$$HEX1$$fa00$$ENDHEX$$mero de rengl$$HEX1$$f300$$ENDHEX$$n actual de dw padre
ll_renglon = idw_requestor.GetRow()
If IsNull(ll_renglon) Or ll_renglon <= 0 Then Return 0

//Obtiene el tipo de datos campo child
ls_tipodatos = Upper(ldwch_child.Describe(as_campo_hijo + ".Coltype"))

//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
li_pos = Pos(ls_tipodatos, "(", 1)
If li_pos > 0 Then ls_tipodatos = Mid ( ls_tipodatos, 1, li_pos - 1)

//Lee el dato correspondiente registro actual del dw padre
Choose Case Upper(ls_tipodatos)
	Case	"INTEGER", "NUMBER", "LONG"	
		la_valor = idw_requestor.GetItemNumber(ll_renglon, as_campo_hijo)
	Case	"STRING" , "CHAR"
		la_valor = idw_requestor.GetItemString(ll_renglon, as_campo_hijo)
	Case 	"DATE"
		la_valor = idw_requestor.GetItemDate(ll_renglon, as_campo_hijo)
	Case	"DATETIME"		
		la_valor = idw_requestor.GetItemDateTime(ll_renglon, as_campo_hijo)
	Case	"DECIMAL"
		la_valor = idw_requestor.GetItemDecimal(ll_renglon, as_campo_hijo)
	Case Else
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_actualiza_texto_dddw', el tipo de datos '" + ls_tipodatos + "' no es v$$HEX1$$e100$$ENDHEX$$lido", StopSign!)
		SetNull(la_valor)
End Choose	

//Busca el rengl$$HEX1$$f300$$ENDHEX$$n con $$HEX1$$e900$$ENDHEX$$se criterio
ls_criterio = as_campo_hijo + "  = " + String(la_valor)
ll_renglon_hijo = ldwch_child.Find(ls_criterio, 1, ldwch_child.Rowcount())
If ll_renglon_hijo > 0 Then
	//Se mueve al rengl$$HEX1$$f300$$ENDHEX$$n
	If ldwch_child.ScrollToRow ( ll_renglon_hijo ) = -1 Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_actualiza_texto_dddw' al cambiar de rengl$$HEX1$$f300$$ENDHEX$$n en la dw child del campo '" + as_campo_hijo + "'", StopSign!)
	Else
		//Obtiene columna actual y posiciona en columna de el child
		ls_columna	= idw_requestor.GetColumnName()
		idw_requestor.SetColumn( as_campo_hijo )
		//Selecciona el rengl$$HEX1$$f300$$ENDHEX$$n
		ldwch_child.selectrow(0, False)
		ldwch_child.ScrollToRow ( ll_renglon_hijo ) 
		ldwch_child.selectrow(ll_renglon_hijo, True)
		//Obtiene la descripci$$HEX1$$f300$$ENDHEX$$n
		ls_desc = ldwch_child.GetItemString(ll_renglon_hijo, as_campo_descripcion)
		//Pone la descripci$$HEX1$$f300$$ENDHEX$$n en el dddw del campo hijo del dw padre
		idw_requestor.SetText(ls_desc)
		//Regresa a columna original
		idw_requestor.SetColumn( ls_columna )
	End If
End If

Return 0

end function

public function integer of_asigna_dddw (string as_nombredw, string as_campo, string as_datacolumn, string as_displaycolumn);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_asigna_dddw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que pone el dddw especificado en el campo dado
//		en 'as_campo' del DW 'idw_requestor'
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			:	Referencia al DW en donde est$$HEX1$$e100$$ENDHEX$$n los campos.
//		as_nombredw		:	Nombre del dw que va a fungir como dddw.
//		as_campo			:	
//		as_datacolumn		:	
//		as_displaycolumn	:
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer	li_contador
String 	ls_Campo, ls_regresa, ls_required, ls_NilIsNull

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

// Valida argumentos
If IsNull(as_campo) Or Trim(as_campo) = "" Then Return 0
If IsNull(as_nombredw) Or Trim(as_nombredw) = "" Then Return 0

//Obtiene el estatus 'Required' para el campo
ls_required = ""
If idw_requestor.Describe(as_campo + ".Edit.Required") = "yes" Then
	ls_required = "Required=Yes,"
ElseIf idw_requestor.Describe(as_campo + ".EditMask.Required") = "yes" Then
	ls_required = "Required=Yes,"
ElseIf idw_requestor.Describe(as_campo + ".DDDW.Required") = "yes" Then
	ls_required = "Required=Yes,"
ElseIf idw_requestor.Describe(as_campo + ".DDLB.Required") = "Yes" Then
End If

//Obtiene el estatus 'NillIsNull' para el campo
ls_NilIsNull = ""
If idw_requestor.Describe(as_campo + ".Edit.NilIsNull") = "yes" Then
	ls_NilIsNull = "NilIsNull=Yes,"
ElseIf idw_requestor.Describe(as_campo + ".EditMask.NilIsNull") = "yes" Then
	ls_NilIsNull = "NilIsNull=Yes,"
ElseIf idw_requestor.Describe(as_campo + ".DDDW.NilIsNull") = "yes" Then
	ls_NilIsNull = "NilIsNull=Yes,"
ElseIf idw_requestor.Describe(as_campo + ".DDLB.NilIsNull") = "Yes" Then
End If

//Asigna el dddw en el campo
of_propiedades_dddw( as_campo, "Name=" + as_nombredw)

//Pone el datacolumn
of_propiedades_dddw( as_campo, "DataColumn=" + as_datacolumn)

//Pone el displaycolumn
of_propiedades_dddw( as_campo, "DisplayColumn=" + as_displaycolumn)

//Pone el vertical scrollbar,el show arrow list y el required
of_propiedades_dddw( as_campo, ls_required + ls_NilIsNull + "HScrollbar=YES,VScrollbar=YES,UseAsBorder=YES,AutoHScroll=True")

Return 0

end function

public function integer of_asigna_param_dw (string as_nuevos_param);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_asigna_param_dw
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que asigna nuevos par$$HEX1$$e100$$ENDHEX$$metros para las dw basadas en SP
//		NOTA : Se realiza un retrieve al aplicar los par$$HEX1$$e100$$ENDHEX$$metros
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			:	Referencia al dw
//		as_nuevos_param	:	String con los nuevos par$$HEX1$$e100$$ENDHEX$$metros separados por comas
//									Ejemplo: @NameOfProcArg=<Valor>,  @NameOfProcArg=<Valor>,...
//				NOTA: Para enviar como par$$HEX1$$e100$$ENDHEX$$metro un valor de tipo string hay que anteponerle
//				doble tilde a la comilla simple (~~'), ejemplo : @pCveOperacion = ~~'A~~'
//
//  DEVUELVE			:
//		El n$$HEX1$$fa00$$ENDHEX$$mero de renglones le$$HEX1$$ed00$$ENDHEX$$dos	: 	Si no hubo errores
//		 -1										:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_sintaxis, ls_sintaxis_original, ls_error, ls_param, ls_modistring, lsarr_sintaxis[]
Long		ll_renglones
Pointer	lp_original

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Obtiene la sintaxis actual de la declaraci$$HEX1$$f300$$ENDHEX$$n de la SP
ls_sintaxis = idw_requestor.Describe("DataWindow.Table.Procedure")
//Respalda la sintaxis original
ls_sintaxis_original = ls_sintaxis

//Valida que no haya ocurrido un error
If Pos ( ls_sintaxis, "!" ) > 0 Or Pos ( ls_sintaxis, "?" ) > 0 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en la funci$$HEX1$$f300$$ENDHEX$$n 'of_asigna_param_dw', no se pudo leer la sintaxis ~r" + &	
					"de la declaraci$$HEX1$$f300$$ENDHEX$$n de la SP para la DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer(lp_original)
	Return -1
End If

//De la sintaxis original quita la secci$$HEX1$$f300$$ENDHEX$$n de los par$$HEX1$$e100$$ENDHEX$$metros
gnv_funciones_string.of_ParseToArray(ls_sintaxis, "@", lsarr_sintaxis)
ls_sintaxis = lsarr_sintaxis[1]

//Le concatena los nuevos par$$HEX1$$e100$$ENDHEX$$metros
ls_sintaxis = ls_sintaxis + as_nuevos_param

//Cambia la sintaxis a la dw
ls_modistring = "DataWindow.Table.Procedure='" + ls_sintaxis + "'"

ls_error = idw_requestor.Modify(ls_modistring)
If Trim(ls_error) <> "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_asigna_param_dw' al aplicar los argumentos nuevos~rde la DW  '" +  idw_requestor.DataObject + "' :~r'" + &
				 ls_error + "'",Stopsign!)
				 
	//Devuelve la sintaxis original
	ls_modistring = "DataWindow.Table.Procedure='" + ls_sintaxis_original + "'"
	ls_error = idw_requestor.Modify(ls_modistring)
End If


//Realiza el retrieve a la dw con los nuevos argumentos
ll_renglones = idw_requestor.Retrieve()

Return 0

end function

public function integer of_asignaparam_dwchild (string as_campo_child, string as_nuevos_param);////////////////////////////////////////////////////////////////////
//	DESCRIPCION	:
//		Funci$$HEX1$$f300$$ENDHEX$$n que asigna nuevos par$$HEX1$$e100$$ENDHEX$$metros para los dwchild cuyas dw est$$HEX1$$e900$$ENDHEX$$n 
//		basadas en SP.
//		NOTA : Se realiza un retrieve al aplicar los par$$HEX1$$e100$$ENDHEX$$metros
//
//	ARGUMENTOS :
//		idw_requestor			:	Referencia al DW padre
//		as_campo_child	:	Nombre del campo en donde est$$HEX2$$e1002000$$ENDHEX$$el dw child
//		as_nuevos_param	:	String con los nuevos par$$HEX1$$e100$$ENDHEX$$metros separados por comas
//									Ejemplo: @NameOfProcArg=<Valor>,  @NameOfProcArg=<Valor>,...
//				NOTA: Para enviar como par$$HEX1$$e100$$ENDHEX$$metro un valor de tipo string hay que anteponerle
//				doble tilde a la comilla simple (~~'), ejemplo : @pCveOperacion = ~~'A~~'
//
//	DEVUELVE	:
//	
//		El n$$HEX1$$fa00$$ENDHEX$$mero de renglones le$$HEX1$$ed00$$ENDHEX$$dos	: 	Si no hubo errores
//		 -1										:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
////////////////////////////////////////////////////////////////////
//	AUTOR	:	FECHA	:		MODIFICACION:	
//	-----------------------------------------------------------------
//	LMAC		10/SEP/98		CREACION
////////////////////////////////////////////////////////////////////
// Declaraciones locales
// ============================
String					ls_sintaxis, ls_sintaxis_original, ls_error, ls_param, ls_modistring, lsarr_sintaxis[]
Long					ll_renglones
Integer				li_regresa
Any					la_valor, la_valorvacio
Datawindowchild 	ldwch_child
Pointer				lp_original

// Bloque de c$$HEX1$$f300$$ENDHEX$$digo
// ============================
lp_original = SetPointer( HourGlass! )

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_child) Or Trim(as_campo_child) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_asignaparam_dwchild', no se ha " + &
				"especificado el campo hijo~ren el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer(lp_original)
	Return -1
End If

//Valida nulos
If IsNull(as_nuevos_param) Then as_nuevos_param = ""

//If IsNull(as_nuevos_param) Or Trim(as_nuevos_param) = "" Then
//	Messagebox("Error",  "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_asignaparam_dwchild', no se ha especificado " + &
//			"los par$$HEX1$$e100$$ENDHEX$$metros nuevos ~rpara el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
//	SetPointer(lp_original)
//	Return -1
//End If

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_child, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_asignaparam_dwchild', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en ~rel campo '" + as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer(lp_original)
	Return -1
End If


//Obtiene la sintaxis actual de la declaraci$$HEX1$$f300$$ENDHEX$$n de la SP
ls_sintaxis = ldwch_child.Describe("DataWindow.Table.Procedure")
//Respalda la sintaxis original
ls_sintaxis_original = ls_sintaxis

//Valida que no haya ocurrido un error
If Pos ( ls_sintaxis, "!" ) > 0 Or Pos ( ls_sintaxis, "?" ) > 0 Then
	Messagebox("Aviso", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en la funci$$HEX1$$f300$$ENDHEX$$n 'of_asignaparam_dwchild', no se pudo leer la sintaxis ~r" + &	
					"de la declaraci$$HEX1$$f300$$ENDHEX$$n de la SP para la DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer(lp_original)
	Return -1
End If

//De la sintaxis original quita la secci$$HEX1$$f300$$ENDHEX$$n de los par$$HEX1$$e100$$ENDHEX$$metros
gnv_funciones_string.of_ParseToArray(ls_sintaxis, "@", lsarr_sintaxis)
ls_sintaxis = lsarr_sintaxis[1]

//Le concatena los nuevos par$$HEX1$$e100$$ENDHEX$$metros
ls_sintaxis = ls_sintaxis + as_nuevos_param

//Cambia la sintaxis a la dw
ls_modistring = "DataWindow.Table.Procedure='" + ls_sintaxis + "'"
ls_error = ldwch_child.Modify(ls_modistring)
If Trim(ls_error) <> "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_asignaparam_dwchild' al aplicar los argumentos nuevos~rde la DW  '" +  idw_requestor.DataObject + "' :~r'" + &
				 ls_error + "'",Stopsign!)
				 
	//Devuelve la sintaxis original
	ls_modistring = "DataWindow.Table.Procedure='" + ls_sintaxis_original + "'"
	ls_error = ldwch_child.Modify(ls_modistring)
End If

//Asigna la transacci$$HEX1$$f300$$ENDHEX$$n al dw child
ldwch_child.SetTransObject(SQLCA)

SetPointer(lp_original)

//Realiza el retrieve a la dw con los nuevos argumentos
Return ldwch_child.Retrieve( )

end function

public function integer of_busca_renglon_dwchild (string as_campo_hijo, string as_criterio, long al_renglon_inicial);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_bsk_renglon_dwchild (of_busca_renglon_dwchild)
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que busca el rengl$$HEX1$$f300$$ENDHEX$$n que cumpla con el criterio
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			: Referencia al DW padre
//		as_campo_hijo	: Nombre del campo hijo en el dw padre
//		as_criterio			: Criterio que debe cumplir el rengl$$HEX1$$f300$$ENDHEX$$n
//		al_renglon_inicial	: A partir de que rengl$$HEX1$$f300$$ENDHEX$$n se va a hacer la b$$HEX1$$fa00$$ENDHEX$$squeda
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_criterio, ls_desc, ls_tipodatos
Long	ll_renglon, ll_max
Integer	li_regresa
Any	la_valor
Pointer	lp_original
Datawindowchild ldwch_child

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_hijo) Or Trim(as_campo_hijo) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_busca_renglon_dwchild', no se ha " + &
				"especificado el campo hijo en el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

If IsNull(as_criterio) Or Trim(as_criterio) = "" Then Return 0

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_hijo, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_busca_renglon_dwchild', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en el campo '" + as_campo_hijo + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Checa que el rengl$$HEX1$$f300$$ENDHEX$$n inicial sea v$$HEX1$$e100$$ENDHEX$$lido
ll_max = ldwch_child.RowCount()
If ll_max < al_renglon_inicial Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_busca_renglon_dwchild', el rengl$$HEX1$$f300$$ENDHEX$$n inicial dado no existe en el ~rdw child del campo '" + &
					as_campo_hijo + "'en el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Busca el rengl$$HEX1$$f300$$ENDHEX$$n que cumpla con el criterio dado
ll_renglon = ldwch_child.Find(as_criterio, al_renglon_inicial, ll_max)

If IsNull(ll_renglon) Then ll_renglon = -1

Return ll_renglon
end function

public function integer of_cambia_sqlselect_dw (string as_sqlselect_nuevo, boolean ab_recargar, boolean ab_iralprimero);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_cambia_sqlselect
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que cambia el SQL Select de un DataWindow
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			: Referencia al DW
//		as_sqlselect_nuevo: String con el estatuto SQL nuevo
//		ab_recargar			: Realiza retrieve en el dw en caso de ser verdadero
//		ab_iralprimero		: Indica que despu$$HEX1$$e900$$ENDHEX$$s del retrieve se va a seleccionar el
//								  primer registro
//
//  DEVUELVE			:
//		  El n$$HEX1$$fa00$$ENDHEX$$mero de registros leidos	: 	Si no hubo errores
//		 -1										:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String		ls_error
Integer	li_regresa
Long		ll_max, ll_renglon
Pointer	lp_original

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_sqlselect_nuevo) Or Trim(as_sqlselect_nuevo) = "" Then
	Messagebox("Error",  "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dw', no se ha " + &
			"especificado el SQL Select nuevo ~rpara el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer(lp_original)
	Return -1
End If

//Cambia el SQL Select del dw
ls_error = idw_requestor.Modify("DataWindow.Table.Select='" + as_sqlselect_nuevo + "'")
If Trim(ls_error) <> "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dw' al aplicar el SQL select nuevo para el DW  '" +  idw_requestor.DataObject + "' :~r'" + &
				 ls_error + "'",Stopsign!)
	SetPointer(lp_original)
	Return -1
End If

//Asigna la transacci$$HEX1$$f300$$ENDHEX$$n al dw
If idw_requestor.SetTransObject(SQLCA) = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dw' al tratar de asignarle ~rel Objeto de la Transacci$$HEX1$$f300$$ENDHEX$$n a la DW  '" +  idw_requestor.DataObject + "'",Stopsign!)
	SetPointer(lp_original)
	Return -1
End If

//Realiza el retrieve para actualizar los datos solo si es indicado
IF ab_recargar THEN
	ll_max = idw_requestor.Retrieve()
ELSE
	SetPointer(lp_original)
	Return ll_max
END IF

//Si no se desea ir al primero, entonces termina
If ab_iralprimero = False Then
	SetPointer(lp_original)
	Return ll_max
End If

//Se mueve al primer registro del dw
If ll_max > 0 Then
	If idw_requestor.ScrollToRow (1) = -1 Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dw' al tratar de cambiar ~ral primer registro del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
		SetPointer(lp_original)
		Return -1
	End If
	idw_requestor.SelectRow ( 0, False )
	idw_requestor.SelectRow ( 1, True )
End If

Return ll_max
end function

public function integer of_cambia_sqlselect_dwchild (string as_campo_child, string as_sqlselect_nuevo, boolean ab_iralprimero, n_tr atr_transaccion);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_cambia_sqlselect_dwchild
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que cambia el SQL Select de un DataWindowChild
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			: Referencia al DW padre
//		as_campo_child	: Nombre del campo en donde est$$HEX2$$e1002000$$ENDHEX$$el dw child
//		as_sqlselect_nuevo: String con el estatuto SQL nuevo
//		ab_iralprimero		: Indica que despu$$HEX1$$e900$$ENDHEX$$s del se va a seleccionar el
//								  primer registro.
//		NOTA	:	El nombre del campo 'as_campo_child' debe ser igual al campo
//						con el cual esta ligado en el dddw
//
//  DEVUELVE			:
//		  El n$$HEX1$$fa00$$ENDHEX$$mero de registros leidos	: 	Si no hubo errores
//		 -1										:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String		ls_error, ls_tipodatos
Integer	li_regresa, li_pos
Long		ll_max, ll_renglon
Any		la_valor, la_valorvacio
Datawindowchild ldwch_child
Pointer	lp_original

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_child) Or Trim(as_campo_child) = "" Then
	MessageBox ( "Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild', no se ha " + &
				"especificado~r el campo hijo para el DW  '" +  idw_requestor.DataObject + "'", StopSign! ) 
	SetPointer ( lp_original ) 
	Return -1
End If

If IsNull(as_sqlselect_nuevo) Or Trim(as_sqlselect_nuevo) = "" Then
	Messagebox("Error",  "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild', no se ha " + &
			"especificado~r el SQL Select nuevo para el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer ( lp_original ) 
	Return -1
End If

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_child, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild ~ren el campo '" + as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	SetPointer(lp_original)
	Return -1
End If

//Cambia el SQL Select del dw child
ls_error = ldwch_child.Modify('DataWindow.Table.Select="' + as_sqlselect_nuevo + '"')
If Trim(ls_error) <> "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild' al aplicar el SQL select nuevo ~rpara el DDDW del campo '" + &
					as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "':~r'" +  ls_error + "'",Stopsign!)
	SetPointer(lp_original)
	Return -1
End If

//Asigna la transacci$$HEX1$$f300$$ENDHEX$$n al dw child
ldwch_child.SetTransObject(atr_transaccion)

//Realiza el retrieve para actualizar los datos
ll_max = ldwch_child.Retrieve()

//Si no se desea ir al primero, entonces termina
If ab_iralprimero = False Then
	SetPointer(lp_original)
	Return ll_max
End If

//Obtiene el n$$HEX1$$fa00$$ENDHEX$$mero de rengl$$HEX1$$f300$$ENDHEX$$n actual de dw padre
ll_renglon = idw_requestor.GetRow()
If IsNull(ll_renglon) Or ll_renglon <= 0 Then
	SetPointer(lp_original)
	Return ll_max
End If

//Obtiene el tipo de datos campo child
ls_tipodatos = Upper(ldwch_child.Describe(as_campo_child + ".Coltype"))
//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
li_pos = Pos(ls_tipodatos, "(", 1)
If li_pos > 0 Then ls_tipodatos = Mid ( ls_tipodatos, 1, li_pos - 1)
			
//Se mueve al primer registro del dw child
If ll_max > 0 Then
	If ldwch_child.ScrollToRow (1) = -1 Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild' al tratar de cambiar al primer registro ~rdel DDDW del campo hijo '"+ &
						as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
		SetPointer(lp_original)
		Return -1
	End If
	ldwch_child.SelectRow ( 0, False )
	ldwch_child.SelectRow ( 1, True )
	
	//Lee el dato correspondiente del primer registro del dw child
	Choose Case Upper(ls_tipodatos)
		Case	"INTEGER", "NUMBER", "LONG"	
			la_valor = ldwch_child.GetItemNumber(1, as_campo_child)
		Case	"STRING" , "CHAR"
			la_valor = ldwch_child.GetItemString(1, as_campo_child)
		Case 	"DATE"
			la_valor = ldwch_child.GetItemDate(1, as_campo_child)
		Case	"DATETIME"		
			la_valor = ldwch_child.GetItemDateTime(1, as_campo_child)
		Case	"DECIMAL"
			la_valor = ldwch_child.GetItemDecimal(1, as_campo_child)
		Case Else
 			Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild',~ren el DW  '" +  idw_requestor.DataObject + "' el tipo de datos " + ls_tipodatos + &
			 				" ~r del campo relacionado '" + as_campo_child + "' no es v$$HEX1$$e100$$ENDHEX$$lido", StopSign!) 
			SetNull(la_valor)
	End Choose	
Else
	//Asigna el valor vac$$HEX1$$ed00$$ENDHEX$$o
	Choose Case Upper(ls_tipodatos)
		Case	"INTEGER", "NUMBER", "LONG"	
			la_valorvacio = 0
		Case	"STRING" , "CHAR"
			la_valorvacio = " "
		Case 	"DATE"
			la_valorvacio = Date("01/01/1900")
		Case	"DATETIME"		
			la_valorvacio = DateTime("01/01/1900")
		Case	"DECIMAL"
			la_valorvacio = 0
		Case Else
 			Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild',~ren el DW  '" +  idw_requestor.DataObject + &
			 				"' el tipo de datos " + ls_tipodatos +  " ~r del campo relacionado '" + as_campo_child + "' no es v$$HEX1$$e100$$ENDHEX$$lido", StopSign!) 
			SetNull(la_valorvacio)
	End Choose	
	la_valor = la_valorvacio
End If

//Asigna el valor al campo hijo del dw padre
idw_requestor.SetItem(ll_renglon, as_campo_child, la_valor)

//Acepta los valores
If idw_requestor.Accepttext() = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_cambia_sqlselect_dwchild' al aceptar el dato '" + String(la_valor) + "~r' en el campo '" + &
					as_campo_child + "' del DW  '" +  idw_requestor.DataObject , StopSign!)
	SetPointer(lp_original)
	Return -1
End If

SetPointer(lp_original)
Return ll_max
end function

public function integer of_filtra_dwchild (string as_campo_child, string as_criterio);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_filtra_dwchild
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que aplica un Filtro al DW CHILD dado de acuerdo 
//		al Criterio	especificado
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		: Referencia al DW
//		as_campo_child	: Nombre del campo hijo en el dw padre
//		as_criterio		: String con el Criterio a aplicar. Si es Nulo o
//						  		"", entonces se eliminar$$HEX2$$e1002000$$ENDHEX$$el filtro actual
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer				li_regresa
Datawindowchild 	ldwch_child

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
//Dw padre
If Not (IsValid(idw_requestor)) Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_filtra_dwchild', no se ha " + &
				"especificado el dw padre", StopSign!)
	Return -1
End If


//Dw Hijo
If IsNull(as_campo_child) Or Trim(as_campo_child) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_filtra_dwchild', no se ha " + &
				"especificado el campo hijo en el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Criterio a utilizar 
If IsNull(as_criterio) Then as_criterio = ""


//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_child, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_filtra_dwchild', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en el campo '" + as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If
		
IF ldwch_child.SetFilter(as_criterio) = -1 THEN RETURN -1
If ldwch_child.Filter( ) = -1 Then Return -1

Return 0

end function

public function integer of_findrow_dwchild (string as_campo_child, string as_criterio, long al_renglon_inicial);////////////////////////////////////////////////////////////////////
//	DESCRIPCION	:
//		Funci$$HEX1$$f300$$ENDHEX$$n que busca el rengl$$HEX1$$f300$$ENDHEX$$n que cumpla con el criterio
//
//	ARGUMENTOS :
//		idw_requestor			: Referencia al DW padre
//		as_campo_child	: Nombre del campo hijo en el dw padre
//		as_criterio			: Criterio que debe cumplir el rengl$$HEX1$$f300$$ENDHEX$$n
//		al_renglon_inicial	: A partir de que rengl$$HEX1$$f300$$ENDHEX$$n se va a hacer la b$$HEX1$$fa00$$ENDHEX$$squeda
//
//	DEVUELVE	:
//	
//		 El n$$HEX1$$fa00$$ENDHEX$$mero de rengl$$HEX1$$f300$$ENDHEX$$n encontrado	: 	Si no hubo errores
//		 N$$HEX1$$fa00$$ENDHEX$$mero negativo						:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
////////////////////////////////////////////////////////////////////
//	AUTOR	:	FECHA	:		MODIFICACION:	
//	-----------------------------------------------------------------
//	LMAC		10/JUNIO/98		CREACION
////////////////////////////////////////////////////////////////////
// Declaraciones locales
// ============================
String	ls_criterio, ls_desc, ls_tipodatos
Long	ll_renglon, ll_max
Integer	li_regresa
Any	la_valor
Pointer	lp_original
Datawindowchild ldwch_child

// Bloque de c$$HEX1$$f300$$ENDHEX$$digo
// ============================
lp_original	=	SetPointer( HourGlass! ) 

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_child) Or Trim(as_campo_child) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_findrow_dwchild', no se ha " + &
				"especificado el campo hijo en el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

If IsNull(as_criterio) Or Trim(as_criterio) = "" Then Return 0

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_child, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_findrow_dwchild', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en el campo '" + as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Checa que el rengl$$HEX1$$f300$$ENDHEX$$n inicial sea v$$HEX1$$e100$$ENDHEX$$lido
ll_max = ldwch_child.RowCount()
If ll_max < al_renglon_inicial Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_findrow_dwchild', el rengl$$HEX1$$f300$$ENDHEX$$n inicial dado no existe en el ~rdw child del campo '" + &
					as_campo_child + "'en el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Busca el rengl$$HEX1$$f300$$ENDHEX$$n que cumpla con el criterio dado
ll_renglon = ldwch_child.Find(as_criterio, al_renglon_inicial, ll_max)

If IsNull(ll_renglon) Then ll_renglon = -1
Setpointer(lp_original)

Return ll_renglon
end function

public function integer of_genera_dddw (string as_campo, string as_sintaxis_sql, integer ai_campos, string as_registro_especial, boolean ab_reg_esp_inicio, n_tr atr_transaccion);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_genera_dddw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que genera y asigna un dddw de acuerdo a
//							  la sintaxis SQL dada
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		:	Referencia a la dw
//		as_campo			:	Nombre del campo al cual se le asignar$$HEX2$$e1002000$$ENDHEX$$el dddw
//		as_sintaxis_sql:	Sintaxis SQL que ser$$HEX2$$e1002000$$ENDHEX$$el origen de los registros del dddw
//		ai_campos		:	N$$HEX1$$fa00$$ENDHEX$$mero de columnas en el dddw (m$$HEX1$$ed00$$ENDHEX$$nimo 2)
//		as_registro_especial:	String separado por | (pipe) que indica el valor num$$HEX1$$e900$$ENDHEX$$rico que le vamos a dar
//										al campo llave y su descripci$$HEX1$$f300$$ENDHEX$$n del registro especial que se va a agregar,
//										un registro especial puede ser <Agregar...>, <Todos>, <Ninguno>, etc.
//										Ejemplo: -1|<Todos>
//										Nota: Si se desea que sea nulo el valor llave se pondr$$HEX2$$e1002000$$ENDHEX$$la palabra "NULL"
//										"" Si no se desea un registro especial
//		ab_reg_esp_inicio	:	True	Se agrega el registro especial al inicio
//									False	Se agrega el registro especial al final
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/OCT/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//  02/NOV/01	LAC		 Quit$$HEX2$$e9002000$$ENDHEX$$los campos 'as_datacolumn', 'as_displaycolumn'
//								 Agregu$$HEX2$$e9002000$$ENDHEX$$los campos 'ai_campos', 'as_registro_especial' y
//								 'ab_reg_esp_inicio'
//	 18/OCT/05	LAC		Argumento de transaccion a conectarse
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_dw, ls_llave, ls_descripcion, lsarr_especial[]
long		ll_renglon, ll_llave
datawindowchild	ldwch_dw

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Selecciona el dw adecuado
ls_dw = "d_dddwmaestro" + string(ai_campos)

//Asigna el dddw maestro a la dw
If of_asigna_dddw(ls_dw, as_campo, "CampoId", "CampoDesc") = -1 Then Return -1

//Cambia la sintaxis SQL del d_dddwmaestro
If of_cambia_sqlselect_dwchild(as_campo, as_sintaxis_sql, False, atr_transaccion) = -1 Then Return -1

//Checa si se va a agregar un registro especial
if not isnull(as_registro_especial) and trim(as_registro_especial) <> "" then
	if idw_requestor.getchild(as_campo, ldwch_dw) = -1 then
		messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$en 'of_genera_dddw' un error al tratar de insertar el registro especial")
		return -1
	end if
	
	gnv_funciones_string.of_ParseToArray(as_registro_especial, "|", lsarr_especial)
	//Lee el valor asignado
	ls_llave = lsarr_especial[1]
	if lower(trim(ls_llave)) = "null" then
		ll_llave = gl_nulo
	else
		ll_llave = long(ls_llave)
	end if
	
	//Lee la descripci$$HEX1$$f300$$ENDHEX$$n
	ls_descripcion = lsarr_especial[2]
	
	//inserta el registro especial
	if ab_reg_esp_inicio then
		ll_renglon = ldwch_dw.insertrow(1)
	else
		ll_renglon = ldwch_dw.insertrow(0)
	end if
	
	//Asigna el campo llave
	ldwch_dw.setitem(ll_renglon, "campoid", ll_llave)
	
	//Asigna la descripci$$HEX1$$f300$$ENDHEX$$n
	ldwch_dw.setitem(ll_renglon, "campodesc", ls_descripcion)
	
end if

Return 0
end function

public function integer of_genera_dddw_char (string as_campo, string as_sintaxis_sql, integer ai_campos, string as_registro_especial, boolean ab_reg_esp_inicio, n_tr atr_transaccion);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_genera_dddw_char
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que genera y asigna un dddw de acuerdo a
//							  la sintaxis SQL dada
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		:	Referencia a la dw
//		as_campo			:	Nombre del campo al cual se le asignar$$HEX2$$e1002000$$ENDHEX$$el dddw
//		as_sintaxis_sql:	Sintaxis SQL que ser$$HEX2$$e1002000$$ENDHEX$$el origen de los registros del dddw
//		ai_campos		:	N$$HEX1$$fa00$$ENDHEX$$mero de columnas en el dddw (m$$HEX1$$ed00$$ENDHEX$$nimo 2)
//		as_registro_especial:	String separado por | (pipe) que indica el valor string que le vamos a dar
//										al campo llave y su descripci$$HEX1$$f300$$ENDHEX$$n del registro especial que se va a agregar,
//										un registro especial puede ser <Agregar...>, <Todos>, <Ninguno>, etc.
//										Ejemplo: ab|<Todos>
//										Nota: Si se desea que sea nulo el valor llave se pondr$$HEX2$$e1002000$$ENDHEX$$la palabra "NULL"
//										"" Si no se desea un registro especial
//		ab_reg_esp_inicio	:	True	Se agrega el registro especial al inicio
//									False	Se agrega el registro especial al final
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/OCT/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//  02/NOV/01	LAC		 Quit$$HEX2$$e9002000$$ENDHEX$$los campos 'as_datacolumn', 'as_displaycolumn'
//								 Agregu$$HEX2$$e9002000$$ENDHEX$$los campos 'ai_campos', 'as_registro_especial' y
//								 'ab_reg_esp_inicio'
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_dw, ls_llave, ls_descripcion, lsarr_especial[]
long		ll_renglon, ll_llave
datawindowchild	ldwch_dw

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Selecciona el dw adecuado
ls_dw = "d_dddwmaestro_char" + string(ai_campos)

//Asigna el dddw maestro a la dw
If of_asigna_dddw(  ls_dw, as_campo, "CampoId", "CampoDesc") = -1 Then Return -1

//Cambia la sintaxis SQL del d_dddwmaestro_char
If of_cambia_sqlselect_dwchild(as_campo, as_sintaxis_sql, False, atr_transaccion) = -1 Then Return -1

//Checa si se va a agregar un registro especial
if not isnull(as_registro_especial) and trim(as_registro_especial) <> "" then
	if idw_requestor.getchild(as_campo, ldwch_dw) = -1 then
		messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$en 'of_genera_dddw_char' un error al tratar de insertar el registro especial")
		return -1
	end if
	
	gnv_funciones_string.of_ParseToArray(as_registro_especial, "|", lsarr_especial)
	
	//Lee el valor asignado
	ls_llave = lsarr_especial[1]

	if lower(trim(ls_llave)) = "null" then ls_llave = gs_nulo
	
	//Lee la descripci$$HEX1$$f300$$ENDHEX$$n
	ls_descripcion = lsarr_especial[2]
	
	//inserta el registro especial
	if ab_reg_esp_inicio then
		ll_renglon = ldwch_dw.insertrow(1)
	else
		ll_renglon = ldwch_dw.insertrow(0)
	end if
	
	//Asigna el campo llave
	ldwch_dw.setitem(ll_renglon, "campoid", ls_llave)
	
	//Asigna la descripci$$HEX1$$f300$$ENDHEX$$n
	ldwch_dw.setitem(ll_renglon, "campodesc", ls_descripcion)
end if

Return 0
end function

public function integer of_habilita_deshabilita (string as_campos, integer ai_accion, long al_color);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_habilita_deshabilita
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que Habilita o Deshabilita el(los) campo(s) especificados
//		en 'as_campos' del DW 'idw_requestor'
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor	: Referencia al DW en donde est$$HEX1$$e100$$ENDHEX$$n los campos.
//		as_campos	:	String separado por comas, en donde se indican los campos
//						 	a proteger o desproteger.
//		ai_accion		:	0	Indica Inhabilitar
//							1	Indica Habilitar
//		al_color		:	RGB del color que pondr$$HEX2$$e1002000$$ENDHEX$$el campo deshabilitado o habilitado
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer	li_contador
String 	ls_Campo, lsarr_campos[]

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

If IsNull(as_campos) Or Trim(as_campos) = "" Then Return 0
If ai_accion < 0 Or ai_accion > 1 Then Return 0

as_campos = as_campos + ","

li_contador = 1
gnv_funciones_string.of_ParseToArray(as_campos, ",", lsarr_campos)

FOR li_contador = 1 TO UpperBound(lsarr_campos)
	ls_Campo = lsarr_campos[li_contador]

	Choose Case ai_accion
		Case 0	//Inhabilitar
			idw_requestor.Modify(ls_Campo + ".Protect='1'")
			idw_requestor.Modify(ls_Campo + ".Background.Color='" + String(al_color) + "'")
		Case 1	//Habilitar
			idw_requestor.Modify(ls_Campo + ".Protect='0'")
			idw_requestor.Modify(ls_Campo + ".Background.Color='" + String(al_color) + "'")
	End Choose

NEXT

Return 0


end function

public function integer of_habilita_deshabilita_dw (string as_campos, boolean ab_habilita, long al_color_habilitar, long al_color_inhabilitar);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_habilita_deshabilita_dw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que Habilita o Deshabilita el(los) campo(s) especificados
//		en 'as_campos' del DW 'idw_requestor'
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor	: Referencia al DW en donde est$$HEX1$$e100$$ENDHEX$$n los campos.
//		as_campos	:	String separado por comas, en donde se indican los campos
//						 	a proteger o desproteger.
//		ab_habilita	:	FALSE	Indica Inhabilitar
//							TRUE	Indica Habilitar
//		al_color_habilitar	: Color a utilizar
//		al_color_inhabilitar	: Color a utilizar
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  13/DIC/00	JAV	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer	li_contador
String 	ls_Campo, lsarr_campos[]

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

If IsNull(as_campos) Or Trim(as_campos) = "" Then Return 0

as_campos = as_campos + ","

gnv_funciones_string.of_ParseToArray(as_campos, ",", lsarr_campos)

FOR li_contador = 1 TO UpperBound(lsarr_campos)
	ls_Campo = lsarr_campos[li_contador]

	Choose Case ab_habilita
		Case FALSE	//Inhabilitar
			idw_requestor.Modify(ls_Campo + ".Background.Color='" + String(al_color_inhabilitar) + "'")
			idw_requestor.Modify(ls_Campo + ".protect='1'")
			
		Case TRUE	//Habilitar
			idw_requestor.Modify(ls_Campo + ".Background.Color='" + String(al_color_habilitar) + "'")
			idw_requestor.Modify(ls_Campo + ".protect='0'")
	End Choose
NEXT

Return 0


end function

public function any of_lee_campo_dwchild (string as_campo_child, string as_campo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_lee_campo_dwchild
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que lee el valor del campo especificado del dddw del
//		campo hijo para el dw padre dado
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			: Referencia al DW padre
//		as_campo_hijo		: Nombre del campo hijo en el dw padre
//		as_campo			: Nombre del campo en el dddw del cual se quiere leer el valor
//
//  DEVUELVE			:
//		 El valor dado	: 	Si no hubo errores
//		 -100				:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	   Creaci$$HEX1$$f300$$ENDHEX$$n	
//	 01/JUL/00	LAC		Adecuaci$$HEX1$$f300$$ENDHEX$$n para que la referencia al campo sea tambi$$HEX1$$e900$$ENDHEX$$n num$$HEX1$$e900$$ENDHEX$$rica
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_criterio, ls_desc, ls_tipodatos
Long	ll_renglon, ll_renglon_child
Integer	li_regresa, li_pos
Any	la_valor
Pointer	lp_original
Datawindowchild ldwch_child

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)
//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_child) Or Trim(as_campo_child) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_leecampo_dddw', no se ha " + &
				"especificado el campo hijo ~ren el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -100
End If

If IsNull(as_campo) Or Trim(as_campo) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_leecampo_dddw', no se ha " + &
				"especificado el campo a buscar ~ren el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -100
End If


ll_renglon = idw_requestor.GetRow()

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_child, ldwch_child)
If li_regresa = -100 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_leecampo_dddw', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en el campo '" + as_campo_child + "' del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -100
End If

//Obtiene el n$$HEX1$$fa00$$ENDHEX$$mero de rengl$$HEX1$$f300$$ENDHEX$$n actual de dw child
ll_renglon_child = ldwch_child.GetRow()
If IsNull(ll_renglon_child) Or ll_renglon_child <= 0 Then Return la_valor

//Si el campo a leer tiene formato de n$$HEX1$$fa00$$ENDHEX$$mero entonces...
if isnumber(as_campo) then
	as_campo = ldwch_child.Describe("#" + as_campo + ".Name")
end if

//Validar si existe el campo en el DW
////////////////////
// PENDIENTE!
////////////////////

//Obtiene el tipo de datos campo a buscar
ls_tipodatos = Upper(ldwch_child.Describe(as_campo + ".Coltype"))

//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
li_pos = Pos(ls_tipodatos, "(", 1)
If li_pos > 0 Then ls_tipodatos = Mid ( ls_tipodatos, 1, li_pos - 1)

//Lee el dato correspondiente registro actual del dw padre
Choose Case Upper(ls_tipodatos)
	Case	"INTEGER", "NUMBER", "LONG"	
		la_valor = ldwch_child.GetItemNumber(ll_renglon_child, as_campo)
	Case	"STRING" , "CHAR"
		la_valor = ldwch_child.GetItemString(ll_renglon_child, as_campo)
	Case 	"DATE"
		la_valor = ldwch_child.GetItemDate(ll_renglon_child, as_campo)
	Case	"DATETIME"		
		la_valor = ldwch_child.GetItemDateTime(ll_renglon_child, as_campo)
	Case	"DECIMAL"
		la_valor = ldwch_child.GetItemDecimal(ll_renglon_child, as_campo)
	Case Else
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_leecampo_dddw' para el DW  '" +  idw_requestor.DataObject + "',~rel tipo de datos '" + &
						ls_tipodatos + "' del campo del dddw no es v$$HEX1$$e100$$ENDHEX$$lido", StopSign!)
		SetNull(la_valor)
End Choose	

Return la_valor


end function

public function string of_lee_sqlselect_dw ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_lee_sqlselect_dw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que lee el SQL Select de un dw
//		NOTA: La dw debe estar grabada en sintaxis de SQL
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		: Nombre del dw
//
//  DEVUELVE			:
//		 El SQL select actual	: 	Si no hubo errores
//		 ""							:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_sql, ls_instruccion
Integer	li_regresa

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Lee el SQL select del dw child
ls_instruccion = "DataWindow.Table.Select"
ls_sql = idw_requestor.Describe(ls_instruccion)

Return ls_sql
end function

public function string of_lee_sqlselect_dwchild (string as_campo_child, boolean ab_msgerror);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_lee_sqlselect_dwchild
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que lee el SQL Select de un dw child
//		NOTA: La dw debe estar grabada en sintaxis de SQL
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		: Nombre del dw padre
//		as_campo_child	: Nombre del campo en donde se encuentra el dw child
//
//  DEVUELVE			:
//		 El SQL select actual	: 	Si no hubo errores
//		 ""							:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Datawindowchild		ldwch_child
STRING					ls_sql, ls_instruccion
INTEGER					li_regresa
Pointer					lp_original

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida vac$$HEX1$$ed00$$ENDHEX$$os y/o espacios
If IsNull(as_campo_child) Or Trim(as_campo_child) = "" Then
	If ab_msgerror Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_lee_sqlselect', no se ha especificado el " + &
						"nombre del campo hijo en el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	End If
	SetPointer(lp_original)
	Return ""
End If

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_child, ldwch_child)
If li_regresa = -1 Then
	If ab_msgerror Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_lee_sqlselect', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
					"DataWindowChild en el campo '" + as_campo_child + " 'del DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	End If
	SetPointer(lp_original)
	Return ""
End If

//Lee el SQL select del dw child
ls_instruccion = "DataWindow.Table.Select"
ls_sql = ldwch_child.Describe(ls_instruccion)

SetPointer(lp_original)

Return ls_sql
end function

public function integer of_objetos_dw (ref string asarr_objetos[], string as_tipo, string as_banda);//------------------------------------------------------------------
//  MODULO/FUNCION	: 	of_objetos_dw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que desglosa la lista de objetos contenidos
//					en el DataObject asociado con el dw. Regresa los nombres en un
//					arreglo string pasado por referencia y la funci$$HEX1$$f300$$ENDHEX$$n retorna el n$$HEX1$$fa00$$ENDHEX$$mero
//					de nombres devueltos en el arreglo
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		:	Referencia a la dw
//		asarr_objetos	:	Arreglo string pasado por referencia
//		as_tipo			:	Tipo de objeto a regresar, '*' para regresar todos
//								Ejem: "column", "compute", "text", etc.
//		as_banda			:	Banda en la cual se desea buscar, '*' para buscar en todas
//								"detail", "header", etc.
//  DEVUELVE			:
//			N$$HEX1$$fa00$$ENDHEX$$mero total de objetos encontrados
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
Integer	li_NumObjetos

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_lista_objetos, ls_Obj_Paso
Integer	li_obj_contador, ls_tab_ini=1, ls_tab_pos, li_contador = 0

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Obtiene el string de TODOS los objetos de la dw
ls_lista_objetos = idw_requestor.Describe("datawindow.objects")

//Encuentra la posici$$HEX1$$f300$$ENDHEX$$n del primer tab
ls_tab_pos = Pos(ls_lista_objetos,"~t",ls_tab_ini)

//Ciclo para obtener los objetos deseados
Do While ls_tab_pos > 0
	//Obtiene el nombre del objeto
	ls_Obj_Paso = Mid(ls_lista_objetos,ls_tab_ini,(ls_tab_pos - ls_tab_ini))
	
	//Checa si el objeto es del tipo y banda deseado
	If (idw_requestor.Describe(ls_Obj_Paso+".type") = as_tipo or as_tipo = "*") &
		And (idw_requestor.Describe(ls_Obj_Paso+".band") = as_banda or as_banda = "*") Then
		li_contador = li_contador + 1
		asarr_objetos[li_contador] = ls_Obj_Paso
	End If
	
	//Obtiene el siguiente objeto
	ls_tab_ini = ls_tab_pos + 1
	ls_tab_pos = Pos(ls_lista_objetos,"~t",ls_tab_ini) 
Loop


ls_Obj_Paso = Mid(ls_lista_objetos,ls_tab_ini,Len(ls_lista_objetos))
If (idw_requestor.Describe(ls_Obj_Paso+".type") = as_tipo or as_tipo = "*") And &
	(idw_requestor.Describe(ls_Obj_Paso+".band") = as_banda or as_banda = "*") Then
	li_contador = li_contador + 1
	asarr_objetos[li_contador] = ls_Obj_Paso
End If

//Regresa el total de nombres
Return li_contador


end function

public function integer of_propiedades_dddw (string as_campo_hijo, string as_propiedades);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_propiedades_dddw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que cambia las propiedades de un dddw
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		:	Referencia al dw que contiene el dddw
//		as_campo_hijo	:	Nombre del campo que contiene al dddw
//		as_propiedades	:	String separado por comas con el nombre de la propiedad
//								y el valor correspondiente
//								Ejemplo:
//									"HScrollbar=Yes,Name=dw_prueba,PercentWidth=150"
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/OCT/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_sintaxis, ls_aplicar, ls_mensaje = '', ls_regresa, ls_SQLSelect
string lsarr_propiedades[]
Integer	li_contador, li_regreso
Datawindowchild	ldwch_child

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

If IsNull(as_propiedades) Or Trim(as_propiedades) = "" Then Return 0

//Respalda el SQLSelect original del dddw 
//(por bug de PB que resetea el SQLSelect al aplicar por ejemplo el VScrollbar)
ls_SQLSelect = of_lee_sqlselect_dwchild( as_campo_hijo, false)

as_propiedades = lower(as_propiedades) + ","
li_contador = 1
li_regreso = 0

gnv_funciones_string.of_ParseToArray(as_propiedades, ",",lsarr_propiedades)

FOR li_contador = 1 TO UpperBound(lsarr_propiedades)
	ls_sintaxis = lsarr_propiedades[li_contador]
	//Aplica la propiedad
	ls_aplicar = as_campo_hijo + ".DDDW." + ls_sintaxis
	ls_regresa = idw_requestor.Modify(ls_aplicar)
	If Trim(ls_regresa) <> "" Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_propiedades_dddw' en el DW  '" +  idw_requestor.DataObject + &
						"'~ral aplicar la propiedad '" + ls_sintaxis + "' del dddw que est$$HEX2$$e1002000$$ENDHEX$$en el campo '" + as_campo_hijo + "'",Stopsign!)
		li_regreso = -1
		exit
	End If
NEXT

//Regresa el SQLSelect original
idw_requestor.GetChild(as_campo_hijo, ldwch_child)
ldwch_child.Modify("DataWindow.Table.Select='" + ls_SQLSelect + "'")

Return li_regreso
end function

public subroutine of_protect_dw (string as_tipo, string as_banda, string as_protect);//------------------------------------------------------------------
//  MODULO/FUNCION	: 	of_protect_dw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que modifica la propiedad protect de todas las columnas del datawindow,
//					         el argumento as_protect es el valor que se asigna a dicha propiedad.
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		:	Referencia a la dw
//		as_tipo			:	Tipo de objeto a regresar, '*' para regresar todos
//								Ejem: "column", "compute", "text", etc.
//		as_banda			:	Banda en la cual se desea buscar, '*' para buscar en todas
//								"detail", "header", etc.
//    as_protect     : Es el valor que se asigna a la propiedad protect de las columnas (1,0)
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  20/AGO/01	FJR	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
Integer	li_NumObjetos

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_lista_objetos, ls_Obj_Paso, lsarr_objetos[], ls_protect
Integer	li_obj_contador, ls_tab_ini=1, ls_tab_pos, li_contador = 0, li_cont

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Obtiene el string de TODOS los objetos de la dw
ls_lista_objetos = idw_requestor.Describe("datawindow.objects")

//Encuentra la posici$$HEX1$$f300$$ENDHEX$$n del primer tab
ls_tab_pos = Pos(ls_lista_objetos,"~t",ls_tab_ini)

//Ciclo para obtener los objetos deseados
Do While ls_tab_pos > 0
	//Obtiene el nombre del objeto
	ls_Obj_Paso = Mid(ls_lista_objetos,ls_tab_ini,(ls_tab_pos - ls_tab_ini))
	
	//Checa si el objeto es del tipo y banda deseado
	If (idw_requestor.Describe(ls_Obj_Paso+".type") = as_tipo or as_tipo = "*") &
		And (idw_requestor.Describe(ls_Obj_Paso+".band") = as_banda or as_banda = "*") Then
		li_contador = li_contador + 1
		lsarr_objetos[li_contador] = ls_Obj_Paso
	End If
	
	//Obtiene el siguiente objeto
	ls_tab_ini = ls_tab_pos + 1
	ls_tab_pos = Pos(ls_lista_objetos,"~t",ls_tab_ini) 
Loop


ls_Obj_Paso = Mid(ls_lista_objetos,ls_tab_ini,Len(ls_lista_objetos))
If (idw_requestor.Describe(ls_Obj_Paso+".type") = as_tipo or as_tipo = "*") And &
	(idw_requestor.Describe(ls_Obj_Paso+".band") = as_banda or as_banda = "*") Then
	li_contador = li_contador + 1
	lsarr_objetos[li_contador] = ls_Obj_Paso
End If


FOR li_cont = 1 TO li_contador
	ls_protect = lsarr_objetos[li_cont]+".Protect="+as_protect
	idw_requestor.Modify(ls_protect)
NEXT


end subroutine

public function integer of_setrow_dwchild (string as_campo_hijo, long al_renglon);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_setrow_dwchild
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que se mueve y pone activo el rengl$$HEX1$$f300$$ENDHEX$$n dado en el dw child
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor			: Referencia al DW padre
//		as_campo_hijo	: Nombre del campo hijo en el dw padre
//		al_renglon			: N$$HEX1$$fa00$$ENDHEX$$mero de rengl$$HEX1$$f300$$ENDHEX$$n
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_tipodatos, ls_campodata
Long	ll_renglon
Integer	li_regresa, li_pos
Any	la_valor
Pointer	lp_original
Datawindowchild ldwch_child


//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida nulos y/o vac$$HEX1$$ed00$$ENDHEX$$os
If IsNull(as_campo_hijo) Or Trim(as_campo_hijo) = "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setrow_dwchild', no se ha " + &
				"especificado el campo hijo ~rpara el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

If IsNull(al_renglon) Or al_renglon <= 0 Then Return 0

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_hijo, ldwch_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setrow_dwchild', no se encontr$$HEX2$$f3002000$$ENDHEX$$un " + &
				"DataWindowChild en el campo '" + as_campo_hijo + "~ren el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Checa que el rengl$$HEX1$$f300$$ENDHEX$$n dado sea v$$HEX1$$e100$$ENDHEX$$lido
ll_renglon = ldwch_child.RowCount()
If ll_renglon <= 0 Then
	SetNull(la_valor)
	idw_requestor.SetItem(ll_renglon, as_campo_hijo, la_valor)
	Return 0
End If

If ll_renglon < al_renglon Then al_renglon = ll_renglon 

//Se mueve al rengl$$HEX1$$f300$$ENDHEX$$n especificado
If ldwch_child.ScrollToRow ( al_renglon ) = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setrow_dwchild' al cambiar de rengl$$HEX1$$f300$$ENDHEX$$n en la dw child del campo '" + &
					as_campo_hijo + "~ren el DW  '" +  idw_requestor.DataObject + "'", StopSign!)
Else
	//Selecciona el rengl$$HEX1$$f300$$ENDHEX$$n
	ldwch_child.selectrow(0, False)
	ldwch_child.selectrow(al_renglon, True)
	
	//Obtiene el campo data del dddw
	ls_campodata = idw_requestor.describe(as_campo_hijo + ".DDDW.DataColumn")
	
	//Obtiene el tipo de datos campo child
	ls_tipodatos = Upper(ldwch_child.Describe(ls_campodata + ".Coltype"))	
	//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
	li_pos = Pos(ls_tipodatos, "(", 1)
	If li_pos > 0 Then ls_tipodatos = Mid ( ls_tipodatos, 1, li_pos - 1)

	//Lee el dato correspondiente registro actual del dw padre
	Choose Case Upper(ls_tipodatos)
		Case	"INTEGER", "NUMBER", "LONG"	
			la_valor = ldwch_child.GetItemNumber(al_renglon, ls_campodata)
		Case	"STRING" , "CHAR"
			la_valor = ldwch_child.GetItemString(al_renglon, ls_campodata)
		Case 	"DATE"
			la_valor = ldwch_child.GetItemDate(al_renglon, ls_campodata)
		Case	"DATETIME"		
			la_valor = ldwch_child.GetItemDateTime(al_renglon, ls_campodata)
		Case	"DECIMAL"
			la_valor = ldwch_child.GetItemDecimal(al_renglon, ls_campodata)
		Case Else
			Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setrow_dwchild' para el DW  '" +  idw_requestor.DataObject + &
							"',~r el tipo de datos '" + ls_tipodatos + "' para el campo '" + ls_campodata + "' no es v$$HEX1$$e100$$ENDHEX$$lido", StopSign!)
			SetNull(la_valor)
	End Choose	
	
	//Pone el valor leido en el dw padre
	ll_renglon = idw_requestor.GetRow()
	If IsNull(ll_renglon) or ll_renglon <= 0 Then
		SetNull(la_valor)
		idw_requestor.SetItem(ll_renglon, as_campo_hijo, la_valor)
		Return 0
	End If
	idw_requestor.SetItem(ll_renglon, as_campo_hijo, la_valor)
	
	//Acepta el nuevo valor en el dw padre
	If idw_requestor.AcceptText() = -1 Then
		Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setrow_dwchild'  para el DW  '" +  idw_requestor.DataObject + &
						",~r el valor '" + String(la_valor) + "' no se pudo asignar al campo '" + as_campo_hijo + "' del dw padre", StopSign!)
		Setpointer(lp_original)
		Return -1
	End If
End If

Setpointer(lp_original)
Return 0

end function

public function integer of_setvisible (string as_campos, boolean ab_valor);////////////////////////////////////////////////////////////////////
//	DESCRIPCION	:	of_setvisible
//		Funci$$HEX1$$f300$$ENDHEX$$n que pone Visible/Invisible el(los) campo(s) especificados
//		en 'as_campos' del DW 'idw_requestor'.
//
//		NOTA:	Para conservar el ancho de la columna antes de ocultarla, se respaldar$$HEX1$$e100$$ENDHEX$$
//					en el TAG de la columna especificada. Si al tratar de mostrarla el TAG est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o
//					o contiene un valor no num$$HEX1$$e900$$ENDHEX$$rico o diferente de 0 se pondr$$HEX2$$e1002000$$ENDHEX$$un ancho default de 100
//
//	ARGUMENTOS :
//		idw_requestor	: Referencia al DW en donde est$$HEX1$$e100$$ENDHEX$$n los campos.
//		as_campos	:	String separado por comas, en donde se indican los campos
//						 	a proteger o desproteger.
//		ab_valor		:	False	Indica ocultar
//							True	Indica mostrar
//	DEVUELVE	:
//	
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
////////////////////////////////////////////////////////////////////
//	AUTOR	:	FECHA	:		MODIFICACION:	
//	-----------------------------------------------------------------
//	LMAC		25/AGOSTO/97		CREACION
//	LMAC		19/OCT/98				SE AJUST$$HEX2$$d3002000$$ENDHEX$$PARA QUE OCULTE AL
//												HACER 0 EL ANCHO DE LA COLUMNA
// LMAC		04/SEPT/99			SE AJUST$$HEX2$$d3002000$$ENDHEX$$PARA QUE CUANDO SE OCULTE NO 
//										PERMITA AJUSTAR LA COLUMNA
//////////////////////////////////////////////////////////////////
Integer	li_contador
String 	ls_Campo, ls_ancho, ls_default = '100', ls_regresa, ls_es_checkbox, lsarr_campos[]

// Valida argumentos
If IsNull(as_campos) Or Trim(as_campos) = "" Then Return 0

as_campos = as_campos + ","

gnv_funciones_string.of_ParseToArray(as_campos, ",", lsarr_campos)

FOR li_contador = 1 TO UpperBound(lsarr_campos)
	ls_Campo = lsarr_campos[li_contador]
	
	If ab_valor Then
		///////////////////////
		//MOSTRAR
		///////////////////////
		//Lee el respaldo del ancho anterior de la columna
		ls_ancho = Trim(idw_requestor.Describe(ls_campo + ".Tag"))
		//Checa que sea correcto el valor leido
		Choose Case ls_ancho
			Case	"!"
				//..no existe el campo especificado
				Continue
			Case "?"
				ls_ancho = idw_requestor.Describe(ls_campo + ".Width")
				
			Case Else
				If Integer(ls_ancho) = 0 Then ls_ancho = ls_default
				
		End Choose
		
		//Pone el nuevo ancho
		idw_requestor.Modify(ls_campo + ".Width='" + ls_ancho + "'")
			
		//Protege el campo para que no reciba el focus
		idw_requestor.Modify(ls_campo + ".Protect='1'")
		
	Else
		///////////////////////
		//OCULTAR
		///////////////////////
		//Lee el ancho de la columna actual
		ls_ancho = Trim(idw_requestor.Describe(ls_campo + ".Width"))
		If IsNull(ls_ancho) Or Long(ls_ancho) <= 0 Then Continue
		
		//Respalda el ancho actual en el tag de la columna
		idw_requestor.Modify(ls_campo + ".Tag='" + ls_ancho + "'")
		ls_es_checkbox = idw_requestor.Describe(ls_campo + ".CheckBox.On")
		If ls_ancho = "!" Then
			//..no existe el campo especificado
			Continue
		End If
		
		if ls_es_checkbox = "?" then
			//Oculta la columna al poner en 0 el ancho
			ls_regresa = idw_requestor.Modify(ls_campo + ".Width='0'")
		else
			ls_regresa = idw_requestor.Modify(ls_campo + ".Visible='0'")
		end if
		
		//Vuelve a habilitar el campo para que reciba el focus
		ls_regresa = idw_requestor.Modify(ls_campo + ".Protect='0'")
	End If
	
NEXT

Return 0
end function

public function integer of_setvisible_child (string as_campo_hijo, string as_campos, boolean ab_mostrar, boolean ab_oculta_encabezado);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_setvisible_child
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que muestra/oculta los campos especificados para el
//		DW child que se encuentra en el campo 'as_campo_hijo'
// 
//  EVENTO/ARGUMENTOS: 
//		idw_requestor		: Nombre del DW que contiene el dw child
//		as_campo_hijo	: Nombre del campo en donde est$$HEX2$$e1002000$$ENDHEX$$el dw child
//		as_campos		: Lista de campos a ocultar o mostrar, separados por comas
//		ab_mostrar			: TRUE  Muestra el campo, FALSE Oculta el campo
//		ab_oculta_encabezado: TRUE  Oculta los text de los encabezados
//							  FALSE No oculta los text de los encabezados
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
// 22/MAR/00	LAC	   Creaci$$HEX1$$f300$$ENDHEX$$n	
//	21/FEB/02	LAC		Considerar n$$HEX1$$fa00$$ENDHEX$$meros como parte de nombre de columna
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
DataWindowChild ldw_child
Integer	li_regresa, li_contador
String		ls_campo, ls_regresa, ls_comando, ls_ancho, ls_default, lsarr_campos[]

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

// Valida argumentos
If IsNull(as_campos) Then as_campos = ""
If IsNull(as_campo_hijo) Or trim(as_campo_hijo) = "" Then Return 0
If IsNull(ab_mostrar) Then Return 0

//Obtiene la referencia al dw child
li_regresa = idw_requestor.GetChild(as_campo_hijo, ldw_child)
If li_regresa = -1 Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setvisible_child'~rNo se encontr$$HEX2$$f3002000$$ENDHEX$$un DataWindowChild en el campo '" + &
			as_campo_hijo + "' de la DW '" + idw_requestor.DataObject + "'", StopSign!)
	Return -1
End If

//Muestra/Oculta las columnas
as_campos = as_campos + ","
li_contador = 1

gnv_funciones_string.of_ParseToArray(as_campos, ",", lsarr_campos)

FOR li_contador = 1 TO UpperBound(lsarr_campos)
	ls_Campo = lsarr_campos[li_contador]
	//Si el campo a leer tiene formato de n$$HEX1$$fa00$$ENDHEX$$mero entonces...
	if isnumber(ls_Campo) then
		ls_Campo = ldw_child.Describe("#" + ls_Campo + ".Name")
	end if	
	
	If ab_mostrar Then
		///////////////////////
		//MOSTRAR
		///////////////////////
		//Lee el respaldo del ancho anterior de la columna
		ls_ancho = Trim(ldw_child.Describe(ls_campo + ".Tag"))
		//Checa que sea correcto el valor leido
		Choose Case ls_ancho
			Case	"!"
				Continue
			Case "?"
				ls_ancho = ldw_child.Describe(ls_campo + ".Width")
			Case Else
				If Integer(ls_ancho) = 0 Then ls_ancho = ls_default
		End Choose
		
		//Pone el nuevo ancho
		ldw_child.Modify(ls_campo + ".Width='" + ls_ancho + "'")
		
		//Protege el campo para que no reciba el focus
		ldw_child.Modify(ls_campo + ".Protect='True'")
		
	Else
		///////////////////////
		//OCULTAR
		///////////////////////
		//Lee el ancho de la columna actual
		ls_ancho = Trim(ldw_child.Describe(ls_campo + ".Width"))
		If IsNull(ls_ancho) Or Long(ls_ancho) <= 0 Then Continue
		
		//Respalda el ancho actual en el tag de la columna
		ldw_child.Modify(ls_campo + ".Tag='" + ls_ancho + "'")
		If ls_ancho = "!" Then Continue

		//Oculta la columna al poner en 0 el ancho
		ldw_child.Modify(ls_campo + ".Width='0'")
		//Vuelve a habilitar el campo campo para que reciba el focus
		ldw_child.Modify(ls_campo + ".Protect='False'")
	End If
NEXT

//Oculta / muestra los encabezados
If ab_oculta_encabezado Then
	ls_regresa = ldw_child.Modify("DataWindow.Header.Height='0'")
	If Trim(ls_regresa) <> "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setvisible_child' al ocultar los encabezados en la DW '" + &
								idw_requestor.DataObject + "'~r(" + ls_regresa + ")", StopSign!)
		Return -1
	End If

Else
	ls_regresa = ldw_child.Modify("DataWindow.Header.Height='58'")
	If Trim(ls_regresa) <> "" Then
	Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_setvisible_child' al mostrar los encabezados en la DW '" + &
								idw_requestor.DataObject + "'~r(" + ls_regresa + ")", StopSign!)
		Return -1
	End If
End If

Return 0

end function

public function integer of_create (string as_sql, n_tr atr_conexion);
long ll_rc, ll_total_columnas, li_contador, li_longitud_campo, ll_longitud, ll_aux, ll_aux_max
string ls_sintaxis, ls_error, ls_nombre, ls_tipo, ls_rtn

//crea la dw din$$HEX1$$e100$$ENDHEX$$micamente
ls_sintaxis = atr_conexion.SyntaxFromSQL(as_sql, &
	"Style(Type=grid )" + & 
	"Style ( Detail_Top_Margin = 0 ) " + &
	"Style ( Detail_Bottom_Margin = 0 ) " + &
	"Style ( Header_Top_Margin = 5 )" + &
	"Style ( Header_Bottom_Margin = 8 )" + &
	"Style ( horizontal_spread = 0 ) " + &
	 "Text(Alignment=2 Border=2 color=1073741824 background.mode=2 background.color=268435456)" ,ls_error)

//	"Text(Alignment=2 Border=6 " ,ls_error)
	
//	"Datawindow(Color = 67108864) " + &
//	 "Text(Alignment=2 Border=6 " ,ls_error)
//	 "Text(Alignment=2 Border=6 color=1073741824 background.mode=2 background.color=268435456)" ,ls_error)
//	 "Column(Border=0 font.face = 'Tahoma')",ls_error)
////	 "Column(Border=0 font.face='Tahoma' font.height='-108' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' ", ls_error)


if len(ls_error) > 0 then 
	ll_rc = -3
END IF

//Crea contenedor local apartir de la sintaxis de DW
idw_requestor.Create( ls_sintaxis, ls_error)

if len(ls_error) > 0 then 
	ll_rc = -4
END IF

//Asigna objeto de la transaccion
idw_requestor.of_setTransObject(atr_conexion)

if idw_requestor.Retrieve() <= 0 then 
//	messagebox(gs_nombreapp, "No se pudo obtener informaci$$HEX1$$f300$$ENDHEX$$n de los renglones", exclamation!)
	ll_rc = -5
END IF

idw_requestor.Modify("DataWindow.Header.Color= '78682240'")
//No permitir mover las columnas
idw_requestor.modify("DataWindow.Grid.ColumnMove=No")
idw_requestor.modify("DataWindow.Selected.Mouse=No")

//Total de columnas generadas 
ll_total_columnas = long(idw_requestor.describe("datawindow.column.count"))

//Ciclo para obtener la altura m$$HEX1$$e100$$ENDHEX$$xima de las columans e igualarlas
ll_aux_max = 0
for li_contador = 1 to ll_total_columnas
	ls_nombre = idw_requestor.describe("#" + string(li_contador) + ".Name")
	ll_aux = long(idw_requestor.describe(ls_nombre + "_t.height"))
	if ll_aux_max < ll_aux then
		ll_aux_max = ll_aux
	end if
next

idw_requestor.SetRedraw(FALSE)
//Ciclo para proteger columnas generadas y poner titulos
for li_contador = 1 to ll_total_columnas
	idw_requestor.Modify ( "#" + string(li_contador) + ".protect='1'" )
	ls_nombre = idw_requestor.describe("#" + string(li_contador) + ".Name")
	
	//para longitud de los campos
	ls_tipo = idw_requestor.Describe( ls_nombre + ".ColType")
	if match(ls_tipo,'char') Then
			  ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(' + ls_nombre + ') for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )' 
	else
			  ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(string(' + ls_nombre + ')) for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
	end if
	idw_requestor.Modify(ls_sintaxis)  
	
	li_longitud_campo = 0
	if idw_requestor.rowcount() >0 then
		 li_longitud_campo = idw_requestor.object.compute_1[1] 
	end if
	if len(ls_nombre) > li_longitud_campo Then
		li_longitud_campo = len(ls_nombre)
	End if
	
	ll_longitud = li_longitud_campo * 40
	
	ls_rtn = idw_requestor.Modify(ls_nombre + ".width='" + string(ll_longitud) + "'")	
	ls_rtn = idw_requestor.Modify("destroy compute_1")
	
	//Iguala el alto de los t$$HEX1$$ed00$$ENDHEX$$tulos
//	idw_requestor.Modify(ls_nombre + "_t.height='" + string(ll_aux_max) + "'")
	
next
idw_requestor.SetRedraw(TRUE)

RETURN SUCCESS


end function

on n_cst_dwutil.create
call super::create
end on

on n_cst_dwutil.destroy
call super::destroy
end on


HA$PBExportHeader$n_cst_string.sru
$PBExportComments$Extension String service
forward
global type n_cst_string from pfc_n_cst_string
end type
end forward

global type n_cst_string from pfc_n_cst_string
end type

forward prototypes
public function string of_desglosa_string (string as_cadena, integer ai_posicion, string as_separador)
end prototypes

public function string of_desglosa_string (string as_cadena, integer ai_posicion, string as_separador);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_desglosa_string
//
//  DESCRIPCION		: 
//		Rutina que lee una cadena de caracteres (separada por determinado
//		caracter) y devuelve la subcadena cuya posicion se indica
//
//  EVENTO/ARGUMENTOS: 
//		as_cadena		: Nombre del campo a buscar validaci$$HEX1$$f300$$ENDHEX$$n.
//		ai_posicion		: Posici$$HEX1$$f300$$ENDHEX$$n de la subcadena que se desea regresar (Empezando en 1).
//		as_separador	: Caracter que sirve como separador (coma, slash, etc.)
//
//  DEVUELVE			:
//		La subcadena: 	Si no hubo errores
//		""				:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error o no se encontr$$HEX2$$f3002000$$ENDHEX$$la subcadena.
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  22/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer	li_Contador, li_Posicion, li_inicio, li_long_separador
String	ls_Regresa, ls_NULL

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)
SetNull ( ls_NULL )

IF IsNull ( as_cadena ) OR IsNull ( as_separador ) OR IsNull ( ai_posicion ) THEN Return ls_NULL

as_cadena = as_cadena + as_separador

ls_Regresa = ""
li_Contador = 0
li_Inicio = 1
li_long_separador = len(as_separador) 
li_Posicion = Pos(as_cadena, as_separador, li_Inicio)
Do while li_Posicion <> 0
	li_Contador ++
	//Verifica si es la posici$$HEX1$$f300$$ENDHEX$$n que se desea regresar
	If li_Contador = ai_posicion Then
		ls_Regresa = Mid(as_cadena, li_Inicio, li_Posicion -li_Inicio)
		Exit
	Else
		li_Inicio = li_Posicion + li_long_separador	
	End If
	li_Posicion = Pos(as_cadena, as_separador, li_Inicio)
Loop

Return ls_Regresa

end function

on n_cst_string.create
call super::create
end on

on n_cst_string.destroy
call super::destroy
end on


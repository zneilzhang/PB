HA$PBExportHeader$u_dw.sru
$PBExportComments$Extension DataWindow class
forward
global type u_dw from pfc_u_dw
end type
type str_origen from structure within u_dw
end type
type str_cat_origen from structure within u_dw
end type
type str_columna from structure within u_dw
end type
end forward

type str_origen from structure
	u_dw		dw_origen
	string		uo_catalogo
	string		titulo
end type

type str_cat_origen from structure
	u_dw		dw_origen
	string		nombre_dw_cat
	string		uo_catalogo
	string		titulo
end type

type str_columna from structure
	string		columna
	long		color
end type

global type u_dw from pfc_u_dw
event postconstructor ( )
event ue_procesaenter pbm_dwnprocessenter
event ue_dwnkey pbm_dwnkey
event ue_postlbuttonup ( )
event ue_filtrorapido ( )
event pbm_ncpaint pbm_ncpaint
event type integer pfc_saveas ( )
event verticalscroll pbm_vscroll
event ue_dwlbuttonup pbm_dwnlbuttonup
end type
global u_dw u_dw

type prototypes


public subroutine Sleep(Long dwMilliseconds) library "kernel32.dll"

end prototypes

type variables
//Var. para la instancia del servicio de zoom
n_cst_dwsrv_printpreview	inv_zoom

//Var. que indica si se van a agregar m$$HEX1$$fa00$$ENDHEX$$ltiples nuevos
Boolean	ib_multiplesnuevos = true

//Var. que indica si se va a permitir exportar (guardar como)
Boolean	ib_guardarcomo = false

//Var. que indica que se est$$HEX2$$e1002000$$ENDHEX$$agregando/insertando un registro nuevo
Boolean	ib_nuevo = false

//Var. que indica si va a aplicar zoom o no a la dw
Boolean	ib_zoom = false

//Var. para el servicio de filtro de dddw
boolean ib_dddropped = false, ib_ddredrawn = true

//Arreglo de campos a validar duplicados
String	isarr_validarepetidos[]

//Arreglo de campos con propiedad Edit Mask
String	isarr_editmask[]

//Arreglos para el registro del servicio de filtro de dddw
String	isarr_filtradddw[]

//Var. del nombre de la columna movida
String	is_columna_movida

// Para definir si la validaci$$HEX1$$f300$$ENDHEX$$n de repetidos sera solo en el dw o en toda la tabla
boolean	ib_validarepetidoslocal

// Var. para el servicio de split
string	is_campo_split

//Arreglo de campos a validar cadena vac$$HEX1$$ed00$$ENDHEX$$a
String	isarr_validacadenavacia[]

//Var. para la administraci$$HEX1$$f300$$ENDHEX$$n de seguridades
Boolean	ib_agregar = true, &
			ib_borrar = true, &
			ib_imprimir = true, &
			ib_actualizar = true
			
//Var. para almacenar los nombres de los campos de una DW que 
//   utilizan ayuda
String isarr_f1[]

n_cst_dwutil inv_dwutil

//Var. que indica si esta activo el servicio de agrupacion de columnas
Protected Boolean	ib_paintagrupador = FALSE, ib_opcionagrupador = FALSE
Boolean	ib_agrupadorcolumnas = FALSE
u_agrupador_columnas iuo_agrupador
integer ii_anchoagrupador = 180, ii_ModoAgrupador = 1, ii_offsetx
w_agrupador iw_agrupador
CONSTANT INTEGER DOCK = 1
CONSTANT INTEGER FLOATING = 2
u_dw_busqueda idw_busqueda

boolean ib_marcacampoactual
long il_colorindicador
string is_coloranterior, is_columnaanterior
boolean ib_bloqueascroll

CONSTANT INTEGER BUSQUEDA = 1
CONSTANT INTEGER FILTRO = 2


end variables

forward prototypes
public function integer of_setmultiplesnuevos (boolean ab_multiples)
public function integer of_setguardarcomo (boolean ab_switch)
public function integer of_setmensajepostupdate (boolean ab_switch)
public function integer of_setvalidacadenavacia (string as_campos)
public function string of_validacadenavacia (string campo, string data)
public function any of_muestra_catalogo (u_dw adw_objeto)
public function integer of_objetos_dw (u_dw adw_objeto, ref string asarr_objetos[], string as_tipo, string as_banda)
public function integer of_habilitaedicion (boolean ab_switch)
public function integer of_privilegiosedicion ()
public function integer of_setvalidarepetidos (string as_campos, boolean ab_local)
public function integer of_register_filtradddw (string as_campo, string as_criterio)
public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value)
public function integer of_filtradddw (boolean ab_switch)
public subroutine of_setregisterf1 (string as_campos)
public function integer of_setvalidarepetidos (string as_campos)
public function string of_validarepetidos (string campo, string data)
public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly)
public function integer of_setzoom (boolean ab_switch)
public function integer of_getparentwindow (ref window aw_parent)
public function integer of_setsplit (string as_campo_split)
public subroutine of_split ()
public function integer of_bringtofront ()
public function integer of_agrupadorcolumnas (boolean ab_activo, integer ai_modo)
public function integer of_setagrupador (boolean ab_activo)
public function integer of_activate ()
public function integer of_agrupadorcolumnas (boolean ab_activo)
public function integer of_setdwbusqueda (boolean ab_activo)
public function integer of_ajustadwbusqueda ()
public function integer of_setindicacampoactual (boolean ab_activo, long al_color)
public function integer of_setindicacampoactual (boolean ab_activo)
public function integer of_setbloqueascrollff (boolean ab_activo)
public function integer of_setdwbusqueda (boolean ab_activo, integer ai_modobusqueda)
public function integer of_create (string as_sql, n_tr atr_conexion)
public function integer of_importaexcel (string as_filename, string as_sheet, string as_columnas, integer ai_startrow)
public function integer of_importaexcel (string as_filename)
end prototypes

event postconstructor();//------------------------------------------------------------------
//  MODULO/FUNCION	:	postconstructor
//
//  DESCRIPCION		:	Evento que se ejecuta despu$$HEX1$$e900$$ENDHEX$$s de realizar el
//								Constructor
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  15/NOV/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long	ll_regreso

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

IF THIS.RowCount() > 0 THEN
	This.Event RowFocuschanged(1)
END IF

SetRedraw(TRUE)

end event

event ue_procesaenter;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
Post( Handle(this),256,9,0 )
 
Return 1
end event

event ue_dwnkey;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_regresa
string	ls_columna, ls_regreso
datawindowchild	ldwch_objeto

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Procesa la tecla presionada
choose case key
	case	keyF5!	//Refresca los dddw si lo hay...
		ls_columna = getcolumnname()
		//Determina si la columna activa es un dddw
		ls_regreso = Describe( ls_columna + ".DDDW.Name")
		//...no es un campo con dddw
		if ls_regreso = '!' or ls_regreso = '?' then return
		
		//Refresca el dddw
		li_regresa = getchild(ls_columna, ldwch_objeto)
		if li_regresa = -1 then
			messagebox("Error", "No se pudo refrescar el dropdown seleccionado", exclamation!)
			return
		else
			ldwch_objeto.retrieve()
		end if
	
	case KeyUpArrow!
	case KeyDownArrow!

end choose
end event

event ue_postlbuttonup();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_regreso, ls_campo, ls_ancho
integer	li_contador
long	ll_ancho

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Actualiza la barra de ayuda
IF IsValid(idw_busqueda) THEN	
	idw_busqueda.of_setRequestor(this)
END IF

ls_regreso = describe(is_columna_movida + ".EditMask.Mask")
if ls_regreso <> '?' or ls_regreso <> '!' then
	for li_contador = 1 to upperbound(isarr_editmask)
		ls_campo = mid(isarr_editmask[li_contador], 1, pos(isarr_editmask[li_contador], "|") - 1)
		ls_ancho = mid(isarr_editmask[li_contador], pos(isarr_editmask[li_contador], "|") + 1 )
		if is_columna_movida = ls_campo then
			ll_ancho = Long( describe( is_columna_movida + ".width" ))
			if ll_ancho < long(ls_ancho) then modify( is_columna_movida + ".Width='" + ls_ancho + "'" )
		end if
	next
end if


end event

event pbm_ncpaint;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Checa si existen registradas columnas para el servicio de filtrar dddw
if upperbound(isarr_filtradddw) > 0 then 
	if ib_dddropped and ib_ddredrawn then
		ib_dddropped = false
		ib_ddredrawn = false
		of_filtradddw(this, false)
		ib_ddredrawn = true
	end if
end if


IF ib_agrupadorcolumnas AND ib_paintagrupador AND ii_ModoAgrupador = DOCK THEN 

	iuo_agrupador.Move(ii_offsetx + this.X,this.Y - iuo_agrupador.Height - 10)
	
	of_BringToFront()
END IF
end event

event type integer pfc_saveas();//------------------------------------------------------------------
//  MODULO/FUNCION	: pfc_saveas
//
//  DESCRIPCION		: Evento para exportar los datos a otro formtato
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  25/ENE/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//	 06/NOV/01	OAQ		 Modificacion para que regrese el directorio actual
//  10/FEB/09	LAC		Exportaci$$HEX1$$f300$$ENDHEX$$n de excel con formato
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_archivo, ls_path,ls_ruta, ls_tipo
Integer	li_regreso
boolean	lb_continua = true
n_cst_filesrv	lnv_filesrv
n_cst_string lnv_string
u_dw	ldw

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

f_SetFilesrv(lnv_filesrv, TRUE)
ls_ruta = lnv_filesrv.of_getcurrentdirectory()

Do
	li_regreso = GetFileSaveName ( "Guardar como", ls_archivo, ls_archivo, "xld", &
	"Excel (datos), *.xl*, Excel (con formato), *.xls, Texto (separado por tabs),*.txt")
		
	If li_regreso <> 1 Then goto fin

	//Obtiene la referencia del directorio activo
	ls_path = lnv_filesrv.of_getcurrentdirectory()
	
	If Right(Trim(ls_path), 1) = "\" Then
		ls_archivo = ls_path + ls_archivo
	Else
		ls_archivo = ls_path + "\" + ls_archivo
	End If
	
	//Valida si el archivo ya existe
	If FileExists ( ls_archivo ) Then
		If messagebox("Guardar como", ls_archivo + " ya existe~r$$HEX1$$bf00$$ENDHEX$$Desea reemplazarlo?", &
			Exclamation!, YesNo!, 2) = 2 Then 
			lb_continua = False
		Else
			lb_continua = True
		End if
	Else
		lb_continua = True		
	End If

Loop Until lb_continua

//Obtiene el tipo de archivo
ls_tipo = mid(ls_archivo, lnv_string.of_lastpos(ls_archivo, '.') + 1)

choose case ls_tipo
	case	'txt'
		If saveas(ls_archivo, text!, true) = -1 Then
			Messagebox(title, "Fall$$HEX2$$f3002000$$ENDHEX$$la exportaci$$HEX1$$f300$$ENDHEX$$n", Exclamation!)
			goto fin
		End If
		
	case	'xld'
		If saveas(ls_archivo, excel5!, true) = -1 Then
			Messagebox(title, "Fall$$HEX2$$f3002000$$ENDHEX$$la exportaci$$HEX1$$f300$$ENDHEX$$n", Exclamation!)
			goto fin
		else
			//Renombra la ext del archivo a xls
			lnv_filesrv.of_filerename(ls_archivo, lnv_string.of_globalreplace(ls_archivo, ".xld", ".xls"))
		End If
		
	case	'xls'
		ldw = this
		li_regreso = uf_save_dw_as_excel(ldw, ls_archivo)
		if li_regreso <> 1 then
			messagebox(title, "Fall$$HEX2$$f3002000$$ENDHEX$$la exportaci$$HEX1$$f300$$ENDHEX$$n", exclamation!)
			goto fin
		end if

	case	'pdf'
		If saveas(ls_archivo, pdf!, true) = -1 Then
			Messagebox(title, "Fall$$HEX2$$f3002000$$ENDHEX$$la exportaci$$HEX1$$f300$$ENDHEX$$n", Exclamation!)
			goto fin
		End If
		
end choose

fin:
lnv_filesrv.of_changedirectory(ls_ruta)
destroy lnv_filesrv

return 1

end event

event verticalscroll;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Esta rutina se usa para evitar el scroll con el mouse en las dw tipo freeform
IF ib_bloqueascroll THEN
	if describe("dataWindow.processing") = '0' then return 1
END IF
end event

public function integer of_setmultiplesnuevos (boolean ab_multiples);
If IsNull(ab_multiples) Then Return FAILURE

ib_multiplesnuevos = ab_multiples

RETURN SUCCESS
end function

public function integer of_setguardarcomo (boolean ab_switch);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_setguardarcomo
//
//  DESCRIPCION		:	Habilita/Deshabilita el servicio para exportar la dw
//								a otros formatos
// 
//  EVENTO/ARGUMENTOS: 
//		ab_switch		:	TRUE	Habilita el servicio
//								FALSE	Inhabilita el servicio
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  25/ENE/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
ib_guardarcomo = ab_switch

return 0
end function

public function integer of_setmensajepostupdate (boolean ab_switch);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_setmensajepostupdate
//
//  DESCRIPCION		:	Habilita/inhabilita el servicio que muestra
// 							el mensaje de movimiento realizado al grabar
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  25/ABR/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//gb_mensajepostupdate = ab_switch

return 0
end function

public function integer of_setvalidacadenavacia (string as_campos);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_setvalidacadenavacia
//
//  DESCRIPCION		:	Valida que no se graben registros con cadenas vacias.
// 
//  EVENTO/ARGUMENTOS:
//						as_campos:	Lista separada por comas de los nombres de los campos
//											a validar 
//
//  DEVUELVE:
//					  0	: 	Si no hubo errores
//					 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  23/MAY/01	MSG	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
pointer		oldpointer

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
setpointer(hourglass!)
oldpointer = SetPointer(HourGlass!)

//Pasa la lista de campo al arreglo
gnv_funciones_string.of_ParseToArray ( as_campos, ",", isarr_validacadenavacia)

//Regresa el puntero original
SetPointer(oldpointer)

Return 0

end function

public function string of_validacadenavacia (string campo, string data);//------------------------------------------------------------------
//  MODULO/FUNCION: of_validacadenavacia
//
//  DESCRIPCION:	 Rutina que valida que el dato capturado no est$$HEX2$$e9002000$$ENDHEX$$vacio;
//							 es decir que  el  registro de la dw no se guarde sin informaci$$HEX1$$f300$$ENDHEX$$n.
//							 Se basa en el arreglo de campos que se llena al habilitar
//							 el servicio de validaci$$HEX1$$f300$$ENDHEX$$n de cadena vacia (of_setvalidacadenavacia)
// 
//								
//								
// 
//  EVENTO/ARGUMENTOS: 
//										campo: nombre de los campos a validar
//										data: valor que el campo toma 
//
//  DEVUELVE:
//		 
//		  Nulo			: 	No hubo registros vacios
//		  Mensaje		:	Si hubo registros vacios
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  23/MAY/01 	 MSG 	Creaci$$HEX1$$f300$$ENDHEX$$n	
//
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer 		li_pos
Boolean	lb_hallado
Long			ll_renglon, ll_registros
String		ls_tipo, ls_expresion, ls_mensaje,ls_mensaje_vacio, & 
				ls_Updatetable, ls_dbName

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Valida si est$$HEX2$$e1002000$$ENDHEX$$inicializado el servicio
If  Upperbound(isarr_validacadenavacia) = 0 then Return gs_nulo

//Checa si el campo est$$HEX2$$e1002000$$ENDHEX$$declarado en el servicio
lb_hallado = false
For li_pos = 1 To Upperbound(isarr_validacadenavacia)
	If isarr_validacadenavacia[li_pos] = campo Then
		lb_hallado = true
		Exit
	End If
Next

If Trim(data) =''   Then 
	    ls_mensaje_vacio = "El campo no puede quedar vacio "
        return ls_mensaje_vacio
else
     	Return gs_nulo
end if






end function

public function any of_muestra_catalogo (u_dw adw_objeto);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_muestra_catalogo
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que muestra el cat$$HEX1$$e100$$ENDHEX$$logo correspondiente
//							  para el dw y campo dados
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		-	El valor id o llave del registro insertado en el cat$$HEX1$$e100$$ENDHEX$$logo mostrado.
//			Se devuelve en un tipo de datos Any.
//		-	NULO si ocurri$$HEX2$$f3002000$$ENDHEX$$alg$$HEX1$$fa00$$ENDHEX$$n error o se cancel$$HEX2$$f3002000$$ENDHEX$$la alta
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  05/NOV/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_SQLErr, ls_nombre_dw_cat, ls_uo_catalogo, ls_parametros, ls_titulo, ls_dataobject, ls_campo
Any		lany_valor
Long		ll_renglon
str_cat_origen	lstr_cat_origen

////Declara la sp
//Declare SPs_Campo_Catalogo Procedure For SPs_Campo_Catalogo
//	 @as_nombre_dw		=	:ls_dataobject
//	,@as_nombre_campo	=	:ls_campo;
//
////------------------------------------------------------------------
//// CODIGO DE LA RUTINA
////------------------------------------------------------------------
//SetPointer(Hourglass!) 
//
////Inicializa la variable de regreso
//SetNull(lany_valor)
//
////Obtiene el nombre del dataobject
//ls_dataobject = adw_objeto.dataobject
//
////Obtiene el rengl$$HEX1$$f300$$ENDHEX$$n activo
//ll_renglon = adw_objeto.getrow()
//
////Obtiene el nombre de la columna activa
//ls_campo = adw_objeto.getcolumnname()
//
////Ejecuta la sp para saber el uo a mostrar
//Execute SPs_Campo_Catalogo;
//ls_SQLErr = SQLCA.SQLErrText
//
//If SQLCA.SQLCode < 0 Then
//	Close SPs_Campo_Catalogo;
//	Rollback;
//	Messagebox(gs_NombreApp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de mostrar el cat$$HEX1$$e100$$ENDHEX$$logo del campo '" + &
//			ls_campo + "'~r" + ls_SQLErr, StopSign!)
//	Return lany_valor
//End If
//
//Fetch SPs_Campo_Catalogo Into :ls_nombre_dw_cat, :ls_uo_catalogo, :ls_titulo;
//
//ls_SQLErr = SQLCA.SQLErrText
//Close SPs_Campo_Catalogo;
//If SQLCA.SQLCode < 0 Then
//	Rollback;
//	Messagebox(gs_NombreApp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de mostrar el cat$$HEX1$$e100$$ENDHEX$$logo del campo '" + &
//			ls_campo + "'~r" + ls_SQLErr, StopSign!)
//	Return lany_valor
//Else
//	Commit;
//	
//	//Valida que el cat$$HEX1$$e100$$ENDHEX$$logo est$$HEX2$$e9002000$$ENDHEX$$correctamente configurado
//	if isnull(ls_nombre_dw_cat) or isnull(ls_uo_catalogo) or trim(ls_uo_catalogo) = "" or trim(ls_nombre_dw_cat) = "" then
//		Messagebox(gs_NombreApp, "El cat$$HEX1$$e100$$ENDHEX$$logo no est$$HEX2$$e1002000$$ENDHEX$$configurado apropiadamente o no est$$HEX2$$e1002000$$ENDHEX$$especificado", StopSign!)
//		return lany_valor
//	end if
//
//	//Arma la estructura de los par$$HEX1$$e100$$ENDHEX$$metros
//	lstr_cat_origen.dw_origen = adw_objeto
//	lstr_cat_origen.nombre_dw_cat = ls_nombre_dw_cat
//	lstr_cat_origen.uo_catalogo = ls_uo_catalogo
//	lstr_cat_origen.titulo = ls_titulo
//	
//	//Muestra la ventana con el uo del cat$$HEX1$$e100$$ENDHEX$$logo
//	OpenWithParm(gwarr_catalogo[gi_ventanas], lstr_cat_origen, "w_cat_maestro")	
//End If	

Return lany_valor
end function

public function integer of_objetos_dw (u_dw adw_objeto, ref string asarr_objetos[], string as_tipo, string as_banda);//------------------------------------------------------------------
//  MODULO/FUNCION	: 	of_objetos_dw
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que desglosa la lista de objetos contenidos
//					en el DataObject asociado con el dw. Regresa los nombres en un
//					arreglo string pasado por referencia y la funci$$HEX1$$f300$$ENDHEX$$n retorna el n$$HEX1$$fa00$$ENDHEX$$mero
//					de nombres devueltos en el arreglo
// 
//  EVENTO/ARGUMENTOS: 
//		adw_objeto		:	Referencia a la dw
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
ls_lista_objetos = adw_objeto.Describe("datawindow.objects")

//Encuentra la posici$$HEX1$$f300$$ENDHEX$$n del primer tab
ls_tab_pos = Pos(ls_lista_objetos,"~t",ls_tab_ini)

//Ciclo para obtener los objetos deseados
Do While ls_tab_pos > 0
	//Obtiene el nombre del objeto
	ls_Obj_Paso = Mid(ls_lista_objetos,ls_tab_ini,(ls_tab_pos - ls_tab_ini))
	
	//Checa si el objeto es del tipo y banda deseado
	If (adw_objeto.Describe(ls_Obj_Paso+".type") = as_tipo or as_tipo = "*") &
		And (adw_objeto.Describe(ls_Obj_Paso+".band") = as_banda or as_banda = "*") Then
		li_contador = li_contador + 1
		asarr_objetos[li_contador] = ls_Obj_Paso
	End If
	
	//Obtiene el siguiente objeto
	ls_tab_ini = ls_tab_pos + 1
	ls_tab_pos = Pos(ls_lista_objetos,"~t",ls_tab_ini) 
Loop


ls_Obj_Paso = Mid(ls_lista_objetos,ls_tab_ini,Len(ls_lista_objetos))
If (adw_objeto.Describe(ls_Obj_Paso+".type") = as_tipo or as_tipo = "*") And &
	(adw_objeto.Describe(ls_Obj_Paso+".band") = as_banda or as_banda = "*") Then
	li_contador = li_contador + 1
	asarr_objetos[li_contador] = ls_Obj_Paso
End If

//Regresa el total de nombres
Return li_contador


end function

public function integer of_habilitaedicion (boolean ab_switch);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_habilitaedicion
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que habilita/inhabilita la edici$$HEX1$$f300$$ENDHEX$$n de la dw
// 
//  EVENTO/ARGUMENTOS: 
//		ab_switch		:	True/False - Habilita/Inhabilita la edici$$HEX1$$f300$$ENDHEX$$n
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  27/FEB/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

Integer	li_columnas, li_contador, li_contadormask = 1
String	ls_columnas[], ls_regreso, ls_color_original, ls_color_dw, ls_original

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Se sale si tiene permisos...
If ab_switch Then Return 0

//Obtiene los nombres de las columnas del dw
li_columnas = of_objetos_dw(this, ls_columnas, "column", "*")

//Congela la dw
this.setredraw(false)

//Ciclo para inhabilitar las columnas
For li_contador = 1 To li_columnas
	//Aplica la expresi$$HEX1$$f300$$ENDHEX$$n para proteger las columnas
	This.Modify(ls_columnas[li_contador] + ".Protect = '0 ~t If(isRowNew(), 0, 1)' ")
	//Pone background transparente
	ls_regreso = This.Describe(ls_columnas[li_contador] + ".Background.Mode")
	If  ls_regreso <> "1" Then
		ls_original = This.Describe(ls_columnas[li_contador] + ".Background.Mode")
		This.Modify(ls_columnas[li_contador] + ".Background.Mode= '0 ~t If(isRowNew(), 0, " + ls_original + ")'")
		ls_color_dw = This.Describe("DataWindow.Color")
		ls_color_original = This.Describe(ls_columnas[li_contador] + ".Background.Color")
		This.Modify(ls_columnas[li_contador] + ".Background.Color='" + ls_color_original + "~t If(isRowNew()," + ls_color_original + "," + ls_color_dw + ")'")
	End If
	//Guarda las columnas con Edit Mask
	ls_regreso = describe(ls_columnas[li_contador] + ".EditMask.Mask")
	if ls_regreso <> "?" and ls_regreso <> "!" then
		isarr_editmask[li_contadormask] = ls_columnas[li_contador] + "|" + describe(ls_columnas[li_contador] + ".width")
		li_contadormask ++
	end if
Next

//Descongela la dw
this.setredraw(true)

Return 0
end function

public function integer of_privilegiosedicion ();//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_privilegiosedicion
//
//  DESCRIPCION		:	Habilita/Deshabilita los campos de acuerdo
//								a la seguridad
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  15/NOV/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer	li_columnas, li_contador
String	ls_columnas[], ls_regreso, ls_color_original, ls_color_dw, ls_original,ls_col

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

////Si tiene privilegios de edici$$HEX1$$f300$$ENDHEX$$n se sale...
//If gi_actualizar = 1 Then Return 0
//
////Obtiene los nombres de las columnas del dw
//li_columnas = of_objetos_dw(this, ls_columnas, "column", "*")
//
////Congela la dw
//this.setredraw(false)
//
////Ciclo para inhabilitar las columnas
//For li_contador = 1 To li_columnas
//	//Aplica la expresi$$HEX1$$f300$$ENDHEX$$n para proteger las columnas
//	This.Modify(ls_columnas[li_contador] + ".Protect = '0 ~t If(isRowNew(), 0, 1)' ")
//	//Pone background transparente
//	ls_regreso = This.Describe(ls_columnas[li_contador] + ".Background.Mode")
//	If  ls_regreso <> "1" Then
//		ls_original = This.Describe(ls_columnas[li_contador] + ".Background.Mode")
//		This.Modify(ls_columnas[li_contador] + ".Background.Mode= '0 ~t If(isRowNew(), 0, " + ls_original + ")'")
//		ls_color_dw = This.Describe("DataWindow.Color")
//		ls_color_original = This.Describe(ls_columnas[li_contador] + ".Background.Color")
//		This.Modify(ls_columnas[li_contador] + ".Background.Color='" + ls_color_original + "~t If(isRowNew()," + ls_color_original + "," + ls_color_dw + ")'")
//	End If
//Next
//
////Descongela la dw
//this.setredraw(true)

Return 0
end function

public function integer of_setvalidarepetidos (string as_campos, boolean ab_local);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_setvalidarepetidos
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que habilita el servicio para validar 
//								captura de datos repetidos en los campos dados
//								y ademas tiene la opcion de buscar localmente (solo en la dw) o buscar
//								globalmente (toda la tabla).
// 
//  EVENTO/ARGUMENTOS:
//		as_campos		:	Lista separada por comas de los nombres de los campos
//								a validar, si la validaci$$HEX1$$f300$$ENDHEX$$n est$$HEX2$$e1002000$$ENDHEX$$compuesto por m$$HEX1$$e100$$ENDHEX$$s de un campo
//								entonces se separa por un pipe "|"
//			Ejemplo		:	CampoA|CampoB,CampoC
//								En este ejemplo se est$$HEX2$$e1002000$$ENDHEX$$diciendo que una llave alterna est$$HEX2$$e1002000$$ENDHEX$$compuesta
//								por el CampoA y el CampoB, y, que otro campo que no se puede repetir es
//								el CampoC
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  23/ENE/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
pointer		oldpointer

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
setpointer(hourglass!)
oldpointer = SetPointer(HourGlass!)

//Pasa la lista de campo al arreglo
gnv_funciones_string.of_ParseToArray ( as_campos, ",", isarr_validarepetidos )

// Guarda en variable de instancia si se validara local o globalmente.
ib_validarepetidoslocal = ab_local

//Regresa el puntero original
SetPointer(oldpointer)

Return 0

end function

public function integer of_register_filtradddw (string as_campo, string as_criterio);//------------------------------------------------------------------
//  FUNCION/EVENTO	:	of_register_filtradddw
//
//  DESCRIPCION		:	Rutina que registra los campos y criterios para el servicio
//								de filtrado de dddw
// 
//  ARGUMENTOS			: 
//			as_campo		:	Nombre del campo que contiene el dddw a filtrar
//			as_criterio	:	String con la condici$$HEX1$$f300$$ENDHEX$$n a aplicar para el filtro de este dddw
//								Nota:
//								Los campos referentes al dddw se deber$$HEX1$$e100$$ENDHEX$$n poner entre [], y, los campos
//								referentes al dw contenedor se deber$$HEX1$$e100$$ENDHEX$$n poner entre {}.
//								Ejemplo:
//									"[id_pais] = {id_pais}"
//								Tambi$$HEX1$$e900$$ENDHEX$$n se pueden usar las referencias a los campos del dddw con n$$HEX1$$fa00$$ENDHEX$$meros.
//									"#3 = {id_pais}"
//								En los ejemplos anteriores, el campo {id_pais} se va a usar para leer el campo
//								en el dw contenedor y obtener el valor correspondiente.
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  16/FEB/02	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_max

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
li_max = upperbound(isarr_filtradddw)
isarr_filtradddw[li_max + 1] = as_campo + "|" + as_criterio

return li_max + 1
end function

public function any of_getitemany (long al_row, string as_column, dwbuffer adw_buffer, boolean ab_orig_value);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_GetItemAny (FORMAT 4) 
//	Arguments:   	al_row			   : The row reference
//   					as_column    		: The column name reference
//   					adw_buffer   		: The dw buffer from which to get the column's data value.
//   					ab_orig_value		: When True, returns the original values that were 
//							  					  retrieved from the database.
//	Returns:			Any - The column value cast to an any datatype
//	Description:	Returns a column's value cast to an any datatype
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//						7.0	Removed test on computed columns.  They can be treated
//								as normal columns.
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
any 		la_value
long		result

/*  Determine the datatype of the column and then call the appropriate 
	 GetItemxxx function and cast the returned value */
CHOOSE CASE Lower ( Left ( Describe ( as_column + ".ColType" ) , 5 ) )

		CASE "char(", "char"		//  CHARACTER DATATYPE
			la_value = GetItemString ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "date"					//  DATE DATATYPE
			la_value = GetItemDate ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "datet"				//  DATETIME DATATYPE
			la_value = GetItemDateTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE "decim"				//  DECIMAL DATATYPE
			la_value = GetItemDecimal ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "numbe", "long", "ulong", "real", "int"				//  NUMBER DATATYPE	
			la_value = GetItemNumber ( al_row, as_column, adw_buffer, ab_orig_value ) 
	
		CASE "time", "times"		//  TIME DATATYPE
			la_value = GetItemTime ( al_row, as_column, adw_buffer, ab_orig_value ) 

		CASE ELSE 					
			SetNull ( la_value ) 

END CHOOSE

Return la_value
end function

public function integer of_filtradddw (boolean ab_switch);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_filtradddw
//
//  DESCRIPCION		: Filtra los ddddw de acuerdo a los registros
// 
//  ARGUMENTOS			: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  27/NOV/02	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string 	ls_criterio = "", ls_campoactivo, ls_aux, ls_tipo
integer	li_contador, li_pos_abre, li_pos_cierra
long		ll_renglon
any		lany_valor
boolean	lb_hallado = false
datawindowchild ldwch_child

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
ll_renglon = this.getrow()	
if ll_renglon <= 0 then return 0 

ls_campoactivo = getcolumnname()

if ab_switch then
	//Valida si este campos est$$HEX2$$e1002000$$ENDHEX$$registrado en el servicio de filtro dddw
	for li_contador = 0 to upperbound(isarr_filtradddw)
		ls_aux = lower(left(isarr_filtradddw[li_contador], pos(isarr_filtradddw[li_contador], "|") - 1))
		if ls_aux = ls_campoactivo then 
			//Lee el campo de criterios
			ls_criterio = right(isarr_filtradddw[li_contador], len(isarr_filtradddw[li_contador]) - pos(isarr_filtradddw[li_contador], "|"))
			lb_hallado = true
		end if
	next
	if not lb_hallado then return 0
	
	//Barre el criterio para armar la condici$$HEX1$$f300$$ENDHEX$$n
	li_pos_abre = pos(ls_criterio, "{", 1)
	do while li_pos_abre > 0
		//Encuentra la llave que cierra
		li_pos_cierra = pos(ls_criterio, "}", li_pos_abre)
		ls_aux = mid(ls_criterio, li_pos_abre + 1, li_pos_cierra - li_pos_abre - 1)
		ls_tipo = Lower ( Left ( Describe ( ls_aux + ".ColType" ) , 5 ) )
		choose case ls_tipo
			case "char(", "char"
				lany_valor = GetItemString ( ll_renglon, ls_aux, primary!, true )
				if isnull(lany_valor) then lany_valor = "#$%&"
				ls_criterio = gnv_funciones_string.of_globalreplace(ls_criterio, "{" + ls_aux + "}", "'" + lany_valor + "'")
				
			case "numbe", "long", "ulong", "real", "int"
				lany_valor = GetItemNumber ( ll_renglon, ls_aux, primary!, true ) 
				if isnull(lany_valor) then lany_valor = "-777"
				ls_criterio = gnv_funciones_string.of_globalreplace(ls_criterio, "{" + ls_aux + "}", "'" + string(lany_valor)+ "'")
				
		end choose
		li_pos_abre = pos(ls_criterio, "{", li_pos_cierra + 1)
	loop
end if 

//Obtiene la referencia al dw child
li_contador = GetChild(ls_campoactivo, ldwch_child)
li_contador = ldwch_child.setfilter(ls_criterio)
li_contador = ldwch_child.filter()

return 0
end function

public subroutine of_setregisterf1 (string as_campos);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_setregisterf1
//
//  DESCRIPCION		: Llena un arreglo con los nombres de campos que utilizan f1
// 
//  ARGUMENTOS			: ab_estado
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/MAY/04	DTR	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
//Pasa la lista de campo al arreglo
gnv_funciones_string.of_ParseToArray ( as_campos, ",", isarr_f1 )

end subroutine

public function integer of_setvalidarepetidos (string as_campos);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_setvalidarepetidos
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que habilita el servicio para validar 
//								captura de datos repetidos en los campos dados
//								y ademas tiene la opcion de buscar localmente (solo en la dw) o buscar
//								globalmente (toda la tabla).
// 
//  EVENTO/ARGUMENTOS:
//		as_campos		:	Lista separada por comas de los nombres de los campos
//								a validar, si la validaci$$HEX1$$f300$$ENDHEX$$n est$$HEX2$$e1002000$$ENDHEX$$compuesto por m$$HEX1$$e100$$ENDHEX$$s de un campo
//								entonces se separa por un pipe "|"
//			Ejemplo		:	CampoA|CampoB,CampoC
//								En este ejemplo se est$$HEX2$$e1002000$$ENDHEX$$diciendo que una llave alterna est$$HEX2$$e1002000$$ENDHEX$$compuesta
//								por el CampoA y el CampoB, y, que otro campo que no se puede repetir es
//								el CampoC
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  23/ENE/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
pointer		oldpointer

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
setpointer(hourglass!)
oldpointer = SetPointer(HourGlass!)

//Pasa la lista de campo al arreglo
gnv_funciones_string.of_ParseToArray ( as_campos, ",", isarr_validarepetidos )

// Guarda en variable de instancia si se validara local o globalmente.
ib_validarepetidoslocal = false

//Regresa el puntero original
SetPointer(oldpointer)

Return 0

end function

public function string of_validarepetidos (string campo, string data);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_validarepetidos
//
//  DESCRIPCION		:	Rutina que valida que el dato capturado no est$$HEX2$$e9002000$$ENDHEX$$repetido
//								en alg$$HEX1$$fa00$$ENDHEX$$n otro registro de la dw.
//								Se basa en el arreglo de campos que se llena al habilitar
//								el servicio de validaci$$HEX1$$f300$$ENDHEX$$n de duplicados (of_setvalidarepetidos)
//
//  EVENTO/ARGUMENTOS:
//			campo			:	Campo a validar
//			data			:	Valor del campo a validar
//
//  DEVUELVE			:
//		  Nulo			: 	No hubo registros repetidos
//		  Mensaje		:	Si hubo registros repetidos
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  19/ENE/01	LAC		Creaci$$HEX1$$f300$$ENDHEX$$n
//	 06/MAY/01	SNH		Se adapto funci$$HEX1$$f300$$ENDHEX$$n para que en vez de buscar valores repetidos solo comparando con los datos
//								contenidos en el dw haga la busqueda en toda la tabla (en la que se intenta guardar).
//	 27/MAY/01	LAC		Adecuaci$$HEX1$$f300$$ENDHEX$$n para que se soporte validaci$$HEX1$$f300$$ENDHEX$$n de datos compuestos por m$$HEX1$$e100$$ENDHEX$$s de una columna.
//	 24/JUN/01	SNH		Adecuaci$$HEX1$$f300$$ENDHEX$$n para validar localmente (solo dw) o global (toda la tabla)
//	 24/JUN/02	OAQ		Adecuacion para que tome el nombre del campo cuando valide local
//	 05/MAY/05	LAC		Valide siempre primero local y luego por BD
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer li_pos
Boolean	lb_hallado
Long	ll_renglon, ll_registros, ll_contador, ll_ocurrencias, ll_hallado, ll_renglon_find, &
		ll_registros_encontrados, ll_lookup
String	ls_tipo, ls_expresion, ls_expresion_bd, ls_mensaje, ls_Updatetable, ls_nombre_bd, ls_nombre,&
			ls_campo, ls_dato, ls_valores, ls_nulo, ls_titulo, ls_editstyle,ls_datacolumn, ls_displaycolumn
n_cst_string	lnv_funciones_string
datawindowchild ldwch_dddw

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Obtiene el n$$HEX1$$fa00$$ENDHEX$$mero de rengl$$HEX1$$f300$$ENDHEX$$n
ll_renglon = getrow()

//Valida si est$$HEX2$$e1002000$$ENDHEX$$inicializado el servicio
If  Upperbound(isarr_validarepetidos) = 0 then Return gs_nulo

//Valida si el dato es nulo
if isnull(data) then return gs_nulo

//Checa si el campo est$$HEX2$$e1002000$$ENDHEX$$declarado en el servicio
lb_hallado = false
For li_pos = 1 To Upperbound(isarr_validarepetidos)
	ll_ocurrencias = lnv_funciones_string.of_CountOccurrences ( isarr_validarepetidos[li_pos], "|" ) + 1
	For ll_contador = 1 To  ll_ocurrencias
		if lnv_funciones_string.of_desglosa_string(isarr_validarepetidos[li_pos], ll_contador, "|") = campo then
			lb_hallado = true
			Exit
		end if
	Next
	if lb_hallado then
		ll_hallado = li_pos
		exit
	end if
Next
//...si no estaba declarado el campo en el servicio...
If Not lb_hallado then return gs_nulo

// Revisa que haya una tabla definida para el dw para guardar informacion
ls_Updatetable = Object.DataWindow.Table.UpdateTable
IF IsNull(ls_Updatetable) OR ls_Updatetable = "" THEN
	ls_mensaje = "La pantalla no esta preparada para guardar la informaci$$HEX1$$f300$$ENDHEX$$n; favor de avisar a sistemas (En la dw se debe definir la tabla updatable)."
	RETURN ls_mensaje
END IF

//Ciclo para armar la expresi$$HEX1$$f300$$ENDHEX$$n a validar...
ls_expresion = ""
ls_expresion_bd = ""
For ll_contador = 1 To ll_ocurrencias
	ls_campo = lnv_funciones_string.of_desglosa_string(isarr_validarepetidos[ll_hallado], ll_contador, "|")
	ls_nombre =  Describe(ls_campo+".Name")
	ls_nombre_bd =  Describe(ls_campo+".dbName")

	//Obtiene el tipo de datos
	ls_tipo = describe(ls_campo + ".ColType")

	//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
	li_pos = Pos(ls_tipo, "(", 1)
	If li_pos > 0 Then ls_tipo = Mid ( ls_tipo, 1, li_pos - 1)

	//Construye la expresion
	Choose Case Upper(ls_tipo)
		Case	"INTEGER", "NUMBER", "LONG"
			If campo = ls_campo then
				ls_dato = "=" + data
			else
				ls_dato = "=" + string(getitemnumber(ll_renglon, ls_campo))
			end if
		Case	"STRING" , "CHAR"
			If campo = ls_campo then
				ls_dato = "='" + data + "'"
			else
				ls_dato = "='" + getitemstring(ll_renglon, ls_campo) + "'"
			end if
		Case 	"DATE"
			If campo = ls_campo then
				ls_dato = "='" + left(data,16) + "'"
			else
				ls_dato = "='" + left(string(getitemdate(ll_renglon, ls_campo)), 16) + "'"
			end if
		Case	"DATETIME"
			
			If campo = ls_campo then
				ls_dato = "=datetime('" + left(data,10) + "')"
			else
				ls_dato = "='" + left(string(getitemdatetime(ll_renglon, ls_campo)),10) + "'"
			end if
		Case	"DECIMAL"
			If campo = ls_campo then
				ls_dato = "=" + data
			else
				ls_dato = "=" + string(getitemdecimal(ll_renglon, ls_campo))
			end if
		Case Else
			ls_mensaje = "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_valida_repetidos' al validar " + &
				"duplicados en '" + ls_campo + "'"
	End Choose

	if isnull(ls_dato) then
		ls_expresion += ' IsNull(' + ls_nombre + ')' + " And "
		ls_expresion_bd += ' IsNull(' + ls_nombre_bd + ')' + " And "
	else
		ls_expresion += ls_nombre + ls_dato + " And "
		ls_expresion_bd += ls_nombre_bd + ls_dato + " And "
	end if
Next

//Quita el $$HEX1$$fa00$$ENDHEX$$ltimo And
ls_expresion = left(ls_expresion, len(ls_expresion) - 4)
ls_expresion_bd = left(ls_expresion_bd, len(ls_expresion_bd) - 4)

IF ib_validarepetidoslocal then
	//Primero valida localmente...
	ll_registros = RowCount()
	ll_renglon_find = Find(ls_expresion,1,ll_registros)
	if ll_renglon = ll_renglon_find then ll_renglon_find = 0
	ll_registros_encontrados = ll_renglon_find
else
	//Luego valida por BD en caso de ser necesario...
	if ll_registros_encontrados = 0 then 
		// Consulta en la tabla de guardar del dw si no hay otro valor igual al
		// que se intenta dar de alta
		DECLARE c_UpdateTable DYNAMIC CURSOR FOR SQLSA;
		string sqlstatement
		//Valida el DBMS
		if pos(sqlca.dbms, "ORAC") > 0 then
			sqlstatement = "SELECT Count(*) FROM " + ls_Updatetable + " WHERE " + ls_expresion_bd
		else
			sqlstatement = "SELECT Count(*) FROM " + ls_Updatetable + " WHERE " + ls_expresion_bd
		end if
		PREPARE SQLSA FROM :sqlstatement ;
		OPEN DYNAMIC c_UpdateTable;
		FETCH c_UpdateTable INTO :ll_registros_encontrados ;
		CLOSE c_UpdateTable ;
	end if
END IF

IF ll_registros_encontrados > 0 THEN
	for ll_contador = 1 to ll_ocurrencias
		ls_campo = lnv_funciones_string.of_desglosa_string(isarr_validarepetidos[ll_hallado], ll_contador, "|")
		ls_titulo = describe(ls_campo + "_t.text")
		
		IF ls_titulo = '!' THEN ls_titulo = ls_campo
		
		ls_valores += "-" + ls_titulo + ": " + ""
		ls_editstyle = lower(describe(ls_campo+".Edit.Style"))
		if ls_editstyle = "dddw" then
			ls_displaycolumn = describe(ls_campo + ".DDDW.DisplayColumn")
			ls_datacolumn = describe(ls_campo + ".DDDW.DataColumn")
			getchild(ls_campo, ldwch_dddw)
			ll_registros = ldwch_dddw.rowcount()
			if trim(campo) <> trim(ls_campo) then
				ll_lookup = ldwch_dddw.getrow()
			else
				ll_lookup = ldwch_dddw.find( ls_datacolumn + "='" + data + "'",1, ll_registros)
			end if
			if isnull(ll_lookup) then
				ls_dato = ""
			else
				if ll_lookup > 0 then
					ls_tipo = ldwch_dddw.describe(ls_displaycolumn + ".ColType")
					//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
					li_pos = Pos(ls_tipo, "(", 1)
					If li_pos > 0 Then ls_tipo = Mid ( ls_tipo, 1, li_pos - 1)
	
					//Construye la expresion
					choose case Upper(ls_tipo)
						case	"INTEGER", "NUMBER", "LONG"
							ls_dato = string(ldwch_dddw.getitemnumber(ll_lookup, ls_displaycolumn))
						case	"STRING" , "CHAR"
							ls_dato = ldwch_dddw.getitemstring(ll_lookup, ls_displaycolumn)
					end choose
				end if
			end if
		else
				ls_tipo = describe(ls_campo + ".ColType")
				//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
				li_pos = Pos(ls_tipo, "(", 1)
				If li_pos > 0 Then ls_tipo = Mid ( ls_tipo, 1, li_pos - 1)

				//Construye la expresion
				choose case Upper(ls_tipo)
					case	"INTEGER", "NUMBER", "LONG"
						if campo = ls_campo then
							ls_dato = data
						else
							ls_dato = string(getitemnumber(ll_renglon, ls_campo))
						end if
					case	"STRING" , "CHAR"
						If campo = ls_campo then
							ls_dato = data
						else
							ls_dato = getitemstring(ll_renglon, ls_campo)
						end if
					Case	"DECIMAL"
						If campo = ls_campo then
							ls_dato = data
						else
							ls_dato = string(getitemdecimal(ll_renglon, ls_campo))
						end if
				end choose
		end if

		ls_valores = ls_valores + ls_dato + "~r"
	next
	ls_mensaje = "Los siguientes valores no se pueden repetir:~r" + ls_valores
	return ls_mensaje
else
	setnull(ls_nulo)
	Return ls_nulo
end if

end function

public function integer of_checkrequired (dwbuffer adw_buffer, ref long al_row, ref integer ai_col, ref string as_colname, boolean ab_updateonly);//////////////////////////////////////////////////////////////////////////////
// ADECUADO POR LAC
//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_CheckRequired 
//	Arguments:		adw_buffer   	The buffer to check for required fields
// 					al_row   		First row to be checked.  Also stores the number of the found row
//						ai_col   		First column to be checked.  Also stores the number of the found column
//						as_colname   	Contains the columnname in error
//	Returns:			Integer
//	 					1 = The required fields test was successful, check arguments for required fields missing
//	 					0 = The required fields test was successful and no errors were found
//  					-1 = Error
//	Description:	Calls the FindRequired function to determine if any of the required columns contain null values.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
// 					6.0.01 Enhanced to call stub function which allows for more flexibility and control.
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
w_master	lw_pfcparent
window	lw_parent
boolean	lb_skipmessage=false
string	ls_msgparm[2], ls_titulo
integer	li_rc

// Check arguments
if IsNull (adw_buffer) or IsNull (al_row) or IsNull (ai_col) or IsNull (as_colname) then return FAILURE

SetPointer(HourGlass!) 

// Call FindRequired to locate first error, if any
ab_updateonly = false
if this.FindRequired (adw_buffer, al_row, ai_col, as_colname, ab_updateonly) < 0 then return FAILURE

// Double Check if failure condition was ecountered.
if al_row < 0 then return FAILURE

// Check if no missing values were found.
if al_row = 0 then return 0

// -- A Missing Value was encountered. --

// Get a reference to the window
this.of_GetParentWindow (lw_parent) 
if IsValid (lw_parent) then
	if lw_parent.TriggerEvent ("pfc_descendant") = 1 then
		lw_pfcparent = lw_parent
	end if
end if	
	
// Make sure the window is not closing.  
if IsValid (lw_pfcparent) then
	if lw_pfcparent.of_GetCloseStatus() then
		// It is closing, so don't show errors now.	
		lb_skipmessage = true
	end if
end if

// Skip the message if the window is closing.	
if not lb_skipmessage then
	// Call stub function to either handle condition or provide a more suitable
	// column name.
	li_rc = this.Event pfc_checkrequirederror (al_row, as_colname)
	if li_rc < 0 then return -1
	
	if li_rc >= 1 then
		//Obtiene la descripci$$HEX1$$f300$$ENDHEX$$n asociada al campo
		ls_titulo = describe(as_colname + "_t.Text")
		if trim(ls_titulo) = "?" or trim(ls_titulo) = "!" then ls_titulo = as_colname
		// Display condition.
		if IsValid(gnv_app.inv_error) then
			ls_msgparm[1] = ls_titulo
			ls_msgparm[2] = String (al_row)
			gnv_app.inv_error.of_Message("pfc_requiredmissing", ls_msgparm, &
					gnv_app.iapp_object.DisplayName)
		else
			of_MessageBox ("pfc_checkrequired_missingvalue", gnv_app.iapp_object.DisplayName, &
				"Falta el valor requerido en el campo " + ls_titulo + &
				". Por favor agrege un valor.", information!, Ok!, 1)
		end if
	
		// Make sure row/column gets focus.
		this.SetRow (al_row)
		this.ScrollToRow (al_row)		
		this.SetColumn (ai_col)
		this.SetFocus () 		
	end if
end if
	
// Return that a required column does contain a null value.
return 1
end function

public function integer of_setzoom (boolean ab_switch);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_setzoom
//
//  DESCRIPCION		:	Habilita/inhabilita el servicio de zoom
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  01/SEP/06	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if IsNull(ab_switch) then return FAILURE

if ab_Switch then
	if IsNull(inv_zoom) or not IsValid (inv_zoom) then
		inv_zoom = Create n_cst_dwsrv_printpreview
		inv_zoom.of_SetRequestor ( this )
		return SUCCESS
	end if
else 
	if IsValid (inv_zoom) then
		Destroy inv_zoom
		return SUCCESS
	end if	
end if

return NO_ACTION

end function

public function integer of_getparentwindow (ref window aw_parent);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_GetParentWindow
//	Arguments:		aw_parent   The Parent window for this object (passed by reference).
//	   								If a parent window is not found, aw_parent is NULL
//	Returns:			Integer - 1 if it succeeds and -1 if an error occurs
//	Description:	Calculates the parent window of a window object
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
powerobject	lpo_parent
oleobject lole_dw
integer	result

lpo_parent = this.GetParent()

// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

if IsNull(lpo_parent) or not IsValid (lpo_parent) then lpo_parent = gw_frame
if IsNull(lpo_parent) or not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return FAILURE
end if

aw_parent = lpo_parent

return SUCCESS
end function

public function integer of_setsplit (string as_campo_split);//------------------------------------------------------------------
//  FUNCION/EVENTO	:	of_setsplit
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n para iniciar servicio de split
// 
//  ARGUMENTOS			: 
//		as_campo_split	:	Campo a partir del cual se har$$HEX2$$e1002000$$ENDHEX$$el split de la dw
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  8/ENE/08	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

is_campo_split = as_campo_split

return 0

end function

public subroutine of_split ();//------------------------------------------------------------------
//  FUNCION/EVENTO	:	of_split
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n para marcar la barra de split en el dw
// 
//  ARGUMENTOS			: 
//		as_campo_split	:	Campo a partir del cual se har$$HEX2$$e1002000$$ENDHEX$$el split de la dw
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  1/AGO/06	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_split_inicial, li_tamano_barra

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if is_campo_split = "" then 
	Modify("DataWindow.HorizontalScrollSplit=0")
else
	Modify("DataWindow.HorizontalScrollSplit=0")
	li_tamano_barra = integer(Object.DataWindow.HorizontalScrollMaximum)
	
	if li_tamano_barra > 0 then
		
		li_split_inicial = integer(describe(is_campo_split + ".X")) + integer(describe(is_campo_split + ".width")) + 10
		post Modify("DataWindow.HorizontalScrollSplit=" + string(li_split_inicial))
		
	end if
end if

end subroutine

public function integer of_bringtofront ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_BringToFront
//
//  DESCRIPCION		: En caso de que esta activo el panel agrupador posiciona
//								los objetos sobre todos los demas
// 
//  EVENTO/ARGUMENTOS: 
//
//
//  DEVUELVE			:
//	  0   :  Todo Bien
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

this.BringToTop = TRUE
	
IF ib_agrupadorcolumnas THEN
	IF IsValid(iuo_agrupador) THEN iuo_agrupador.BringToTop = TRUE
END IF

RETURN 0
end function

public function integer of_agrupadorcolumnas (boolean ab_activo, integer ai_modo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AgrupadorColumnas
//
//  DESCRIPCION		: Relaciona y prepara el objeto DataWindow para interactuar con el control
// 
//  EVENTO/ARGUMENTOS: 
//      ab_activo  : Variable de control para activar o desactivar el servicio
//
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//		0 : Ning$$HEX1$$fa00$$ENDHEX$$n Cambio
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
window lw_parent
integer li_rtn, li_respaldo
boolean lb_respaldo
exception ex1, ex2, ex3
dragobject luo_parent
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Eventos relacionados: Clicked, Resize, RetrieveEnd, RetrieveStart, Paint, Destructor, pfc_prermbmenu
//IMPORTANTE: Debe activar el servicio despues de que todos los objetos de la ventana 
//					 hayan sido posicionados


IF NOT ib_opcionagrupador AND ab_activo THEN
	messagebox(gs_nombreapp,"Debe activar el servicio del panel agrupador",exclamation!)
	RETURN -1
END IF

//Respalda valores anteriores
lb_respaldo = ib_agrupadorcolumnas
li_respaldo = ii_ModoAgrupador

TRY
	//Asigna nuevos valores
	ib_agrupadorcolumnas = ab_activo
	ii_ModoAgrupador = ai_modo
		
	of_GetParentWindow(lw_parent)
		
	//Si activa al objeto
	IF ab_activo THEN
		
		CHOOSE CASE ai_modo
			CASE DOCK //Integrado al objeto
				
				IF isvalid(iuo_agrupador) THEN 
					ex3 = CREATE exception
					ex3.Text = "Ya existe una instancia del objeto"
					THROW ex3
				END IF
				
				//Variable de control en el Paint
				ib_paintagrupador = FALSE
				//LEC20100803
				IF this.GetParent().Classname() <> lw_parent.classname() THEN
					luo_parent = this.GetParent()
					ii_offsetx = luo_parent.X
				ELSE
					ii_offsetx = 0
				END IF
				
				//Abre el Objeto
				li_rtn = lw_parent.OpenUserObject(iuo_agrupador)
				
				IF li_rtn <> 1 THEN
					ex1 = CREATE exception
					ex1.Text = "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al abrir el Objeto Panel Agrupado"
					THROW ex1
				END IF
				
				SetRedraw(FALSE)
				
				//Inicializa los valores correspondientes
				li_rtn = iuo_agrupador.of_InicializaDetalle(this)
				
				IF li_rtn <> 1 THEN
					ex2 = CREATE exception
					THROW ex2
				END IF
				
				//Ajusta la posicion del Agrupador y del DW
				this.Height = Height - ii_anchoagrupador - 10
				this.post move(this.x,this.y + ii_anchoagrupador)
				iuo_agrupador.post Move(ii_offsetx + this.X, this.Y)

				iuo_agrupador.height = ii_anchoagrupador
				this.Y = iuo_agrupador.Y + iuo_agrupador.Height + 10
				
				//--------------------------------------------------------
				
				ib_paintagrupador = TRUE
				
				//Posiciona los objetos sobre todos los demas
				of_BringToFront()
				
				SetRedraw(TRUE)	
				
			CASE FLOATING //Flotante
				//Abre el panel flotante
				OpenWithParm(iw_agrupador,this)
				of_BringToFront()
			CASE ELSE
				li_rtn = -1
		END CHOOSE
	
	ELSE
		//Eliminar el Objeto
		IF isvalid(iuo_agrupador) THEN
			//Si es de modo INTEGRADO cambia la posicion del DW
			IF ii_ModoAgrupador = DOCK THEN
				this.y = iuo_agrupador.Y
				this.height += ii_anchoagrupador
			END IF
			//Cierra y destrute el objeto
			li_rtn = lw_parent.CloseUserObject(iuo_agrupador)
			DESTROY iuo_agrupador
			
			//Apaga la variable de control 
			ib_paintagrupador = FALSE
		END IF
		//En caso de modo FLOTANTE
		IF isvalid(iw_agrupador) THEN
			//Cierra el Panel
			Close(iw_agrupador)
		END IF
		
		li_rtn = 1
	END IF
CATCH(runtimeerror a)
	//Restaura los valores anteriores
	SetRedraw(TRUE)
	ib_agrupadorcolumnas = lb_respaldo
	ii_ModoAgrupador = li_respaldo
	ib_paintagrupador = FALSE
	
	messagebox(gs_nombreapp,"Runtime: Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al inicializar el servicio de Panel Agrupador~n"+a.text,stopsign!)
	li_rtn = -1
	
CATCH(exception e)
	//Restaura los valores anteriores
	SetRedraw(TRUE)
	ib_agrupadorcolumnas = lb_respaldo
	ii_ModoAgrupador = li_respaldo
	ib_paintagrupador = FALSE
	
	IF len(trim(e.Text)) > 0 THEN messagebox(gs_nombreapp,"Exception: Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al inicializar el servicio de Panel Agrupador~n"+e.text,stopsign!)
	
	li_rtn = -1
	
END TRY

RETURN li_rtn

end function

public function integer of_setagrupador (boolean ab_activo);//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_SetAgrupador
//
//  DESCRIPCION		:	Habilita o Deshabilita el Servicio
// 
//  EVENTO/ARGUMENTOS:
//		ab_activo		:	Habilita o Deshabilita el Servicio
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  05/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_opcionagrupador = ab_activo

RETURN 0
end function

public function integer of_activate ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_Activate
//
//  DESCRIPCION		: Para identificar cual es el datawindow activo, 
//								posiciona su ventana sobre todas y muestra un fondo azul
// 
//  EVENTO/ARGUMENTOS: 
//
//
//  DEVUELVE			:
//	  0   :  Todo Bien
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
boolean lb_border
integer li_borderstyle, li_contador
window lw_parent

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

long ll_color, ll_coloractivate

ll_color = long(Describe("Datawindow.Color"))
ll_coloractivate = RGB(47,54,153)

of_getparentwindow(lw_parent)

lw_parent.BringToTop = TRUE

FOR li_contador = 1 TO 3
	Modify("Datawindow.Color='"+string(ll_colorActivate)+"'")
	Sleep(50)
	Modify("Datawindow.Color='"+string(ll_color)+"'")
	Sleep(50)
NEXT


RETURN 0
end function

public function integer of_agrupadorcolumnas (boolean ab_activo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AgrupadorColumnas
//
//  DESCRIPCION		: Relaciona y prepara el objeto DataWindow para interactuar con el control
// 
//  EVENTO/ARGUMENTOS: 
//      ab_activo  : Variable de control para activar o desactivar el servicio
//
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//		0 : Ning$$HEX1$$fa00$$ENDHEX$$n Cambio
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

RETURN of_agrupadorcolumnas(ab_activo, ii_ModoAgrupador)

end function

public function integer of_setdwbusqueda (boolean ab_activo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_setDWBusquedas
//
//  DESCRIPCION		: Inicializa el objeto para busquedas dw informacion en el dw
// 
//  EVENTO/ARGUMENTOS: 
//      ab_activo  : Variable de control para activar o desactivar el servicio
//
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//		0 : Ning$$HEX1$$fa00$$ENDHEX$$n Cambio
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
window lw_parent
integer li_rtn
exception ex1
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

RETURN of_setDWBusqueda(ab_activo, this.FILTRO)
end function

public function integer of_ajustadwbusqueda ();powerobject lpo_parent
userobject luserobject
tab ltab
long ll_x, ll_y

IF IsValid(idw_busqueda) THEN 
	
	lpo_parent = this.getParent()
	// Loop getting the parent of the object until it is of type window!
	do while IsValid (lpo_parent) 
		if lpo_parent.TypeOf() <> window! then
			CHOOSE CASE lpo_parent.TypeOf() 
				CASE userobject!
					luserobject = lpo_parent
					ll_y += luserobject.y
					ll_x += luserobject.x
				CASE tab!
					ltab = lpo_parent
					ll_y += ltab.y
					ll_x += ltab.x
			END CHOOSE
			lpo_parent = lpo_parent.GetParent()
		else
			exit
		end if
	loop

	//Acomoda el objeto
	idw_busqueda.width = this.Width
	idw_busqueda.x = this.x + ll_x
	idw_busqueda.y = this.y - idw_busqueda.height + 5 + ll_y
	RETURN 1
END IF

RETURN 0
end function

public function integer of_setindicacampoactual (boolean ab_activo, long al_color);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


ib_marcacampoactual = ab_activo
il_colorindicador = al_color

RETURN 1
end function

public function integer of_setindicacampoactual (boolean ab_activo);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

 //if(mod( getrow(),2) <> 0, rgb(255,255,255),15780518) /* 134217750) */
 
 of_setIndicaCampoActual(ab_activo, 15780518)

RETURN 1
end function

public function integer of_setbloqueascrollff (boolean ab_activo);

ib_bloqueascroll = ab_activo

RETURN 1
end function

public function integer of_setdwbusqueda (boolean ab_activo, integer ai_modobusqueda);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_setDWBusquedas
//
//  DESCRIPCION		: Inicializa el objeto para busquedas dw informacion en el dw
// 
//  EVENTO/ARGUMENTOS: 
//      ab_activo  : Variable de control para activar o desactivar el servicio
//
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//		0 : Ning$$HEX1$$fa00$$ENDHEX$$n Cambio
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/ABR/11	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
window lw_parent
integer li_rtn
exception ex1
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
TRY
		
	of_GetParentWindow(lw_parent)
		
	//Si activa al objeto
	IF ab_activo THEN
		IF isvalid(idw_busqueda) THEN 
			ex1 = CREATE exception
			ex1.Text = "Ya existe una instancia del objeto"
			THROW ex1
		END IF
				
		//Abre el Objeto
		li_rtn = lw_parent.OpenUserObject(idw_busqueda)
		
		IF li_rtn <> 1 THEN
			ex1 = CREATE exception
			ex1.Text = "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al abrir el Objeto para b$$HEX1$$fa00$$ENDHEX$$squedas"
			THROW ex1
		END IF
		
		idw_busqueda.of_setRequestor(this)
		idw_busqueda.of_setTipoBusqueda(ai_modobusqueda)
	ELSE
		//Eliminar el Objeto
		IF isvalid(idw_busqueda) THEN
			//Cierra y destrute el objeto
			li_rtn = lw_parent.CloseUserObject(idw_busqueda)
			DESTROY idw_busqueda
		END IF
		
		li_rtn = 1
	END IF
CATCH(runtimeerror a)
	//Restaura los valores anteriores
	SetRedraw(TRUE)
	
	messagebox("Aviso","Runtime: Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al inicializar el servicio de B$$HEX1$$fa00$$ENDHEX$$squedas~n"+a.text,stopsign!)
	li_rtn = -1
	
CATCH(exception e)
	//Restaura los valores anteriores
	SetRedraw(TRUE)
	
	IF len(trim(e.Text)) > 0 THEN messagebox("Aviso","Exception: Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al inicializar el servicio de B$$HEX1$$fa00$$ENDHEX$$squedas~n"+e.text,stopsign!)
	
	li_rtn = -1
	
END TRY

RETURN li_rtn



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
	 "Text(Alignment=2 Border=6 color=1073741824 background.mode=2 background.color=24987935)" ,ls_error)

//	"Text(Alignment=2 Border=6 " ,ls_error)
	
//	"Datawindow(Color = 67108864) " + &
//	 "Text(Alignment=2 Border=6 " ,ls_error)
//	 "Text(Alignment=2 Border=6 color=1073741824 background.mode=2 background.color=268435456)" ,ls_error)
//	 "Column(Border=0 font.face = 'Tahoma')",ls_error)
////	 "Column(Border=0 font.face='Tahoma' font.height='-108' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' ", ls_error)


if len(ls_error) > 0 then 
	IF isvalid(gnv_app.inv_debug) THEN gnv_app.inv_debug.of_message("rtn = 3 -> "+ls_error)		
	ll_rc = -3
END IF

//Crea contenedor local apartir de la sintaxis de DW
this.Create( ls_sintaxis, ls_error)

if len(ls_error) > 0 then 
	IF isvalid(gnv_app.inv_debug) THEN gnv_app.inv_debug.of_message("rtn = 4 -> "+ls_error)
	ll_rc = -4
END IF

//Asigna objeto de la transaccion
this.of_setTransObject(atr_conexion)

if this.Retrieve() <= 0 then 
//	messagebox(gs_nombreapp, "No se pudo obtener informaci$$HEX1$$f300$$ENDHEX$$n de los renglones", exclamation!)
	ll_rc = -5
END IF

//this.Modify("DataWindow.Header.Color= '78682240'")
////No permitir mover las columnas
//this.modify("DataWindow.Grid.ColumnMove=No")
//this.modify("DataWindow.Selected.Mouse=No")
//
////Total de columnas generadas 
//ll_total_columnas = long(this.describe("datawindow.column.count"))
//
////Ciclo para obtener la altura m$$HEX1$$e100$$ENDHEX$$xima de las columans e igualarlas
//ll_aux_max = 0
//for li_contador = 1 to ll_total_columnas
//	ls_nombre = this.describe("#" + string(li_contador) + ".Name")
//	ll_aux = long(this.describe(ls_nombre + "_t.height"))
//	if ll_aux_max < ll_aux then
//		ll_aux_max = ll_aux
//	end if
//next


////Ciclo para proteger columnas generadas y poner titulos
//for li_contador = 1 to ll_total_columnas
//	this.Modify ( "#" + string(li_contador) + ".protect='1'" )
//	ls_nombre = this.describe("#" + string(li_contador) + ".Name")
//	
//	//para longitud de los campos
//	ls_tipo = this.Describe( ls_nombre + ".ColType")
//	if match(ls_tipo,'char') Then
//			  ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(' + ls_nombre + ') for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )' 
//	else
//			  ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(string(' + ls_nombre + ')) for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
//	end if
//	this.Modify(ls_sintaxis)  
//	
//	li_longitud_campo = 0
//	if this.rowcount() >0 then
//		 li_longitud_campo = this.object.compute_1[1] 
//	end if
//	if len(ls_nombre) > li_longitud_campo Then
//		li_longitud_campo = len(ls_nombre)
//	End if
//	
//	ll_longitud = li_longitud_campo * 40
//	
//	ls_rtn = this.Modify(ls_nombre + ".width='" + string(ll_longitud) + "'")	
//	ls_rtn = this.Modify("destroy compute_1")
//	
//	//Iguala el alto de los t$$HEX1$$ed00$$ENDHEX$$tulos
////	idw_requestor.Modify(ls_nombre + "_t.height='" + string(ll_aux_max) + "'")
//	
//next


RETURN SUCCESS


end function

public function integer of_importaexcel (string as_filename, string as_sheet, string as_columnas, integer ai_startrow);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_importaExcel
//
//  DESCRIPCION		: Importa Excel a dw, celda por celda en base a las columnas especificadas
// 
//  EVENTO/ARGUMENTOS: 
//							as_filename : archivo excel
//							as_sheet : N$$HEX1$$fa00$$ENDHEX$$mero de hoja del excel
//							as_columnas : Cadena con las columnas a importar en el siguiente formato separado por ";" (Ej. nombreColumnadw:ordenColExcel)
//							ai_startrow : reglon inicial
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  20/MAR/14	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
int     li_rtn, li_i
string  ls_range
long    ll_excel_rows, ll_max_rows, ll_max_columns
long    ll_i, ll_j
string  lsa_column_names[], ls_mod
long    lla_column_pos[]
long    ll_row
int     li_rc
string  las_truncated_data[]
string ls_errorMessage
w_avance_carga lw_avance_carga

oleobject lole_excel, lole_workbook, lole_worksheet
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

IF NOT isValid(inv_base) THEN of_setBase(TRUE)


OPEN(lw_avance_carga)	
lw_avance_carga.of_SetTitle("Importaci$$HEX1$$f300$$ENDHEX$$n Excel")	
lw_avance_carga.of_SetText('Cargando...  ')		

TRY   
    lole_excel = create oleobject
    li_rtn = lole_excel.ConnectToNewObject("excel.application")
    if li_rtn <> 0 then
            ls_errorMessage = "Error running MS Excel api"
            li_rtn = -1
    else
        li_rtn = 1
        lole_excel.WorkBooks.Open(as_filename) 

        lole_workbook = lole_excel.application.workbooks(1)

        int li_sheetnum
        IF IsNumber(as_sheet) THEN
            li_sheetnum = Integer(as_sheet)
        ELSE
//LEC            li_sheetnum = uof_pub_excel_get_sheet_byname(as_sheet, lole_workbook)
        END IF
        lole_worksheet = lole_workbook.worksheets(li_sheetnum)

        ll_max_rows     = lole_worksheet.UsedRange.Rows.Count
        ll_max_columns  = lole_worksheet.UsedRange.Columns.Count
		  
		lw_avance_carga.of_SetStep(1)
		lw_avance_carga.of_SetMaxPosition(ll_max_rows)

        string lsa_tmp[]
//LEC        lsa_column_names = f_split(f_trim(as_imported_columns,";"), ";")
	    gnv_funciones_string.of_parseToArray(as_columnas,";",lsa_column_names) 
        FOR ll_i = 1 TO UpperBound(lsa_column_names)
            IF (pos(lsa_column_names[ll_i], ":")>0) THEN
//                lsa_tmp = f_split(lsa_column_names[ll_i], ":")
			    gnv_funciones_string.of_parseToArray(lsa_column_names[ll_i],":",lsa_tmp) 					 
                lla_column_pos[UpperBound(lla_column_pos)+1] = long(lsa_tmp[2])
                lsa_column_names[ll_i] = lsa_tmp[1]
            END IF
        NEXT

        string  ls_cellValue, ls_coltype, ls_value
        int         li_idx_col, li_statrRow
        boolean lb_copyData = false
        int         li_col_offset, li_vlen

        li_statrRow = ai_startrow

        IF (UpperBound(lla_column_pos)=0) THEN
            IF (UpperBound(lsa_column_names)<ll_max_columns) THEN ll_max_columns = UpperBound(lsa_column_names)
            FOR ll_j = li_statrRow TO ll_max_rows
                li_col_offset = 0
                ll_row = this.insertRow(0) // insert new row
                FOR ll_i = 1 TO (ll_max_columns)
                    ls_cellValue = String(lole_worksheet.cells(ll_j,ll_i).value)
                    IF (lsa_column_names[(ll_i)] = "") THEN 
                        li_col_offset++
                        continue
                    END IF
//                  li_rc = adw_dest.SetItem(ll_row, lsa_column_names[(ll_i)], lole_worksheet.cells(ll_j, (ll_i)).value)

                    ls_value = String(lole_worksheet.cells(ll_j, ll_i).value)
                    ls_coltype = this.describe(lsa_column_names[(ll_i)]+'.ColType')

                    // Checking length of string data
                    IF (pos(ls_coltype, "char")>0) THEN
                        li_vlen = integer(replace(left(ls_coltype, len(ls_coltype)-1), 1, 5, ""))
                        IF (li_vlen > 0 AND len(ls_value)>li_vlen) THEN
                            li_rtn = -2
                            ls_value = left(ls_value, li_vlen)
//                            IF (f_array_indexof(las_truncated_data, lsa_column_names[ll_i])<1) THEN
//                                las_truncated_data[UpperBound(las_truncated_data)+1] = lsa_column_names[ll_i]
//                            END IF
                        END IF
                    END IF

//                    li_rc = guo_common_utilities.uof_pub_set_dw_value(adw_dest, ll_row,  lsa_column_names[(ll_i)], ls_value,  ls_coltype)
				 this.inv_base.of_setItem(ll_row,lsa_column_names[(ll_i)],ls_value)

                NEXT
            NEXT

        ELSE			
            FOR ll_j = li_statrRow TO ll_max_rows
			  lw_avance_carga.of_SetTitle("Importaci$$HEX1$$f300$$ENDHEX$$n Excel "+string((ll_j / lw_avance_carga.of_GetMaxPosition()),'#0 %'))	
			  lw_avance_carga.of_StepIt()
			  lw_avance_carga.of_SetText('Procesando...  '+string(ll_j) + ' de ' + string(ll_max_rows))
			  
                ll_row = this.insertRow(0) // insert new row
                FOR ll_i = 1 TO UpperBound(lla_column_pos)
                    ls_cellValue = String(lole_worksheet.cells(ll_j,lla_column_pos[ll_i]).value)
                    this.SetItem(ll_row, lsa_column_names[ll_i], ls_cellValue)
                NEXT
            NEXT
        END IF
    end if

CATCH ( runtimeerror  lo_rte)
    li_rtn = -1
    ls_errorMessage = "MS Excel api runtime error"
FINALLY   
    // Quit
    IF (IsValid(lole_excel)) THEN 
        lole_excel.application.quit()
        lole_excel.DisconnectObject()
    END IF

    destroy lole_Excel
    destroy lole_workbook
    destroy lole_worksheet 
END TRY

IF isValid(lw_avance_carga) THEN close(lw_avance_carga)

RETURN li_rtn

end function

public function integer of_importaexcel (string as_filename);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_importaExcel
//
//  DESCRIPCION		: Importa Excel a dw, copia el contenido del excel al portapapeles
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  20/MAR/14	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
int     li_rtn, li_i
string  ls_range
long    ll_excel_rows, ll_max_rows, ll_max_columns
long    ll_i, ll_j
string  lsa_column_names[], ls_mod
long    lla_column_pos[]
long    ll_row
int     li_rc
string  las_truncated_data[]
string ls_errorMessage
CONSTANT LONG xlUp = -4162		  
CONSTANT LONG xlDown = -4121
CONSTANT LONG xlByRows = 1
CONSTANT LONG xlPrevious = 2

oleobject lole_excel, lole_workbook, lole_worksheet
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------


IF NOT isValid(inv_base) THEN of_setBase(TRUE)

TRY   
    lole_excel = create oleobject
    li_rtn = lole_excel.ConnectToNewObject("excel.application")
    if li_rtn <> 0 then
            ls_errorMessage = "Error running MS Excel api"
            li_rtn = -1
    else
        li_rtn = 1
	    lole_excel.Application.DisplayAlerts = False
        lole_excel.WorkBooks.Open(as_filename) 
        lole_workbook = lole_excel.application.workbooks(1)

        int li_sheetnum
//        IF IsNumber(as_sheet) THEN
//            li_sheetnum = Integer(as_sheet)
//        END IF
        lole_worksheet = lole_workbook.worksheets(1)		  

        ll_max_rows     = lole_worksheet.UsedRange.Rows.Count
        ll_max_columns  = lole_worksheet.UsedRange.Columns.Count
		  
		ll_max_rows = lole_worksheet.Cells(ll_max_rows, "A").End(xlUp).Row
		ll_max_rows = lole_worksheet.Range("A:A").End(xlDown).Row
		ll_max_rows = lole_worksheet.Cells.End(xlUp).Row
		ll_max_rows = lole_worksheet.Cells(1048576, 1).End(xlUp).Row
/*
http://www.mrexcel.com/forum/excel-questions/310453-cells-rows-end-xlup-count-insted-usedrange-rows-count.html
MsgBox ("COL A TOP: " & Range("A:A").End(xlUp).row)
MsgBox ("COL A BOTTOM: " & Range("A:A").End(xlDown).row)
MsgBox ("ENIRE SHEET BOTTOM: " & Cells(65536, 1).End(xlUp).row)
MsgBox ("sheet limit: " & Cells.End(xlUp).row)
MsgBox ("short method Bottom Row: " & Cells.End(xlDown).row)

MsgBox ("Right Column: " & Cells.End(xlToRight).Column)
MsgBox ("Left Column: " & Range("1:1").End(xlToLeft).Column)

MsgBox ("Right Column: " & Range("1:1").End(xlToRight).Column)
MsgBox ("track Column: " & ActiveCell.Offset(1, 1).End(xlToRight).Column)
*/
	     lole_worksheet.Range(lole_worksheet.Cells(1,1),lole_worksheet.Cells(ll_max_rows,ll_max_columns)).Select()
		  
//		lole_excel.ActiveCell.CurrentRegion.Select()
		lole_excel.Selection.Copy()
		this.reset()
		li_rtn = this.ImportClipboard()
		lole_worksheet.Cells(1,1).copy()
		//lole_workbook.Application.CutCopyMode = False

	end if
CATCH ( runtimeerror  lo_rte)
    li_rtn = -1
    ls_errorMessage = "MS Excel api runtime error"
FINALLY   
    // Quit
    IF (IsValid(lole_excel)) THEN 	    
        lole_excel.application.quit()
	   lole_excel.Application.DisplayAlerts = True
        lole_excel.DisconnectObject()  
    END IF

    destroy lole_Excel
    destroy lole_workbook
    destroy lole_worksheet 
END TRY

RETURN li_rtn


//RETURN of_importaExcel(as_filename,"1",as_columnas,1)
end function

event rbuttonup;//------------------------------------------------------------------
// OJO!, EN ESTE EVENTO SE ESTA BRINCANDO EL CODIGO DEL ANCESTRO
//------------------------------------------------------------------

//////////////////////////////////////////////////////////////////////////////
//	Event:  			rbuttonup
//	Description:	Popup menu
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//						5.0.04 Modified script to avoid 64K segment problem with 16bit machine code executables
// 					6.0	Added DataWindow Property to the popup menu.
// 					6.0 	Added check for the new RowManager.of_GetRestoreRow() switch.
// 					6.0.01 Added call to pfc_prermbmenuproperty to isolate calls to shared variable.
// 					6.0.01 Corrected so that dwo.protect works properly for protect expressions.
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
boolean		lb_frame
boolean		lb_desired
boolean		lb_readonly
boolean		lb_editstyleattrib
integer		li_tabsequence
long			ll_getrow
string		ls_editstyle
string		ls_val
string		ls_protect
string		ls_colname
string		ls_currcolname
string		ls_type
string		ls_expression
n_cst_conversion	lnv_conversion
m_dw					lm_dw
window				lw_parent
window				lw_frame
window				lw_sheet
window				lw_childparent

//--------------------------------------------
// DECLARACIONES LOCALES
//--------------------------------------------
long ll_contador
boolean lb_encontro
string ls_nombre


// Determine if RMB popup menu should occur
if not ib_RMBmenu or IsNull (dwo) then	return 1

// No RMB support for OLE objects and graphs
ls_type = dwo.Type
if ls_type = "ole" or ls_type = "tableblob" or ls_type = "graph" then return 1

// No RMB support for print preview mode
if this.Object.DataWindow.Print.Preview = "yes" then return 1

// Determine parent window for PointerX, PointerY offset
this.of_GetParentWindow (lw_parent)
//OAQ: adecuacion para que funcione con user objects
If Not IsValid(lw_parent) or IsNull(lw_parent) Then lw_parent = gw_frame
if IsValid (lw_parent) then
	// Get the MDI frame window if available
	lw_frame = lw_parent
	do while IsValid (lw_frame)
		IF lw_frame.Typeof() <> window! THEN
			lb_frame = false
			Exit		
		END IF
	
		if lw_frame.windowtype = MDI! or lw_frame.windowtype = MDIHelp! then
			lb_frame = true
			exit
		else
			lw_frame = lw_frame.ParentWindow()
		end if
	loop
	
	if lb_frame then
		// If MDI frame window is available, use it as the reference point for the
		// popup menu for sheets (windows opened with OpenSheet function) or child windows
		if lw_parent.windowtype = Child! then
			lw_parent = lw_frame
		else
			lw_sheet = lw_frame.GetFirstSheet()
			if IsValid (lw_sheet) then
				do
					// Use frame reference for popup menu if the parentwindow is a sheet
					if lw_sheet = lw_parent then
						lw_parent = lw_frame
						exit
					end if
					lw_sheet = lw_frame.GetNextSheet (lw_sheet)
				loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
			end if
		end if
	else
		// SDI application.  All windows except for child windows will use the parent
		// window of the control as the reference point for the popmenu
		if lw_parent.windowtype = Child! then
			lw_childparent = lw_parent.ParentWindow()
			if IsValid (lw_childparent) then
				lw_parent = lw_childparent
			end if
		else
			lw_parent = gw_frame
		end if
	end if
else
	return 1
end if


// Create popup menu
lm_dw = create m_dw
lm_dw.of_SetParent (this)

//////////////////////////////////////////////////////////////////////////////
// Main popup menu operations
//////////////////////////////////////////////////////////////////////////////
ll_getrow = this.GetRow()

ls_val = this.Object.DataWindow.ReadOnly
lb_readonly = lnv_conversion.of_Boolean (ls_val)

choose case ls_type
	case "datawindow", "column", "compute", "text", "report", &
		"bitmap", "line", "ellipse", "rectangle", "roundrectangle", "groupbox"

		// Row operations based on readonly status
		lm_dw.m_table.m_insert.Enabled = not lb_readonly
		lm_dw.m_table.m_addrow.Enabled = not lb_readonly
		lm_dw.m_table.m_delete.Enabled = not lb_readonly

		// Menu item enablement for current row
		if not lb_readonly then
			lb_desired = False
			if ll_getrow > 0 then lb_desired = true
			lm_dw.m_table.m_delete.Enabled = lb_desired
			lm_dw.m_table.m_insert.Enabled = lb_desired			
		end if
		
	case else
		lm_dw.m_table.m_insert.Enabled = false
		lm_dw.m_table.m_delete.Enabled = false
		lm_dw.m_table.m_addrow.Enabled = false
end choose

// Get column properties
ls_currcolname = this.GetColumnName()
if ls_type = "column" then
	ls_editstyle = dwo.Edit.Style
	ls_colname = dwo.Name
	ls_protect = dwo.Protect
	if not IsNumber(ls_protect) then
		// Since it is not a number, it must be an expression.
		ls_expression = Right(ls_protect, Len(ls_protect) - Pos(ls_protect, "~t"))
		ls_expression = "Evaluate(~""+ls_expression+","+String(row)+")"
		ls_protect = this.Describe(ls_expression)
	end if
	ls_val = dwo.TabSequence
	if IsNumber (ls_val) then
		li_tabsequence = Integer (ls_val)
	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Transfer operations.  Only enable for editable column edit styles
//////////////////////////////////////////////////////////////////////////////
lm_dw.m_table.m_copy.Enabled = false
lm_dw.m_table.m_cut.Enabled = false
lm_dw.m_table.m_paste.Enabled = false
lm_dw.m_table.m_selectall.Enabled = false

// Get the column/editystyle specific editable flag.
if ls_type = "column" and not lb_readonly then
	choose case ls_editstyle
		case "edit"
			ls_val = dwo.Edit.DisplayOnly
		case "editmask"
			ls_val = dwo.EditMask.Readonly
		case "ddlb"
			ls_val = dwo.DDLB.AllowEdit
		case "dddw"
			ls_val = dwo.DDDW.AllowEdit
		case else
			ls_val = ""
	end choose
	lb_editstyleattrib = lnv_conversion.of_Boolean (ls_val)
	if IsNull(lb_editstyleattrib) then lb_editstyleattrib = false
end if

if ls_type = "column" and not lb_readonly then
	if dwo.BitmapName = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
		
		if Len (this.SelectedText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
			// Copy
			lm_dw.m_table.m_copy.Enabled = true

			// Cut
			if li_tabsequence > 0 and ls_protect = "0" then
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				lm_dw.m_table.m_cut.Enabled = lb_desired
			end if
		end if
			
		if li_tabsequence > 0 and ls_protect = "0" then
			// Paste
			if Len (ClipBoard()) > 0 then
				lb_desired = false
				choose case ls_editstyle
					case "edit", "editmask"
						lb_desired = not lb_editstyleattrib
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib
				end choose
				lm_dw.m_table.m_paste.Enabled = lb_desired
			end if

			// Select All
			if Len (this.GetText()) > 0 and ll_getrow = row and ls_currcolname = ls_colname then
				choose case ls_editstyle
					case "ddlb", "dddw"
						lb_desired = lb_editstyleattrib						
					case else
						lb_desired = true
				end choose
				lm_dw.m_table.m_selectall.Enabled = lb_desired				
			end if
		end if

	end if
end if

//////////////////////////////////////////////////////////////////////////////
// Services
//////////////////////////////////////////////////////////////////////////////
// Row Manager
if IsValid (inv_RowManager) then
	// Undelete capability
	if inv_RowManager.of_IsRestoreRow() then
		if this.DeletedCount() > 0 and not lb_readonly then
			lm_dw.m_table.m_restorerow.Visible = true
			lm_dw.m_table.m_restorerow.Enabled = true
		else
			lm_dw.m_table.m_restorerow.Visible = false
			lm_dw.m_table.m_restorerow.Enabled = false
		end if
	end if
else
	lm_dw.m_table.m_restorerow.Visible = false
	lm_dw.m_table.m_restorerow.Enabled = false
end if

// QueryMode
// Default to false
lm_dw.m_table.m_operators.Visible = false
lm_dw.m_table.m_operators.Enabled = false
lm_dw.m_table.m_values.Visible = false
lm_dw.m_table.m_values.Enabled = false
lm_dw.m_table.m_dash12.Visible = false

//if IsValid (inv_QueryMode) then
//	if inv_QueryMode.of_GetEnabled() then
//		// Do not allow undelete while in querymode
//		lm_dw.m_table.m_restorerow.Visible = false
//		lm_dw.m_table.m_restorerow.Enabled = false		
//
//		// Default visible to true if in querymode
//		lm_dw.m_table.m_values.Visible = true
//		lm_dw.m_table.m_operators.Visible = true
//		lm_dw.m_table.m_dash12.Visible = true
//
//		if ls_type = "column" and not lb_readonly then
//			if dwo.bitmapname = "no" and ls_editstyle <> "checkbox" and ls_editstyle <> "radiobuttons" then
//				if li_tabsequence > 0 and ls_protect = "0" then				
//					lb_desired = false
//					choose case ls_editstyle
//						case "edit", "editmask"
//							lb_desired = not lb_editstyleattrib
//						case "ddlb", "dddw"
//							lb_desired = lb_editstyleattrib
//					end choose
//					// Enablement based on column				
//					lm_dw.m_table.m_values.Enabled = lb_desired
//					lm_dw.m_table.m_operators.Enabled = lb_desired
//				end if
//			end if
//		end if
//	end if
//end if


//Si esta habilitado el servicio de Buscar, pone visible la opcion en el menu
If IsValid(inv_Find) Then
	lm_dw.m_table.m_buscar.Visible = TRUE
	lm_dw.m_table.m_dash14.Visible = TRUE
Else
	lm_dw.m_table.m_buscar.Enabled = FALSE
	//lm_dw.m_table.m_dash14.Enabled = FALSE
End If

//Si el campo esta registrado para F1 habilita la opci$$HEX1$$f300$$ENDHEX$$n
ll_contador = 1
lb_encontro = false
for ll_contador = 1 to upperbound ( isarr_f1 )
	if dwo.name = isarr_f1 [ll_contador] then 
		lb_encontro = true 
		continue
	end if
next
lm_dw.m_table.m_f1.enabled = lb_encontro

////Si esta habilitado el servicio de filtrar, pone visible la opcion en el menu
//If IsValid(inv_Filter) Then
//	lm_dw.m_table.m_filtrar.Visible = TRUE
//	lm_dw.m_table.m_filtrar.Enabled = TRUE
//	lm_dw.m_table.m_dash14.Visible = TRUE
//End If

// DataWindow property entries. (isolate calls to shared variable)
this.event pfc_prermbmenuproperty (lm_dw)

// Allow for any other changes to the popup menu before it opens
this.event pfc_prermbmenu (lm_dw)

// Send rbuttonup notification to row selection service
if IsValid (inv_RowSelect) then inv_RowSelect.event pfc_rbuttonup (xpos, ypos, row, dwo)

// Popup menu
lm_dw.m_table.PopMenu (lw_parent.PointerX() + 5, lw_parent.PointerY() + 10)

destroy lm_dw

return 1
end event

on u_dw.create
call super::create
end on

on u_dw.destroy
call super::destroy
end on

event type integer pfc_preinsertrow();call super::pfc_preinsertrow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
int li_return
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)
if ancestorreturnvalue <> 1 then return ancestorreturnvalue

//Checa los privilegios de la cuenta
If Not ib_agregar  Then
	Messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Su cuenta no tiene privilegios para agregar registros en esta vista', Exclamation!)
	Return PREVENT_ACTION
End If

////Checa los privilegios de la cuenta
//If gi_agregar = 0  Then
//	Messagebox('Atenci$$HEX1$$f300$$ENDHEX$$n','Su cuenta no tiene privilegios para agregar registros en esta vista', Exclamation!)
//	Return PREVENT_ACTION
//End If

//Checa si hay cambios pendientes.
IF ib_multiplesnuevos THEN
	li_Return = CONTINUE_ACTION
ELSE
	If ib_nuevo Then 
		li_Return = PREVENT_ACTION
	Else
		li_Return = CONTINUE_ACTION
	End If
END IF

RETURN li_Return
end event

event itemchanged;call super::itemchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_campo, ls_mensaje, ls_mensaje_vacio, ls_aux, ls_columnas[], &
			ls_datacolumn, ls_displaycolumn, ls_tipocol, ls_editable
integer	li_count, li_i, li_pos
boolean	lb_numerico
datawindowchild	ldwch_objeto
any		lany_regreso

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

ls_campo = dwo.name

//Valida si es un dddw y checa si el valor capturado existe
ls_datacolumn = describe(ls_campo + ".DDDW.datacolumn")
ls_displaycolumn = describe(ls_campo + ".DDDW.displaycolumn")
ls_editable = lower(Describe(ls_campo + ".DDDW.AllowEdit"))
	
if ls_datacolumn <> "?" and ls_datacolumn <> "!" and ls_displaycolumn <> "?" and ls_displaycolumn <> "!"then
	if getchild (ls_campo, ldwch_objeto ) = 1 then
		ls_tipocol = ldwch_objeto.describe(ls_datacolumn + ".coltype")
		//Quita los par$$HEX1$$e900$$ENDHEX$$ntesis
		li_pos = Pos(ls_tipocol, "(", 1)
		If li_pos > 0 Then ls_tipocol = Mid ( ls_tipocol, 1, li_pos - 1)
		
		Choose Case Upper(ls_tipocol)
			Case	"INTEGER", "NUMBER", "LONG", "DECIMAL", "REAL", "ULONG"
				lb_numerico = true
			case else
				lb_numerico = false
		End Choose

	  if not isnumber(data) then
		if lb_numerico then
		 ls_aux = ls_displaycolumn + "='" + data + "'"
		else
		 ls_aux = ls_datacolumn + "='" + data + "'"
		end if
	  else
		IF lb_numerico then
		 ls_aux = ls_datacolumn + "=" + data
		ELSE
		 ls_aux = ls_datacolumn + "='" + data + "'"
		END IF
	  end if

	  if ldwch_objeto.find(ls_aux, 1, ldwch_objeto.rowcount()) <= 0 AND ls_editable <> "yes" then
		messagebox("Aviso", "El dato '" + data + "' no existe en la lista", exclamation!) 
		return 1
	  end if
	end if
end if

////Verificar que exista el servicio de calendario
//if IsValid(iuo_calendar) then
//	// Obtener las columnas que estan registradas para el servicio
//	li_count = iuo_calendar.of_GetRegistered(ls_columnas)
//	// Procesar cada columna
//	for li_i=1 to li_count
//		// Verificar que la columna que sufri$$HEX2$$f3002000$$ENDHEX$$el cambio es una columna  registrada por el servicio.
//		// Ademas de verifcar que los datos capturados sean val$$HEX1$$ed00$$ENDHEX$$dos para las fechas
//		if dwo.name = ls_columnas[li_i] and not Match(data, "^[0-9/-]") then
//			MessageBox ("Atenci$$HEX1$$f300$$ENDHEX$$n", "Ha introducido car$$HEX1$$e100$$ENDHEX$$cteres inv$$HEX1$$e100$$ENDHEX$$lidos en un campo fecha. ~r~nFavor de corregirlo", exclamation!)
//			return 1
//		end if
//	next 
//end if

//Servicio que valida las cadenas vac$$HEX1$$ed00$$ENDHEX$$as
ls_mensaje_vacio = of_validacadenavacia(dwo.name,data)
If len(ls_mensaje_vacio) > 0 Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n", ls_mensaje_vacio, Exclamation!)
	Return 1
End If

//Servicio que valida los datos repetidos
ls_mensaje = of_validarepetidos(dwo.name,data)
If len(ls_mensaje) > 0 Then
	Messagebox("Atenci$$HEX1$$f300$$ENDHEX$$n", ls_mensaje, Exclamation!)
	lany_regreso = of_getitemany(row,ls_campo, primary!, true)
	setitem(row, ls_campo, lany_regreso)
	Return 1
End If

////Checa si el campo va a lanzar una ventana de cat$$HEX1$$e100$$ENDHEX$$logo
//ls_aux = lower(gf_lee_campo_dwchild(this, ls_campo, "2" ))
//If ls_aux = "<agregar...>" Then
//	of_muestra_catalogo(this)
//	return 2
//End If


end event

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Long	ll_regreso
int	li_columnas,li_contador
string	ls_columnas[],ls_col

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

inv_dwutil.of_setRequestor(this)

////define fondo
//if gnv_app.il_buttonface <> -1 then modify("DataWindow.Color='" + string(gnv_app.il_buttonface) + "'")

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Habilita el servicio de mensaje postupdate
of_setmensajepostupdate(true)

//Ejecuta el evento postconstructor
PostEvent ("postconstructor")

//Servicio para poder ordenar mediante campos dddw
of_SetSort(TRUE)
inv_sort.of_SetUseDisplay(TRUE)

////Habilita el servicio de dddw calendar
//if not isnull(dataobject) and trim(dataobject) <> "" and dataobject <> "d_calendar" then
//	ll_regreso = of_SetDropDownCalendar(true)
//	if ll_regreso = 1 then	
//		//Registra todos los campos fecha al servicio de calendario
//		iuo_calendar.of_Register(iuo_calendar.DDLB)
//		iuo_calendar.of_SetInitialValue(TRUE)
//		iuo_calendar.of_SetDateFormat("dd/mm/yyyy")
//	end if
//end if

//Obtiene los nombres de las columnas del dw
li_columnas = of_objetos_dw(this, ls_columnas, "column", "*")

//No permitir mover las columnas
modify("DataWindow.Grid.ColumnMove=No")

////Ciclo para cambiar a upper las columnas
//For li_contador = 1 To li_columnas
//	ls_col = describe(ls_columnas[li_contador] + ".Edit.Case")
//	if ls_col = 'Any' then
//		modify(ls_columnas[li_contador] + ".Edit.Case = 'Upper'")
//	end if
//next


end event

event pfc_postinsertrow(long al_row);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_campo
integer	li_columnas, li_maxcol

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Checa que se haya insertado sin problemas el registro
If al_row <= 0 Then Return

//Enciende la bandera de que se est$$HEX2$$e1002000$$ENDHEX$$agregando un registro nuevo
ib_nuevo = true

//Mueve el scroll al registro nuevo
scrolltorow(al_row)

//Pone el focus en el primer campo editable
li_maxcol = integer(object.datawindow.column.Count)

for li_columnas = 1 to li_maxcol
	ls_campo = describe("#" + string(li_columnas) +".Name")
	if ls_campo = "!" then continue
	if describe(ls_campo +".tabsequence") = "10" then
		setcolumn(ls_campo)
		scrolltorow(al_row)
		exit
	end if
next
end event

event updateend;call super::updateend;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Apaga la bandera de que se est$$HEX2$$e1002000$$ENDHEX$$agregando un registro nuevo
ib_nuevo = false
end event

event retrieveend;call super::retrieveend;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//...para que ejecute el rowfocus cuando solo hay un registro
If rowcount > 0 then this.post event rowfocuschanged(1)

//Apaga la bandera de registro nuevo
ib_nuevo = false

IF ib_agrupadorcolumnas THEN
	iuo_agrupador.of_AsignaDWDetalle(This)
END IF
end event

event sqlpreview;call super::sqlpreview;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string		ls_mensaje, ls_listacampos, ls_listavalores, ls_campo, ls_valor, &
				ls_tabla, ls_camposliga[], las_listacampos[], las_listavalores[]
integer		li_numligas, li_contador, li_contador2
boolean		lb_hallado = false
pointer		oldpointer
n_cst_linkageattrib 	lnv_linkargs

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

setpointer(hourglass!)
oldpointer = SetPointer(HourGlass!)

choose case sqltype
	case	PreviewInsert!

		//Checa si el servicio de linkage es v$$HEX1$$e100$$ENDHEX$$lido...
		if isvalid(inv_linkage) then
			//... y si no es el primero de la cadena
			if not inv_linkage.of_IsRoot () then
				//coordina los valores de la llave del maestro-detalle
				ls_mensaje =	"No se pudo grabar el rengl$$HEX1$$f300$$ENDHEX$$n " + string(row) + " debido a que no se pudo coordinar ~r" + &
									"los valores de los campo llave en '" + dataobject + "'"
				if this.inv_linkage.of_SetKeyValues( row ) = -1 then
					messagebox("Aviso", ls_mensaje, StopSign!)
					return 2
				end if
				//Obtiene la lista de campos y valores
				ls_listacampos = gnv_funciones_string.of_desglosa_string(sqlsyntax, 1, ') VALUES (')
				ls_listacampos = Mid ( ls_listacampos, Pos(ls_listacampos, "(" ) + 1 , len(ls_listacampos) )	
				ls_listavalores = gnv_funciones_string.of_desglosa_string(sqlsyntax, 2, ') VALUES (')
				ls_listavalores = Mid ( ls_listavalores, 1, LastPos(ls_listavalores, ")" ) - 1 )
				
				//Reemplaza las " si vienen
				ls_listacampos = gnv_funciones_string.of_globalreplace(ls_listacampos, '"', '')
				
				//Pasa a arreglo los campos y valores
				gnv_funciones_string.of_parsetoarray(ls_listacampos, ',', las_listacampos)
				gnv_funciones_string.of_parsetoarray(ls_listavalores, ',', las_listavalores)
				
				//Obtiene el arreglo con los campo liga
				inv_linkage.of_GetArguments ( lnv_linkargs )
				li_numligas = UpperBound ( lnv_linkargs.is_mastercolarg ) 
				ls_camposliga = lnv_linkargs.is_mastercolarg
				
				//Barre los campos liga
				For li_contador = 1 To li_numligas
					lb_hallado = false
					ls_campo = lnv_linkargs.is_detailcolarg[li_contador]
					//Lee y formatea el valor
					Choose Case Lower ( Left ( Describe ( ls_campo + ".ColType" ) , 5 ) )
						Case "char(", "date"	, "datet", "time", "times"
							ls_valor =  "'" + string( inv_Linkage.of_GetItemAny (row, ls_campo )) + "'"
						Case Else
							ls_valor = string( inv_Linkage.of_GetItemAny (row, ls_campo ))
					End Choose
							
					//Busca el campo para asignarle el nuevo valor en los arreglos
					For li_contador2 = 1 to upperbound(las_listacampos)
						If trim(ls_campo) = trim(las_listacampos[li_contador2]) Then
							lb_hallado = true
							las_listavalores[li_contador2] = ls_valor
							exit
						End If
					Next
					//Valida si se encontr$$HEX1$$f300$$ENDHEX$$, si no agrega los campos y valores
					If not lb_hallado Then
						las_listacampos[upperbound(las_listacampos) + 1] = ls_campo
						las_listavalores[upperbound(las_listavalores) + 1] = ls_valor
					End If
				Next
				
				//Genera el nuevo sqlpreview
				gnv_funciones_string.of_ArrayToString ( las_listacampos, ',', true, ls_listacampos )
				gnv_funciones_string.of_ArrayToString ( las_listavalores, ',', true, ls_listavalores )
				ls_tabla = gnv_funciones_string.of_desglosa_string(sqlsyntax, 1, '(')
				ls_mensaje = gnv_funciones_string.of_desglosa_string(sqlsyntax, 1, '(') + " ( " + ls_listacampos + &
								") VALUES ( "  + ls_listavalores + ")"
				SetSQLPreview ( ls_mensaje )
			end if

		end if
end choose

//Regresa el puntero original
SetPointer(oldpointer)

Return 0
end event

event type integer pfc_preupdate();call super::pfc_preupdate;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long			ll_contador, ll_renglones
integer		li_resultado
string		ls_campos
n_ds			lds_objeto
pointer		oldpointer


//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//setpointer(hourglass!)
//oldpointer = SetPointer(HourGlass!)
//
////Procesa el borrado l$$HEX1$$f300$$ENDHEX$$gico
//if deletedcount() > 0 And pos(Describe("datawindow.objects"), "ind_vigente") > 0 then
//	//Crea el datastore para almacenar los cambios
//	lds_objeto = CREATE n_ds
//	lds_objeto.dataobject = dataobject
//	lds_objeto.of_SetTransObject ( SQLCA )
//	ll_renglones = deletedcount()
//	//Mueve el buffer al datastore, por tanto se elimina el buffer delete!
//	li_resultado = rowsmove ( 1, ll_renglones, delete!, lds_objeto, 1, primary! )
//	if li_resultado = -1 then
//		destroy lds_objeto
//		messagebox("Aviso", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de hacer el borrado l$$HEX1$$f300$$ENDHEX$$gico en '" + dataobject + "'", stopsign!)
//		return FAILURE
//	end if
//	
//	//Pone el estatus de Modified! a c/u de los renglones
//	for ll_contador = 1 to lds_objeto.rowcount()
//		//...lo pone primero a NotModified!
//		if lds_objeto.SetItemStatus ( ll_contador, 0, primary!, NotModified! ) = -1 then
//			destroy lds_objeto
//			messagebox("Aviso", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de hacer el borrado l$$HEX1$$f300$$ENDHEX$$gico en '" + dataobject + "'", stopsign!)
//			return FAILURE
//		end if
//		//...luego a Modified!		
//		if lds_objeto.SetItemStatus ( ll_contador, 0, primary!, DataModified! ) = -1 then 
//			destroy lds_objeto
//			messagebox("Aviso", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de hacer el borrado l$$HEX1$$f300$$ENDHEX$$gico en '" + dataobject + "'", stopsign!)
//			return FAILURE
//		end if
//		//...apaga la vigencia
//		lds_objeto.SetItem ( ll_contador, "ind_vigente", 0 )
//		lds_objeto.SetItem ( ll_contador, "fecha_movimiento", gf_fechaservidor())
//		lds_objeto.SetItem ( ll_contador, "usuario_modifica", upper(gs_id_usuario))
//	next
//	
//	//Graba los registros del datastore
//	if lds_objeto.of_update(true, true) = -1 then
//		destroy lds_objeto
//		messagebox("Aviso", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de hacer el borrado l$$HEX1$$f300$$ENDHEX$$gico en '" + dataobject + "'", stopsign!)
//		return FAILURE
//	end if
//	//destruye la instancia del ds
//	destroy lds_objeto
//end if
//
////Regresa el puntero original
//SetPointer(oldpointer)

Return SUCCESS

end event

event pfc_prermbmenu;call super::pfc_prermbmenu;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long	ll_renglon
dwItemStatus ldws_status

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_renglon = getselectedrow(0)
if ll_renglon = 0 then ll_renglon = getrow()
if isnull(ll_renglon) or ll_renglon <= 0 then return

////Verifica si no es un registro con estatus de new! o newmodified!

//ldws_status = getitemstatus(ll_renglon, 0, Primary!)
//
//if ldws_status = New! or ldws_status = NewModified! then
//	m_dw.m_table.m_delete.enabled = true
//else
//	m_dw.m_table.m_delete.enabled = false
//end if

m_dw.m_table.m_addrow.enabled = ib_agregar
m_dw.m_table.m_insert.enabled = ib_agregar

ldws_status = getitemstatus(ll_renglon, 0, Primary!)
if ldws_status = New! or ldws_status = NewModified! then
	m_dw.m_table.m_delete.enabled = true
else
	m_dw.m_table.m_delete.enabled = ib_borrar
end if



m_dw.m_table.m_seppanel.visible = ib_opcionagrupador
m_dw.m_table.m_panelagrupador.visible = ib_opcionagrupador
m_dw.m_table.m_panelagrupador.m_activar.enabled = NOT ib_agrupadorcolumnas
m_dw.m_table.m_panelagrupador.m_desactivar.enabled = ib_agrupadorcolumnas

end event

event itemfocuschanged;call super::itemfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
boolean lb_esdddw, lb_esdddw_ant
string ls_regreso
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Selecciona todo el valor del campo
selecttext (1, 8000)

////Ejecuta este evento para el servicio de dddw search
//if not isnull(inv_dropdownsearch) and isvalid(inv_dropdownsearch) then
//	inv_dropdownsearch.Event pfc_ItemFocusChanged(row, dwo)
//end if

IF ib_MarcaCampoActual THEN 
	//Determina si la columna activa es un dddw
	ls_regreso = Describe( string(dwo.name) + ".DDDW.Name")
	//...no es un campo con dddw
	if ls_regreso <> '!' AND ls_regreso <> '?' then lb_esdddw = TRUE
	
	ls_regreso = Describe( is_columnaanterior + ".DDDW.Name")
	//...no es un campo con dddw
	if ls_regreso <> '!' AND ls_regreso <> '?' then lb_esdddw_ant =  TRUE
		
	IF NOT lb_esdddw_ant AND (NOT isnull(is_coloranterior) AND is_coloranterior <> "") THEN
		ls_regreso = Modify(is_columnaanterior+".Background.Color='"+is_coloranterior+"'")
	END IF
	
	IF isvalid(gnv_app.inv_debug) THEN
		gnv_app.inv_debug.of_message("Columna anterior: "+is_columnaanterior)
		gnv_app.inv_debug.of_message("Color anterior: "+is_coloranterior)
		gnv_app.inv_debug.of_message("Columna actual: "+string(dwo.name) )
		IF lb_esdddw THEN
			gnv_app.inv_debug.of_message("lb_esdddw: TRUE")	
		ELSE
			gnv_app.inv_debug.of_message("lb_esdddw: FALSE" )	
		END IF
		IF lb_esdddw_ant THEN
			gnv_app.inv_debug.of_message("lb_esdddw_ant: TRUE")	
		ELSE
			gnv_app.inv_debug.of_message("lb_esdddw_ant: FALSE" )	
		END IF
	END IF
	
	is_coloranterior = Describe(string(dwo.name)+".Background.Color")
//	is_coloranterior = mid(is_coloranterior,2,len(is_coloranterior)-2) //gnv_funciones_string.of_globalreplace( is_coloranterior, '"','')
	is_coloranterior = gnv_funciones_string.of_globalreplace( is_coloranterior, "'",'~"')
	//is_coloranterior = gnv_funciones_string.of_globalreplace( is_coloranterior, "	",'~t')
//	16777215~tif(ind_bloqueo = 1 Or contratado > 0 Or status = 'C', 77379767, RGB(255,255,255))
	is_columnaanterior = string(dwo.name)
	
	IF NOT lb_esdddw THEN ls_regreso = Modify(string(dwo.name)+".Background.Color='"+string(il_colorindicador)+"'")		

	
	
END IF
end event

event lbuttonup;call super::lbuttonup;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Respalda la columna movida
is_columna_movida =	Left( Trim( Left( GetObjectAtPointer(), Pos( GetObjectAtPointer(), '~t' ) ) ), &
							Len(Trim( Left( GetObjectAtPointer(), Pos( GetObjectAtPointer(), '~t' ) ) )) - 3 )


//Ejecuta el post evento
post event ue_postlbuttonup()
end event

event type integer pfc_zoom();//------------------------------------------------------------------
// OJO!, EN ESTE EVENTO SE ESTA BRINCANDO EL CODIGO DEL ANCESTRO
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
debugbreak()
//Revisa si est$$HEX2$$e1002000$$ENDHEX$$habilitado el servicio de zoom
if IsValid (inv_zoom) then
//	if IsValid (inv_PrintPreview) then
//		if inv_PrintPreview.of_GetEnabled() then
//			return inv_PrintPreview.of_SetZoom()
//		else
//			return inv_zoom.of_SetZoom()
//		end if
//	else
//		return inv_zoom.of_SetZoom()
//	end if
	return inv_zoom.of_SetZoom()
else
	return FAILURE
end if


end event

event rowfocuschanging;call super::rowfocuschanging;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombre_dw
dwItemStatus ldwis_estatus

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if isnull(currentrow) or currentrow = 0 then return 0
if ancestorreturnvalue = 1 then return 1

//ls_nombre_dw = classname()
//ldwis_estatus = GetItemStatus(currentrow, 0, Primary!)
//
//choose case pos(ls_nombre_dw, 'dw_cat_listado')
//	case	is > 0
//	case else
//		//previene el cambio de registro si es nuevo y tipo ficha
//		if (ldwis_estatus = new! or ldwis_estatus = newmodified!) and describe("DataWindow.Processing") = "0" then
//			setredraw(false)
//			//ejecuta el post para scrollear a este registro, ya que como quiera al prevenir el
//			//cambio de rengl$$HEX1$$f300$$ENDHEX$$n la dw scrollea a ese rengl$$HEX1$$f300$$ENDHEX$$n
//			post scrolltorow(currentrow)
//			post setredraw(true)
//			return 1
//		end if
//
//end choose

return 0
end event

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
dwItemStatus ldwis_estatus
		
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if isnull(currentrow) or currentrow <= 0 then return -1

ldwis_estatus = GetItemStatus(currentrow, 0, Primary!)

//Si el rengl$$HEX1$$f300$$ENDHEX$$n es nuevo y el dw es tipo grid, entonces no ilumina el rengl$$HEX1$$f300$$ENDHEX$$n
if ldwis_estatus = new! or ldwis_estatus = newmodified! and describe("DataWindow.Processing") = "1" then
	selectrow(currentrow, false)
end if

end event

event clicked;call super::clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
dwItemStatus ldwis_estatus 
string ls_objeto
long ll_rtn

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

//if isnull(row) or row <= 0 then return 1

//ldwis_estatus = GetItemStatus(row, 0, Primary!)
//
////Si el rengl$$HEX1$$f300$$ENDHEX$$n es nuevo y el dw es tipo grid, entonces no ilumina el rengl$$HEX1$$f300$$ENDHEX$$n
//if ldwis_estatus = new! or ldwis_estatus = newmodified! and describe("DataWindow.Processing") = "1" then
//	selectrow(row, false)
//end if


IF ib_agrupadorcolumnas THEN
	ls_objeto = dwo.name
	IF right(ls_objeto,2) = '_t'  THEN
		DragIcon = 'Structure5!'
		//Asigna la variable de Paso para el control
		iuo_agrupador.of_AsignaColumnaNueva(ls_objeto)
		Drag(begin!)
	END IF
END IF

return ll_rtn
end event

event dropdown;call super::dropdown;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Checa si existen registradas columnas para el servicio de filtrar dddw
if upperbound(isarr_filtradddw) > 0 then 
	ib_dddropped = true
	ib_ddredrawn = false
	
	of_filtradddw(this, true)
	
	ib_ddredrawn = true
end if
end event

event itemerror;call super::itemerror;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if ancestorreturnvalue <> 0 then return ancestorreturnvalue

return 3
end event

event type integer pfc_predeleterow();call super::pfc_predeleterow;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

if ancestorreturnvalue = PREVENT_ACTION then return PREVENT_ACTION

//Si el dw est$$HEX2$$e1002000$$ENDHEX$$vac$$HEX1$$ed00$$ENDHEX$$o abortar proceso
if rowcount() = 0 then return PREVENT_ACTION

return CONTINUE_ACTION
end event

event pfc_finddlg();//////////////////////////////////////////////////////////////////////////////
// OVERRIDE
//	ADECUADO LAC
//////////////////////////////////////////////////////////////////////////////
//	Event:			pfc_finddlg
//	Arguments:		None
//	Returns:			None
//	Description:	Invokes the Find dialog window.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
boolean	lb_response = false
window	lw_ventana

if IsValid (inv_Find) then	
	//Checa la ventana padre
	if of_getparentwindow(lw_ventana) = 1 then
		if lw_ventana.windowtype = response! then lb_response = true
	end if
	if lb_response then
		inv_Find.Event pfc_finddlg_response()
	else
		inv_Find.Event pfc_finddlg()
	end if
end if
end event

event getfocus;//////////////////////////////////////////////////////////////////////////////
// OJO! SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//////////////////////////////////////////////////////////////////////////////
//	Event:  			getfocus
//	Arguments:		None
//	Returns:  		None
//	Description:		Notify the parent window that this control got focus.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
window 	lw_parent

of_GetParentWindow(lw_parent)
if IsValid(lw_parent) then
	// Dynamic call to the parent window.
	lw_parent.dynamic event pfc_ControlGotFocus (this)
end if


end event

event rbuttondown;//////////////////////////////////////////////////////////////////////////////
// OJO!: LAC: SE EST$$HEX2$$c1002000$$ENDHEX$$DANDO OVERRIDE
//////////////////////////////////////////////////////////////////////////////
//	Event:			rbuttondown
//	Description:		Allow for focus change on rbuttondown
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0 	Added Linkage service notification.
//////////////////////////////////////////////////////////////////////////////
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
//////////////////////////////////////////////////////////////////////////////
integer	li_rc
long		ll_currow
string	ls_colname
string	ls_curcolname
string ls

// Validate arguments.
if not ib_RMBfocuschange or IsNull (dwo) or row <= 0 then return

if IsValid (inv_Linkage) then
	If inv_Linkage.event pfc_rbuttondown (xpos, ypos, row, dwo) <> &
		inv_Linkage.CONTINUE_ACTION then
		// The user or an error prevents changing to a new row.
		return
	end if
end if

if IsValid (inv_RowSelect) then inv_RowSelect.event pfc_rbuttondown (xpos, ypos, row, dwo)

if dwo.type <> "column" then return

// Perform no action if already over current row/column.
ls_colname = dwo.name
ls_curcolname = this.GetColumnName()
ll_currow = this.GetRow()
if (ls_colname = ls_curcolname) and (row = ll_currow) then return

// Set row & column.
if this.SetRow (row) = 1 then
	//Valida primero si es editable el campo por protecT
	ls = describe(ls_colname + ".protect")
	ls = right(ls, len(ls) - pos(ls, '~t'))
	ls = left(ls, len(ls) - 1)
	if describe("evaluate('"+ ls + "'," +string(row) +")") = '1' then return
	
	//Valida primero si es editable el campo por tabsequence
	if describe(ls_colname + ".TabSequence") = '0' then return
	
	//Valida primero si es editable el campo por display only
	if describe(ls_colname + ".Edit.DisplayOnly") = '1' then return
	
	//...pone el focus en la columna
	this.SetColumn (ls_colname)
end if
end event

event resize;call super::resize;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Si est$$HEX2$$e1002000$$ENDHEX$$habilitado el servicio de split ajusta la barra de split
if len(trim(is_campo_split)) > 0 then post of_split()


IF ib_agrupadorcolumnas AND ii_ModoAgrupador = DOCK THEN 	
	iuo_agrupador.Width = this.Width
END IF

of_AjustaDWBusqueda()
end event

event scrollhorizontal;call super::scrollhorizontal;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long	ll_split

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Si est$$HEX2$$e1002000$$ENDHEX$$habilitado el servicio de split valida el m$$HEX1$$ed00$$ENDHEX$$nimo movimiento del split
if len(trim(is_campo_split)) > 0 then
	choose case pane
		case 1
			Object.DataWindow.HorizontalScrollPosition = 0
			post setcolumn(is_campo_split)
		case 2
			ll_split = long(object.DataWindow.HorizontalScrollSplit)
			if scrollpos <= ll_split then Object.DataWindow.HorizontalScrollPosition2 = ll_split
	end choose
end if


//Sincroniza el movimiento de la barra de ayudas
IF IsValid(idw_busqueda) THEN idw_busqueda.Object.DataWindow.HorizontalScrollPosition = scrollpos
end event

event destructor;call super::destructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//LEC20100803
IF ib_agrupadorcolumnas THEN of_AgrupadorColumnas(FALSE)

of_setDWBusqueda(FALSE)
end event

event retrievestart;call super::retrievestart;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF ib_agrupadorcolumnas THEN
	IF IsValid(itr_Object) THEN SetTransObject(itr_Object)
END IF
		
end event


HA$PBExportHeader$u_grupo.sru
forward
global type u_grupo from u_base
end type
type st_opciones from statictext within u_grupo
end type
type st_cerrar from statictext within u_grupo
end type
type st_etiqueta from statictext within u_grupo
end type
type p_1 from picture within u_grupo
end type
end forward

global type u_grupo from u_base
integer width = 402
integer height = 64
boolean border = true
long backcolor = 67108864
event lbuttonup pbm_lbuttonup
event losefocus pbm_bnkillfocus
event getfocus ( )
event lbuttondown pbm_lbuttondown
st_opciones st_opciones
st_cerrar st_cerrar
st_etiqueta st_etiqueta
p_1 p_1
end type
global u_grupo u_grupo

type prototypes
//
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"

public function Long BringWindowToTop(Long lhwnd) library "user32.dll"

Public Function Boolean GetWindowRect (Long hwnd, Ref RECT rectangle)  library "user32.dll"
end prototypes

type variables

u_agrupador_columnas iuo_parent
st_grupo ist_informacion

Boolean ib_selected
Boolean ib_mousecaptured
Boolean ib_mouseleave
Boolean ib_mousedown
Boolean ib_mouseover

window iw_parent
u_grupo iuo_grupo

u_grupo_opciones iuo_opciones

integer ii_offsetX, ii_offsetY

boolean ib_textofocus = FALSE, ib_opcionesfocus = FALSE, ib_cerrarfocus = FALSE
boolean ib_opcionesvisible = FALSE

boolean ib_filtroactivo = FALSE


integer ii_x, ii_y
end variables

forward prototypes
public function boolean of_punterodentro (integer ai_x, integer ai_y)
public function integer of_lbuttondown (integer ai_x, integer ai_y)
public function integer of_lbuttonup (integer ai_x, integer ai_y)
public function integer of_settext (string as_text)
public function integer of_setparent (u_agrupador_columnas luo_parent)
public function integer of_offset (integer ai_x, integer ai_y)
public function integer of_muestraopciones (boolean ab_visible)
public function integer of_procfiltros (ref n_ds lds_return)
public function integer of_asignavalores (string asarr_valores[])
public function integer of_asignainfo (ref st_grupo ast_grupo)
public function integer of_estatusfiltro (boolean ab_activo)
public function integer of_modopanel ()
end prototypes

event losefocus;//------------------------------------------------------------------
//  MODULO/FUNCION	: losefocus
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

IF NOT ib_textofocus AND NOT ib_opcionesfocus AND NOT ib_cerrarfocus THEN
//	messagebox("","lose focus botton"+tag)
END IF
end event

event getfocus();//------------------------------------------------------------------
//  MODULO/FUNCION	: Getfocus
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

//Si tiene el foco al menos un control contenido en el objeto
IF ib_textofocus OR ib_opcionesfocus OR ib_cerrarfocus THEN
	//Si esta mostrando el menu emergente
	IF NOT ib_OpcionesVisible THEN
		//Lo oculta
		iuo_parent.of_OcultarOpciones()
	END IF
END IF
end event

event lbuttondown;
ii_x = xpos
ii_y = ypos
end event

public function boolean of_punterodentro (integer ai_x, integer ai_y);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_PunteroDentro
//
//  DESCRIPCION		: Indica si una posicion esta dentro del area del grupo
// 
//  EVENTO/ARGUMENTOS: 
//		:ai_x = Posicion X
//		:ai_y = Posicion Y
//
//  DEVUELVE			:
//	  1   :  Verdadero o Falso
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_x, li_y

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

li_x = ai_x - this.x
li_y = ai_y - this.y

IF li_x > 0 AND li_x <= width AND li_y > 0 AND li_y <= height THEN return true

return false
end function

public function integer of_lbuttondown (integer ai_x, integer ai_y);

//IF of_PunteroDentro(ai_x, ai_y) THEN
//	ib_mousedown = TRUE
//	ib_selected = TRUE
//ELSE
//	ib_mousedown = FALSE
//	ib_selected = FALSE	
//END IF

RETURN 1
end function

public function integer of_lbuttonup (integer ai_x, integer ai_y);

//IF of_PunteroDentro(ai_x, ai_y) AND ib_mousedown THEN
//	ib_mousedown = FALSE
//	iuo_parent.EVENT ue_click_grupo(integer(This.Tag))
//END IF

RETURN 1
end function

public function integer of_settext (string as_text);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_SetText
//
//  DESCRIPCION		: Asigna el valor de la etiqueta
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

st_etiqueta.text = as_text

return 1
end function

public function integer of_setparent (u_agrupador_columnas luo_parent);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_SetParent
//
//  DESCRIPCION		: Asigna el Objeto Padre
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

iuo_parent = luo_parent

return 1
end function

public function integer of_offset (integer ai_x, integer ai_y);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_OffSet
//
//  DESCRIPCION		: Asigna la posicion relativa del grupo respecto al objeto agrupador
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ii_offsetX = ai_x //+ iuo_parent.X
ii_offsetY = ai_y //+ iuo_parent.Y

Move(ai_x, ai_y)

RETURN 1
end function

public function integer of_muestraopciones (boolean ab_visible);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_MuestraOpciones
//
//  DESCRIPCION		: Muestra/Oculta el Men$$HEX2$$fa002000$$ENDHEX$$emergente de opciones
// 
//  EVENTO/ARGUMENTOS: 
//      ab_visible  : Visibilidad el men$$HEX2$$fa002000$$ENDHEX$$emergente
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rtn, li_modo_panel, li_x, li_y
n_ds lds_param
w_base_dropdown lw_popup
RECT rc
			
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
boolean lb
			
TRY
	IF ab_visible THEN
		IF NOT ib_opcionesvisible THEN
			li_modo_panel = of_ModoPanel()
			
			IF of_ProcFiltros(lds_param) = 0 THEN RETURN -1
			
			GetWindowRect(Handle(iuo_parent), rc)
			
			rc.top = PixelsToUnits(rc.top, YPixelsToUnits!)
			rc.left = PixelsToUnits(rc.left, XPixelsToUnits!)
			
			Open(lw_popup,'w_base_dropdown')
			
			li_rtn = lw_popup.OpenUserObject(iuo_opciones)
			lw_popup.width = iuo_opciones.width
			lw_popup.height = iuo_opciones.height
			
			iuo_opciones.of_SetParentWindow(iw_parent)
			iuo_opciones.of_SetParent(iuo_grupo)
			iuo_opciones.of_CargaDatos(lds_param)
			

			lw_popup.move(rc.Left + ii_OffsetX, rc.Top + ii_OffSetY + iuo_parent.GROUP_HEIGHT)
			
			lw_popup.Show()
//			
//			ib_opcionesvisible = TRUE
			
	//	ELSE
	//		of_MuestraOpciones(FALSE)
		END IF
	ELSE
		IF ib_opcionesvisible THEN
			IF IsValid(iuo_opciones) THEN iw_parent.CloseUserObject(iuo_opciones)
			ib_opcionesvisible = FALSE
		END IF
	END IF

CATCH(runtimeerror a)
	messagebox(gs_nombreapp,"Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al inicializar el men$$HEX2$$fa002000$$ENDHEX$$de opciones~n"+a.text,stopsign!)
	RETURN -1
END TRY



RETURN 1

end function

public function integer of_procfiltros (ref n_ds lds_return);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ProcFiltros
//
//  DESCRIPCION		: Genera los textos por los cuales se podra filtrar la columna especificada
// 
//  EVENTO/ARGUMENTOS: 
//      lds_return  : DataStore solo con los renglons que tengan valor diferente para la columna
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_index, li_num_columnas, li_rc
st_grupo lst_grupo
string ls_columna, ls_tipo_dato, ls_valor, ls_valor_siguiente, ls_sintaxis, ls_error
n_ds lds_temp, lds_filtro
long ll_row_find, ll_row

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Obtiene $$HEX1$$ed00$$ENDHEX$$ndice u orden del Grupo
li_index = integer(this.Tag)

//Obtiene informaci$$HEX1$$f300$$ENDHEX$$n del grupo
lst_grupo = iuo_parent.ist_grupos[li_index]

ls_columna = iuo_parent.ist_grupos[li_index].Columna

//Si no hay datos cargados termina
IF iuo_parent.ids_data.rowcount() = 0 THEN return 0

////Copia los datos Originales
//lds_temp = CREATE n_ds
//lds_temp.dataobject = iuo_parent.ids_data.dataobject
//iuo_parent.ids_data.rowscopy(1,iuo_parent.ids_data.RowCount(),primary!,lds_temp,1,primary!)
//LEC20100803
iuo_parent.of_Copiar(iuo_parent.ids_data, lds_temp)

////Genera objeto para guardar localmente la informacion antes de regresarla
//lds_filtro = CREATE n_ds
//lds_filtro.dataobject = lds_temp.dataobject
//LEC20100803
lds_filtro = CREATE n_ds
ls_sintaxis = lds_temp.Describe("datawindow.syntax")
li_rc = lds_filtro.Create(ls_sintaxis, ls_error)
li_num_columnas = integer(lds_temp.Describe("DataWindow.Column.Count"))

ls_tipo_dato = lst_grupo.TipoDeDato

lds_temp.SetSort(ls_columna)
lds_temp.Sort()
ll_row_find = 1
ll_row = 1

CHOOSE CASE LEFT(UPPER(ls_tipo_dato),4)
	CASE 'CHAR'
		
		DO WHILE ll_row_find > 0
			//lds_temp.RowsCopy(ll_row_find,ll_row_find,primary!,lds_filtro,lds_filtro.RowCount() + 1, primary!)
			//LEC20100803
			lds_filtro.object.data[ll_row, 1, ll_row, li_num_columnas] = lds_temp.object.data[ll_row_find, 1, ll_row_find, li_num_columnas]
			
			ls_valor = lds_temp.GetItemString(ll_row_find,ls_columna)		
			
			IF IsNull(ls_valor) THEN
				ll_row_find = lds_temp.Find("NOT ISNULL("+ls_columna + ")",ll_row_find + 1, lds_temp.RowCount())				
			ELSE
				ll_row_find = lds_temp.Find(ls_columna + " <> '" + ls_valor+"'",ll_row_find + 1, lds_temp.RowCount())
			END IF
			
			ll_row ++
		LOOP

	CASE 'LONG', 'DECI'
		
		DO WHILE ll_row_find > 0
			//lds_temp.RowsCopy(ll_row_find,ll_row_find,primary!,lds_filtro,lds_filtro.RowCount() + 1, primary!)
			//LEC20100803
			lds_filtro.object.data[ll_row_find, 1, ll_row_find, li_num_columnas] = lds_temp.object.data[ll_row_find, 1, ll_row_find, li_num_columnas]
			
			ls_valor = String(lds_temp.GetItemDecimal(ll_row_find,ls_columna))
			
			IF IsNull(ls_valor) THEN
				ll_row_find = lds_temp.Find("NOT ISNULL("+ls_columna + ")",ll_row_find + 1, lds_temp.RowCount())				
			ELSE
				ll_row_find = lds_temp.Find(ls_columna + " <> " + ls_valor,ll_row_find + 1, lds_temp.RowCount())
			END IF
			
		LOOP		
	CASE 'DATE'
		DO WHILE ll_row_find > 0
			//lds_temp.RowsCopy(ll_row_find,ll_row_find,primary!,lds_filtro,lds_filtro.RowCount() + 1, primary!)
			//LEC20100803
			lds_filtro.object.data[ll_row_find, 1, ll_row_find, li_num_columnas] = lds_temp.object.data[ll_row_find, 1, ll_row_find, li_num_columnas]
			
			ls_valor = String(lds_temp.GetItemDate(ll_row_find,ls_columna))
			
			IF IsNull(ls_valor) THEN
				ll_row_find = lds_temp.Find("NOT ISNULL("+ls_columna + ")",ll_row_find + 1, lds_temp.RowCount())				
			ELSE
				ll_row_find = lds_temp.Find(ls_columna + " <> date('" + ls_valor+"')",ll_row_find + 1, lds_temp.RowCount())
			END IF
			
		LOOP		
END CHOOSE

////Copia los datos para regresarlos
//lds_return = CREATE n_ds
//lds_return.dataobject = lds_filtro.dataobject
//lds_filtro.RowsCopy(1,lds_filtro.rowcount(),primary!,lds_return, 1, primary!)
//LEC20100803
iuo_parent.of_Copiar(lds_filtro, lds_return)

DESTROY lds_filtro
DESTROY lds_temp

return 1


end function

public function integer of_asignavalores (string asarr_valores[]);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AsignaValores
//
//  DESCRIPCION		: Genera el filtro del grupo de acuerdo a los valores seleccionados
// 
//  EVENTO/ARGUMENTOS: 
//		:asarr_valores[] : Arreglo de valores de la columa seleccionada
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string lsarr_vacio[], ls_filtro, ls_nulos, ls_valor, ls_arrnonumeric[]
integer li_index, li_nonum
n_cst_string   inv_string

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


ist_informacion.valores[] = lsarr_vacio[]
ist_informacion.valores[] = asarr_valores[]

ls_nulos = ''

IF UpperBound(asarr_valores[]) > 0 THEN
	CHOOSE CASE LEFT(ist_informacion.TipoDeDato,4)
		CASE 'CHAR'
			ls_filtro = ist_informacion.Columna + " in ( "
			FOR li_index = 1 TO UpperBound(asarr_valores)
				
				IF LEN(asarr_valores[li_index]) = 0 THEN ls_nulos = " or ISNULL("+ist_informacion.Columna+")"
				
				ls_filtro += "'"+asarr_valores[li_index]+"',"
			NEXT
			
			ls_filtro = LEFT(ls_filtro,Len(ls_filtro) - 1) + ")" + ls_nulos
			
		CASE 'DECI', 'LONG'
			ls_arrnonumeric[1] = ','
			ls_arrnonumeric[2] = '$'
			
			ls_filtro = ist_informacion.Columna + " in ( "
			FOR li_index = 1 TO UpperBound(asarr_valores)
				IF LEN(asarr_valores[li_index]) = 0 THEN
					ls_nulos = " or ISNULL("+ist_informacion.Columna+")"
				ELSE
					ls_valor = asarr_valores[li_index]
					FOR li_NoNum = 1 TO UpperBound(ls_arrnonumeric)
						ls_valor = inv_string.of_GlobalReplace(ls_valor ,ls_arrNoNumeric[li_NoNum], '')
					NEXT
					ls_filtro += ls_valor +","
				END IF
			NEXT
			
			ls_filtro = LEFT(ls_filtro,Len(ls_filtro) - 1) + ")" + ls_nulos
		CASE 'DATE'
			ls_filtro = ist_informacion.Columna + " in ( "
			FOR li_index = 1 TO UpperBound(asarr_valores)
				IF LEN(asarr_valores[li_index]) = 0 THEN
					ls_nulos = " or ISNULL("+ist_informacion.Columna+")"
				ELSE
					ls_filtro += "date('"+asarr_valores[li_index]+"'),"
				END IF
			NEXT
			
			ls_filtro = LEFT(ls_filtro,Len(ls_filtro) - 1) + ")" + ls_nulos
	END CHOOSE
END IF

//Asigna el filtro generado al grupo
ist_informacion.Filtro = ls_filtro
li_index = Integer(This.Tag)
iuo_parent.ist_grupos[li_index].Filtro = ls_filtro

//Llama los filtros
iuo_parent.of_AplicaFiltros()

RETURN 1
end function

public function integer of_asignainfo (ref st_grupo ast_grupo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AsignaInfo
//
//  DESCRIPCION		: Asigna informacion del grupo
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_tipo

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Obtiene tipo de dato
ls_tipo = upper(iuo_parent.ids_data.Describe(ast_grupo.Columna+".Coltype"))

ast_grupo.TipoDeDato = ls_tipo

//Asigna localmente la informacion
ist_informacion = ast_grupo

RETURN 1
end function

public function integer of_estatusfiltro (boolean ab_activo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_EstatusFiltro
//
//  DESCRIPCION		: Actualiza el estado el Filtro si esta aplicado o no
// 
//  EVENTO/ARGUMENTOS: 
//		ab_activo : Activa/Desactiva el indicador si hay filtro aplicado
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_filtroactivo = ab_activo

IF ab_activo THEN
	st_opciones.TextColor = 128
ELSE
	st_opciones.TextColor = 8388608
END IF

RETURN 1
end function

public function integer of_modopanel ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ModoPanel
//
//  DESCRIPCION		: Obtiene el modo en que fue abierto el objeto agrupador
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  Todo Bien
//  -1   :  Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT IsValid(iw_parent) THEN RETURN -1

IF iw_parent.Classname() = 'w_agrupador' THEN
	RETURN 2
ELSE
	RETURN 1
END IF




end function

on u_grupo.create
int iCurrent
call super::create
this.st_opciones=create st_opciones
this.st_cerrar=create st_cerrar
this.st_etiqueta=create st_etiqueta
this.p_1=create p_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_opciones
this.Control[iCurrent+2]=this.st_cerrar
this.Control[iCurrent+3]=this.st_etiqueta
this.Control[iCurrent+4]=this.p_1
end on

on u_grupo.destroy
call super::destroy
destroy(this.st_opciones)
destroy(this.st_cerrar)
destroy(this.st_etiqueta)
destroy(this.p_1)
end on

event constructor;call super::constructor;//------------------------------------------------------------------
//  MODULO/FUNCION	: Constructor
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
st_grupo lst_grupo

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Inicializa el Objeto
IF isvalid(message.powerobjectparm) THEN
	lst_grupo = message.powerobjectparm
	
	st_etiqueta.Text = lst_grupo.nombre
	st_etiqueta.Tag = lst_grupo.columna
END IF

Border = TRUE

//StyleBox!
//StyleLowered!
//BorderStyle = StyleRaised!
BorderStyle = StyleShadowBox!

//st_etiqueta.BackColor = RGB(128,128,255)

ib_isupdateable = false
iuo_grupo = this

of_getparentwindow(iw_parent)

end event

event destructor;call super::destructor;//------------------------------------------------------------------
//  MODULO/FUNCION	: destructor
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


of_MuestraOpciones(FALSE)

//Restatura la memoria de objetos no usados
GarbageCollect ( )
end event

type st_opciones from statictext within u_grupo
integer x = 270
integer y = 4
integer width = 50
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
string pointer = "HyperLink!"
long textcolor = 8388608
long backcolor = 67108864
string text = "$$HEX1$$da00$$ENDHEX$$"
boolean focusrectangle = false
end type

event clicked;
of_MuestraOpciones(true)
end event

event getfocus;
ib_opcionesfocus = true

parent.event getfocus()
end event

event losefocus;

ib_opcionesfocus = false

parent.event losefocus()
end event

type st_cerrar from statictext within u_grupo
integer x = 306
integer width = 101
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = symbol!
fontpitch fontpitch = variable!
string facename = "Wingdings"
string pointer = "HyperLink!"
long textcolor = 8388608
long backcolor = 67108864
string text = "$$HEX1$$d500$$ENDHEX$$"
boolean focusrectangle = false
end type

event clicked;

iuo_parent.EVENT ue_cerrar_grupo(integer(parent.Tag))
end event

event getfocus;
ib_cerrarfocus = TRUE

parent.event getfocus()
end event

event losefocus;

ib_cerrarfocus = FALSE

parent.event losefocus()
end event

type st_etiqueta from statictext within u_grupo
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

event clicked;

iuo_parent.EVENT ue_click_grupo(integer(parent.Tag))
end event

event getfocus;
ib_textofocus = TRUE

parent.event getfocus()
end event

event losefocus;
ib_textofocus = FALSE

parent.event losefocus()
end event

type p_1 from picture within u_grupo
boolean visible = false
integer x = 347
integer y = 12
integer width = 50
integer height = 44
boolean bringtotop = true
boolean originalsize = true
string picturename = "C:\Users\lcollomb\Desktop\cerrar.jpg"
boolean focusrectangle = false
end type

event clicked;
iuo_parent.EVENT ue_cerrar_grupo(integer(parent.Tag))
end event


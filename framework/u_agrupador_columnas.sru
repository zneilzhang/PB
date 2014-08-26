HA$PBExportHeader$u_agrupador_columnas.sru
forward
global type u_agrupador_columnas from u_base
end type
type st_leyenda from statictext within u_agrupador_columnas
end type
end forward

global type u_agrupador_columnas from u_base
integer width = 1490
integer height = 108
long backcolor = 12632256
event ue_grupo_agregado ( )
event ue_grupo_removido ( )
event ue_click_grupo ( integer ai_index )
event lbuttonup pbm_lbuttonup
event lbuttondown pbm_lbuttondown
event ue_cerrar_grupo ( integer ai_index )
event ue_post_constructor ( )
st_leyenda st_leyenda
end type
global u_agrupador_columnas u_agrupador_columnas

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
public function Long BringWindowToTop(Long lhwnd) library "user32.dll"
end prototypes

type variables


st_grupo ist_grupos[]

CONSTANT INTEGER SEPARACIONX = 30
CONSTANT INTEGER SEPARACIONY = 15
CONSTANT LONG GROUP_HEIGHT = 70
CONSTANT LONG GROUP_WIDTH = 400

CONSTANT INTEGER IDENTACION = 64

BOOLEAN ib_mousedown

window iw_parent

u_dw idw_control
n_ds ids_data
n_ds ids_backup

string is_syntax_parte1, is_syntax_parte2
string is_syntax_original
string is_columna_nueva
string is_sort_original

constant integer  ROJO = 1
constant integer  VERDE = 2
constant integer  VERDEOSC = 6
constant integer  VERDEOSC1 = 7
constant integer  AZUL = 3
constant integer  AZULOSC = 8
constant integer  AZULOSC1 = 9
constant integer  NEGRO = 4
constant integer  GRIS = 5
constant integer  MORADO = 10

string isarr_colores[]

end variables

forward prototypes
public function integer of_organizargrupos ()
public function integer of_totalgrupos ()
public function string of_obtenercompute (integer ai_index)
public function integer of_asignarcompute (integer ai_index, string as_compute)
public function integer of_creagruposdw ()
public function integer of_asignadwdetalle (u_dw adw_control)
public function integer of_inicializadetalle (u_dw adw_control)
public function integer of_ajustacolumnas ()
public function integer of_buscainiciosyntax (string as_syntax, long al_pos_ini)
public function string of_obtienecolumnanueva ()
public function integer of_asignacolumnanueva (string as_columna)
public function integer of_agregagrupo (st_grupo ast_grupo)
public function integer of_agregagrupo (string as_columna, string as_nombre)
public function string of_obtienecolumna (integer ai_index)
public function string of_obtienenombrecolumna (integer ai_index)
public function integer of_asignacolor (integer ai_color)
public function integer of_removergrupo (integer ai_index)
public function integer of_ayuda ()
public function integer of_removertodos ()
public function integer of_removergrupo (integer ai_index, boolean ab_actualizar)
public function integer of_ocultaropciones ()
public function integer of_aplicafiltros ()
public function integer of_copiar (u_dw adw_objeto, ref n_ds ads_objeto)
public function integer of_copiar (n_ds ads_objeto, ref u_dw adw_objeto)
public function integer of_copiar (n_ds adw_objeto, ref n_ds ads_objeto)
public function integer of_copiar (n_ds ads_objeto, ref u_dw adw_objeto, boolean ab_regenerar)
end prototypes

event ue_click_grupo(integer ai_index);//------------------------------------------------------------------
//  MODULO/FUNCION	: ue_click_grupo
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


//of_AsignaColumnaNueva(of_ObtieneColumna(ai_index))
//Drag(begin!)

//ist_grupos[ai_index].objeto.of_ProcFiltros()

//messagebox("",string(ai_index))

end event

event lbuttonup;//------------------------------------------------------------------
//  MODULO/FUNCION	: lbuttonup
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

//Pasa el Foco
st_leyenda.SetFocus()


end event

event lbuttondown;//------------------------------------------------------------------
//  MODULO/FUNCION	: lbuttondown
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

//Si el modo de Agrupacion es Ventana Flotante
//Identifica el datawindow al que pertenece
IF idw_control.ii_ModoAgrupador = idw_control.FLOATING THEN idw_control.of_Activate()
end event

event ue_cerrar_grupo(integer ai_index);//------------------------------------------------------------------
//  MODULO/FUNCION	: ue_cerrar_grupo
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

//Elimina el Grupo del Control
of_RemoverGrupo(ai_index)

//Crea las agrupaciones en el Datawindow
of_CreaGruposDW()
end event

event ue_post_constructor();//------------------------------------------------------------------
//  MODULO/FUNCION	: ue_post_constructor
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

//Ajusta los objetos del control
st_leyenda.x = 27
st_leyenda.y = 28

st_leyenda.width = width - st_leyenda.x - 27
st_leyenda.height = height - st_leyenda.y - 28
end event

public function integer of_organizargrupos ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_OrganizarGrupos
//
//  DESCRIPCION		: Ajusta las posiciones de los Grupos en el Control
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
long ll_x, ll_y, ll_tmp, ll_total
integer li_index
u_grupo luo_grupo

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_total = UpperBound(ist_grupos)

ll_x = SEPARACIONX
ll_y = SEPARACIONY
ll_tmp = SEPARACIONX

FOR li_index = 1 TO ll_total
	
	IF li_index > 1 THEN ll_tmp = ist_grupos[li_index - 1].objeto.X + GROUP_WIDTH + SEPARACIONX
	
	IF (ll_tmp + GROUP_WIDTH) > width THEN
		ll_y += GROUP_HEIGHT + SEPARACIONY
		ll_x = SEPARACIONX
	ELSE
		ll_x = ll_tmp
	END IF
	
	ist_grupos[li_index].objeto.of_Offset(ll_x,ll_y)
	
NEXT

RETURN 1
end function

public function integer of_totalgrupos ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_TotalGrupos
//
//  DESCRIPCION		: Obtiene el Total de Grupos en el Control
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  Total de Grupos
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

RETURN UpperBound(ist_grupos)
end function

public function string of_obtenercompute (integer ai_index);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ObtenerCompute
//
//  DESCRIPCION		: Obtiene el nombre del compute del grupo
// 
//  EVENTO/ARGUMENTOS: 
//      ai_index  : $$HEX1$$cd00$$ENDHEX$$ndice u Orden del Grupo
//
//  DEVUELVE			:
//	  !   :  Error
//        :  Nombre del compute
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

IF of_TotalGrupos() < ai_index THEN
	messagebox(gs_nombreapp,"El indice especificado no existe",exclamation!)
	RETURN '!'
END IF

return ist_grupos[ai_index].compute

end function

public function integer of_asignarcompute (integer ai_index, string as_compute);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AsignarCompute
//
//  DESCRIPCION		: Asignar el nombre del Compute del Grupo como referencia al Grupo  en el $$HEX1$$ed00$$ENDHEX$$ndice especificado
// 
//  EVENTO/ARGUMENTOS: 
//      ai_index  : Indice u Orden del Grupo
//		as_compute : Nombre del compute del grupo correspondiente
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

IF of_TotalGrupos() < ai_index THEN
	messagebox(gs_nombreapp,"El $$HEX1$$ed00$$ENDHEX$$ndice especificado no existe",exclamation!)
	RETURN -1
END IF

ist_grupos[ai_index].compute = as_compute

RETURN 1
end function

public function integer of_creagruposdw ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_CreaGruposDW
//
//  DESCRIPCION		: Genera dinamicamente los Agrupadores del DataWindow
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
long ll_cont, ll_pos_retrieve, ll_pos_insert, li_ret, ll_x
long ll_pos_etiqueta, ll_pos_analiza, ll_pos_ini, ll_pos_fin, li_pos_proc
boolean lb_salir
string ls_Columna, ls_syntax, ls_campo, ls_titulo_gpo, ls_insert_gpo, &
		ls_insert_tit, ls_parte2, ls_err, ls_display_columna, ls_nombre_obj, &
		ls_sort, ls_letra, ls_syntax_parte2, ls_syntax_parte1, lsarr_vacio[], &
		lsarr_campos[], ls_convierte_tree_view, ls_processing, ls_valor_nulo_titulo
		
long ll_total_grupos
n_ds lds_temp
int li_rtn
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_total_grupos = of_TotalGrupos()

//Debe definer al inicio de todo un esquema de colores con la funci$$HEX1$$f300$$ENDHEX$$n of_AsignaColor
IF upperbound(isarr_colores) = 0 then 
	messagebox(gs_nombreapp,"No se ha definido el modo de colores para el agrupador",exclamation!)
	return -1
END IF

//Toma las partes de la sintaxis para trabajar localmente
ls_syntax_parte1 = is_syntax_parte1
ls_syntax_parte2 = is_syntax_parte2

ls_syntax =	is_syntax_parte1 + is_syntax_parte2
				
idw_control.setredraw(false)
//Limpa filtros actuales
idw_control.SetFilter("")
idw_control.Filter()

//Si no hay grupos en el Control Restaura los valores actuales
if ll_total_grupos = 0 then
	
//	lds_temp = CREATE n_ds
//	lds_temp.dataobject = idw_control.dataobject
//	//Respalda valores actuales
//	idw_control.RowsCopy(1,idw_control.RowCount(),primary!,lds_temp,1,primary!)
	//LEC20100803
	of_Copiar(idw_control, lds_temp)
	
	
	//Restaura el dw con la sintaxis original
	li_ret = idw_control.Create(is_syntax_original, ls_err)
	
	if li_ret <> 1 then messagebox('Error', 'Ocurri$$HEX2$$f3002000$$ENDHEX$$un error de sintaxis al crear el DW~n' + ls_err)
	
//	//Restaura los valores actuales
//	lds_temp.RowsCopy(1,lds_temp.RowCount(),primary!,idw_control,1,primary!)
	//LEC20100803
	of_Copiar(lds_temp, idw_control)
	
	DESTROY lds_temp
	
	idw_control.sort()
	idw_control.groupcalc()
	
	of_AjustaColumnas()
end if

//Si no hay grupos termina
if ll_total_grupos = 0 then return 0
//Inicializa identaci$$HEX1$$f300$$ENDHEX$$n
ll_x = 151

//Para cada uno de los Grupos
for ll_cont = 1 to ll_total_grupos
//	Falta Eliminar esos campos del dw
//	Validar el processing 9

	//Define nuevo nombre del compute
	ls_nombre_obj = "computePB_"+string(ll_cont)
	
	ls_columna = of_ObtieneColumna(ll_cont) + '_t' 		
	ls_display_columna = of_ObtieneNombreColumna(ll_cont)
	
	ls_campo = left(ls_columna,len(ls_columna) - 2)
	
	//Concatena las variables de ordenamiento
	ls_sort += ls_campo + " ASC,"
	
	//Define compute que se utilizara como titulo del grupo en el tree view
	ls_valor_nulo_titulo = "IF (isnull("+ls_campo+"),'(Nulo)',string("+ls_campo+"))"
//	ls_titulo_gpo = "'" + ls_display_columna + ": ' +" + ls_campo + " + ' (' + string(count("+ls_campo+" for group "+string(ll_cont)+"))+ ' elementos)'"
	ls_titulo_gpo = "'" + ls_display_columna + ": ' +" + ls_valor_nulo_titulo + " + ' (' + string(count(1 for group "+string(ll_cont)+"))+ ' elementos)'"

	//Genera por codigo el grupo
	ls_insert_gpo += 'group(level='+string(ll_cont)+' header.height=92 trailer.height=0 by=("'+ls_campo+'" ) header.color="536870912" trailer.color="536870912" ) ~n' 	
//	ls_insert_tit += 'compute(band=header.'+string(ll_cont)+' alignment="0" expression="'+ls_titulo_gpo+'"border="1" color="1073741824" x="'+string(ll_x)+'" y="4" height="64" width="1" format="[GENERAL]" html.valueishtml="0"  name='+ls_nombre_obj+' visible="1"  hidesnaked=1  font.face="Tahoma" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="268435456" ) ~n'
	ls_insert_tit += 'compute(band=header.'+string(ll_cont)+' alignment="0" expression="'+ls_titulo_gpo+'"border="1" color="'+isarr_colores[1]+'" x="'+string(ll_x)+'" y="4" height="64" width="1" format="[GENERAL]" html.valueishtml="0"  name='+ls_nombre_obj+' visible="1"  hidesnaked=1  font.face="Tahoma" font.height="-8" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="'+isarr_colores[2]+'" ) ~n'
	
	of_AsignarCompute(ll_cont,ls_nombre_obj)		
	
	//Incrementa variable de identaci$$HEX1$$f300$$ENDHEX$$n de los grupos
	ll_x += IDENTACION

next

//Busca la posicion del procesing...
li_pos_proc = pos(ls_syntax_parte1,'processing=')
//y cambia el procesing de DW a TreeViewDW
ls_syntax_parte1 = left(ls_syntax_parte1,li_pos_proc - 1) + 'processing=8' + mid(ls_syntax_parte1,li_pos_proc + 12)

//Crea el resultado del nuevo dW
ls_syntax =	ls_syntax_parte1 + ls_insert_gpo + '~n' + &
				ls_insert_tit + '~n' + &
				ls_syntax_parte2
				
//Genera sentencia de ordenamiento primero en base a los grupos y despues en base al ordenamiento original
IF LEN(TRIM(is_sort_original)) > 0 THEN
	ls_sort = ls_sort + is_sort_original
ELSE
	ls_sort = left(ls_sort,len(ls_sort) - 1)
END IF

if len(ls_syntax) > 1 then
//	//Respalda los valores actuales
//	lds_temp = CREATE n_ds
//	lds_temp.dataobject = idw_control.dataobject
//	idw_control.RowsCopy(1,idw_control.RowCount(),primary!,lds_temp,1,primary!)
	//LEC20100803
	of_Copiar(idw_control, lds_temp)

	//Crea el nuevo objeto
	li_ret = idw_control.Create(ls_syntax, ls_err)
	
//	//Restaura los valores actuales
//	lds_temp.RowsCopy(1,lds_temp.RowCount(),primary!,idw_control,1,primary!)
	//LEC20100803
	of_Copiar(lds_temp, idw_control)
	
	DESTROY lds_temp
	
	if li_ret <> 1 then 
		messagebox(gs_nombreapp, 'Ocurri$$HEX2$$f3002000$$ENDHEX$$un error de sintaxis al crear el DW~n' + ls_err)
		li_rtn = -1
	end if
	
	//Destruye las columnas por las cuales se esta agrupando
	for ll_cont = 1 to ll_total_grupos
		idw_control.Modify("destroy "+of_ObtieneColumna(ll_cont))
		idw_control.Modify("destroy "+of_ObtieneColumna(ll_cont)+"_t")
	next

	//Aplica los filtros definidos por grupo en caso de que hubiera
	of_AplicaFiltros()
	
	//Ordena la info
	idw_control.setsort(ls_sort)
	idw_control.sort()
	idw_control.groupcalc()
	
	of_AjustaColumnas()
	li_rtn = 1
else
	li_rtn = -1
end if

idw_control.setredraw(true)

return li_rtn
end function

public function integer of_asignadwdetalle (u_dw adw_control);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AsignaDWDetalle
//
//  DESCRIPCION		: Asigna referencia del DW y genera un respaldo de los datos
// 
//  EVENTO/ARGUMENTOS: 
//      adw_control  : Control Datawindow de Origen
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
int li_rc
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Asigna referencia del DW origen a variable de control
idw_control = adw_control

//ids_data Guarda un respaldo de los datoa actuales
//Si existe lo limpia
IF IsValid(ids_data) THEN
	DESTROY ids_data
END IF

////Genera un nuevo respaldo
//ids_data = CREATE n_ds
//ids_data.dataobject = adw_control.dataobject
//
//RETURN adw_control.rowscopy(1,adw_control.RowCount(),Primary!,ids_data,1,Primary!)

//LEC20100803
li_rc = of_Copiar(adw_control, ids_data)

RETURN li_rc
end function

public function integer of_inicializadetalle (u_dw adw_control);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_InicializaDetalle
//
//  DESCRIPCION		: Relaciona y prepara el objeto DataWindow para interactuar con el control
// 
//  EVENTO/ARGUMENTOS: 
//      adw_control  : Control DW de tipo u_dw
//
//	REQUISITOS
//							Deber ser un datawindow de tipo FREEFORM o GRID siempre en forma de listado
//							Los encabezados de las columnas SIEMPRE DEBE ser el nombre de la columna mas "_t"
//							El orden de las columnas esta definido por el orden del select no por la manera en que se acomodan en el dw
//
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
long ll_pos_insert, ll_pos_menor, ll_pos_retrieve, li_pos_proc, ll_height
integer li_cont, li_ret, li_processing, li_pos_det, li_pos_header
string ls_syntax, ls_err, ls_convierte_tree_view
n_ds lds_temp

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//LEC20100803
//IF isnull(adw_control.dataobject) Or len(trim(adw_control.dataobject)) = 0 then
//	messagebox(gs_nombreapp,"No ha establecido el DataWindow para mostar")
//	RETURN -1
//END IF

is_sort_original = adw_control.Describe("DataWindow.Table.Sort")
IF isnull(is_sort_original) THEN is_sort_original = ''

//Respanda sintaxis original del DW
is_syntax_original = adw_control.describe("datawindow.syntax")
//LEC20100803
IF isnull(is_syntax_original) Or len(trim(is_syntax_original)) = 0 then
	messagebox(gs_nombreapp,"No ha establecido el DataWindow para mostar")
	RETURN -1
END IF

//debugbreak()

//Obtiene la posicion del sql del dw
//LEC20100803
//ll_pos_retrieve = pos(is_syntax_original,'retrieve')
ll_pos_retrieve = pos(is_syntax_original,'table')

//Busca la posicion de algun objeto visible
ll_pos_menor = of_BuscaInicioSyntax(is_syntax_original,ll_pos_retrieve)

if ll_pos_menor = 0 then
	messagebox("Aviso","No se pudo definir la estructura del objeto~n"+adw_control.dataobject,exclamation!)
	return -1
end if

//Divide la sintaxis original en 2 partes
//1ra Va del inicio a donde inicia el primer texto
is_syntax_parte1 = left(is_syntax_original,ll_pos_menor) + '~n' 
li_pos_proc = pos(is_syntax_parte1,'processing=')
is_syntax_parte1 = left(is_syntax_parte1,li_pos_proc - 1) + 'processing=8' + mid(is_syntax_parte1,li_pos_proc + 12)

//2da La parte de los textos y organizacion de grupos y columnas
is_syntax_parte2 = mid(is_syntax_original,ll_pos_menor + 1)

li_processing = integer(mid(is_syntax_original,li_pos_proc+11,2))

//FreeForm(0) Grid(1)
IF li_processing > 1 THEN
	messagebox(gs_nombreapp,"Por el momento solo pueden utilizarse DataWindows de tipo FreeForm y Grid",information!)
	RETURN -1
END IF

//Si el tipo de datawindow es distinto a trewview(8) y treeviewgrid(9)
if li_processing <> 8 and li_processing <> 9 then
	//Lo convierte a tree view (8)
	ls_convierte_tree_view = "~n tree(type=1 showconnectlines=no showleafnodeconnectLines=yes  indent=32 showtreenodeicon=no defaultexpandtolevel=1 stateiconalignmode=0 selectnodebymouse=no rtollayout=no )"
	is_syntax_parte2 += ls_convierte_tree_view
end if

li_pos_det = pos(is_syntax_parte1,'header(height')
li_pos_header = pos(is_syntax_parte1,')',li_pos_det +1)

if li_pos_header > 0 then
	is_syntax_parte1 = left(is_syntax_parte1,li_pos_header - 1) + 'height.autosize=yes) ' + mid(is_syntax_parte1,li_pos_header + 1)
end if

//Asigna nueva sintaxis
ls_syntax = is_syntax_parte1 + is_syntax_parte2

of_Copiar(adw_control, ids_backup)

//Relaciona el objeto y respalda datos originales
of_AsignaDWDetalle(adw_control)

////Respalda datos actuales
//lds_temp = CREATE n_ds
//lds_temp.dataobject = adw_control.dataobject
//adw_control.rowscopy(1,adw_control.rowcount(),primary!,lds_temp,1,primary!)
//LEC20100803
of_Copiar(adw_control, lds_temp)

//Crea el nuevo DW
li_ret = adw_control.Create(ls_syntax, ls_err)
//Asigna la sintaxis original
is_syntax_original = ls_syntax

////Restautra valores actuales
//lds_temp.RowsCopy(1,lds_temp.Rowcount(),primary!,adw_control,1,primary!)
//LEC20100803
of_Copiar(lds_temp, adw_control)

DESTROY lds_temp

if li_ret <> 1 then 
	messagebox(gs_nombreapp, 'Ocurri$$HEX2$$f3002000$$ENDHEX$$un error de sintaxis al crear el DW dataobject ~n' + ls_err)
	adw_control.setredraw(true)
	return -1
end if

//Finaliza
adw_control.groupcalc()
adw_control.sort()
of_AjustaColumnas()
adw_control.setredraw(true)


return 1
end function

public function integer of_ajustacolumnas ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AjustaColumnas()
//
//  DESCRIPCION		: Ajusta las dimensiones de los grupos en el datawindow
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
//  
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_total_columnas, ll_num_col, ll_width, ll_x, ll_cont, ll_total_grupos
string ls_columna

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//6-Nov Tal vez se necesario reevaluar la necesidad de esta funcion

idw_control.setredraw(false)

ll_total_grupos = of_TotalGrupos()

//Muestra/Oculta El texto informativo
IF ll_total_grupos > 0 THEN
	st_leyenda.visible = false
ELSE
	st_leyenda.visible = true
END IF

ll_total_columnas = long(idw_control.Describe("DataWindow.Column.Count"))

ll_x = 151 + (IDENTACION * ll_total_grupos)
	
for ll_num_col = 1 to ll_total_columnas
	
	IF idw_control.describe("#"+string(ll_num_col)+".visible") = '0' then continue
	
	ls_columna = idw_control.describe("#"+string(ll_num_col)+".name")
	ll_width = long(idw_control.describe(ls_columna+".width"))
	idw_control.modify(ls_columna+".x='"+string(ll_x)+"'")
	idw_control.modify(ls_columna+"_t.x='"+string(ll_x)+"'")
	ll_x += ll_width + 5
next


For ll_cont = 1 to ll_total_grupos
	ll_width = ll_x - 151 - (IDENTACION * ll_cont)
	idw_control.modify(of_ObtenerCompute(ll_cont)+".Width='"+string(ll_width)+"'")
next

idw_control.setredraw(true)
	

return 1
end function

public function integer of_buscainiciosyntax (string as_syntax, long al_pos_ini);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_BuscaInicioSyntax
//
//  DESCRIPCION		: Busca un texto a partir de la posicion especificada
//								Los textos a buscar son inicializados en la funci$$HEX1$$f300$$ENDHEX$$n
// 
//  EVENTO/ARGUMENTOS: 
//      as_syntax  : El texto que forma el datawindow
//		al_pos_ini : Posicion a partir de la cual busca
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
string lsarr_buscar[]
long ll_pos_insert, ll_pos_menor
integer li_cont

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_pos_insert = 0
li_cont = 1

//Inicializa Arreglo de Palabras a buscar
lsarr_buscar[1] = 'text('
lsarr_buscar[2] = 'column('
lsarr_buscar[3] = 'compute('
lsarr_buscar[4] = 'htmltable('
lsarr_buscar[5] = 'htmlgen('

//Obtiene la posicion del grupo, texto, campo o compute del dw
for li_cont = 1 to upperbound(lsarr_buscar[])
	ll_pos_insert = pos(as_syntax,lsarr_buscar[li_cont],al_pos_ini) - 1
	
	if (ll_pos_insert < ll_pos_menor or ll_pos_menor = 0) and ll_pos_insert > -1 then ll_pos_menor = ll_pos_insert
next


return ll_pos_menor
end function

public function string of_obtienecolumnanueva ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ObtieneColumnaNueva
//
//  DESCRIPCION		: Lee el valor de la variable de paso entre el agrupador y el dw
//							  Sirve para definir el nombre de la columna
//							  Haciendo referencia en el evento DragDrop
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  string : Valor de la variable de paso
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


return is_columna_nueva
end function

public function integer of_asignacolumnanueva (string as_columna);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AsignaColumnaNueva
//
//  DESCRIPCION		: Asigna variable de Paso para Pasar columnas del DW al Agrupador
// 
//  EVENTO/ARGUMENTOS: 
//      as_columna  : Nombre de la columna
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

//Asigna variable de Paso para Pasar columnas del DW al Agrupador
is_columna_nueva = as_columna

RETURN 1
end function

public function integer of_agregagrupo (st_grupo ast_grupo);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AgregaGrupo
//
//  DESCRIPCION		: Agrega un nuevo agrupdor
// 
//  EVENTO/ARGUMENTOS: 
//      ast_grupo  : Estructura del Grupo
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
integer li_rtn, li_newindex
u_grupo luo_grupo

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

TRY

	//Crea el Objeto
	li_rtn = iw_parent.OpenUserObject(luo_grupo)
	
	li_newindex = UpperBound(ist_grupos) + 1
	
	//Asigna el Objeto Padre
	luo_grupo.of_setparent(THIS)
	
	//Asigna el tama$$HEX1$$f100$$ENDHEX$$o del Grupo
	luo_grupo.width = GROUP_WIDTH
	luo_grupo.height = GROUP_HEIGHT
	
	//Asigna la Etiqueta del Grupo
	luo_grupo.of_SetText(ast_grupo.nombre)
	
	//La Etiqueta siempre debe contener el indice el grupo
	luo_grupo.Tag = string(li_newindex)
	
	ast_grupo.objeto = luo_grupo
	ast_grupo.index = li_newindex
	
	//Determinar que el Objeto Panel Agrupador es el Padre del Objeto Grupo
	SetParent(Handle(luo_grupo), Handle(THIS))
	
	IF li_rtn = 1 THEN 
		//Pasa la estructura de datos al grupo y asiga valores necesarios
		luo_grupo.of_AsignaInfo(ast_grupo)
		
		//Actualiza el Arreglo de  Grupos
		ist_grupos[li_newindex] = ast_grupo
		
		//Ajusta las posiciones de los grupos en el control
		of_OrganizarGrupos()
		
		//Actualiza las agrupaciones en el Datawindow
		of_CreaGruposDW()
		
		//Trae los objetos al frente
		idw_control.of_BringToFront()
		
		//Lanza el evento
		event ue_grupo_agregado()
	END IF
	
CATCH(runtimeerror a)

	messagebox(gs_nombreapp,"Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al agregar el grupo~n"+a.text,stopsign!)
	RETURN -1
	
END TRY

GarbageCollect ()

return 1

end function

public function integer of_agregagrupo (string as_columna, string as_nombre);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AgregaGrupo
//
//  DESCRIPCION		: Agrega un nuevo agrupdor
// 
//  EVENTO/ARGUMENTOS: 
//      as_columna  : Nombre de la columna como viene en el dw
//		as_nombre   : Etiqueta que va a traer el grupo
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

st_grupo lst_grupo

lst_grupo.columna = as_columna
lst_grupo.nombre = as_nombre

return of_AgregaGrupo(lst_grupo)
end function

public function string of_obtienecolumna (integer ai_index);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ObtenerColumna
//
//  DESCRIPCION		: Obtiene el nombre de la columna asignada el grupo
// 
//  EVENTO/ARGUMENTOS: 
//      ai_index  : $$HEX1$$cd00$$ENDHEX$$ndice u Orden del Grupo
//
//  DEVUELVE			:
//	  !   :  Error
//        :  Nombre del compute
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

IF of_TotalGrupos() < ai_index THEN
	messagebox(gs_nombreapp,"El indice especificado no existe",exclamation!)
	RETURN '!'
END IF

RETURN ist_grupos[ai_index].columna
end function

public function string of_obtienenombrecolumna (integer ai_index);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ObtieneNombreColumna
//
//  DESCRIPCION		: Obtiene el nombre de la etiqueta del Grupo
// 
//  EVENTO/ARGUMENTOS: 
//      ai_index  : $$HEX1$$cd00$$ENDHEX$$ndice u Orden del Grupo
//
//  DEVUELVE			:
//	  !   :  Error
//        :  Nombre del compute
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

IF of_TotalGrupos() < ai_index THEN
	messagebox(gs_nombreapp,"El $$HEX1$$ed00$$ENDHEX$$ndice especificado no existe",exclamation!)
	RETURN '!'
END IF

RETURN ist_grupos[ai_index].nombre
end function

public function integer of_asignacolor (integer ai_color);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AsignaColor
//
//  DESCRIPCION		: Define los colores que se van usar para formar los grupos del tree view
// 
//  EVENTO/ARGUMENTOS: 
//      ai_color  : Constantes para los colores
//
//	//constant integer  ROJO = 1
//	//constant integer  VERDE = 2
//	//constant integer  AZUL = 3
//	//constant integer  NEGRO = 4
//	//constant integer  GRIS = 5
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
string lsarr_vacio[]

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


isarr_colores[] = lsarr_vacio[]

CHOOSE CASE ai_color
	CASE VERDE
		isarr_colores[1] = '8421376'
		isarr_colores[2] = '12639424'
	CASE AZUL
		isarr_colores[1] = '8388608'
		isarr_colores[2] = '15780518'
	CASE GRIS
		isarr_colores[1] = '1073741824'
		isarr_colores[2] = '268435456'
	CASE AZULOSC
		isarr_colores[1] = '1073741824'
		isarr_colores[2] = '134217741'
	CASE AZULOSC1
		isarr_colores[1] = '1073741824'
		isarr_colores[2] = '134217729'		
	CASE MORADO
		isarr_colores[1] = '1073741824'
		isarr_colores[2] = '134217858'				
	CASE VERDEOSC
		isarr_colores[1] = '1073741824'
		isarr_colores[2] = '8421376'						
	CASE VERDEOSC1
		isarr_colores[1] = '1073741824'
		isarr_colores[2] = '32768'								
END CHOOSE


return 1
end function

public function integer of_removergrupo (integer ai_index);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_RemoverGrupo
//
//  DESCRIPCION		: Elimina un Grupo del control
// 
//  EVENTO/ARGUMENTOS: 
//			ai_index : $$HEX1$$cd00$$ENDHEX$$ndice del Grupo
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

return of_RemoverGrupo(ai_index,TRUE)
end function

public function integer of_ayuda ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_ayuda
//
//  DESCRIPCION		: Muesta en mensaje de texto con informaci$$HEX1$$f300$$ENDHEX$$n importante para el uso del control
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

string ls_msg

ls_msg	= "REQUISITOS~n~n"+&
				"~tDeber ser un datawindow de tipo FREEFROM o GRID siempre en forma de listado~n"+&
				"~tLos encabezados de las columnas SIEMPRE DEBE ser el nombre de la columna mas _t ~n"+&
				"~tEl orden de las columnas esta definido por el orden del select no por la manera en que se acomodan en el dw~n"+&
				"~tSolo de puede usar para la manipulacion de informacion"+&
				"~tCada vez que se requiera cargar informacion debe asignarse el objeto de la transacci$$HEX1$$f300$$ENDHEX$$n"+&
				"~tLos DDDW por el momento no est$$HEX1$$e100$$ENDHEX$$n soportados"+&
				"~t~t 1) Inicializar el Objeto en el constructor of_InicializaDetalle"+&
				"~t~t 2) En el Retriveend del DW agregar la funci$$HEX1$$f300$$ENDHEX$$n of_AsignaDWDetalle Para actualizar la informacion del Objeto"+&
				"~t~t 3) Si va agregar grupos por codigo hacerlo depues del retrieve del DW"+&
				"~t~t 4) En el Clicked del DW Agregar lo necesario para inicial el Drag de la columna y usar la fnc of_AsignaColumnaNueva para la variable de paso"


messagebox(gs_nombreapp,ls_msg,information!)

return 1
end function

public function integer of_removertodos ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_RemoverTodos
//
//  DESCRIPCION		: Cierra todos los Grupos del control
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
integer li_index

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

FOR li_index = 1 TO UpperBound(ist_grupos)
	of_RemoverGrupo(li_index,FALSE)
NEXT

RETURN 1
end function

public function integer of_removergrupo (integer ai_index, boolean ab_actualizar);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_RemoverGrupo
//
//  DESCRIPCION		: Elimina un Grupo del control
// 
//  EVENTO/ARGUMENTOS: 
//		ai_index : $$HEX1$$cd00$$ENDHEX$$ndice u Orden del Grupo
//		ab_actualizar : Si actualiza o no las agrupaciones del DW
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
Long ll_index, ll_total, ll_newindex
st_grupo lst_grupos[], lst_vacio[]

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_total = UpperBound(ist_grupos)

//Elimina el Grupo y reorganiza el listado de Grupos
FOR ll_index = 1 TO ll_total
	IF ll_index <> ai_index THEN
		ll_newindex ++
		
		lst_grupos[ll_newindex] = ist_grupos[ll_index]
		lst_grupos[ll_newindex].index = ll_newindex
		lst_grupos[ll_newindex].objeto.tag = string(ll_newindex)
	ELSE
		SetParent(Handle(ist_grupos[ll_index].objeto), Handle(iw_parent))
		iw_parent.CloseUserObject(ist_grupos[ll_index].objeto)
	END IF
NEXT

ist_grupos[] = lst_vacio[]
ist_grupos = lst_grupos

of_OrganizarGrupos()

IF ab_actualizar THEN
	//Actualiza las agrupaciones en el Datawindow
	of_CreaGruposDW()
END IF

//Lanza evento
event ue_grupo_removido()

RETURN 1

end function

public function integer of_ocultaropciones ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_OcultarOpciones
//
//  DESCRIPCION		: Oculta el menu emergente con las opciones del grupo
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//	  1   :  todo Bien
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_index

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

FOR li_index = 1 TO UpperBound(ist_grupos)
	ist_grupos[li_index].objeto.of_MuestraOpciones(FALSE)
NEXT

RETURN 1
end function

public function integer of_aplicafiltros ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_AplicaFiltros
//
//  DESCRIPCION		: Aplicar los Filtros de todas las columas si lo llegaran a tener
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
integer li_index
string ls_filtro

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Recorre todos los Grupos...
FOR li_index = 1 TO UpperBound(ist_grupos)
	//Si no contiene informacion sobre filtro lo ignora
	IF isnull(ist_grupos[li_index].Filtro) OR LEN(TRIM(ist_grupos[li_index].Filtro)) = 0 THEN 
		//Desactiva Bandera para saber si ha sido filtrado
		ist_grupos[li_index].objeto.of_estatusfiltro(FALSE)
		CONTINUE
	END IF
	
	//Contatena Filtros de Grupos
	ls_filtro += "( "+ist_grupos[li_index].Filtro + ") and "
	
	//Activa Bandera para saber si ha sido filtrado
	ist_grupos[li_index].objeto.of_estatusfiltro(TRUE)
NEXT

ls_filtro = LEFT(ls_filtro,LEN(ls_filtro) - 5)

//Aplica el Filtro
idw_control.SetFilter(ls_filtro)
idw_control.Filter()


RETURN 1


end function

public function integer of_copiar (u_dw adw_objeto, ref n_ds ads_objeto);int li_rc, li_num_columnas
string ls_error, ls_sintaxis

IF IsValid(ads_objeto) THEN DESTROY ads_objeto

ads_objeto = CREATE n_ds
ls_sintaxis = adw_objeto.Describe("datawindow.syntax")
li_rc = ads_objeto.Create(ls_sintaxis, ls_error)
li_num_columnas = integer(adw_objeto.Describe("DataWindow.Column.Count"))

IF adw_objeto.rowcount() > 0 THEN
	ads_objeto.object.data[1,1,adw_objeto.rowcount(),li_num_columnas] = adw_objeto.object.data[1,1,adw_objeto.rowcount(),li_num_columnas]
END IF

RETURN li_rc
end function

public function integer of_copiar (n_ds ads_objeto, ref u_dw adw_objeto);//int li_rc, li_num_columnas
//string ls_error, ls_sintaxis
//
////ls_sintaxis = ads_objeto.Describe("datawindow.syntax")
////li_rc = adw_objeto.Create(ls_sintaxis, ls_error)
//li_num_columnas = integer(ads_objeto.Describe("DataWindow.Column.Count"))
//
//adw_objeto.object.data[1,1,ads_objeto.rowcount(),li_num_columnas] = ads_objeto.object.data[1,1,ads_objeto.rowcount(),li_num_columnas]

RETURN of_copiar(ads_objeto, adw_objeto, FALSE)
end function

public function integer of_copiar (n_ds adw_objeto, ref n_ds ads_objeto);int li_rc, li_num_columnas
string ls_error, ls_sintaxis

IF IsValid(ads_objeto) THEN DESTROY ads_objeto

ads_objeto = CREATE n_ds
ls_sintaxis = adw_objeto.Describe("datawindow.syntax")
li_rc = ads_objeto.Create(ls_sintaxis, ls_error)
li_num_columnas = integer(adw_objeto.Describe("DataWindow.Column.Count"))

IF adw_objeto.Rowcount() > 0 THEN
	ads_objeto.object.data[1,1,adw_objeto.rowcount(),li_num_columnas] = adw_objeto.object.data[1,1,adw_objeto.rowcount(),li_num_columnas]
END IF

RETURN li_rc
end function

public function integer of_copiar (n_ds ads_objeto, ref u_dw adw_objeto, boolean ab_regenerar);int li_rc, li_num_columnas
string ls_error, ls_sintaxis

IF ab_regenerar THEN
	ls_sintaxis = ads_objeto.Describe("datawindow.syntax")
	li_rc = adw_objeto.Create(ls_sintaxis, ls_error)
END IF

li_num_columnas = integer(ads_objeto.Describe("DataWindow.Column.Count"))

IF ads_objeto.rowcount() > 0 THEN
	adw_objeto.object.data[1,1,ads_objeto.rowcount(),li_num_columnas] = ads_objeto.object.data[1,1,ads_objeto.rowcount(),li_num_columnas]
END IF

RETURN li_rc
end function

on u_agrupador_columnas.create
int iCurrent
call super::create
this.st_leyenda=create st_leyenda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_leyenda
end on

on u_agrupador_columnas.destroy
call super::destroy
destroy(this.st_leyenda)
end on

event constructor;call super::constructor;//------------------------------------------------------------------
//  MODULO/FUNCION	: Constructor
//
//  LEEME		:	VEA LA FUNCION of_ayuda() para m$$HEX1$$e100$$ENDHEX$$s informaci$$HEX1$$f300$$ENDHEX$$n
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

//Activa el servicio del Resize
of_SetResize( TRUE )

//Registra el Texto
inv_resize.of_Register( st_leyenda, 0, 0, 100, 100 )

//Inicializa la variable de ventana padre
of_getparentwindow(iw_parent)

//Asigna esquema de colores por default
of_AsignaColor(GRIS)

post event ue_post_constructor()
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

//Quita los Grupos del control
of_RemoverTodos()

//Desasigna las variables
is_syntax_parte1 = gs_nulo
is_syntax_parte2 = gs_nulo
is_syntax_original = gs_nulo
is_columna_nueva = gs_nulo
is_sort_original = gs_nulo

////Inicializa el datawindow padre
//idw_control.dataobject = idw_control.dataobject
//
////Si tiene un objeto transaccion valido.. asignado mediante of_SetTransObject
//IF IsValid(idw_control.itr_object) THEN
//	//Pobla de nuevo con datos
//	idw_control.of_SetTransObject(idw_control.itr_object)
//	idw_control.event pfc_Retrieve()
//ELSE
//	messagebox(gs_nombreapp,"No se encontr$$HEX2$$f3002000$$ENDHEX$$objeto de transacci$$HEX1$$f300$$ENDHEX$$n para cargar datos",information!)
//END IF
//LEC20100803
IF IsValid(ids_backup) THEN 
	of_Copiar(ids_backup, idw_control, TRUE)
	DESTROY ids_backup
END IF

//Destruye el respaldo de datos
IF IsValid(ids_data) THEN DESTROY ids_data



end event

event dragdrop;call super::dragdrop;//------------------------------------------------------------------
//  MODULO/FUNCION	: dragdrop
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
DataWindow	ldw_control
integer li_cont
string ls_campo, ls_nombre, ls_columna
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//Si el objeto origen no es un dw no hace nada
IF TypeOf (source) <> DataWindow! THEN RETURN

//Obtiene el datawindow
ldw_control = source

//Compara que el Datawindow Origen sea el mismo que esta asignado al control
if ldw_control.ClassName() = idw_control.ClassName() then
	
	//Lee la variable de control (Tal vez ya no sea necesario)
	ls_columna = of_ObtieneColumnaNueva()
	
	//Si no se asigno columna...
	IF isnull(ls_columna) THEN
		messagebox(gs_nombreapp,"Debe asignar la columna de paso",exclamation!)
		RETURN
	END IF
	
	//La columna debe estar en el formato NombreColumna_t
	//Para asi obtener el titulo y nombre de la columna
	ls_campo = left(ls_columna,len(ls_columna)-2)
	ls_nombre = ldw_control.describe(ls_columna+".text")
	
	//Agrega la referencia del Grupo al Control
	of_AgregaGrupo(ls_campo, ls_nombre)
	
	//Limpia la variable de columna
	of_AsignaColumnaNueva(gs_nulo)
	

	idw_control.DragIcon = ''
end if




end event

event resize;call super::resize;//------------------------------------------------------------------
//  MODULO/FUNCION	: resize
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

//Ajusta los Agrupadores del Datawindow Padre
of_AjustaColumnas()

//Acomoda los grupos del control
of_OrganizarGrupos()
end event

type st_leyenda from statictext within u_agrupador_columnas
event lbuttondown pbm_lbuttondown
integer x = 27
integer y = 28
integer width = 1906
integer height = 64
string dragicon = "Menu5!"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 134217745
long backcolor = 67108864
string text = "Arrastre hasta aqu$$HEX2$$ed002000$$ENDHEX$$el t$$HEX1$$ed00$$ENDHEX$$tulo de la columna para agrupar los elementos por ese criterio."
boolean focusrectangle = false
end type

event lbuttondown;
parent.event lbuttondown(flags, xpos, ypos)
end event

event dragdrop;

parent.event DragDrop(source)
end event


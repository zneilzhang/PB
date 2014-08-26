HA$PBExportHeader$w_permisos.srw
forward
global type w_permisos from w_main
end type
type dw_permisos from u_dw within w_permisos
end type
type tv_1 from u_tvs within w_permisos
end type
type dw_niveles from u_dw within w_permisos
end type
end forward

global type w_permisos from w_main
integer width = 4032
boolean toolbarvisible = false
dw_permisos dw_permisos
tv_1 tv_1
dw_niveles dw_niveles
end type
global w_permisos w_permisos

type variables
n_ds ids_menu
long il_nivel_usuario
end variables

forward prototypes
public function integer of_inicializar ()
end prototypes

public function integer of_inicializar ();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_row, ll_row_find, ll_row_ini, ll_row_fin, ll_handle
n_ds  lds_temp
integer li_rtn, li_index
string ls_nombre, ls_imagen
m_apppfc_frame lm_menu
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ids_menu = CREATE n_ds
ids_menu.dataobject = 'd_ex_gr_menu'

lm_menu = CREATE m_apppfc_frame

ll_row = ids_menu.InsertRow(0)
ids_menu.Object.nombre[ll_row] 			 = lm_menu.classname()
ids_menu.Object.nivel[ll_row] 			    = 1
ids_menu.Object.orden[ll_row] 			    = 1
ids_menu.Object.texto[ll_row] 			    = 'Men$$HEX1$$fa00$$ENDHEX$$'
ids_menu.Object.ind_visible[ll_row] 	    = 1
ids_menu.Object.ind_habilitado[ll_row]   = 0

li_rtn = gf_desglose_menu(lm_menu, 1, 1, ids_menu)

ids_menu.SetFilter("ind_visible = 1")
ids_menu.Filter()
ids_menu.Sort()

lds_temp = CREATE n_ds
lds_temp.dataobject = ids_menu.dataobject
ids_menu.RowsCopy(1, ids_menu.RowCount(), Primary!, lds_temp, 1, Primary!)

//Filtra los menus que no vamos a asignarles permisos
lds_temp.SetFilter("nivel = 2 and nombre in ('m_file', 'm_edit', 'm_view', 'm_insert', 'm_window', 'm_help' )	")
lds_temp.Filter()

IF lds_temp.RowCount() = 0 THEN RETURN 0

//Elimina del dw los men$$HEX1$$fa00$$ENDHEX$$s que no se utilizan
FOR li_index = 1 TO lds_temp.RowCount()
	ll_row_ini = ids_menu.Find("nombre = '" + lds_temp.object.nombre[li_index] + "'", 1, ids_menu.RowCount())
	ll_row_fin = ids_menu.Find("nivel <= " + string(ids_menu.object.nivel[ll_row_ini]) , ll_row_ini + 1, ids_menu.RowCount())	 - 1
	
	IF ll_row_fin <= 0 THEN ll_row_fin = ids_menu.RowCount()
	
	ids_menu.RowsMove(ll_row_ini, ll_row_fin, Primary!, ids_menu, ids_menu.DeletedCount() + 1, Delete!)
		
NEXT

//ids_menu.SaveAs("C:\lec_permisos.xls",excel!, true)

tv_1.event ue_cargar(0,	0,	"")

tv_1.ExpandAll(1)
ll_handle = tv_1.FindItem ( RootTreeItem!	, 0 )
tv_1.SelectItem ( ll_handle )

dw_niveles.Retrieve()

DESTROY lds_temp
DESTROY lm_menu

RETURN 1
end function

on w_permisos.create
int iCurrent
call super::create
this.dw_permisos=create dw_permisos
this.tv_1=create tv_1
this.dw_niveles=create dw_niveles
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_permisos
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.dw_niveles
end on

on w_permisos.destroy
call super::destroy
destroy(this.dw_permisos)
destroy(this.tv_1)
destroy(this.dw_niveles)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//	Habilita el servicio de resize
of_setresize(true)

//	Registra los objetos para el resize (x, y, width, height)
inv_resize.of_Register(dw_niveles, inv_resize.SCALEBOTTOM) 
inv_resize.of_Register(tv_1, inv_resize.SCALERIGHTBOTTOM) 


of_inicializar()
end event

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


//En este evento se define el menu a usar para la ventana
of_setMenu(m_apppfc_catalogo)

m_apppfc_catalogo.m_edit.m_agregar.enabled = FALSE
m_apppfc_catalogo.m_edit.m_borrar.enabled = FALSE
m_apppfc_catalogo.m_edit.m_busqueda.enabled = FALSE

end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

dw_niveles.x = 5
dw_niveles.y = 5

dw_niveles.height = height - dw_niveles.y - 20
tv_1.x = dw_niveles.x + dw_niveles.width + 20
tv_1.y = dw_niveles.y
tv_1.width = width - tv_1.x - 20
tv_1.height = height - tv_1.y - 20
end event

type dw_permisos from u_dw within w_permisos
integer x = 251
integer y = 700
integer width = 1115
integer height = 696
integer taborder = 30
boolean titlebar = true
string dataobject = "d_sq_gr_permisos"
boolean controlmenu = true
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

of_setupdateable(true)

visible = false

SetTransObject(SQLCA)
end event

event pfc_preupdate;call super::pfc_preupdate;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_row

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_row = dw_niveles.getrow()

//Obtiene el nivel actual
il_nivel_usuario = dw_niveles.object.nivel[ll_row]

//Elimina los permisos actuales para el nivel seleccionado
RowsMove(1, RowCount(), Primary!, this, 1, Delete!)

//Carga los permisos
tv_1.event ue_obtiene_menu(1)

RETURN SUCCESS
//RETURN PREVENT_ACTION
end event

event pfc_update;call super::pfc_update;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_row, ll_nivel

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF ancestorreturnvalue <> 1 THEN RETURN ancestorreturnvalue

//ll_row = dw_niveles.getrow()
//
////Obtiene el nivel actual
//ll_nivel = dw_niveles.object.nivel[ll_row]
//
//IF ll_nivel = gi_nivel THEN
//	//Carga los permisos para el nivel de usuario
//	gw_frame.of_CargaPermisosNivel(gi_nivel)
//END IF

RETURN SUCCESS
end event

type tv_1 from u_tvs within w_permisos
event ue_cargar ( long al_handle,  integer ai_nivel,  string as_padre )
event ue_marca_subitem ( long al_parent,  integer ai_status )
event ue_carga_permisos ( long al_padre )
event type integer ue_obtiene_menu ( long al_padre )
integer x = 1614
integer width = 2423
integer height = 1612
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
boolean checkboxes = true
end type

event ue_cargar(long al_handle, integer ai_nivel, string as_padre);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
treeviewitem ltvi_item
long 		ll_row, ll_handle, ll_item, ll_pos, ll_imgindex
string ls_valores, lsarr_valores[]
n_ds lds_temp
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF al_handle = 0 THEN
	If FindItem(RootTreeItem!,0) < 0 Then
		ll_row = ids_menu.Find("nivel = 1",1, ids_menu.RowCount())
		
		ll_imgindex = ids_menu.object.imgindex[ll_row]
		
		ltvi_item.Data		=	Classname(this)
		
		IF ll_imgindex > 0 THEN
			ltvi_item.PictureIndex = ll_imgindex
			ltvi_item.SelectedPictureIndex = ll_imgindex
		END IF
		
		ltvi_item.Label	=	gnv_funciones_string.of_globalReplace(ids_menu.object.texto[ll_row],"&","")
		
		ll_handle	=	InsertItemFirst ( 0, ltvi_item )
		
		event ue_cargar(ll_handle, 2, ids_menu.object.nombre[ll_row])
	End If
ELSE
	ll_item = 1
	
	lds_temp = CREATE n_ds
	lds_temp.dataobject = ids_menu.dataobject
	
	ids_menu.RowsCopy(1, ids_menu.RowCount(), Primary!, lds_temp, 1, Primary!)
	
	lds_temp.SetFilter("padre = '" + as_padre + "'")
	lds_temp.Filter()
	lds_temp.Sort()
	
	
	FOR ll_row = 1 TO lds_temp.RowCount()
		ll_imgindex 							= lds_temp.object.imgindex[ll_row]
		ltvi_item.Data 						= lds_temp.object.nombre[ll_row]
		ltvi_item.Label 						= gnv_funciones_string.of_globalReplace(lds_temp.object.texto[ll_row],"&","") 
		
		IF ll_imgindex > 0 THEN
			ltvi_item.PictureIndex = ll_imgindex
			ltvi_item.SelectedPictureIndex = ll_imgindex
		END IF
		
		ll_item = InsertItem(al_handle, ll_item, ltvi_item)	
		
		event ue_cargar(ll_item, ai_nivel + 1, lds_temp.object.nombre[ll_row])
		
	NEXT
	
	DESTROY lds_temp
	
END IF


RETURN 
end event

event ue_marca_subitem(long al_parent, integer ai_status);///////////////////////////////////////////////////////////////////////////
//
// Objetivo	:	Marca o desmarca las opciones que est$$HEX1$$e100$$ENDHEX$$n dentro del Item
//					que se est$$HEX2$$e1002000$$ENDHEX$$marcando o desmarcando
//
//	Fecha			Modifico		Descripcion
//	-------		--------		------------------------------------------------
//	05May04		EGC			Creacion
//
///////////////////////////////////////////////////////////////////////////

TreeViewItem	ltvi_item
Long				ll_handle


//Marca o desmarca los que est$$HEX1$$e100$$ENDHEX$$n dentro del Item
ll_handle	=	FindItem ( ChildTreeItem!, al_parent )
Do While ll_handle <> -1
	GetItem(ll_handle, ltvi_item)
	ltvi_item.StatePictureIndex = ai_status
	SetItem( ll_handle, ltvi_item )
	event ue_marca_subitem(ll_handle,ai_status)
	ll_handle	=	FindItem ( NextTreeItem! , ll_handle )
Loop




end event

event ue_carga_permisos(long al_padre);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
TreeViewItem	ltvi_item 
Long ll_hijo
String ls_data

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if al_padre = 0 then return

//Marca o desmarca los que est$$HEX1$$e100$$ENDHEX$$n dentro del Item
ll_hijo	=	FindItem ( ChildTreeItem!, al_padre )
Do While ll_hijo <> -1
	GetItem(ll_hijo, ltvi_item)
	ls_data = string(ltvi_item.data)
	
	if dw_permisos.find("menu = '"+ls_data+"'",1,dw_permisos.rowcount()) > 0 then
		ltvi_item.StatePictureIndex = 2
	else
		ltvi_item.StatePictureIndex = 1
	end if
	
	SetItem( ll_hijo, ltvi_item )

	event ue_carga_permisos(ll_hijo)
	ll_hijo	=	FindItem ( NextTreeItem! , ll_hijo )
Loop





end event

event type integer ue_obtiene_menu(long al_padre);//------------------------------------------------------------------
//  FUNCION/EVENTO	: ue_obtiene_menu
//
//  DESCRIPCION		: Llena el dw de los permisos de usuario con los items seleccionados
//
//  ARGUMENTOS			: 
//			al_padre		:	Handle del nodo padre
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
TreeViewItem	ltvi_item
Long				ll_hijo, ll_handle, ll_row
String			ls_opcion, ls_menu, ls_label, ls_data
integer			li_nivel
n_ds				lds_nivel

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if al_padre = 0 then return 1

//Marca o desmarca los que est$$HEX1$$e100$$ENDHEX$$n dentro del Item
ll_hijo	=	FindItem ( ChildTreeItem!, al_padre )
Do While ll_hijo <> -1
	GetItem(ll_hijo, ltvi_item)
	li_nivel = ltvi_item.level
	ls_label = ltvi_item.label
	ls_data = string(ltvi_item.data)

	//...si esta seleccionado el nodo
	if ltvi_item.StatePictureIndex = 2 then
		ll_row = dw_permisos.InsertRow(0)
		dw_permisos.object.sistema[ll_row] = gs_sistema
		dw_permisos.object.nivel[ll_row] = il_nivel_usuario
		dw_permisos.object.menu[ll_row] = ls_data
	end if

	event ue_obtiene_menu(ll_hijo) 
	ll_hijo	=	FindItem ( NextTreeItem! , ll_hijo )
Loop

return 1




end event

event clicked;call super::clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF handle = 0 THEN RETURN

//Inserta un renglon activar cambios pendientes
dw_permisos.insertrow(0)
dw_permisos.object.nivel[1] = 999
This.SelectItem ( handle )
This.Event Post  Selectionchanged (0,handle)







end event

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Habilita los servicios para el manejo del TV
of_setbase(True)
of_setprint(True)
of_setlevelsource(True)
ib_rmbmenu = FALSE
end event

event selectionchanged;call super::selectionchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
TreeViewItem	ltvi_current
Long				ll_handle, ll_childhandle, ll_status
String			ls_opcion
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


ll_handle	=	This.FindItem ( CurrentTreeItem!, 0 )

This.GetItem(ll_handle, ltvi_current)
ll_status	=	ltvi_current.StatePictureIndex


////Marca los que est$$HEX1$$e100$$ENDHEX$$n dentro del Item
event ue_marca_subitem(ll_handle,ll_status)
//Marca o desmarca los que est$$HEX1$$e100$$ENDHEX$$n dentro del Item


//Si el Item es Marcado, Marca tambien el (los) Parent
If	ltvi_current.StatePictureIndex = 2 Then
	
	ll_handle	=	This.FindItem ( ParentTreeItem!, ll_handle )
	Do While ll_handle <> -1 
		This.GetItem(ll_handle, ltvi_current)
		ltvi_current.StatePictureIndex = 2
		This.SetItem( ll_handle, ltvi_current )
		ll_handle	=	This.FindItem ( ParentTreeItem!, ll_handle )
	Loop
End If

end event

event keydown;call super::keydown;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Long				ll_handle
String			ls_opcion

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

If	keyflags = 0 Then
	If key = KeySpaceBar! Then
		ll_handle	=	This.FindItem ( CurrentTreeItem!, 0 )

		This.Event Post  Selectionchanged (0,ll_handle)
	End If
End If
end event

type dw_niveles from u_dw within w_permisos
integer width = 1591
integer height = 1612
integer taborder = 10
string dataobject = "d_sq_gr_nivel_usuario"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_nivel
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF currentrow > 0 THEN
	ll_nivel = object.nivel[currentrow]
	dw_permisos.Retrieve(gs_sistema, ll_nivel)
	tv_1.event ue_carga_permisos(1)
END IF
end event

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_sql
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_rmbmenu = false
of_setupdateable(false)

settransobject(SQLCA)

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

//retrieve()

Modify("Destroy cat_agregar")
Modify("Destroy cat_agregar_t")
Modify("Destroy cat_modificar")
Modify("Destroy cat_modificar_t")
Modify("Destroy cat_eliminar")
Modify("Destroy cat_eliminar_t")

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


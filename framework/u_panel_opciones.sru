HA$PBExportHeader$u_panel_opciones.sru
forward
global type u_panel_opciones from u_base
end type
type tv_1 from u_tvs within u_panel_opciones
end type
end forward

global type u_panel_opciones from u_base
integer width = 709
event postconstructor ( )
tv_1 tv_1
end type
global u_panel_opciones u_panel_opciones

type variables

n_ds ids_menu
m_apppfc_frame im_menu
end variables

forward prototypes
public function integer of_menuclicked (menu am_menu, string as_opcion)
public function integer of_inicializar (menu am_menu, n_ds ads_opciones)
end prototypes

event postconstructor();
tv_1.width = width
tv_1.height = height
end event

public function integer of_menuclicked (menu am_menu, string as_opcion);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_EKMenuClicked
//
//  DESCRIPCION		: Asigna las opciones a la barra de herramientas
//
//  ARGUMENTOS			: 
//		am_menu			: nombre del menu
//		
//  DEVUELVE			:
//		  0	: 	No pasa nada
//		  1   :  Todo bien
//		
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  14/JUL/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------


string	ls_menu, ls_texto, ls_imagen 
boolean  lb_visible, lb_enabled
long ll_row, ll_item, ll_total_items, ll_rc

menu	lmarr_items[], lm_menu, lm_padre

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT IsValid(am_menu) THEN RETURN 0

lmarr_items = am_menu.item[]

ll_total_items = upperbound(lmarr_items)

IF ll_total_items = 0 THEN RETURN 0

ll_rc = 0

FOR ll_item = 1 TO ll_total_items
	
	lm_menu    = lmarr_items[ll_item]
	
	IF NOT IsValid(lm_menu) THEN RETURN 0
	
	ls_menu = lmarr_items[ll_item].classname()
	
	IF ls_menu = as_opcion THEN
		lmarr_items[ll_item].event Clicked()
		ll_rc = 1
		EXIT
	ELSE
		ll_rc = of_MenuClicked(lm_menu, as_opcion)
		IF ll_rc <> 0 THEN EXIT
	END IF
		
NEXT

RETURN ll_rc

end function

public function integer of_inicializar (menu am_menu, n_ds ads_opciones);
long ll_handle, ll_row
integer li_index
string ls_imagen

ids_menu = CREATE n_ds
ids_menu.dataobject = ads_opciones.dataobject
ids_menu.SetSort("orden")
ads_opciones.RowsCopy(1, ads_opciones.RowCount(), Primary!, ids_menu, 1, Primary!)

im_menu = am_menu

FOR ll_row = 1 TO ids_menu.RowCount()
	ls_imagen = ids_menu.object.imagen[ll_row]
	
	IF NOT isnull(ls_imagen) THEN 
		li_index = tv_1.AddPicture(ls_imagen)
		ids_menu.object.imgindex[ll_row] = li_index
	END IF
	
NEXT

tv_1.event ue_cargar(0,	0,	"")

tv_1.ExpandAll(1)
ll_handle = tv_1.FindItem ( RootTreeItem!	, 0 )
tv_1.SelectItem ( ll_handle )

RETURN 1
end function

on u_panel_opciones.create
int iCurrent
call super::create
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tv_1
end on

on u_panel_opciones.destroy
call super::destroy
destroy(this.tv_1)
end on

event constructor;call super::constructor;
of_setResize(TRUE)

inv_resize.of_register(tv_1,inv_resize.SCALERIGHTBOTTOM)

post event postconstructor()
end event

type tv_1 from u_tvs within u_panel_opciones
event ue_arma_arbol ( long al_padre )
event ue_cargar ( long al_handle,  integer ai_nivel,  string as_padre )
integer width = 704
integer height = 736
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Calibri"
boolean linesatroot = true
boolean trackselect = true
end type

event ue_arma_arbol(long al_padre);//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String		ls_sql
Integer	li_rc
Long		ll_hijo

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//No muestra el men$$HEX2$$fa002000$$ENDHEX$$contextual
ib_rmbmenu = False

li_rc = inv_levelsource.of_Register(1, "texto", "", ids_menu, "")
inv_levelsource.of_SetPictureColumn(1, "1")
inv_levelsource.of_SetSelectedPictureColumn(1, "2")

//inv_levelsource.of_Register(2, "texto", ":parent.1.dept_id", "d_empbydept", SQLCA, "")
li_rc = inv_levelsource.of_Register(2, "texto", "", ids_menu, "padre = ':parent.1.nombre'")
inv_levelsource.of_SetPictureColumn(2, "4")
inv_levelsource.of_SetSelectedPictureColumn (2, "5")
//
//li_rc = inv_levelsource.of_Register(3, "texto", "", ids_menu, "padre = :parent.2.nombre and nivel = 4")
//inv_levelsource.of_SetPictureColumn(2, "4")
//inv_levelsource.of_SetSelectedPictureColumn (2, "5")



////////////////////////////////////////////////////////////////////////////////////////////////////////
////Nivel 1 (RUBA)
////////////////////////////////////////////////////////////////////////////////////////////////////////
//ls_sql = "Select 'Grupo Ruba' as descripcion From dummy"
//
//li_rc = inv_levelsource.of_Register(1, "descripcion", "", Sqlca, ls_sql,"")
//If li_rc <> 1 Then 
//	MessageBox(gs_nombreapp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error (" + String(li_rc) + ") al armar el nivel 1.", Exclamation!)
//End If
//
//inv_levelsource.of_SetPictureColumn(1, "1")
//inv_levelsource.of_SetSelectedPictureColumn(1, "1")
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
////Nivel 2 (PLAZA)
////////////////////////////////////////////////////////////////////////////////////////////////////////
////ls_sql = 	"Select id_identificador, descripcion, valor = id_identificador From px_so_identificador_cc " + &
////			"Where  ind_plaza = 1 Order By 1"
//ls_sql = "SELECT p.id_identificador, p.descripcion, valor = p.id_identificador FROM px_so_identificador_cc p INNER JOIN scc_tmp_usuario_plaza su ON p.id_identificador = su.id_identificador AND su.id_spid = @@spid  Order By 1"
//
//li_rc = inv_levelsource.of_Register(2, "descripcion", "", Sqlca, ls_sql,"")
//If li_rc <> 1 Then 
//	MessageBox(gs_nombreapp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error (" + String(li_rc) + ") al armar el nivel 2.", Exclamation!)
//End If
//
//inv_levelsource.of_SetPictureColumn(2, "2")
//inv_levelsource.of_SetSelectedPictureColumn(2, "2")
//
////////////////////////////////////////////////////////////////////////////////////////////////////////
////Nivel 3 (PROYECTO)
////////////////////////////////////////////////////////////////////////////////////////////////////////
//li_rc = inv_levelsource.of_Register(3, "descripcion", ":parent.1.id_identificador", "d_nivel_plaza_terreno", Sqlca, "")
//If li_rc <> 1 Then 
//	MessageBox(gs_nombreapp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error (" + String(li_rc) + ") al armar el nivel 3.", Exclamation!)
//End If
//
//inv_levelsource.of_SetPictureColumn(3, "3")
//inv_levelsource.of_SetSelectedPictureColumn(3, "3")
//
//parent.setredraw(False)
//
//Limpia el tv
DeleteItem(FindItem(RootTreeItem!, 0))

Event pfc_populate(0) 

//Expande todo el $$HEX1$$e100$$ENDHEX$$rbol para que se poble de hijos
expandall(FindItem(RootTreeItem!, 0))

////Contrae hasta el segundo nivel
//ll_hijo = FindItem(childtreeitem!, FindItem(RootTreeItem!, 0))
//
//Do While ll_hijo <> -1
//	collapseitem(ll_hijo)
//	ll_hijo = FindItem(nexttreeitem!, ll_hijo)
//Loop

//Scrollea al primer nodo
SetFirstVisible(findItem(RootTreeItem! , 0))

Parent.SetReDraw(True)


end event

event ue_cargar(long al_handle, integer ai_nivel, string as_padre);treeviewitem ltvi_item
long 		ll_row, ll_handle, ll_item, ll_pos, ll_imgindex
string ls_valores, lsarr_valores[]
n_ds lds_temp

IF al_handle = 0 THEN
	If FindItem(RootTreeItem!,0) < 0 Then
		ll_row = ids_menu.Find("nivel = 2",1, ids_menu.RowCount())
		
		ll_imgindex = ids_menu.object.imgindex[ll_row]
		
		ltvi_item.Data		=	Classname(this)
		
		IF ll_imgindex > 0 THEN
			ltvi_item.PictureIndex = ll_imgindex
			ltvi_item.SelectedPictureIndex = ll_imgindex
		END IF
		
		ltvi_item.Label	=	gnv_funciones_string.of_globalReplace(ids_menu.object.texto[ll_row],"&","")
		
		ll_handle	=	InsertItemFirst ( 0, ltvi_item )
		
		event ue_cargar(ll_handle, 3, ids_menu.object.nombre[ll_row])
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
		IF lds_temp.object.texto[ll_row] = "-" THEN CONTINUE
		
		ll_imgindex 							= lds_temp.object.imgindex[ll_row]
		ltvi_item.Data 						= lds_temp.object.nombre[ll_row]
		ltvi_item.Label 						= gnv_funciones_string.of_globalReplace(lds_temp.object.texto[ll_row],"&","") 
		
//		IF ll_imgindex > 0 THEN
		ltvi_item.PictureIndex = ll_imgindex
		ltvi_item.SelectedPictureIndex = ll_imgindex
//		END IF
		
		ll_item = InsertItem(al_handle, ll_item, ltvi_item)	
		
		event ue_cargar(ll_item, ai_nivel + 1, lds_temp.object.nombre[ll_row])
		
	NEXT
	
	DESTROY lds_temp
	
END IF


RETURN 
end event

event constructor;call super::constructor;//Habilita los servicios para el manejo del TV
of_setbase(True)
of_setprint(True)
of_setlevelsource(True)
ib_rmbmenu = FALSE
end event

event pfc_retrieve;call super::pfc_retrieve;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Any 			la_args[20]
Integer 		li_level, li_rc

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
If IsValid(inv_levelsource) Then
	li_level = of_GetNextLevel(al_parent)
	inv_levelsource.of_GetArgs(al_parent, li_level, la_args)
End If

li_rc = of_Retrieve(al_parent, la_args, ads_data)
Return li_rc
end event

event clicked;call super::clicked;This.SelectItem ( handle )

This.Event Post  Selectionchanged (0,handle)





end event

event selectionchanged;call super::selectionchanged;TreeViewItem	ltvi_current
String			ls_opcion_menu
long ll_handle

ll_handle	=	This.FindItem ( CurrentTreeItem!, 0 )

This.GetItem(ll_handle, ltvi_current)

IF ltvi_current.level > 1 THEN 
	ls_opcion_menu = ltvi_current.data
	
	of_menuClicked(gw_frame.menuid, ls_opcion_menu)
END IF


end event


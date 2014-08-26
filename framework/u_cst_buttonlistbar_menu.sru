HA$PBExportHeader$u_cst_buttonlistbar_menu.sru
forward
global type u_cst_buttonlistbar_menu from u_cst_buttonlistbar
end type
end forward

global type u_cst_buttonlistbar_menu from u_cst_buttonlistbar
end type
global u_cst_buttonlistbar_menu u_cst_buttonlistbar_menu

type variables

n_ds ids_menu
m_apppfc_frame im_menu
end variables

forward prototypes
public function integer of_menuclicked (menu am_menu, string as_opcion)
public function integer of_inicializar (menu am_menu, n_ds ads_opciones)
end prototypes

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
long ll_row
string ls_imagen, ls_nombre, ls_texto

ids_menu = CREATE n_ds
ids_menu.dataobject = ads_opciones.dataobject
ids_menu.SetSort("orden")
ads_opciones.RowsCopy(1, ads_opciones.RowCount(), Primary!, ids_menu, 1, Primary!)

im_menu = am_menu

//Omite el titulo
FOR ll_row = 2 TO ids_menu.RowCount()
	ls_nombre = ids_menu.object.nombre[ll_row]
	ls_texto = ids_menu.object.texto[ll_row]
	IF ls_texto = "-" THEN CONTINUE
	ls_imagen = ids_menu.object.imagen[ll_row]
	
	of_AddItem(ls_texto, ls_imagen, ls_nombre)
		
NEXT

of_setTheme(gs_temaactual)
RETURN 1
end function

event selectionchanged;call super::selectionchanged;
String ls_opcion_menu

IF newindex > 0 THEN
	ls_opcion_menu = string(of_getData(newindex))
	of_menuClicked(gw_frame.menuid, ls_opcion_menu)
END IF


end event

on u_cst_buttonlistbar_menu.create
call super::create
end on

on u_cst_buttonlistbar_menu.destroy
call super::destroy
end on

event constructor;call super::constructor;
il_CurrentOrientation = VERTICAL
end event

type uo_scrolldown from u_cst_buttonlistbar`uo_scrolldown within u_cst_buttonlistbar_menu
end type

type uo_scrollup from u_cst_buttonlistbar`uo_scrollup within u_cst_buttonlistbar_menu
end type

type lv_imagelistlarge from u_cst_buttonlistbar`lv_imagelistlarge within u_cst_buttonlistbar_menu
end type

type lv_imagelistxlarge from u_cst_buttonlistbar`lv_imagelistxlarge within u_cst_buttonlistbar_menu
end type

type lv_imagelistmedium from u_cst_buttonlistbar`lv_imagelistmedium within u_cst_buttonlistbar_menu
end type

type lv_imagelistsmall from u_cst_buttonlistbar`lv_imagelistsmall within u_cst_buttonlistbar_menu
end type

type st_buttonlistbarlabel from u_cst_buttonlistbar`st_buttonlistbarlabel within u_cst_buttonlistbar_menu
end type

event st_buttonlistbarlabel::constructor;call super::constructor;of_SetSize(XLARGE)
end event


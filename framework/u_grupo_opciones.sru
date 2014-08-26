HA$PBExportHeader$u_grupo_opciones.sru
forward
global type u_grupo_opciones from u_base
end type
type st_texto from statictext within u_grupo_opciones
end type
type cb_cancelar from commandbutton within u_grupo_opciones
end type
type cb_aceptar from commandbutton within u_grupo_opciones
end type
type lv_listado from u_lvs within u_grupo_opciones
end type
end forward

global type u_grupo_opciones from u_base
accessiblerole accessiblerole = pushbuttonrole!
integer width = 850
integer height = 844
event losefocus pbm_bnkillfocus
event lbuttondown pbm_lbuttondown
event ue_post_constructor ( )
st_texto st_texto
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
lv_listado lv_listado
end type
global u_grupo_opciones u_grupo_opciones

type variables

window iw_parent
window iw_popup
u_grupo iuo_grupo


boolean ib_listfocus = false
boolean ib_aceptarfocus = false
boolean ib_cancelarfocus = false
boolean ib_textofocus = false

string is_columna

st_grupo ist_info
end variables

forward prototypes
public function integer of_setparent (u_grupo auo_padre)
public function integer of_setparentwindow (window aw_window)
public function integer of_cargadatos (n_ds ads_datos)
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

//Si ning$$HEX1$$fa00$$ENDHEX$$n control dentro del objeto tiene el foco se sale
IF NOT ib_listfocus AND NOT ib_aceptarfocus AND NOT ib_cancelarfocus AND NOT ib_textofocus THEN
	cb_cancelar.event clicked()
END IF
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

st_texto.SetFocus()


end event

event ue_post_constructor();////------------------------------------------------------------------
////  MODULO/FUNCION	: ue_post_constructor
////
////  FECHA    	AUTOR    DESCRIPCION
////------------------------------------------------------------------
////  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
////------------------------------------------------------------------
////------------------------------------------------------------------
//// DECLARACIONES LOCALES
////------------------------------------------------------------------
//n_ds lds_datos
//string ls_columna, ls_valor
//integer li_item, li_total_items, li_total_valores, li_index
//listviewitem lvi_data
//
////------------------------------------------------------------------
//// CODIGO DE LA RUTINA
////------------------------------------------------------------------
//
////Obtiene datastore con datos del filtro
//lds_datos = message.powerobjectparm
//
////Asigna variables de control
//ist_info = iuo_grupo.ist_informacion
//ls_columna = ist_info.columna
//
////Llena el listado
//lv_listado.inv_datasource.of_Register(ls_columna, lds_datos)
//lv_listado.Event pfc_Populate()
//
//li_total_items = lv_listado.TotalItems()
//
//li_total_valores = UpperBound(ist_info.valores)
//
////Marca solo los valores por los que este filtrado
//IF li_total_valores = 0 THEN
//	FOR li_item = 1 TO li_total_items
//		lv_listado.GetItem(li_item,lvi_data)
//		
//		ls_valor = lvi_data.label
//		IF LEN(TRIM(ls_valor)) = 0 THEN lvi_data.label = '(Vac$$HEX1$$ed00$$ENDHEX$$o o Nulo)'
//		
//		lvi_data.StatePictureIndex = 2
//		lv_listado.SetItem(li_item,lvi_data)
//	NEXT
//ELSE
//	
//	FOR li_index = 1 TO li_total_valores
//
//		li_item = lv_listado.FindItem(0,ist_info.valores[li_index], TRUE,TRUE)
//		
//		IF li_item > 0 THEN
//			lv_listado.GetItem(li_item,lvi_data)
//			lvi_data.StatePictureIndex = 2
//			lv_listado.SetItem(li_item,lvi_data)	
//		END IF
//	NEXt
//	
//	FOR li_item = 1 TO li_total_items
//		lv_listado.GetItem(li_item,lvi_data)
//		ls_valor = lvi_data.label
//		IF LEN(TRIM(ls_valor)) = 0 THEN lvi_data.label = '(Vac$$HEX1$$ed00$$ENDHEX$$o o Nulo)'
//		lv_listado.SetItem(li_item,lvi_data)
//	NEXT
//	
//END IF
//
//
end event

public function integer of_setparent (u_grupo auo_padre);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_SetParent
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

//asigna el objeto padre
iuo_grupo = auo_padre

RETURN 1
end function

public function integer of_setparentwindow (window aw_window);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_SetParentWindow
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

//asigna el objeto padre
iw_parent = aw_window

RETURN 1
end function

public function integer of_cargadatos (n_ds ads_datos);//------------------------------------------------------------------
//  MODULO/FUNCION	: of_CargaDatos
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
n_ds lds_datos
string ls_columna, ls_valor
integer li_item, li_total_items, li_total_valores, li_index
listviewitem lvi_data
long ll_row
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Obtiene datastore con datos del filtro
lds_datos = ads_datos

//Asigna variables de control
ist_info = iuo_grupo.ist_informacion
ls_columna = ist_info.columna

////Llena el listado
//lv_listado.inv_datasource.of_Register(ls_columna, lds_datos)
//lv_listado.Event pfc_Populate()
//LEC20100803
//No se puede usar el lds_datos debido a que no utiliza un dataobject
FOR ll_row = 1 TO lds_datos.RowCount()
	CHOOSE CASE LEFT(UPPER(ist_info.TipoDeDato),4)
		CASE 'CHAR'
			ls_valor = lds_datos.GetItemString(ll_row,ls_columna)
		CASE 'LONG', 'DECI'
			ls_valor = String(lds_datos.GetItemDecimal(ll_row,ls_columna))
		CASE 'DATE'
			ls_valor = String(lds_datos.GetItemDate(ll_row,ls_columna))
	END CHOOSE
	lv_listado.AddItem(ls_valor, 1)
	
NEXT

lv_listado.AddColumn(ls_columna , Center! , 1000)

li_total_items = lv_listado.TotalItems()

li_total_valores = UpperBound(ist_info.valores)

//Marca solo los valores por los que este filtrado
IF li_total_valores = 0 THEN
	FOR li_item = 1 TO li_total_items
		lv_listado.GetItem(li_item,lvi_data)
		
		ls_valor = lvi_data.label
		IF LEN(TRIM(ls_valor)) = 0 THEN lvi_data.label = '(Vac$$HEX1$$ed00$$ENDHEX$$o o Nulo)'
		
		lvi_data.StatePictureIndex = 2
		lv_listado.SetItem(li_item,lvi_data)
	NEXT
ELSE
	
	FOR li_index = 1 TO li_total_valores

		li_item = lv_listado.FindItem(0,ist_info.valores[li_index], TRUE,TRUE)
		
		IF li_item > 0 THEN
			lv_listado.GetItem(li_item,lvi_data)
			lvi_data.StatePictureIndex = 2
			lv_listado.SetItem(li_item,lvi_data)	
		END IF
	NEXt
	
	FOR li_item = 1 TO li_total_items
		lv_listado.GetItem(li_item,lvi_data)
		ls_valor = lvi_data.label
		IF LEN(TRIM(ls_valor)) = 0 THEN lvi_data.label = '(Vac$$HEX1$$ed00$$ENDHEX$$o o Nulo)'
		lv_listado.SetItem(li_item,lvi_data)
	NEXT
	
END IF

of_GetParentWindow(iw_popup)

RETURN 0
end function

on u_grupo_opciones.create
int iCurrent
call super::create
this.st_texto=create st_texto
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.lv_listado=create lv_listado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_texto
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_aceptar
this.Control[iCurrent+4]=this.lv_listado
end on

on u_grupo_opciones.destroy
call super::destroy
destroy(this.st_texto)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.lv_listado)
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

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

of_getparentwindow(iw_parent)

st_texto.SetFocus()

post event ue_post_constructor()


end event

type st_texto from statictext within u_grupo_opciones
integer x = 27
integer y = 8
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Seleccione Filtro"
boolean focusrectangle = false
end type

event losefocus;ib_textofocus = false

parent.post event losefocus()
end event

event getfocus;ib_textofocus = true
end event

type cb_cancelar from commandbutton within u_grupo_opciones
integer x = 489
integer y = 724
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancelar"
end type

event clicked;//------------------------------------------------------------------
//  MODULO/FUNCION	: clicked
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

//Cierra el panel de Opciones
iuo_grupo.of_MuestraOpciones(FALSE)

//iw_popup.Hide()

Close(iw_popup)

end event

event getfocus;ib_cancelarfocus = true


end event

event losefocus;ib_cancelarfocus = false

parent.post event losefocus()
end event

type cb_aceptar from commandbutton within u_grupo_opciones
integer x = 110
integer y = 724
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
end type

event getfocus;ib_aceptarfocus = true
end event

event losefocus;ib_aceptarfocus = false

parent.post event losefocus()
end event

event clicked;//------------------------------------------------------------------
//  MODULO/FUNCION	: clicked
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  04/NOV/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_item, li_total_items, li_index
listviewitem lvi_data
string lsarr_valores[], lsarr_vacio[]

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Obtiene los valores marcados
li_total_items = lv_listado.TotalItems()

FOR li_item = 1 TO li_total_items
	lv_listado.GetItem(li_item,lvi_data)
	IF lvi_data.StatePictureIndex = 2 THEN 
		li_index++
		IF lvi_data.label = '(Vac$$HEX1$$ed00$$ENDHEX$$o o Nulo)' THEN
			lsarr_valores[li_index] = ''
		ELSE
			lsarr_valores[li_index] = lvi_data.label
		END IF
	END IF
NEXT

IF li_total_items = UpperBound(lsarr_valores) THEN 
	lsarr_valores[] = lsarr_vacio[]
END IF

//Genera los filtros del grupo
iuo_grupo.of_AsignaValores(lsarr_valores)

//Cierra el men$$HEX1$$fa00$$ENDHEX$$
cb_cancelar.event clicked()


end event

type lv_listado from u_lvs within u_grupo_opciones
integer x = 14
integer y = 72
integer width = 818
integer height = 636
integer taborder = 10
boolean showheader = false
boolean checkboxes = true
listviewview view = listviewreport!
end type

event pfc_retrieve;call super::pfc_retrieve;Any  la_args[20]

la_args[1] = "windows"    // Retrieval argument
return this.of_Retrieve(la_args, ads_data)

end event

event constructor;call super::constructor;
ib_rmbmenu = false

of_SetDataSource(TRUE)


end event

event losefocus;call super::losefocus;
ib_listfocus = FALSE

parent.post event losefocus()
end event

event getfocus;call super::getfocus;ib_listfocus = true
end event


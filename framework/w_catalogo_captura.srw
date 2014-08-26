HA$PBExportHeader$w_catalogo_captura.srw
forward
global type w_catalogo_captura from w_response
end type
type p_1 from picture within w_catalogo_captura
end type
type cb_2 from commandbutton within w_catalogo_captura
end type
type cb_1 from commandbutton within w_catalogo_captura
end type
type uo_header from u_cst_xpheader within w_catalogo_captura
end type
type tab_1 from tab within w_catalogo_captura
end type
type tabpage_1 from userobject within tab_1
end type
type dw_1 from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_1 dw_1
end type
type tab_1 from tab within w_catalogo_captura
tabpage_1 tabpage_1
end type
end forward

global type w_catalogo_captura from w_response
integer width = 2871
integer height = 1652
string title = "Producto:"
boolean controlmenu = false
long backcolor = 16777215
boolean center = true
p_1 p_1
cb_2 cb_2
cb_1 cb_1
uo_header uo_header
tab_1 tab_1
end type
global w_catalogo_captura w_catalogo_captura

type variables
w_catalogo2 iw_parent
u_dw idw_listado, idw_ficha, idw_puntos_venta
long il_row, il_id
u_dw idw_empleados_puntos_venta
end variables
on w_catalogo_captura.create
int iCurrent
call super::create
this.p_1=create p_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_header=create uo_header
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.uo_header
this.Control[iCurrent+5]=this.tab_1
end on

on w_catalogo_captura.destroy
call super::destroy
destroy(this.p_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_header)
destroy(this.tab_1)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------



IF NOT iw_parent.ib_nuevo THEN 
	idw_ficha.event pfc_retrieve()
ELSE
	idw_ficha.event pfc_addrow()
	il_row = 0
	il_id = 0
END IF

idw_ficha.setfocus()


end event

event pfc_preopen;call super::pfc_preopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_nombre
long  ll_ciudad_id
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

iw_parent = Message.PowerObjectParm

idw_listado = iw_parent.dw_cat_listado

il_row = idw_listado.getrow()
IF il_row > 0 THEN il_id = idw_listado.object.id[il_row]

//Cargar la varible de instancia id con el id del catalogo para el retrieve
//il_id

//Definir el titulo de la ventana y el encabezado
uo_header.of_setTheme(gs_temaactual)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.LEFT)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.RIGHT)
uo_header.of_setText(iw_parent.title, uo_header.LEFT)
uo_header.of_setImage(iw_parent.icon, uo_header.LEFT)
title = iw_parent.title

idw_ficha.setfocus()
end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
p_1.x = tab_1.x + tab_1.width - p_1.width - 20
end event

type p_1 from picture within w_catalogo_captura
integer x = 2725
integer y = 112
integer width = 96
integer height = 84
string picturename = "D:\Documentos\Google Drive\Dev\Proyectos\MiTiendita\pbl\ico\delete.png"
boolean focusrectangle = false
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


end event

type cb_2 from commandbutton within w_catalogo_captura
integer x = 2135
integer y = 1460
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

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rtn
n_ds lds_eliminadas
string ls_nombre
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//	Returns:  integer
//	 1 = success
//	 0 = No pending changes found 
//	-1 = AcceptText error
//	-2 = UpdatesPending error was encountered
//	-3 = Validation error was encountered
// -9 = The pfc_updateprep process failed
//	-4 = The pfc_preupdate process failed
//	-5 = The pfc_begintran process failed
//	-6 = The pfc_update process failed
//	-7 = The pfc_endtran process failed
//	-8 = The pfc_postsave process failed

li_rtn = event pfc_save() 
IF li_rtn < 0 THEN RETURN

lds_eliminadas = CREATE n_ds
lds_eliminadas.dataobject = idw_listado.dataobject
IF il_row > 0 THEN 
	idw_listado.rowsmove(1,idw_listado.deletedcount(),delete!, lds_eliminadas, 1, primary!)
	idw_listado.deleterow(il_row)
ELSE
	il_row = idw_listado.rowcount() + 1
END IF

li_rtn = idw_ficha.rowscopy(1,1,primary!, idw_listado, il_row, primary!)
//idw_listado.setItemStatus(il_row, 0, primary!, notmodified!)
idw_listado.resetUpdate()
IF lds_eliminadas.rowcount() > 0 THEN lds_eliminadas.rowsmove(1,lds_eliminadas.rowcount(),primary!,idw_listado,1,delete!)

iw_parent.event ue_actualizar()


close(parent)
end event

type cb_1 from commandbutton within w_catalogo_captura
integer x = 2510
integer y = 1460
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_disableCloseQuery = TRUE
close(parent)
end event

type uo_header from u_cst_xpheader within w_catalogo_captura
integer width = 2853
end type

on uo_header.destroy
call u_cst_xpheader::destroy
end on

type tab_1 from tab within w_catalogo_captura
integer x = 9
integer y = 112
integer width = 2853
integer height = 1328
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.Control[]={this.tabpage_1}
end on

on tab_1.destroy
destroy(this.tabpage_1)
end on

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2816
integer height = 1212
long backcolor = 79741120
string text = "Generales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_1.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within tabpage_1
integer x = 9
integer y = 16
integer width = 2830
integer height = 1172
integer taborder = 10
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_sql
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

idw_ficha = this

settransObject(SQLCA)
of_setReqColumn(TRUE)
ib_rmbmenu = FALSE

//of_setbloqueascrollff( TRUE)
of_setindicacampoactual( TRUE )

end event

event pfc_retrieve;call super::pfc_retrieve;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_id
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_id = il_id
IF isnull(ll_id) THEN ll_id = 0


RETURN retrieve(il_id)
end event


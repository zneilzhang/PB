HA$PBExportHeader$w_consulta_ventas.srw
forward
global type w_consulta_ventas from w_main
end type
type uo_header from u_cst_xpheader within w_consulta_ventas
end type
type st_1 from statictext within w_consulta_ventas
end type
type dw_consulta from u_dw within w_consulta_ventas
end type
type dw_parametros from u_dw within w_consulta_ventas
end type
type ln_1 from line within w_consulta_ventas
end type
type ln_2 from line within w_consulta_ventas
end type
end forward

global type w_consulta_ventas from w_main
integer width = 3282
string title = "Ventas"
event ue_procesar ( )
uo_header uo_header
st_1 st_1
dw_consulta dw_consulta
dw_parametros dw_parametros
ln_1 ln_1
ln_2 ln_2
end type
global w_consulta_ventas w_consulta_ventas

type variables
n_cst_powerfilter inv_powerfilter 
end variables

event ue_procesar();//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
date ld_fec_ini, ld_fec_fin
string ls_empresa, ls_entidad, ls_producto_financiero
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF dw_parametros.event pfc_acceptText(TRUE) <> 1 THEN RETURN

ld_fec_ini = dw_parametros.object.fecha_ini[1]
ld_fec_fin = dw_parametros.object.fecha_fin[1]

ls_empresa = dw_parametros.object.empresa[1]
ls_producto_financiero = dw_parametros.object.producto_financiero[1]
ls_entidad = dw_parametros.object.entidad[1]

dw_consulta.setSort("fecha_firma ")
dw_consulta.retrieve(ld_fec_ini, ld_fec_fin, ls_empresa, ls_producto_financiero, ls_entidad)
dw_consulta.sort()

//called from menu to toggle powerfilter
inv_powerfilter.ib_checked = TRUE
inv_powerfilter.event ue_clicked()


end event

on w_consulta_ventas.create
int iCurrent
call super::create
this.uo_header=create uo_header
this.st_1=create st_1
this.dw_consulta=create dw_consulta
this.dw_parametros=create dw_parametros
this.ln_1=create ln_1
this.ln_2=create ln_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_header
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_consulta
this.Control[iCurrent+4]=this.dw_parametros
this.Control[iCurrent+5]=this.ln_1
this.Control[iCurrent+6]=this.ln_2
end on

on w_consulta_ventas.destroy
call super::destroy
destroy(this.uo_header)
destroy(this.st_1)
destroy(this.dw_consulta)
destroy(this.dw_parametros)
destroy(this.ln_1)
destroy(this.ln_2)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Inicializa el servicio de resize
of_setresize(true)

//Registra los objetos
inv_resize.of_register(dw_consulta, 0,0,100,100)
end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_header.x = 5
uo_header.width = this.width
uo_header.y = 1

dw_consulta.x = 5
dw_consulta.y = dw_parametros.y + dw_parametros.height + 15
dw_consulta.height = height - dw_consulta.y - 20
dw_consulta.width = width - 20



end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

uo_header.of_setTheme(gs_temaactual)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.LEFT)
uo_header.of_SetTextColor(RGB(255,255,255),uo_header.RIGHT)
uo_header.of_setText(this.title, uo_header.LEFT)
uo_header.of_setImage(this.icon, uo_header.LEFT)
end event

event ue_define_menu;call super::ue_define_menu;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//En este evento se define el menu a usar para la ventana
of_setMenu(m_apppfc_consulta)
end event

event pfc_controlgotfocus;call super::pfc_controlgotfocus;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombredw

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
if not isvalid(m_apppfc_catalogo) then return

m_apppfc_catalogo.m_edit.m_agregar.enabled = false
m_apppfc_catalogo.m_edit.m_borrar.enabled = false

if adrg_control.typeof() <> datawindow! then 

else
	
	ls_nombredw = idw_active.classname( )
	
	//Valida si hay registros
	if idw_active.rowcount() > 0 then m_apppfc_catalogo.m_edit.m_borrar.enabled = true
	
	//Si el servicio de guardacomo est$$HEX2$$e1002000$$ENDHEX$$activado habilita la opci$$HEX1$$f300$$ENDHEX$$n saveas
	m_apppfc_frame.m_file.m_saveas.visible =  idw_active.ib_guardarcomo
	m_apppfc_frame.m_file.m_saveas.enabled =  idw_active.ib_guardarcomo
	m_apppfc_frame.m_file.m_saveas.toolbaritemvisible =  idw_active.ib_guardarcomo
end if

end event

type uo_header from u_cst_xpheader within w_consulta_ventas
integer taborder = 10
end type

on uo_header.destroy
call u_cst_xpheader::destroy
end on

type st_1 from statictext within w_consulta_ventas
integer x = 27
integer y = 124
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Par$$HEX1$$e100$$ENDHEX$$metros"
boolean focusrectangle = false
end type

type dw_consulta from u_dw within w_consulta_ventas
integer x = 23
integer y = 860
integer width = 3154
integer height = 736
integer taborder = 20
string dataobject = "d_brow_detalle"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_setUpdateable(FALSE)
setTransObject(SQLCA)

inv_powerfilter = create n_cst_powerfilter
inv_powerfilter.of_setdw(this)

//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(True)
inv_rowselect.of_SetStyle(inv_rowselect.SINGLE)

of_setguardarcomo(true)

////Servicio de ordenamiento por columnas
//of_setsort(true)
//inv_sort.of_setstyle(inv_sort.dragdrop)
//inv_sort.of_setcolumnheader(true)


end event

event resize;call super::resize;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

if isvalid(inv_powerfilter) then
	inv_powerfilter.event ue_positionbuttons()
END IF
end event

event ue_dwlbuttonup;call super::ue_dwlbuttonup;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//post an event to either reposition the powerfilter buttons or handle a buttonclick. ue_buttonclicked will call ue_positionbuttons
inv_powerfilter.event post ue_buttonclicked(dwo)
end event

type dw_parametros from u_dw within w_consulta_ventas
integer x = 27
integer y = 212
integer width = 3031
integer height = 616
integer taborder = 10
string dataobject = "d_brow_detalle"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;////------------------------------------------------------------------
//// DECLARACIONES LOCALES
////------------------------------------------------------------------
//date ldt_hoy, ldt_fec_ini
//string ls_sql
////------------------------------------------------------------------
//// CODIGO DE LA RUTINA
////------------------------------------------------------------------
//
//of_setUpdateable(FALSE)
//ldt_hoy = date(SQLCA.of_fechaServidor())
//ldt_fec_ini = date("01/"+string(month(ldt_hoy))+"/"+string(year(ldt_hoy)))
//insertrow(0)
//
//ls_sql = "SELECT DISTINCT empresa, empresa FROM ventas ORDER BY empresa"
//inv_dwutil.of_genera_dddw_char("empresa", ls_sql, 2, "NULL|(Todos)", false, SQLCA)
////inv_dwutil.of_propiedades_dddw("empresa", "PercentWidth=150,useasborder=no")
//inv_dwutil.of_setvisible_child( "empresa", "1", false, true)
//
//ls_sql = "SELECT DISTINCT producto_financiero, producto_financiero FROM ventas ORDER BY producto_financiero"
//inv_dwutil.of_genera_dddw_char("producto_financiero", ls_sql, 2, "NULL|(Todos)", false, SQLCA)
//inv_dwutil.of_setvisible_child( "producto_financiero", "1", false, true)
//
//ls_sql = "SELECT DISTINCT entidad, entidad FROM ventas ORDER BY entidad"
//inv_dwutil.of_genera_dddw_char("entidad", ls_sql, 2, "NULL|(Todos)", false, SQLCA)
//inv_dwutil.of_setvisible_child( "entidad", "1", false, true)
//
//object.fecha_ini[1] = ldt_fec_ini
//object.fecha_fin[1] = ldt_hoy
//
end event

event itemchanged;call super::itemchanged;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------




end event

type ln_1 from line within w_consulta_ventas
long linecolor = 12632256
integer linethickness = 4
integer beginx = 41
integer beginy = 188
integer endx = 1902
integer endy = 188
end type

type ln_2 from line within w_consulta_ventas
long linecolor = 1073741824
integer linethickness = 4
integer beginx = 41
integer beginy = 192
integer endx = 1902
integer endy = 192
end type


HA$PBExportHeader$w_imprimir.srw
forward
global type w_imprimir from w_popup
end type
type cb_imprimir from commandbutton within w_imprimir
end type
type dw_reporte from u_dw within w_imprimir
end type
end forward

global type w_imprimir from w_popup
integer x = 214
integer y = 221
cb_imprimir cb_imprimir
dw_reporte dw_reporte
end type
global w_imprimir w_imprimir

type variables
string is_archivo_logo
end variables
event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
datawindow ldw_datawindow
string ls_preview
window lw_parent
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

dw_reporte.of_setUpdateable(FALSE)
of_setResize(TRUE)

inv_resize.of_register(dw_reporte,0,0,100,100)


ldw_datawindow = Message.powerobjectParm

lw_parent = ldw_datawindow.getParent()

this.title = "Vista Preliminar - " + lw_parent.title

dw_reporte.dataobject = ldw_datawindow.dataobject

ldw_datawindow.RowsCopy(1, ldw_datawindow.rowcount(), Primary!, dw_reporte, 1, Primary!)

dw_reporte.modify("t_nombre_empresa.text='" + gs_nombre_compania + "'") 			 
dw_reporte.modify("t_fecha.text = 'Fecha : '" + f_fecha_mes(datetime(today())) + "'")

// Prepara el DataWindow en Forma de Preview
dw_reporte.Modify ("DataWindow.Print.Preview=yes")
ls_preview = dw_reporte.Describe ("dataWindow.Print.Preview")
dw_reporte.Modify ("DataWindow.Print.Preview.Zoom=90")

//Ajusta el tama$$HEX1$$f100$$ENDHEX$$o del logo
is_archivo_logo = gf_asigna_logo(this, dw_reporte)


post event ue_ajusta_objetos()
end event

on w_imprimir.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.dw_reporte=create dw_reporte
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.dw_reporte
end on

on w_imprimir.destroy
call super::destroy
destroy(this.cb_imprimir)
destroy(this.dw_reporte)
end on

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

cb_imprimir.x = 5
cb_imprimir.y = 5

dw_reporte.x = 5
dw_reporte.y = cb_imprimir.y + cb_imprimir.height + 20
dw_reporte.width = width - 80
dw_reporte.height = height - 160
end event

event close;call super::close;//Elimina el archivo temporal de la imagen
filedelete(is_archivo_logo)
end event

type cb_imprimir from commandbutton within w_imprimir
integer x = 27
integer y = 8
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprimir"
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

dw_reporte.event pfc_print()
end event

type dw_reporte from u_dw within w_imprimir
integer x = 9
integer y = 108
integer width = 2427
integer height = 1252
integer taborder = 10
boolean hscrollbar = true
end type


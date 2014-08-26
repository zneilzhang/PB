HA$PBExportHeader$w_autorizacion.srw
forward
global type w_autorizacion from w_response
end type
type st_proceso from statictext within w_autorizacion
end type
type p_1 from picture within w_autorizacion
end type
type st_1 from statictext within w_autorizacion
end type
type sle_password from singlelineedit within w_autorizacion
end type
type cb_aceptar from commandbutton within w_autorizacion
end type
type cb_1 from commandbutton within w_autorizacion
end type
type r_1 from rectangle within w_autorizacion
end type
end forward

global type w_autorizacion from w_response
integer width = 1275
integer height = 504
string title = "Seguridad"
boolean controlmenu = false
boolean center = true
st_proceso st_proceso
p_1 p_1
st_1 st_1
sle_password sle_password
cb_aceptar cb_aceptar
cb_1 cb_1
r_1 r_1
end type
global w_autorizacion w_autorizacion

type variables

long il_autorizacion_id
end variables

on w_autorizacion.create
int iCurrent
call super::create
this.st_proceso=create st_proceso
this.p_1=create p_1
this.st_1=create st_1
this.sle_password=create sle_password
this.cb_aceptar=create cb_aceptar
this.cb_1=create cb_1
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_proceso
this.Control[iCurrent+2]=this.p_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.sle_password
this.Control[iCurrent+5]=this.cb_aceptar
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.r_1
end on

on w_autorizacion.destroy
call super::destroy
destroy(this.st_proceso)
destroy(this.p_1)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.cb_aceptar)
destroy(this.cb_1)
destroy(this.r_1)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_descripcion

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

il_autorizacion_id = long(message.stringparm)

sle_password.setfocus()

IF il_autorizacion_id > 0 THEN
	SELECT descripcion
	INTO :ls_descripcion
	FROM autorizaciones
	WHERE id = :il_autorizacion_id;
ELSE
	ls_descripcion = "PROC. NO DISPONIBLE"
END IF

st_proceso.text = ls_descripcion





end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//dw_1.setfocus()
end event

type st_proceso from statictext within w_autorizacion
integer x = 274
integer y = 108
integer width = 974
integer height = 96
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Proceso"
boolean focusrectangle = false
end type

type p_1 from picture within w_autorizacion
integer x = 37
integer y = 12
integer width = 219
integer height = 192
boolean originalsize = true
string picturename = "ico\lock2.png"
boolean focusrectangle = false
end type

type st_1 from statictext within w_autorizacion
integer x = 274
integer y = 20
integer width = 974
integer height = 96
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "Autorizaci$$HEX1$$f300$$ENDHEX$$n de Acceso "
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_autorizacion
event keydown pbm_keydown
event keyup pbm_keyup
integer x = 197
integer y = 256
integer width = 846
integer height = 104
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean password = true
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event keydown;
//sle_buscar.text
end event

event keyup;
IF key = keyEnter! THEN
	//Post( Handle(this),256,9,0 )
//	dw_1.setfocus()
	RETURN
END IF


end event

event modified;
cb_aceptar.event clicked()
end event

type cb_aceptar from commandbutton within w_autorizacion
integer x = 192
integer y = 464
integer width = 343
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Aceptar"
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_codigo, ls_password

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

SELECT password
INTO :ls_password
FROM autorizaciones
WHERE id = :il_autorizacion_id;

IF SQLCA.sqlcode <> 0 THEN
	Messagebox(gs_nombreapp, "EL PROCESO DE AUTORIZACION NO EXISTE",exclamation!)
	RETURN
END IF

IF sle_password.text = gnv_app.inv_seguridad.of_desencriptar(ls_password) THEN
	CloseWithReturn(parent, "OK")
ELSE
	messagebox(gs_nombreapp, "LA CLAVE DE AUTORIZACI$$HEX1$$d300$$ENDHEX$$N NO ES VALIDA", exclamation!)
END IF


end event

type cb_1 from commandbutton within w_autorizacion
integer x = 553
integer y = 464
integer width = 343
integer height = 92
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


CloseWithReturn(parent, "")
end event

type r_1 from rectangle within w_autorizacion
long linecolor = 33554432
integer linethickness = 8
long fillcolor = 1073741824
integer width = 1262
integer height = 220
end type


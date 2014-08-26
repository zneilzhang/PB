HA$PBExportHeader$w_about.srw
$PBExportComments$Extension About window
forward
global type w_about from pfc_w_about
end type
type cb_info from u_cb within w_about
end type
type st_usuario from u_st within w_about
end type
type st_bd from u_st within w_about
end type
type st_servidor from u_st within w_about
end type
type st_usuario_inf from u_st within w_about
end type
type st_servidor_inf from u_st within w_about
end type
type st_compilacion from u_st within w_about
end type
type st_compilacion_inf from u_st within w_about
end type
type st_licencia from statictext within w_about
end type
type ln_division from line within w_about
end type
type st_spid_inf from u_st within w_about
end type
type st_1 from u_st within w_about
end type
type st_bd_inf from u_st within w_about
end type
type shl_1 from statichyperlink within w_about
end type
end forward

global type w_about from pfc_w_about
integer width = 1810
integer height = 1108
boolean center = true
cb_info cb_info
st_usuario st_usuario
st_bd st_bd
st_servidor st_servidor
st_usuario_inf st_usuario_inf
st_servidor_inf st_servidor_inf
st_compilacion st_compilacion
st_compilacion_inf st_compilacion_inf
st_licencia st_licencia
ln_division ln_division
st_spid_inf st_spid_inf
st_1 st_1
st_bd_inf st_bd_inf
shl_1 shl_1
end type
global w_about w_about

type variables
//Var. para el control de la muestra de la informaci$$HEX1$$f300$$ENDHEX$$n
Boolean	ib_info = False
end variables

on w_about.create
int iCurrent
call super::create
this.cb_info=create cb_info
this.st_usuario=create st_usuario
this.st_bd=create st_bd
this.st_servidor=create st_servidor
this.st_usuario_inf=create st_usuario_inf
this.st_servidor_inf=create st_servidor_inf
this.st_compilacion=create st_compilacion
this.st_compilacion_inf=create st_compilacion_inf
this.st_licencia=create st_licencia
this.ln_division=create ln_division
this.st_spid_inf=create st_spid_inf
this.st_1=create st_1
this.st_bd_inf=create st_bd_inf
this.shl_1=create shl_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_info
this.Control[iCurrent+2]=this.st_usuario
this.Control[iCurrent+3]=this.st_bd
this.Control[iCurrent+4]=this.st_servidor
this.Control[iCurrent+5]=this.st_usuario_inf
this.Control[iCurrent+6]=this.st_servidor_inf
this.Control[iCurrent+7]=this.st_compilacion
this.Control[iCurrent+8]=this.st_compilacion_inf
this.Control[iCurrent+9]=this.st_licencia
this.Control[iCurrent+10]=this.ln_division
this.Control[iCurrent+11]=this.st_spid_inf
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_bd_inf
this.Control[iCurrent+14]=this.shl_1
end on

on w_about.destroy
call super::destroy
destroy(this.cb_info)
destroy(this.st_usuario)
destroy(this.st_bd)
destroy(this.st_servidor)
destroy(this.st_usuario_inf)
destroy(this.st_servidor_inf)
destroy(this.st_compilacion)
destroy(this.st_compilacion_inf)
destroy(this.st_licencia)
destroy(this.ln_division)
destroy(this.st_spid_inf)
destroy(this.st_1)
destroy(this.st_bd_inf)
destroy(this.shl_1)
end on

event open;call super::open;//------------------------------------------------------------------
//  MODULO/FUNCION	: open
//
//  DESCRIPCION		: Abre la ventana "Acerca de" con los atributos
//							  apropiados
//  
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  21/JUL/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string lsarr_parametros[], lsarr_valores[]
integer li_index
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

//Ajusta el tama$$HEX1$$f100$$ENDHEX$$o inicial de la ventana
This.Height = ln_division.BeginY + 100

//Asigna la informaci$$HEX1$$f300$$ENDHEX$$n
st_usuario_inf.text = string(gi_Id_Usuario) + " - " + lower(gs_nombre_usuario) + " en " +gs_UserNombrePC+"\"+gs_UserID
st_servidor_inf.text = "" //upper(SQLCA.ServerName)
st_bd_inf.text = "" //lower(SQLCA.LogId)
st_spid_inf.text = "" //string(gdec0_spid)

gnv_funciones_string.of_ParseToArray(SQLCA.dbparm,";",lsarr_parametros)
FOR li_index = 1 TO UpperBound(lsarr_parametros)
	IF pos(lsarr_parametros[li_index],"SERVER") > 0 OR pos(lsarr_parametros[li_index],"PORT") > 0 THEN
			gnv_funciones_string.of_ParseToArray(lsarr_parametros[li_index],"=",lsarr_valores)
			st_servidor_inf.text += lsarr_valores[2] + " "
	END IF

	IF pos(lsarr_parametros[li_index],"DATABASE") > 0 THEN
		gnv_funciones_string.of_ParseToArray(lsarr_parametros[li_index],"=",lsarr_valores)
		st_bd_inf.text = lsarr_valores[2] + " "
	END IF

NEXT


//Obtiene el PowerObjectParm
inv_aboutattrib = Message.PowerObjectParm

//Permite que la ventana se cierre sin validar nada en el evento "CloseQuery"
ib_disableclosequery = True

// Muestra el bitmap de la aplicaci$$HEX1$$f300$$ENDHEX$$n
If Len(inv_aboutattrib.is_logo) > 0 Then
	p_about.PictureName = inv_aboutattrib.is_logo
Else
	p_about.Visible = False
End If

// Despliega el nombre de la aplicaci$$HEX1$$f300$$ENDHEX$$n
If Len(inv_aboutattrib.is_application) > 0 Then
	st_application.text = inv_aboutattrib.is_application
	this.Title = 'Acerca de '+ inv_aboutattrib.is_application
Else
	st_application.text = ''
	this.Title = 'Acerca de '
End If

// Despliega el no. de versi$$HEX1$$f300$$ENDHEX$$n de la aplicaci$$HEX1$$f300$$ENDHEX$$n
If Len(inv_aboutattrib.is_version) > 0 Then
	st_version.text = inv_aboutattrib.is_version
Else
	st_version.text = ''
End If

// Despliega los Derechos Reservados (copyright)
If Len(inv_aboutattrib.is_copyright) > 0 Then
	st_copyright.text = inv_aboutattrib.is_copyright
Else
	st_copyright.text = ''
End If

// Display the appropriate application version number.
If Len(inv_aboutattrib.is_licencia) > 0 Then
	st_licencia.text = inv_aboutattrib.is_licencia
Else
	st_licencia.text = ''
End If

//Despliega la fecha de compilaci$$HEX1$$f300$$ENDHEX$$n
st_compilacion_inf.text = string(gdt_compilacion, "dd/mm/yyyy hh:mm")
end event

type p_about from pfc_w_about`p_about within w_about
integer x = 14
integer y = 8
integer width = 594
integer height = 484
boolean originalsize = false
boolean border = true
borderstyle borderstyle = styleraised!
end type

type st_application from pfc_w_about`st_application within w_about
integer x = 617
integer y = 36
integer width = 1175
end type

type st_version from pfc_w_about`st_version within w_about
integer x = 617
integer y = 108
integer width = 1175
end type

type cb_ok from pfc_w_about`cb_ok within w_about
integer x = 1417
integer y = 624
integer taborder = 30
end type

type st_copyright from pfc_w_about`st_copyright within w_about
integer x = 617
integer y = 172
integer width = 1175
integer height = 116
end type

type cb_info from u_cb within w_about
integer x = 1417
integer y = 516
integer taborder = 20
boolean bringtotop = true
string text = "Info  >>"
end type

event clicked;call super::clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)


If ib_info Then
	//Contrae la ventana
	Parent.Height = ln_division.BeginY + 100
	
	//Cambia el texto del bot$$HEX1$$f300$$ENDHEX$$n
	cb_info.Text = "Info >>"
	
Else
	//Expande la ventana
	Parent.Height = 1140
	
	//Cambia el texto del bot$$HEX1$$f300$$ENDHEX$$n
	cb_info.Text = "Info <<"
	
End If

//Cambia la bandera de la variable
ib_info = Not ib_info
end event

type st_usuario from u_st within w_about
integer x = 27
integer y = 768
integer width = 215
integer height = 72
boolean bringtotop = true
long textcolor = 8388608
long backcolor = 79741120
string text = "Usuario : "
alignment alignment = right!
end type

type st_bd from u_st within w_about
integer x = 27
integer y = 860
integer width = 215
integer height = 72
boolean bringtotop = true
long textcolor = 8388608
long backcolor = 79741120
string text = "Servicio : "
alignment alignment = right!
end type

type st_servidor from u_st within w_about
integer x = 27
integer y = 944
integer width = 215
integer height = 72
boolean bringtotop = true
long textcolor = 8388608
long backcolor = 79741120
string text = "Servidor : "
alignment alignment = right!
end type

type st_usuario_inf from u_st within w_about
integer x = 242
integer y = 768
integer width = 1198
integer height = 72
boolean bringtotop = true
long backcolor = 79741120
string text = "99 - Nombre de Usuario"
end type

type st_servidor_inf from u_st within w_about
integer x = 247
integer y = 944
integer width = 773
integer height = 72
boolean bringtotop = true
long backcolor = 79741120
string text = "ServidorSRV"
end type

type st_compilacion from u_st within w_about
integer x = 1029
integer y = 944
integer width = 306
integer height = 72
boolean bringtotop = true
long textcolor = 8388608
long backcolor = 79741120
string text = "Generado el : "
alignment alignment = right!
end type

type st_compilacion_inf from u_st within w_about
integer x = 1335
integer y = 944
integer width = 421
integer height = 72
boolean bringtotop = true
long backcolor = 79741120
string text = "16/02/2001 00:00"
end type

type st_licencia from statictext within w_about
integer x = 617
integer y = 280
integer width = 1175
integer height = 216
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 79741120
boolean focusrectangle = false
end type

type ln_division from line within w_about
integer linethickness = 1
integer beginx = 37
integer beginy = 740
integer endx = 1751
integer endy = 740
end type

type st_spid_inf from u_st within w_about
boolean visible = false
integer x = 242
integer y = 860
integer width = 1211
integer height = 72
integer taborder = 10
long backcolor = 79741120
boolean enabled = true
string text = "QQQQQQQQQQQQQQQQQQQQQQQQ"
end type

event doubleclicked;call super::doubleclicked;Clipboard (text)
end event

type st_1 from u_st within w_about
boolean visible = false
integer x = 27
integer y = 860
integer width = 215
integer height = 72
long textcolor = 8388608
long backcolor = 79741120
string text = "Sesi$$HEX1$$f300$$ENDHEX$$n :"
alignment alignment = right!
end type

type st_bd_inf from u_st within w_about
integer x = 242
integer y = 860
integer width = 1198
integer height = 72
long backcolor = 79741120
string text = "BaseDatos"
end type

type shl_1 from statichyperlink within w_about
integer x = 78
integer y = 500
integer width = 443
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 79741120
string text = "luel81@hotmail.com"
boolean focusrectangle = false
string url = "mailto:luel81@hotmail.com?Subject=Informacion%20LynchClean"
end type


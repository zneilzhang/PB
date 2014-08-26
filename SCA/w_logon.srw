HA$PBExportHeader$w_logon.srw
$PBExportComments$Extension Logon window
forward
global type w_logon from pfc_w_logon
end type
type r_1 from rectangle within w_logon
end type
type st_version from statictext within w_logon
end type
type st_nom_cia from statictext within w_logon
end type
type p_logo_compania from picture within w_logon
end type
end forward

global type w_logon from pfc_w_logon
integer width = 2624
integer height = 1216
boolean titlebar = false
string title = ""
boolean controlmenu = false
long backcolor = 67108864
boolean center = true
event ue_keyup pbm_keyup
event ue_keydown pbm_keydown
r_1 r_1
st_version st_version
st_nom_cia st_nom_cia
p_logo_compania p_logo_compania
end type
global w_logon w_logon

type variables

end variables

event ue_keyup;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


end event

event ue_keydown;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
graphicobject lgo_objeto
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF key = keyEnter! THEN
	lgo_objeto = getfocus()
	post (Handle(lgo_objeto), 256, 9, long(0,0))
END IF
end event

on w_logon.create
int iCurrent
call super::create
this.r_1=create r_1
this.st_version=create st_version
this.st_nom_cia=create st_nom_cia
this.p_logo_compania=create p_logo_compania
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.r_1
this.Control[iCurrent+2]=this.st_version
this.Control[iCurrent+3]=this.st_nom_cia
this.Control[iCurrent+4]=this.p_logo_compania
end on

on w_logon.destroy
call super::destroy
destroy(this.r_1)
destroy(this.st_version)
destroy(this.st_nom_cia)
destroy(this.p_logo_compania)
end on

event open;//------------------------------------------------------------------
// OJO!, SE EST$$HEX2$$c1002000$$ENDHEX$$BRINCANDO EL ANCESTRO
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_commandparm, ls_cia, ls_password
Environment env
Integer lrtn

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)




//Centra la ventana
lrtn = GetEnvironment(env)

This.Y = (PixelsToUnits ( env.ScreenHeight, YPixelsToUnits! ) - This.Height) / 2
This.X = (PixelsToUnits ( env.ScreenWidth, XPixelsToUnits! ) - This.Width) / 2




// Allow for pre and post open events to occur
This.Event pfc_preopen()
This.Post Event pfc_postopen()

//Intentos de logon
ii_logonattempts = 3

//Pone el t$$HEX1$$ed00$$ENDHEX$$tulo de la ventana
Title = Title + " " + inv_logonattrib.is_appname

ib_disableclosequery = true

// Validate for a valid PowerObjectParm
If IsValid(Message.PowerObjectParm) Then
	If inv_logonattrib.ClassName() = Message.PowerObjectParm.ClassName() Then
		inv_logonattrib = Message.PowerObjectParm
	End IF
Else
	// Set the return code to mean the window was closed by error.
	inv_logonattrib.ii_rc = -1
	inv_logonattrib.is_userid = ""
	CloseWithReturn (this, inv_logonattrib)
	Return
End If

//Valida si no trae informaci$$HEX1$$f300$$ENDHEX$$n desde el la l$$HEX1$$ed00$$ENDHEX$$nea de comando
//if gb_command_line then
//	ls_commandparm = CommandParm()
//	ls_cia = gf_desglosa_string(ls_commandparm, 1, "|")
//	ls_password = gf_desglosa_string(ls_commandparm, 2, "|")
//else
	ls_cia = gs_nulo
	ls_password = gs_nulo
//end if

// User ID
sle_userid.text = ls_cia

// Password
sle_password.text = ls_password

// Logo
If Len(inv_logonattrib.is_logo) > 0 Then
	p_logo.picturename = inv_logonattrib.is_logo
Else
	p_logo.Visible = False
End If

// Application Name
if Len (inv_logonattrib.is_appname) = 0 then
	inv_logonattrib.is_appname = "the application"	
end if
st_help.text = inv_logonattrib.is_appname + "."

// Set the logon attempts variable
If IsValid(inv_logonattrib) Then
	If Not IsNull(inv_logonattrib.ii_logonattempts) Then
		ii_logonattempts = inv_logonattrib.ii_logonattempts
	End If
End If

sle_userid.SetFocus()


end event

event pfc_default;//------------------------------------------------------------------
// OJO!, EN ESTE EVENTO SE ESTA BRINCANDO EL CODIGO DEL ANCESTRO
//------------------------------------------------------------------

//------------------------------------------------------------------
//  MODULO/FUNCION	: pfc_default
//
//  DESCRIPCION		: En este evento se manda realizar el logon a la
//							  aplicaci$$HEX1$$f300$$ENDHEX$$n
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

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)
integer	li_rc

//////////////////////////////////////////////////////////////////////////////
// Checa que se hayan capturado el usuario y el password
//////////////////////////////////////////////////////////////////////////////
if Len (sle_userid.text) = 0 then
	of_MessageBox ("pfc_logon_enterid", inv_logonattrib.is_appname, &
		"Favor de proporcionar la Compa$$HEX2$$f100ed00$$ENDHEX$$a", exclamation!, OK!, 1)
	sle_userid.SetFocus()
	return
end if
if Len (sle_password.text) = 0 then
	of_MessageBox ("pfc_logon_enterpassword", inv_logonattrib.is_appname, &
		"Favor de proporcionar la Clave de Acceso", exclamation!, OK!, 1)
	sle_password.SetFocus()
	return
end if
if Isnull(inv_logonattrib.ipo_source) or Not IsValid (inv_logonattrib.ipo_source) then
	this.event pfc_cancel()
	return
End If

//////////////////////////////////////////////////////////////////////////////
// Attempt to logon
// LAC: Adecuado para Enkontrol
//////////////////////////////////////////////////////////////////////////////
ii_logonattempts = 3
ii_logonattempts --
li_rc = inv_logonattrib.ipo_source.dynamic event pfc_logon &
	(sle_userid.text, sle_password.text)
if IsNull (li_rc) then 
	this.event pfc_cancel()
	return
ElseIf li_rc <= 0 Then
	
//	//Desconecta la transacci$$HEX1$$f300$$ENDHEX$$n LAC
//	Disconnect using SQLCA;
	
	If ii_logonattempts > 0  Then
		// There are still have more attempts for a succesful login.
//		if SQLCA.SQLCode <> -1 then
//			of_MessageBox ("pfc_logon_incorrectpassword", This.Title, &
//				"La Clave proporcionada no es correcta", StopSign!, Ok!, 1)
//		end if
		sle_password.post SetFocus()
		Return
	Else
		// Failure return code
		inv_logonattrib.ii_rc = -1	
		CloseWithReturn (this, inv_logonattrib)
	End If
Else
	// Successful return code
	inv_logonattrib.ii_rc = 1
	inv_logonattrib.is_userid = gs_id_usuario
	inv_logonattrib.is_password = sle_password.text	
	CloseWithReturn (this, inv_logonattrib)	
End if

Return
end event

event pfc_postopen;call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_cia, ls_password

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Respalda la info
ls_cia = sle_userid.text
ls_password = sle_password.text

//Pasa los textos default
sle_userid.text = ls_cia
sle_password.text = ls_password

//Si fu$$HEX2$$e9002000$$ENDHEX$$lanzado por l$$HEX1$$ed00$$ENDHEX$$nea de comando manda ejecutar los eventos para realizar el login
//Pone el focus en el campo password
sle_userid.setfocus()

end event

event show;call super::show;
setwindowrgn (handle(this),CreateRoundRectRgn(0,1,557,285, 30, 30),true)
end event

type p_logo from pfc_w_logon`p_logo within w_logon
integer x = 329
integer y = 40
integer width = 407
integer height = 320
boolean originalsize = false
string picturename = "D:\Documentos\Google Drive\Dev\Proyectos\MiTiendita\pbl\ico\logo.png"
borderstyle borderstyle = stylelowered!
boolean map3dcolors = true
end type

type st_help from pfc_w_logon`st_help within w_logon
integer x = 1312
integer y = 528
integer width = 1234
integer height = 224
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 8388608
long backcolor = 16777215
string text = "Nombre de la aplicacion"
long bordercolor = 134217729
end type

event st_help::constructor;call super::constructor;//visible = false
end event

type cb_ok from pfc_w_logon`cb_ok within w_logon
integer x = 1705
integer y = 984
integer width = 343
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string text = "Aceptar"
boolean default = false
end type

type cb_cancel from pfc_w_logon`cb_cancel within w_logon
integer x = 2062
integer y = 984
integer width = 343
fontcharset fontcharset = ansi!
string facename = "Tahoma"
string text = "Cancelar"
end type

type sle_userid from pfc_w_logon`sle_userid within w_logon
integer x = 1202
integer y = 772
integer width = 197
integer height = 72
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 0
long backcolor = 16777215
textcase textcase = upper!
integer limit = 2
borderstyle borderstyle = stylebox!
end type

event sle_userid::modified;call super::modified;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rtn
n_tr ltr_cnx
string ls_password, ls_cia, ls_nombre_cia
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ls_cia = this.text
IF len(trim(ls_cia)) = 0 THEN
	st_nom_cia.text = ""
	sle_password.text = ""
END IF

ls_password = gnv_app.inv_seguridad.of_getpassword()

ltr_cnx = CREATE n_tr
li_rtn = ltr_cnx.of_conectarCiaEK("dba",ls_password, ls_cia)

SELECT nombre
INTO :ls_nombre_cia
FROM datos_compania
WHERE clave_compania = :ls_cia
USING ltr_cnx;

ltr_cnx.of_disconnect()

IF li_rtn = 0 THEN
	messagebox(gs_nombreapp,"La compa$$HEX2$$f100ed00$$ENDHEX$$a no est$$HEX2$$e1002000$$ENDHEX$$definida en el archivo de configuraci$$HEX1$$f300$$ENDHEX$$n kontrol.ini", exclamation!)
	RETURN	
END IF

st_nom_cia.text = ls_nombre_cia
sle_password.text = ""



end event

type sle_password from pfc_w_logon`sle_password within w_logon
event ue_keydown pbm_keydown
integer x = 1202
integer y = 872
integer width = 1193
integer height = 72
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 0
long backcolor = 16777215
borderstyle borderstyle = stylebox!
end type

event sle_password::ue_keydown;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF key = keyEnter! THEN 
	IF len(trim(this.text)) > 0 THEN event pfc_default()
END IF
end event

type st_2 from pfc_w_logon`st_2 within w_logon
integer x = 878
integer y = 772
integer width = 265
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Compa$$HEX2$$f100ed00$$ENDHEX$$a"
alignment alignment = left!
end type

type st_3 from pfc_w_logon`st_3 within w_logon
integer x = 873
integer y = 872
integer width = 265
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 67108864
string text = "Clave"
alignment alignment = left!
end type

type r_1 from rectangle within w_logon
long linecolor = 33554432
linestyle linestyle = transparent!
integer linethickness = 4
long fillcolor = 1073741824
integer x = 210
integer y = 4
integer width = 2395
integer height = 756
end type

type st_version from statictext within w_logon
integer x = 2002
integer y = 676
integer width = 398
integer height = 64
boolean bringtotop = true
integer textsize = -6
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16810239
long backcolor = 16777215
alignment alignment = right!
boolean focusrectangle = false
end type

event constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
text = string(gdt_compilacion, "ddmmyy.hh")
end event

type st_nom_cia from statictext within w_logon
integer x = 1413
integer y = 772
integer width = 987
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
boolean focusrectangle = false
end type

type p_logo_compania from picture within w_logon
event ue_mousedown pbm_lbuttondown
integer x = 23
integer width = 274
integer height = 1172
boolean bringtotop = true
boolean originalsize = true
string picturename = "D:\EnKontrol\RUBA\SCA\ico\enkontrol_tit_v.bmp"
boolean focusrectangle = false
end type


HA$PBExportHeader$w_avance_carga.srw
$PBExportComments$(LEC) Muestra progreso de avance
forward
global type w_avance_carga from w_popup
end type
type st_texto from statictext within w_avance_carga
end type
type hpb_carga from hprogressbar within w_avance_carga
end type
end forward

global type w_avance_carga from w_popup
integer width = 1275
integer height = 324
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean center = true
st_texto st_texto
hpb_carga hpb_carga
end type
global w_avance_carga w_avance_carga

type variables
dec id_step
string is_msg_det
end variables

forward prototypes
public function integer of_setstep (decimal ad_valor)
public function decimal of_getstep ()
public function integer of_settext (string as_texto)
public function integer of_settitle (string as_titulo)
public function integer of_setposition (decimal ad_valor)
public function long of_getposition ()
public function long of_getmaxposition ()
public function integer of_envia_msg (string as_msg, string as_msg_det)
public function integer of_setmsg (string as_msg_det)
public function string of_getmsg ()
public function integer of_setmaxposition (long al_pos)
public function integer of_stepit ()
end prototypes

public function integer of_setstep (decimal ad_valor);

id_step = ad_valor
hpb_carga.setstep = ad_valor

RETURN 1
end function

public function decimal of_getstep ();

IF isnull(id_step) then id_step = 0

RETURN id_step 
end function

public function integer of_settext (string as_texto);

st_texto.text = as_texto

return 1
end function

public function integer of_settitle (string as_titulo);

this.title = as_titulo

return 1
end function

public function integer of_setposition (decimal ad_valor);

hpb_carga.position = ad_valor

return 1
end function

public function long of_getposition ();

return hpb_carga.position
end function

public function long of_getmaxposition ();

return hpb_carga.MaxPosition
end function

public function integer of_envia_msg (string as_msg, string as_msg_det);//gf_msgbox_det(gs_nombreapp,as_msg,as_msg_det,'information.bmp',FALSE)

gnv_app.inv_error.of_Message(gs_nombreapp, as_msg, information!)

return 1
end function

public function integer of_setmsg (string as_msg_det);

is_msg_det = as_msg_det

return 1
end function

public function string of_getmsg ();


return is_msg_det


end function

public function integer of_setmaxposition (long al_pos);



hpb_carga.MaxPosition = al_pos

RETURN 1
end function

public function integer of_stepit ();

RETURN hpb_carga.StepIt()
end function

on w_avance_carga.create
int iCurrent
call super::create
this.st_texto=create st_texto
this.hpb_carga=create hpb_carga
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_texto
this.Control[iCurrent+2]=this.hpb_carga
end on

on w_avance_carga.destroy
call super::destroy
destroy(this.st_texto)
destroy(this.hpb_carga)
end on

event open;call super::open;

st_texto.text = ''
hpb_carga.maxposition = 100
hpb_carga.minposition = 0
hpb_carga.position = 0
end event

type st_texto from statictext within w_avance_carga
integer x = 32
integer y = 120
integer width = 1170
integer height = 92
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type hpb_carga from hprogressbar within w_avance_carga
integer x = 32
integer y = 24
integer width = 1170
integer height = 72
unsignedinteger maxposition = 3
integer setstep = 1
end type


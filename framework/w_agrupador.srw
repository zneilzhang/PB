HA$PBExportHeader$w_agrupador.srw
forward
global type w_agrupador from w_popup
end type
type st_title from u_st within w_agrupador
end type
end forward

global type w_agrupador from w_popup
integer x = 214
integer y = 221
integer width = 690
integer height = 332
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
windowtype windowtype = child!
boolean toolbarvisible = false
st_title st_title
end type
global w_agrupador w_agrupador

type prototypes

PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
end prototypes

type variables

u_dw idw_objeto
end variables

on w_agrupador.create
int iCurrent
call super::create
this.st_title=create st_title
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_title
end on

on w_agrupador.destroy
call super::destroy
destroy(this.st_title)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
w_main lw_parent
integer li_rtn

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//Activa el Servicio de Resize
of_SetResize(TRUE)

//Registra el titulo de la ventana
inv_resize.of_Register(st_title,0,0,100,0)

//Lee el parametro
idw_objeto = Message.PowerObjectParm
	

IF isvalid(idw_objeto.iuo_agrupador) THEN close(this)

IF this.OpenUserObject(idw_objeto.iuo_agrupador) <> 1 THEN close(this)

inv_resize.of_Register(idw_objeto.iuo_agrupador,0,0,100,100)

IF idw_objeto.iuo_agrupador.of_InicializaDetalle(idw_objeto) <> 1 THEN close(this)


Width = 1000
Height = idw_objeto.ii_anchoagrupador * 3

SetParent(handle(this),handle(idw_objeto.iuo_agrupador.iw_parent))








end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
st_title.x = 1
st_title.y = 1
st_title.width = width - 20


idw_objeto.iuo_agrupador.X = st_title.x
idw_objeto.iuo_agrupador.Y = st_title.y + st_title.height + 10
idw_objeto.iuo_agrupador.width = width - 70
idw_objeto.iuo_agrupador.height = height - idw_objeto.iuo_agrupador.y - 60
end event

event resize;call super::resize;
//idw_objeto.iuo_agrupador.event Resize(sizetype,newwidth,newheight)
end event

event pfc_controlgotfocus;call super::pfc_controlgotfocus;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


idw_objeto.of_activate()
end event

event mousedown;call super::mousedown;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

idw_objeto.iuo_agrupador.of_OcultarOpciones()

Send( Handle( this ), 274, 61458, 0 )
end event

type st_title from u_st within w_agrupador
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
integer x = 41
integer y = 112
integer width = 535
integer height = 68
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8388608
string text = "Panel de agrupaci$$HEX1$$f300$$ENDHEX$$n"
end type


HA$PBExportHeader$w_editday.srw
forward
global type w_editday from w_response
end type
type cb_2 from u_cb within w_editday
end type
type cb_1 from u_cb within w_editday
end type
type dw_1 from u_dw within w_editday
end type
end forward

global type w_editday from w_response
integer width = 1600
integer height = 996
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_editday w_editday

on w_editday.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_editday.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;n_cst_dayattrib lnv_dayattrib

of_setbase(TRUE)
inv_base.of_center()

lnv_dayattrib = message.powerobjectparm

dw_1.setitem(1,"daytext",lnv_dayattrib.is_text)
dw_1.setitem(1,"daycolor",lnv_dayattrib.il_color)
dw_1.setitem(1,"daypicture",lnv_dayattrib.is_picture)

this.title = string(lnv_dayattrib.id_day,"mmmm dd, yyyy")

setnull(lnv_dayattrib.id_day)
message.powerobjectparm = lnv_dayattrib
end event

type cb_2 from u_cb within w_editday
integer x = 1189
integer y = 320
integer taborder = 30
string text = "Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;
parent.event pfc_close()
end event

type cb_1 from u_cb within w_editday
integer x = 1189
integer y = 220
integer taborder = 20
string text = "OK"
boolean default = true
end type

event clicked;call super::clicked;n_cst_dayattrib lnv_dayattrib

dw_1.accepttext()

lnv_dayattrib.is_text = dw_1.getitemstring(1,"daytext")
lnv_dayattrib.il_color = dw_1.getitemnumber(1,"daycolor")
lnv_dayattrib.is_picture = dw_1.getitemstring(1,"daypicture")

closewithreturn(parent,lnv_dayattrib)
end event

type dw_1 from u_dw within w_editday
integer width = 1586
integer height = 964
integer taborder = 10
string dataobject = "d_editday"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type


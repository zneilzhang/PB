HA$PBExportHeader$w_dm_pb2xls.srw
forward
global type w_dm_pb2xls from window
end type
type st_3 from statictext within w_dm_pb2xls
end type
type st_2 from statictext within w_dm_pb2xls
end type
type st_1 from statictext within w_dm_pb2xls
end type
type cb_1 from commandbutton within w_dm_pb2xls
end type
end forward

global type w_dm_pb2xls from window
integer x = 471
integer y = 624
integer width = 1824
integer height = 460
boolean titlebar = true
string title = "Demo version"
windowtype windowtype = response!
long backcolor = 79741120
st_3 st_3
st_2 st_2
st_1 st_1
cb_1 cb_1
end type
global w_dm_pb2xls w_dm_pb2xls

type variables
integer cc = 10
end variables

event open;timer(1)
event timer()

end event

event timer;if cc > 0 then
	cb_1.Text = 'Close ' + string(cc)+ ' sec'
	cc --
else
	cb_1.Text = 'Close'
	cb_1.enabled = true
	cc = 00
end if
end event

on w_dm_pb2xls.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.cb_1}
end on

on w_dm_pb2xls.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

type st_3 from statictext within w_dm_pb2xls
integer x = 763
integer y = 116
integer width = 983
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "hand-m.cur"
long textcolor = 8388608
long backcolor = 79741120
string text = "http://desta.com.ua/pb2xls"
boolean focusrectangle = false
end type

event clicked;run('start "' + this.text + '"', minimized!) 

end event

type st_2 from statictext within w_dm_pb2xls
integer x = 50
integer y = 116
integer width = 695
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "For more information visit:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_dm_pb2xls
integer x = 50
integer y = 40
integer width = 1696
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "In your application the demo version of library PB2XLS is used"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_dm_pb2xls
integer x = 1317
integer y = 220
integer width = 434
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean enabled = false
string text = "Close"
end type

event clicked;close(parent)
end event


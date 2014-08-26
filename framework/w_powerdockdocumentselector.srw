HA$PBExportHeader$w_powerdockdocumentselector.srw
forward
global type w_powerdockdocumentselector from window
end type
type lv_1 from listview within w_powerdockdocumentselector
end type
type cb_3 from commandbutton within w_powerdockdocumentselector
end type
type cb_2 from commandbutton within w_powerdockdocumentselector
end type
type cb_1 from commandbutton within w_powerdockdocumentselector
end type
type uo_1 from u_cst_statictext within w_powerdockdocumentselector
end type
end forward

global type w_powerdockdocumentselector from window
integer width = 2368
integer height = 1048
boolean titlebar = true
string title = "More Windows"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
lv_1 lv_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
uo_1 uo_1
end type
global w_powerdockdocumentselector w_powerdockdocumentselector

type variables
u_cst_tabcontrol iuo_parent
end variables

forward prototypes
public function long of_getcolor (string as_color)
public function integer of_loadlist ()
end prototypes

public function long of_getcolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "BACKGROUND2"
		CHOOSE CASE iuo_parent.il_CurrentTheme
			CASE iuo_parent.BLUE
				ll_color = RGB(129,169,226)
			CASE iuo_parent.SILVER
				ll_color = RGB(153,151,181)
			CASE iuo_parent.OLIVE
				ll_color = RGB(183,198,145)
			CASE iuo_parent.CLASSIC
				ll_color = RGB(213,210,202)
		END CHOOSE
END CHOOSE

RETURN ll_color
end function

public function integer of_loadlist ();Long ll_index, ll_count
Long ll_imagelist
ListViewItem lvi

lv_1.DeleteItems()

ll_count = UpperBound(iuo_parent.is_images)

FOR ll_index = 1 TO ll_count	
	lv_1.AddLargePicture ( iuo_parent.is_images[ll_index] )	
NEXT

ll_count = UpperBound(iuo_parent.ist_tabs)

FOR ll_index = 1 TO ll_count
	
	lvi.Label = iuo_parent.of_GetText(ll_index)
	lvi.PictureIndex = iuo_parent.ist_tabs[ll_index].al_pic_index
	lvi.Data = ll_index
	
	lv_1.AddItem(lvi)
NEXT

RETURN 1
end function

on w_powerdockdocumentselector.create
this.lv_1=create lv_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={this.lv_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.uo_1}
end on

on w_powerdockdocumentselector.destroy
destroy(this.lv_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;iuo_parent = Message.PowerObjectParm

uo_1.of_BackColor2(of_GetColor("BACKGROUND2"))
uo_1.Resize(Width, Height)

of_LoadList()
end event

type lv_1 from listview within w_powerdockdocumentselector
integer x = 78
integer y = 52
integer width = 1618
integer height = 868
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
listviewview view = listviewlist!
long largepicturemaskcolor = 536870912
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type cb_3 from commandbutton within w_powerdockdocumentselector
integer x = 1815
integer y = 840
integer width = 494
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;Close(PARENT)
end event

type cb_2 from commandbutton within w_powerdockdocumentselector
integer x = 1815
integer y = 172
integer width = 494
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close Document"
end type

event clicked;ListViewItem lvi

lv_1.GetItem(lv_1.SelectedIndex(), lvi)

iuo_parent.of_CloseTab(Long(lvi.data))

of_LoadList()
end event

type cb_1 from commandbutton within w_powerdockdocumentselector
integer x = 1815
integer y = 40
integer width = 498
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Activate Document"
end type

event clicked;ListViewItem lvi

lv_1.GetItem(lv_1.SelectedIndex(), lvi)

iuo_parent.of_SelectTab(Long(lvi.data))

Close(PARENT)
end event

type uo_1 from u_cst_statictext within w_powerdockdocumentselector
integer x = 5
integer width = 2496
integer height = 1316
integer taborder = 10
long backcolor = 16777215
boolean #vgradientfill = true
end type

on uo_1.destroy
call u_cst_statictext::destroy
end on


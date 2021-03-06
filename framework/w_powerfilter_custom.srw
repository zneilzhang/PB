HA$PBExportHeader$w_powerfilter_custom.srw
forward
global type w_powerfilter_custom from window
end type
type dw_filter2 from datawindow within w_powerfilter_custom
end type
type dw_filter1 from datawindow within w_powerfilter_custom
end type
type cbx_matchcase from checkbox within w_powerfilter_custom
end type
type dw_parm2 from datawindow within w_powerfilter_custom
end type
type dw_parm1 from datawindow within w_powerfilter_custom
end type
type st_colheader from statictext within w_powerfilter_custom
end type
type st_useasterisk from statictext within w_powerfilter_custom
end type
type st_usequestionmark from statictext within w_powerfilter_custom
end type
type rb_or from radiobutton within w_powerfilter_custom
end type
type rb_and from radiobutton within w_powerfilter_custom
end type
type st_showrows from statictext within w_powerfilter_custom
end type
type cb_cancel from commandbutton within w_powerfilter_custom
end type
type cb_ok from commandbutton within w_powerfilter_custom
end type
end forward

global type w_powerfilter_custom from window
string tag = "//MULTILANG Custom Filter"
integer width = 2203
integer height = 864
boolean titlebar = true
string title = "Custom Filter"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_filter2 dw_filter2
dw_filter1 dw_filter1
cbx_matchcase cbx_matchcase
dw_parm2 dw_parm2
dw_parm1 dw_parm1
st_colheader st_colheader
st_useasterisk st_useasterisk
st_usequestionmark st_usequestionmark
rb_or rb_or
rb_and rb_and
st_showrows st_showrows
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_powerfilter_custom w_powerfilter_custom

type variables
/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
s_powerfilter_parms is_returnparms
s_powerfilter_parms is_openparms
String	is_colformat
DataWindowChild Filter_child1,Filter_child2
Boolean	ib_buttonpressed
//MultLang Support
String is_equals
String is_doesnotequal
String is_isgreaterthan
String is_isgreaterthanorequalto
String is_islessthan
String is_islessthanorequalto
String is_beginswith
String is_doesnotbeginwith
String is_endswith
String is_doesnotendwith
String is_contains
String is_doesnotcontain
String is_Blank
String is_And
String is_Cancel
String is_CustomFilter
String is_MatchCase
String is_OK
String is_Or
String is_Showrowswhere
String is_UseAsterisk
String is_UseQuestionmark

end variables

forward prototypes
public function integer of_setlanguage (integer ai_languagenumber)
public function integer of_replace (ref string as_string, string as_old, string as_new)
end prototypes

public function integer of_setlanguage (integer ai_languagenumber);/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
Integer	li_lang
Datastore	lds_lang

lds_lang = CREATE datastore
lds_lang.dataobject = 'd_powerfilter_languages'

li_lang = ai_languagenumber //offset already done in checkbox, English = 0, is in column 2

is_equals 						= lds_lang.GetItemString(2,li_lang)
is_doesnotequal 				= lds_lang.GetItemString(3,li_lang)
is_isgreaterthan 				= lds_lang.GetItemString(4,li_lang)
is_isgreaterthanorequalto 	= lds_lang.GetItemString(5,li_lang)
is_islessthan 					= lds_lang.GetItemString(6,li_lang)
is_islessthanorequalto 		= lds_lang.GetItemString(7,li_lang)
is_beginswith 					= lds_lang.GetItemString(8,li_lang)
is_doesnotbeginwith 			= lds_lang.GetItemString(9,li_lang)
is_endswith 					= lds_lang.GetItemString(10,li_lang)
is_doesnotendwith 			= lds_lang.GetItemString(11,li_lang)
is_contains 					= lds_lang.GetItemString(12,li_lang)
is_doesnotcontain 			= lds_lang.GetItemString(13,li_lang)
is_Blank 						= lds_lang.GetItemString(63,li_lang)
is_And 							= lds_lang.GetItemString(67,li_lang)
is_Cancel 						= lds_lang.GetItemString(69,li_lang)
is_CustomFilter 				= lds_lang.GetItemString(72,li_lang)
is_MatchCase 					= lds_lang.GetItemString(77,li_lang)
is_OK 							= lds_lang.GetItemString(79,li_lang)
is_Or 							= lds_lang.GetItemString(80,li_lang)
is_Showrowswhere 				= lds_lang.GetItemString(84,li_lang)
is_UseAsterisk					= lds_lang.GetItemString(95,li_lang)
is_UseQuestionmark 			= lds_lang.GetItemString(96,li_lang)
DESTROY lds_lang

CB_ok.Text = is_OK
CB_Cancel.Text = is_Cancel 
cbx_matchcase.text = is_MatchCase
st_showrows.text = is_Showrowswhere
st_usequestionmark.Text = is_UseQuestionmark
st_useasterisk.Text = is_UseAsterisk
rb_and.text = is_and
rb_or.text = is_or
this.title = is_CustomFilter
//populate dropdown displaytext values for dw_filter1 and dw_filter2
Integer li_row,li_rows
li_rows = Filter_child1.rowcount()
li_row = Filter_child1.Find("filtertype = 'equals'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_equals )

li_row = Filter_child1.Find("filtertype = 'does not equal'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_doesnotequal )

li_row = Filter_child1.Find("filtertype = 'is greater than'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_isgreaterthan )

li_row = Filter_child1.Find("filtertype = 'is greater than or equal to'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_isgreaterthanorequalto )

li_row = Filter_child1.Find("filtertype = 'is less than'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_islessthan )

li_row = Filter_child1.Find("filtertype = 'is less than or equal to'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_islessthanorequalto )

li_row = Filter_child1.Find("filtertype = 'begins with'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_beginswith )

li_row = Filter_child1.Find("filtertype = 'does not begin with'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_doesnotbeginwith )

li_row = Filter_child1.Find("filtertype = 'ends with'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_endswith )

li_row = Filter_child1.Find("filtertype = 'does not end with'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_doesnotendwith )

li_row = Filter_child1.Find("filtertype = 'contains'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_contains )

li_row = Filter_child1.Find("filtertype = 'does not contain'" , 1, li_rows)
IF li_row > 0 then Filter_child1.Setitem( li_row,'displaytext',is_doesnotcontain )

li_rows = Filter_child2.rowcount()
li_row = Filter_child2.Find("filtertype = 'equals'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_equals )

li_row = Filter_child2.Find("filtertype = 'does not equal'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_doesnotequal )

li_row = Filter_child2.Find("filtertype = 'is greater than'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_isgreaterthan )

li_row = Filter_child2.Find("filtertype = 'is greater than or equal to'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_isgreaterthanorequalto )

li_row = Filter_child2.Find("filtertype = 'is less than'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_islessthan )

li_row = Filter_child2.Find("filtertype = 'is less than or equal to'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_islessthanorequalto )

li_row = Filter_child2.Find("filtertype = 'begins with'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_beginswith )

li_row = Filter_child2.Find("filtertype = 'does not begin with'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_doesnotbeginwith )

li_row = Filter_child2.Find("filtertype = 'ends with'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_endswith )

li_row = Filter_child2.Find("filtertype = 'does not end with'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_doesnotendwith )

li_row = Filter_child2.Find("filtertype = 'contains'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_contains )

li_row = Filter_child2.Find("filtertype = 'does not contain'" , 1, li_rows)
IF li_row > 0 then Filter_child2.Setitem( li_row,'displaytext',is_doesnotcontain )

RETURN 0
end function

public function integer of_replace (ref string as_string, string as_old, string as_new);/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
Long	ll_startpos

ll_startpos = Pos(as_string, as_old )
// Only enter the loop if you find old_str.
DO WHILE ll_startpos > 0
	 as_string = Replace(as_string, ll_startpos, Len(as_old), as_new)	 // Replace old_str with new_str.
	 ll_startpos = Pos(as_string, as_old, ll_startpos+Len(as_new))	 // Find the next occurrence of old_str.
LOOP
RETURN 0
end function

on w_powerfilter_custom.create
this.dw_filter2=create dw_filter2
this.dw_filter1=create dw_filter1
this.cbx_matchcase=create cbx_matchcase
this.dw_parm2=create dw_parm2
this.dw_parm1=create dw_parm1
this.st_colheader=create st_colheader
this.st_useasterisk=create st_useasterisk
this.st_usequestionmark=create st_usequestionmark
this.rb_or=create rb_or
this.rb_and=create rb_and
this.st_showrows=create st_showrows
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.dw_filter2,&
this.dw_filter1,&
this.cbx_matchcase,&
this.dw_parm2,&
this.dw_parm1,&
this.st_colheader,&
this.st_useasterisk,&
this.st_usequestionmark,&
this.rb_or,&
this.rb_and,&
this.st_showrows,&
this.cb_cancel,&
this.cb_ok}
end on

on w_powerfilter_custom.destroy
destroy(this.dw_filter2)
destroy(this.dw_filter1)
destroy(this.cbx_matchcase)
destroy(this.dw_parm2)
destroy(this.dw_parm1)
destroy(this.st_colheader)
destroy(this.st_useasterisk)
destroy(this.st_usequestionmark)
destroy(this.rb_or)
destroy(this.rb_and)
destroy(this.st_showrows)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;DataWindowChild Item_child1,Item_child2
integer rtncode,li_row
String	ls_return,ls_mod

is_openparms = message.powerobjectparm

is_colformat = is_openparms.Parm11

st_colheader.Text = is_openparms.Parm6
cbx_matchcase.checked = is_openparms.Parm9

rtncode = dw_filter1.GetChild('Item', Filter_child1)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_filter2.GetChild('Item', Filter_child2)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

//multilang
of_setlanguage(is_openparms.parm14) //set language strings

dw_filter1.insertrow(0)
li_row = Filter_child1.find( "filtertype = '" +lower(string(is_openparms.parm1)+"'"), 1, filter_child1.rowcount())
Filter_child1.setrow( li_row)
Filter_child1.scrolltorow( li_row)
dw_filter1.SetItem(1,'item',lower(string(is_openparms.parm1)))

dw_filter2.insertrow(0)
li_row = Filter_child2.find( "filtertype = '" +lower(string(is_openparms.parm3)+"'"), 1, filter_child2.rowcount())
Filter_child2.setrow( li_row)
Filter_child2.scrolltorow( li_row)
dw_filter2.SetItem(1,'item',lower(string(is_openparms.parm3)))

IF upper(is_openparms.parm5) = 'AND' THEN
	rb_and.checked=TRUE
	rb_or.checked=FALSE
ELSE
	rb_and.checked=FALSE
	rb_or.checked=TRUE
END IF

dw_parm1.insertrow(0)
dw_parm1.SetItem(1,'Item',is_openparms.Parm2)
dw_parm2.insertrow(0)
dw_parm2.SetItem(1,'Item',is_openparms.Parm4)

//IF isdate(is_openparms.Parm2) THEN
//	dp_1.setvalue( datetime(date(is_openparms.Parm2)))
//END IF
//IF isdate(is_openparms.Parm4) THEN
//	dp_2.setvalue( datetime(date(is_openparms.Parm4)))
//END IF

rtncode = dw_parm1.GetChild('Item', Item_child1)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")
rtncode = dw_parm2.GetChild('Item', Item_child2)
IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild")

datastore	ds_1
ds_1 = is_openparms.Parm7
ds_1.sharedata( Item_child1)
ds_1.sharedata( Item_child2)

ls_return = Item_child1.Modify("timeitem.visible='0' dateitem.visible='0' datetimeitem.visible='0' numericitem.visible='0' item.visible='0' ")
ls_return = Item_child2.Modify("timeitem.visible='0' dateitem.visible='0' datetimeitem.visible='0' numericitem.visible='0' item.visible='0' ")

ls_mod = Item_child1.describe('t_blank.text')
of_replace( ls_mod,'(Blank)', is_blank)
ls_return = Item_child1.modify('t_blank.text='+ls_mod)
ls_return = Item_child2.modify('t_blank.text='+ls_mod) //should be identical to 1st, no need to describe and replace twice

ls_mod = Item_child1.describe('t_blank.visible')
of_replace( ls_mod,'(Blank)', is_blank)
ls_return = Item_child1.modify('t_blank.visible='+ls_mod)
ls_return = Item_child2.modify('t_blank.visible='+ls_mod) //should be identical to 1st, no need to describe and replace twice


//Turn off features depending on data type
CHOOSE CASE lower(is_openparms.Parm10)
	CASE 'char(','char'
//		dp_1.visible = FALSE
//		dp_2.visible = FALSE
		Item_child1.Modify('item.Format="'+is_colformat+'"')
		Item_child1.Modify('item.visible="1" ')
		Item_child2.Modify('item.Format="'+is_colformat+'"')
		Item_child2.Modify('item.visible="1" ')
	CASE 'date'
		cbx_matchcase.visible = FALSE
		Item_child1.Modify('dateitem.Format="'+is_colformat+'"')
		Item_child1.Modify('dateitem.visible="1" ')
		Item_child2.Modify('dateitem.Format="'+is_colformat+'"')
		Item_child2.Modify('dateitem.visible="1" ')
	CASE 'datet','times'
		cbx_matchcase.visible = FALSE
		Item_child1.Modify('datetimeitem.Format="'+is_colformat+'"')
		Item_child1.Modify('datetimeitem.visible="1" ')
		Item_child2.Modify('datetimeitem.Format="'+is_colformat+'"')
		Item_child2.Modify('datetimeitem.visible="1" ')
	CASE 'time'
		cbx_matchcase.visible = FALSE
//		dp_1.visible = FALSE
//		dp_2.visible = FALSE
		Item_child1.Modify('timeitem.Format="'+is_colformat+'"')
		Item_child1.Modify('timeitem.visible="1" ')
		Item_child2.Modify('timeitem.Format="'+is_colformat+'"')
		Item_child2.Modify('timeitem.visible="1" ')
	CASE 'int','long','numbe','real','ulong','decim'
		cbx_matchcase.visible = FALSE
//		dp_1.visible = FALSE
//		dp_2.visible = FALSE
		Item_child1.Modify('numericitem.Format="'+is_colformat+'"')
		Item_child1.Modify('numericitem.visible="1" ')
		Item_child2.Modify('numericitem.Format="'+is_colformat+'"')
		Item_child2.Modify('numericitem.visible="1" ')
	CASE ELSE
		messagebox("Error","Column type is not recognized")
		RETURN -1
END CHOOSE

end event

event closequery;if not ib_buttonpressed THEN
	cb_cancel.postevent(clicked!) //alt-F4 got us here, cancel appropriately via cb_cancel
	return 1  //neither button was pressed, don't allow close
else
	return 0
end if
end event

type dw_filter2 from datawindow within w_powerfilter_custom
integer x = 137
integer y = 348
integer width = 741
integer height = 92
integer taborder = 70
string title = "none"
string dataobject = "d_powerfilter_customfilter"
boolean border = false
end type

type dw_filter1 from datawindow within w_powerfilter_custom
integer x = 137
integer y = 160
integer width = 727
integer height = 92
integer taborder = 70
string title = "none"
string dataobject = "d_powerfilter_customfilter"
boolean border = false
end type

type cbx_matchcase from checkbox within w_powerfilter_custom
string tag = "//MULTILANG Match Case"
integer x = 32
integer y = 680
integer width = 896
integer height = 52
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Match Case"
end type

type dw_parm2 from datawindow within w_powerfilter_custom
integer x = 905
integer y = 348
integer width = 1102
integer height = 96
integer taborder = 60
string title = "none"
string dataobject = "d_powerfilter_customparm"
boolean border = false
end type

event itemchanged;/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
//IF isdate(data) THEN
//	dp_2.setvalue( datetime(date(data)))
//END IF
end event

type dw_parm1 from datawindow within w_powerfilter_custom
integer x = 905
integer y = 160
integer width = 1102
integer height = 92
integer taborder = 20
string title = "none"
string dataobject = "d_powerfilter_customparm"
boolean border = false
end type

event itemchanged;/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
//IF isdate(data) THEN
//	dp_1.setvalue( datetime(date(data)))
//END IF
end event

type st_colheader from statictext within w_powerfilter_custom
integer x = 96
integer y = 92
integer width = 2062
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "ColHeader"
boolean focusrectangle = false
end type

type st_useasterisk from statictext within w_powerfilter_custom
string tag = "//MULTILANG Use * to represent any series of characters"
integer x = 32
integer y = 564
integer width = 1810
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use * to represent any series of characters"
boolean focusrectangle = false
end type

type st_usequestionmark from statictext within w_powerfilter_custom
string tag = "//MULTILANG Use ? to represent any single character"
integer x = 32
integer y = 500
integer width = 1733
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Use ? to represent any single character"
boolean focusrectangle = false
end type

type rb_or from radiobutton within w_powerfilter_custom
string tag = "//MULTILANG Or"
integer x = 549
integer y = 272
integer width = 293
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Or"
end type

type rb_and from radiobutton within w_powerfilter_custom
string tag = " //MULTILANG And"
integer x = 215
integer y = 272
integer width = 315
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "And"
boolean checked = true
end type

type st_showrows from statictext within w_powerfilter_custom
string tag = "//MULTILANG Show rows were:"
integer x = 32
integer y = 28
integer width = 1115
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show rows where:"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_powerfilter_custom
string tag = "//MULTILANG Cancel"
integer x = 1815
integer y = 656
integer width = 347
integer height = 100
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
boolean cancel = true
end type

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/
//Cancel returns original strings back
is_returnparms.parm1 = is_OpenParms.Parm1
is_returnparms.parm2 = is_OpenParms.Parm2
is_returnparms.parm3 = is_OpenParms.Parm3
is_returnparms.parm4 = is_OpenParms.Parm4
is_returnparms.parm5 = is_OpenParms.Parm5
is_returnparms.parm9 = is_OpenParms.Parm9
is_returnparms.parm8 = 'CANCEL' //Cancel pressed
ib_buttonpressed = TRUE
closewithreturn(Parent,is_returnparms)

end event

type cb_ok from commandbutton within w_powerfilter_custom
string tag = "//MULTILANG OK"
integer x = 1435
integer y = 656
integer width = 347
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
boolean default = true
end type

event clicked;/*
	PowerFilter Datawindow Filter Service
	Copyright $$HEX2$$a9002000$$ENDHEX$$2010 James R. Reese.  All Rights Reserved.
*/

dw_parm1.accepttext( )
dw_parm2.accepttext( )

is_returnparms.parm1 = dw_filter1.GetItemString( 1,'Item')
is_returnparms.parm2 = dw_parm1.GetItemString(1,'Item')
is_returnparms.parm12 = filter_child1.getitemstring(filter_child1.getrow(),'displaytext')
is_returnparms.parm3 = dw_filter2.GetItemString( 1,'Item')
is_returnparms.parm4 = dw_parm2.GetItemString(1,'Item')
is_returnparms.parm13 = filter_child2.getitemstring(filter_child2.getrow(),'displaytext')
IF rb_and.checked THEN
	is_returnparms.parm5 = 'and'
ELSE
	is_returnparms.parm5 = 'or'
END IF
is_returnparms.parm8 = 'OK' //ok pressed
is_returnparms.parm9 = cbx_matchcase.checked //Match case if parm9=TRUE
IF is_returnparms.parm1 = '' THEN
	messagebox("Error","Error in Filter Options")
	RETURN
END IF
ib_buttonpressed = TRUE
closewithreturn(Parent,is_returnparms)
end event


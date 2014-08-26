HA$PBExportHeader$w_calendarproperties.srw
forward
global type w_calendarproperties from w_popup
end type
type dw_1 from u_dw within w_calendarproperties
end type
end forward

global type w_calendarproperties from w_popup
integer x = 1001
integer y = 1000
integer width = 2359
integer height = 1240
string title = "Calendar Properties"
dw_1 dw_1
end type
global w_calendarproperties w_calendarproperties

type variables
u_supercalendar iu_cal
end variables

on w_calendarproperties.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_calendarproperties.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;
iu_cal  = message.powerobjectparm

dw_1.setitem(1,"headercolor",iu_cal.of_getheadercolor())
dw_1.setitem(1,"headertextcolor",iu_cal.of_getheadertextcolor())
dw_1.setitem(1,"daycolor",iu_cal.of_getdaycolor())
dw_1.setitem(1,"daytextcolor",iu_cal.of_getdaytextcolor())
dw_1.setitem(1,"linecolor",iu_cal.of_getlinecolor())
dw_1.setitem(1,"unuseddaycolor",iu_cal.of_getunuseddaycolor())
dw_1.setitem(1,"footertextcolor",iu_cal.of_getfootertextcolor())
dw_1.setitem(1,"dayhovercolor",iu_cal.of_getdayhovercolor())
dw_1.setitem(1,"footercolor",iu_cal.of_getfootercolor())

if iu_cal.of_ismonthbuttons() then dw_1.setitem(1,"showmonthbuttons",1)
if iu_cal.of_isyearbuttons() then dw_1.setitem(1,"showyearbuttons",1)
if iu_cal.of_ismonthdropdown() then dw_1.setitem(1,"monthmenu",1)
if iu_cal.of_isdaynameinfooter() then dw_1.setitem(1,"showdaynameinfooter",1)
if iu_cal.of_iscolordayonhover() then dw_1.setitem(1,"colordayonhover",1)
if iu_cal.of_isshortmonthnames() then dw_1.setitem(1,"shortmonthnames",1)
if iu_cal.of_isshortdaynames() then dw_1.setitem(1,"shortdaynames",1)
end event

event resize;call super::resize;
dw_1.resize(workspacewidth(),workspaceheight())
end event

type dw_1 from u_dw within w_calendarproperties
integer width = 2318
integer height = 1136
integer taborder = 10
string dataobject = "d_properties"
boolean hscrollbar = true
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event itemchanged;call super::itemchanged;
setpointer(hourglass!)

Choose Case string(dwo.name)
		
	Case "headercolor"
		iu_cal.of_setheadercolor(long(data))
		
	Case "headertextcolor"
		iu_cal.of_setheadertextcolor(long(data))
		
	Case "daycolor"
		iu_cal.of_setdaycolor(long(data))
		
	Case "daytextcolor"
		iu_cal.of_setdaytextcolor(long(data))
		
	Case "linecolor"
		iu_cal.of_setlinecolor(long(data))
		
	Case "unuseddaycolor"
		iu_cal.of_setunuseddaycolor(long(data))
		
	Case "showmonthbuttons"
		iu_cal.of_setmonthbuttons(data = "1")
		
	Case "showyearbuttons"
		iu_cal.of_setyearbuttons(data = "1")
		
	Case "monthmenu"
		iu_cal.of_setmonthdropdown(data = "1")
		
	Case "showdaynameinfooter"
		iu_cal.of_setdaynameinfooter(data = "1")
		
	Case "footertextcolor"
		iu_cal.of_setfootertextcolor(long(data))
		
	Case "colordayonhover"
		iu_cal.of_setcolordayonhover(data = "1")
		
	Case "dayhovercolor"
		iu_cal.of_setdayhovercolor(long(data))
		
	Case "footercolor"
		iu_cal.of_setfootercolor(long(data))
		
	Case "shortmonthnames"
		iu_cal.of_setshortmonthnames(data = "1")
		
	Case "shortdaynames"
		iu_cal.of_setshortdaynames(data = "1")
		
End Choose
end event


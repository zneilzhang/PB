HA$PBExportHeader$w_main_calendarexample.srw
forward
global type w_main_calendarexample from w_main
end type
type uo_1 from u_supercalendar within w_main_calendarexample
end type
end forward

global type w_main_calendarexample from w_main
integer width = 2834
integer height = 1432
string title = "Calendar Example App"
uo_1 uo_1
end type
global w_main_calendarexample w_main_calendarexample

type variables

end variables
on w_main_calendarexample.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_main_calendarexample.destroy
call super::destroy
destroy(this.uo_1)
end on

event resize;call super::resize;
uo_1.resize(this.workspacewidth(),this.workspaceheight())
end event

event open;call super::open;of_setbase(TRUE)
inv_base.of_center()

//uo_1.of_setdaynameinfooter(TRUE)
//uo_1.of_setcolordayonhover(TRUE)
//uo_1.of_setdayhovercolor(rgb(166,202,240))

uo_1.of_setmonth(today())


end event
event pfc_postopen;call super::pfc_postopen;


if messagebox("Calendar Example Application","Welcome to the Calendar Example Application!~r~n~r~nTo edit a day, just double click the day.~r~n~r~nWould you like to open the Calendar Properties window now?",Question!,YesNo!) = 1 then

	openwithparm(w_calendarproperties,uo_1)

end if
end event

type uo_1 from u_supercalendar within w_main_calendarexample
integer height = 1204
integer taborder = 50
end type

on uo_1.destroy
call u_supercalendar::destroy
end on

event calendar_daydoubleclicked;call super::calendar_daydoubleclicked;n_cst_dayattrib lnv_dayattrib

lnv_dayattrib.id_day = ad_day
lnv_dayattrib.is_text = uo_1.of_getdaytext(ad_day)
lnv_dayattrib.il_color = uo_1.of_getdaycolor(ad_day)
lnv_dayattrib.is_picture = uo_1.of_getdaypicture(ad_day)

openwithparm(w_editday,lnv_dayattrib)

lnv_dayattrib = message.powerobjectparm

if isnull(lnv_dayattrib) or NOT isvalid(lnv_dayattrib) then return

uo_1.of_setdaytext(ad_day,lnv_dayattrib.is_text)
uo_1.of_setdaycolor(ad_day,lnv_dayattrib.il_color)
uo_1.of_setdaypicture(ad_day,lnv_dayattrib.is_picture)
end event


HA$PBExportHeader$u_supercalendar.sru
forward
global type u_supercalendar from u_base
end type
type pb_nextyear from u_pb within u_supercalendar
end type
type cb_nextmonth from u_cb within u_supercalendar
end type
type pb_prevyear from u_pb within u_supercalendar
end type
type cb_prevmonth from u_cb within u_supercalendar
end type
type dw_cal from u_dw within u_supercalendar
end type
type timing_hover from timing within u_supercalendar
end type
end forward

global type u_supercalendar from u_base
integer width = 2656
integer height = 1176
boolean border = true
event calendar_premonthmenu ( ref m_calendar_monthselection am_monthmenu )
event calendar_dayselected ( date ad_day )
event calendar_monthchanged ( date ad_newmonth )
event calendar_daychanged ( date ad_day )
event calendar_daydoubleclicked ( date ad_day )
event calendar_dayrightclicked ( date ad_day )
pb_nextyear pb_nextyear
cb_nextmonth cb_nextmonth
pb_prevyear pb_prevyear
cb_prevmonth cb_prevmonth
dw_cal dw_cal
timing_hover timing_hover
end type
global u_supercalendar u_supercalendar

type variables

Private:

integer				ii_year
integer				ii_month

n_cst_datetime		inv_datetime

boolean				ib_monthmenuopen

integer				ii_hoverrow

long					il_headercolor = rgb(0,0,128)
long					il_headertextcolor = rgb(255,251,240)
long					il_daytextcolor = 33554592
long					il_daycolor = 1087434968
long					il_linecolor = 268435456
long					il_unuseddaycolor = 78682240
long					il_footercolor = rgb(0,0,128)
long					il_footertextcolor = rgb(255,251,240)
long					il_dayhovercolor = rgb(166,202,240)

boolean				ib_showmonthbuttons = TRUE
boolean				ib_showyearbuttons = TRUE
boolean				ib_monthdropdown = TRUE
boolean				ib_showdaynameinfooter = FALSE
boolean				ib_colordayonhover = FALSE

boolean				ib_shortmonthnames
boolean				ib_shortdaynames

CONSTANT long		HEADERHEIGHT = 41
CONSTANT long		FOOTERHEIGHT = 19
CONSTANT long		INSIDELINEWIDTH = 3
CONSTANT long		OUTSIDELINEWIDTH = 2
CONSTANT long		DAYNAMEINDENT = 2

nonvisualobject	inv_model
end variables

forward prototypes
public function date of_decrementmonth ()
private function integer of_getcorrespondingrow (date ad_day)
public function long of_getdaycolor ()
public function long of_getdayhovercolor ()
public function long of_getdaytextcolor ()
public function long of_getfootercolor ()
public function long of_getfootertextcolor ()
public function long of_getheadercolor ()
public function long of_getheadertextcolor ()
public function long of_getlinecolor ()
public function date of_getmonth ()
public function date of_decrementyear ()
public function date of_incrementyear ()
public function boolean of_isdaynameinfooter ()
public function boolean of_ismonthdropdown ()
public function boolean of_isshortmonthnames ()
public function date of_getselectedday ()
public function long of_getunuseddaycolor ()
public function date of_incrementmonth ()
public function boolean of_iscolordayonhover ()
public function boolean of_ismonthbuttons ()
public function boolean of_isshortdaynames ()
public function boolean of_isyearbuttons ()
private function integer of_resetmonthname ()
public function integer of_resizebuttons ()
public function integer of_setcolordayonhover (boolean ab_switch)
public function integer of_setdaycolor (long al_color)
public function integer of_setdayhovercolor (long al_color)
public function integer of_setdaytextcolor (long al_color)
public function integer of_setfootercolor (long al_color)
public function integer of_setfootertextcolor (long al_color)
public function integer of_setheadercolor (long al_color)
public function integer of_setheadertextcolor (long al_color)
public function integer of_setlinecolor (long al_color)
public function integer of_setmonthbuttons (boolean ab_switch)
public function integer of_setmonthdropdown (boolean ab_switch)
public function integer of_setshortdaynames (boolean ab_switch)
public function integer of_setshortmonthnames (boolean ab_switch)
private function integer of_settext (date ad_day, string as_text)
public function integer of_setunuseddaycolor (long al_color)
public function integer of_setyearbuttons (boolean ab_switch)
private function boolean of_canselectrow (integer ai_row)
public function integer of_setdaynameinfooter (boolean ab_switch)
private function integer of_setcolor (date ad_day, long al_color)
public function integer of_setpicture (date ad_day, string as_picture)
public function long of_getdaycolor (date ad_day)
public function string of_getdaypicture (date ad_day)
public subroutine of_setdaycolor (date ad_day, long al_color)
public subroutine of_setdaypicture (date ad_day, string as_picture)
public subroutine of_setdaytext (date ad_day, string as_text)
public function string of_getdaytext (date ad_day)
public function integer of_setmonth (date ad_date)
public function integer of_setmodel (nonvisualobject anv_model)
public function nonvisualobject of_getmodel ()
end prototypes

event calendar_premonthmenu;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			calendar_premonthmenu
//
//	Arguments:		m_calendar_monthselection BY REFERENCE
//
//	Description:	Triggered before the popup menu is opened, allowing you to
//						modify the menu.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

am_monthmenu.m_popup.m_january.text = "January " + string(ii_year)
am_monthmenu.m_popup.m_february.text = "February " + string(ii_year)
am_monthmenu.m_popup.m_march.text = "March " + string(ii_year)
am_monthmenu.m_popup.m_april.text = "April " + string(ii_year)
am_monthmenu.m_popup.m_may.text = "May " + string(ii_year)
am_monthmenu.m_popup.m_june.text = "June " + string(ii_year)
am_monthmenu.m_popup.m_july.text = "July " + string(ii_year)
am_monthmenu.m_popup.m_august.text = "August " + string(ii_year)
am_monthmenu.m_popup.m_september.text = "September " + string(ii_year)
am_monthmenu.m_popup.m_october.text = "October " + string(ii_year)
am_monthmenu.m_popup.m_november.text = "November " + string(ii_year)
am_monthmenu.m_popup.m_december.text = "December " + string(ii_year)


end event

event calendar_daychanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			calendar_daychanged
//
//	Arguments:		date		day that has changed
//
//	Description:	This event should be fired by the model when a day's text
//						or color has changed.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_color
string ls_text,ls_picture

//Model should always be valid here.. it triggered this event
if isvalid(inv_model) then

	ls_text = inv_model.function dynamic of_getdaytext(ad_day)
	ll_color = inv_model.function dynamic of_getdaycolor(ad_day)
	ls_picture = inv_model.function dynamic of_getdaypicture(ad_day)
	
	of_settext(ad_day,ls_text)
	of_setcolor(ad_day,ll_color)
	of_setpicture(ad_day,ls_picture)
	
end if

end event

public function date of_decrementmonth ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_decrementmonth()
//
//	Returns:  		Date  The first day of the newly displayed month
//
//	Description:	Updates the display to the previous month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
date ld_newmonth
int li_year, li_month

li_month = ii_month
li_year = ii_year

if li_month = 1 then
	li_month = 12
	li_year --
else
	li_month --
end if

ld_newmonth = date(li_year,li_month,1)

of_setmonth(ld_newmonth)

return ld_newmonth
end function

private function integer of_getcorrespondingrow (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getcorrespondingrow
//
//	Arguments:		Date
//
//	Returns:  		integer
//
//	Description:	INTERNAL USE.  Returns the row where the date is being 
//						displayed.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_row,li_firstday

li_firstday = daynumber(date(year(ad_day),month(ad_day),1))

li_row = day(ad_day) + li_firstday - 1

return li_row
end function

public function long of_getdaycolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaycolor
//
//	Returns:  		long
//
//	Description:	Returns the RGB value for the day background color.  This is
//						the default day color and can be overridden by setting a color
//						for a specific day.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_daycolor
end function

public function long of_getdayhovercolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdayhovercolor
//
//	Returns:  		long
//
//	Description:	Returns the color a day will be if the hovering feature is 
//						enabled and the mouse hovers over a day.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_dayhovercolor
end function

public function long of_getdaytextcolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaytextcolor
//
//	Returns:  		long
//
//	Description:	Returns the RGB color for the text within days.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_daytextcolor
end function

public function long of_getfootercolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getfootercolor
//
//	Returns:  		long
//
//	Description:	Returns the background color of the footer.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_footercolor
end function

public function long of_getfootertextcolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getfootertextcolor
//
//	Returns:  		long
//
//	Description:	Returns the color of the text within the footer.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_footertextcolor
end function

public function long of_getheadercolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getheadercolor
//
//	Returns:  		long
//
//	Description:	Returns the background color of the header.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_headercolor
end function

public function long of_getheadertextcolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getheadertextcolor
//
//	Returns:  		long
//
//	Description:	Returns the RGB color the the text within the header,
//						including the month and day names.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_headertextcolor
end function

public function long of_getlinecolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getlinecolor
//
//	Returns:  		long
//
//	Description:	Returns the color of the grid-like lines that seperate days.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_linecolor
end function

public function date of_getmonth ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getmonth
//
//	Returns:  		Date		The first day of the currently displayed month.
//
//	Description:	Returns the first day of the currently displayed month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return date(ii_year,ii_month,1)
end function

public function date of_decrementyear ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_decrementyear
//
//	Returns:			Date   The first day of the newly displayed month
//
//	Description:	Updates the display to the previous year.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
date ld_newmonth

ld_newmonth = date(ii_year - 1,ii_month,1)

of_setmonth(ld_newmonth)

return ld_newmonth
end function

public function date of_incrementyear ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_incrementyear
//
//	Returns:  		date		The first day of the newly displayed month.
//
//	Description:	Updates the display by one year.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
date ld_newmonth

ld_newmonth = date(ii_year + 1,ii_month,1)

of_setmonth(ld_newmonth)

return ld_newmonth
end function

public function boolean of_isdaynameinfooter ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_isdaynameinfooter
//
//	Returns:  		Boolean
//
//	Description:	Returns the status of the footer feature.  If selected a
//						footer will be displayed with the name of the day the mouse
//						is currently over.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
return ib_showdaynameinfooter
end function

public function boolean of_ismonthdropdown ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_monthdropdown
//
//	Returns:  		Boolean
//
//	Description:	Returns the status of the month dropdown feature.  If the 
//						feature is selected the user will be able to click on the
//						month name to access a popup menu list of all the months
//						for the displayed year.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return ib_monthdropdown
end function

public function boolean of_isshortmonthnames ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_isshortmonthnames
//
//	Returns:  		Boolean
//
//	Description:	TRUE = short names (Jan,Feb,Mar...)
//						FALSE = long names (January,Febuary,March...)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
return ib_shortmonthnames
end function

public function date of_getselectedday ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getselectedday
//
//	Returns:  		date
//
//	Description:	Returns the currently selected day.  If no day is selected
//						it will return NULL.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_row
date ld_null
setnull(ld_null)

li_row = dw_cal.getselectedrow(0)

if li_row < 1 then return ld_null

return date(ii_year,ii_month,dw_cal.getitemnumber(li_row,"number"))
end function

public function long of_getunuseddaycolor ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getunuseddaycolor
//
//	Returns:  		long
//
//	Description:	Returns the background color of the day cells that are not
//						used for any given month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return il_unuseddaycolor
end function

public function date of_incrementmonth ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_incrementmonth
//
//	Returns:  		Date		The first day of the newly displayed month.
//
//	Description:	Updates the display to the next month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
date ld_newmonth
int li_year, li_month

li_month = ii_month
li_year = ii_year

if li_month = 12 then
	li_month = 1
	li_year ++
else
	li_month ++
end if

ld_newmonth = date(li_year,li_month,1)

of_setmonth(ld_newmonth)

return ld_newmonth
end function

public function boolean of_iscolordayonhover ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_iscolordayonhover
//
//	Returns:  		Boolean
//
//	Description:	Returns the status of the hover feature.  If the feature is
//						is selected a day will be colored when the mouse passes over
//						it.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return ib_colordayonhover
end function

public function boolean of_ismonthbuttons ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_ismonthbuttons
//
//	Returns:  		Boolean
//
//	Description:	TRUE = monthbuttons are displayed.
//						FALSE = there not
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return ib_showmonthbuttons
end function

public function boolean of_isshortdaynames ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_isshortdaynames
//
//	Returns:  		Boolean
//
//	Description:	TRUE = short names (Mon,Tue,Wed...)
//						FALSE = long names (Monday,Tuesday,Wednesday..)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return ib_shortdaynames
end function

public function boolean of_isyearbuttons ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_isyearbuttons
//
//	Returns:  		Boolean
//
//	Description:	TRUE = year buttons are displayed
//						FALSE = monkeys like bananas
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return ib_showyearbuttons
end function

private function integer of_resetmonthname ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_resetmonthname
//
//	Returns:  		integer (SUCCESS or 1)
//
//	Description:	Resets month display text, the length of the text box
//						according the text, and the position of the down arrow.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
n_cst_platform lnv_platform
string ls_monthname
window lw_parent
int li_height,li_width

//Set the Title.
ls_monthname = inv_datetime.of_MonthName(ii_month)
if ib_shortmonthnames then ls_monthname = left(ls_monthname,3)
dw_cal.Object.t_month.text = ls_monthname + " " + string(ii_year)

f_setplatform(lnv_platform,TRUE)

of_getparentwindow(lw_parent)
lnv_platform.of_gettextsize(lw_parent,ls_monthname + " " + string(ii_year),"Tahoma",12,TRUE,FALSE,FALSE,li_height,li_width)

f_setplatform(lnv_platform,FALSE)

dw_cal.object.t_month.width = li_width
dw_cal.object.t_dwnarrow.x = long(dw_cal.object.t_month.x) + long(dw_cal.object.t_month.width) + 2
dw_cal.object.t_monthborder.width = long(dw_cal.object.t_dwnarrow.x) + long(dw_cal.object.t_dwnarrow.width) - long(dw_cal.object.t_monthborder.x)
dw_cal.object.t_daytext.text = ""

return SUCCESS
end function

public function integer of_resizebuttons ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_resizebuttons
//
//	Returns:  		integer (SUCCESS or 1)
//
//	Description:	Repositions and make visible/invisible the month and year
//						navigation buttons.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

if ib_showmonthbuttons <> cb_nextmonth.visible then
	cb_nextmonth.visible = ib_showmonthbuttons
	cb_prevmonth.visible = ib_showmonthbuttons
end if

if ib_showyearbuttons <> pb_nextyear.visible then
	pb_nextyear.visible = ib_showyearbuttons
	pb_prevyear.visible = ib_showyearbuttons
end if

if NOT ib_showmonthbuttons and not ib_showyearbuttons then return SUCCESS

if ib_showmonthbuttons and ib_showyearbuttons then
	cb_nextmonth.x = width - cb_nextmonth.width - 50
	pb_nextyear.x = cb_nextmonth.x - pb_nextyear.width
	pb_prevyear.x = pb_nextyear.x - pb_prevyear.width
	cb_prevmonth.x = pb_prevyear.x - cb_prevmonth.width
elseif ib_showmonthbuttons and NOT ib_showyearbuttons then
	cb_nextmonth.x = width - cb_nextmonth.width - 50
	cb_prevmonth.x = cb_nextmonth.x - cb_prevmonth.width
elseif NOT ib_showmonthbuttons and ib_showyearbuttons then
	pb_nextyear.x = width - pb_nextyear.width - 50
	pb_prevyear.x = pb_nextyear.x - pb_prevyear.width
end if

return SUCCESS
end function

public function integer of_setcolordayonhover (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setcolordayonhover
//
//	Arguments:		Boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Toggles the color day on hover feature.  If the feature is
//						is selected a day will be colored when the mouse passes over
//						it.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

ib_colordayonhover = ab_switch

if ab_switch = FALSE and ii_hoverrow > 0 then
	dw_cal.setitem(ii_hoverrow,"ishovering",0)
end if

if ab_switch = TRUE then
	of_setdayhovercolor(il_dayhovercolor)
end if

return SUCCESS
end function

public function integer of_setdaycolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaycolor
//
//	Arguments:		long		New default day background color
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the default background color for days.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
string ls_expression1 = "if (number = 0,"
string ls_expression2 = ",if ( ishovering = 1,"
string ls_expression3 = ",if ( isnull(backcolor) ,"
string ls_expression4 = ", backcolor)))"
string ls_expression

ls_expression = ls_expression1 + string(il_unuseddaycolor) + ls_expression2 + string(il_dayhovercolor) + ls_expression3 + string(al_color) + ls_expression4
ls_expression = "'0~t" + ls_expression + "'"

if dw_cal.modify("day_1.background.color = " + ls_expression + " day_2.background.color = " + ls_expression + " day_3.background.color = " + ls_expression + " day_4.background.color = " + ls_expression + " day_5.background.color = " + ls_expression + " day_6.background.color = " + ls_expression + " day_7.background.color = " + ls_expression) = "" then
	il_daycolor = al_color
	return SUCCESS
else
	return FAILURE
end if
end function

public function integer of_setdayhovercolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdayhovercolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the color a day will be if the mouse passes over it 
//						when the color day on hover feature is enabled.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

string ls_expression1 = "if (number = 0,"
string ls_expression2 = ",if ( ishovering = 1,"
string ls_expression3 = ",if ( isnull(backcolor),"
string ls_expression4 = ", backcolor)))"
string ls_expression

ls_expression = ls_expression1 + string(il_unuseddaycolor) + ls_expression2 + string(al_color) + ls_expression3 + string(il_daycolor) + ls_expression4
ls_expression = "'0~t" + ls_expression + "'"

if dw_cal.modify("day_1.background.color = " + ls_expression + " day_2.background.color = " + ls_expression + " day_3.background.color = " + ls_expression + " day_4.background.color = " + ls_expression + " day_5.background.color = " + ls_expression + " day_6.background.color = " + ls_expression + " day_7.background.color = " + ls_expression) = "" then
	il_dayhovercolor = al_color
	return SUCCESS
else
	return FAILURE
end if
end function

public function integer of_setdaytextcolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaytextcolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the color for the text within the day cells.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

if dw_cal.modify("day_1.color = " + string(al_color) + " day_2.color = " + string(al_color) + " day_3.color = " + string(al_color) + " day_4.color = " + string(al_color) + " day_5.color = " + string(al_color) + " day_6.color = " + string(al_color) + " day_7.color = " + string(al_color) + " number_1.color = " + string(al_color) + " number_2.color = " + string(al_color) + " number_3.color = " + string(al_color) + " number_4.color = " + string(al_color) + " number_5.color = " + string(al_color) + " number_6.color = " + string(al_color) + " number_7.color = " + string(al_color)) = "" then
	il_daytextcolor = al_color
	return SUCCESS
else
	return FAILURE
end if
end function

public function integer of_setfootercolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setfootercolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the background color of the footer.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

il_footercolor = al_color

dw_cal.modify("datawindow.footer.color = " + string(al_color))

return SUCCESS
end function

public function integer of_setfootertextcolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setfootertextcolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the color of the text dislayed in the footer.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

dw_cal.modify("t_daytext.color = " + string(al_color))

il_footertextcolor = al_color

return SUCCESS
end function

public function integer of_setheadercolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setheadercolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the background color of the header.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

if dw_cal.modify("DataWindow.Header.Color = " + string(al_color)) = "" then
	il_headercolor = al_color
	return SUCCESS
else
	return FAILURE
end if
end function

public function integer of_setheadertextcolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setheadertextcolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the color of the text within the header, including the
//						month and day names.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

if dw_cal.modify("t_month.color = " + string(al_color) + " t_dwnarrow.color = " + string(al_color) + " t_sunday.color = " + string(al_color) + " t_monday.color = " + string(al_color) + " t_tuesday.color = " + string(al_color) + " t_wednesday.color = " + string(al_color) + " t_thursday.color = " + string(al_color) + " t_friday.color = " + string(al_color) + " t_saturday.color = " + string(al_color)) = "" then
	il_headertextcolor = al_color
	return SUCCESS
else
	return FAILURE
end if

end function

public function integer of_setlinecolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setlinecolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the color of the lines which seperate day cells.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

if dw_cal.modify("datawindow.color = " + string(al_color)) = "" then
	il_linecolor = al_color
	return SUCCESS
else
	return FAILURE
end if
end function

public function integer of_setmonthbuttons (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setmonthbuttons
//
//	Arguments:		boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Toggles the visibility of the month navigation buttons.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

setredraw(FALSE)

ib_showmonthbuttons = ab_switch
of_resizebuttons()

setredraw(TRUE)

return SUCCESS
end function

public function integer of_setmonthdropdown (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setmonthdropdown
//
//	Arguments:		boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Enables/disables the month dropdown available when you click
//						on the month name.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

if ab_switch then
	dw_cal.modify("t_dwnarrow.visible = 1")
else
	dw_cal.modify("t_dwnarrow.visible = 0")
end if

ib_monthdropdown = ab_switch

return SUCCESS
end function

public function integer of_setshortdaynames (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setshortdaynames
//
//	Arguments:		Boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	TRUE = show short day names (Mon,Tue,Wed...)
//						FALSE = show long names (Monday, Tuesday, Wednesday..)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////


if ab_switch then
	dw_cal.modify("t_sunday.text = 'Do' t_monday.text = 'Lu' t_tuesday.text = 'Ma' t_wednesday.text = 'Mi' t_thursday.text = 'Ju' t_friday.text = 'Vi' t_saturday.text = 'Sa'")
else
	dw_cal.modify("t_sunday.text = 'Domingo' t_monday.text = 'Lunes' t_tuesday.text = 'Martes' t_wednesday.text = 'Miercoles' t_thursday.text = 'Jueves' t_friday.text = 'Viernes' t_saturday.text = 'Sabado'")
end if

ib_shortdaynames = ab_switch

return SUCCESS
end function

public function integer of_setshortmonthnames (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setshortmonthnames
//
//	Arguments:		Boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	TRUE = show short names (Jan,Feb,Mar...)
//						FALSE = Show long names (January, February,March..)
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

ib_shortmonthnames = ab_switch

of_resetmonthname()

return SUCCESS
end function

private function integer of_settext (date ad_day, string as_text);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_settext
//
//	Arguments:		date		date whose text to change
//						string	string to set the day's text to
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Updates the day cell's DISPLAY for the passed day.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_row

li_row = of_getcorrespondingrow(ad_day)

if li_row < 1 or li_row > 42 then return FAILURE

if trim(as_text) = "" then setnull(as_text)

dw_cal.setitem(li_row,"day","~r~n" + as_text)

return SUCCESS
end function

public function integer of_setunuseddaycolor (long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setunuseddaycolor
//
//	Arguments:		long
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Sets the color for the day cells that aren't being used.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
string ls_expression1 = "if (number = 0,"
string ls_expression2 = ",if ( ishovering = 1,"
string ls_expression3 = ",if ( isnull(backcolor) ,"
string ls_expression4 = ", backcolor)))"
string ls_expression

ls_expression = ls_expression1 + string(al_color) + ls_expression2 + string(il_dayhovercolor) + ls_expression3 + string(il_daycolor) + ls_expression4
ls_expression = "'0~t" + ls_expression + "'"

if dw_cal.modify("day_1.background.color = " + ls_expression + " day_2.background.color = " + ls_expression + " day_3.background.color = " + ls_expression + " day_4.background.color = " + ls_expression + " day_5.background.color = " + ls_expression + " day_6.background.color = " + ls_expression + " day_7.background.color = " + ls_expression) = "" then
	il_unuseddaycolor = al_color
	return SUCCESS
else
	return FAILURE
end if
end function

public function integer of_setyearbuttons (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setyearbuttons
//
//	Arguments:		Boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Toggles the visibility of the year navigation buttons.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

setredraw(FALSE)

ib_showyearbuttons = ab_switch
of_resizebuttons()

setredraw(TRUE)

return SUCCESS
end function

private function boolean of_canselectrow (integer ai_row);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_canselectrow
//
//	Arguments:		integer  ai_row
//
//	Returns:  		Boolean
//
//	Description:	INTERNAL USE.  Returns TRUE if the row passed in is a valid
//						day and therefore can be selected.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
if ai_row < 1 then return FALSE

if dw_cal.getitemnumber(ai_row,"number") = 0 then return FALSE

return TRUE
end function

public function integer of_setdaynameinfooter (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaynameinfooter
//
//	Arguments:		Boolean
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Toggles the footer on or off.  If this feature is on the
//						name of the day which the mouse is currently over will be
//						displayed in the footer.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

ib_showdaynameinfooter = ab_switch

this.event resize(0,0,0)


return SUCCESS
end function

private function integer of_setcolor (date ad_day, long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setcolor
//
//	Arguments:		date		Day of the color to change
//						long		New color
//
//	Returns:  		integer 
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	INTERNAL USE.  UPDATES THE DISPLAY ONLY, DOES NOT UPDATE 
//						THE MODEL.  Sets the background color for the passed day.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int		li_row

li_row = of_getcorrespondingrow(ad_day)

if li_row < 1 or li_row > 42 then return FAILURE

dw_cal.setitem(li_row,"backcolor",al_color)

return SUCCESS
end function

public function integer of_setpicture (date ad_day, string as_picture);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setpicture
//
//	Arguments:		date		Day to change
//						string	filename of the picture
//
//	Returns:  		integer 
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	INTERNAL USE.  UPDATES THE DISPLAY ONLY, DOES NOT UPDATE 
//						THE MODEL.  Sets the picture icon for the passed day.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int		li_row

li_row = of_getcorrespondingrow(ad_day)

if li_row < 1 or li_row > 42 then return FAILURE

if trim(as_picture) = "" then setnull(as_picture)

dw_cal.setitem(li_row,"picture",as_picture)

return SUCCESS
end function

public function long of_getdaycolor (date ad_day);return inv_model.function dynamic of_getdaycolor(ad_day)

end function

public function string of_getdaypicture (date ad_day);return inv_model.function dynamic of_getdaypicture(ad_day)
end function

public subroutine of_setdaycolor (date ad_day, long al_color);
inv_model.function dynamic of_setdaycolor(ad_day,al_color)
end subroutine

public subroutine of_setdaypicture (date ad_day, string as_picture);
inv_model.function dynamic of_setdaypicture(ad_day,as_picture)
end subroutine

public subroutine of_setdaytext (date ad_day, string as_text);
inv_model.function dynamic of_setdaytext(ad_day,as_text)
end subroutine

public function string of_getdaytext (date ad_day);return inv_model.function dynamic of_getdaytext(ad_day)
end function

public function integer of_setmonth (date ad_date);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setmonth
//
//	Arguments:		date		date containing the new month to display
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Updates the calendar's display to the passed month.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
Integer 	li_month, li_year, li_c
Integer  li_FirstDayNum, li_daysinmonth
Integer	li_days[12]={31,28,31,30,31,30,31,31,30,31,30,31}
string 	ls_days[42]
long		ll_null
string	ls_null
setnull(ls_null)
setnull(ll_null)
string	ls_daytext,ls_daypicture
long		ll_daycolor
date		ld_day

// Check the argument(s).
If IsNull(ad_date) or ad_date = date("50/50/1900") Then
	Return FAILURE
End If			 

dw_cal.object.t_monthborder.border = 0

setpointer(Hourglass!)
setredraw(FALSE)

dw_cal.selectrow(0,FALSE)

li_year = Year(ad_date)
li_month = Month(ad_date)

ii_year = li_year
ii_month = li_month

of_resetmonthname()

//The following couple of lines were "borrowed" from the PFC

//--Determine the number of days in the month.--
// Get the number of days per month for a non leap year.
li_daysinmonth = li_days[li_month]
// Check for a leap year.
If li_month=2 Then
	If ( (Mod(li_year,4) = 0 And Mod(li_year,100) <> 0) Or (Mod(li_year,400) = 0) ) Then
		li_daysinmonth = 29
	End If
End If

li_FirstDayNum = DayNumber(Date(li_year, li_month, 1))

//Refresh the dw
For li_c = 1 to 42
	
	//Set the day number
	if li_c < li_firstdaynum or li_c > (li_daysinmonth + li_firstdaynum - 1) then
		dw_cal.setitem(li_c,"number",0)
	else
		dw_cal.setitem(li_c,"number",(li_c - li_firstdaynum + 1))
	end if
	
	//Reset the day text
	if NOT isnull(dw_cal.getitemstring(li_c,"day")) then
		dw_cal.setitem(li_c,"day",ls_null)
	end if
	
	//Reset the day color
	if NOT isnull(dw_cal.getitemnumber(li_c,"backcolor")) then
		dw_cal.setitem(li_c,"backcolor",ll_null)
	end if
	
	//Reset the day picture
	if NOT isnull(dw_cal.getitemstring(li_c,"picture")) then
		dw_cal.setitem(li_c,"picture",ls_null)
	end if
Next

//If we have an associated model, then pull any data for this month.
For li_c = 1 to li_daysinmonth
	ld_day = date(ii_year,ii_month,li_c)
	
	//Get text from the model
	ls_daytext = inv_model.function dynamic of_getdaytext(ld_day)
	//Update the day display with the text
	if NOT isnull(ls_daytext) then of_settext(ld_day,ls_daytext)

	//Get the day color from the model
	ll_daycolor = inv_model.function dynamic of_getdaycolor(ld_day)
	//Update the day display with the color
	if NOT isnull(ll_daycolor) then of_setcolor(ld_day,ll_daycolor)
	
	//Get the picture from the model
	ls_daypicture = inv_model.function dynamic of_getdaypicture(ld_day)
	//Update the day display with the picture
	if NOT isnull(ls_daypicture) then of_setpicture(ld_day,ls_daypicture)
Next

SetRedraw(TRUE)

this.event calendar_monthchanged(ad_date)

return SUCCESS
end function

public function integer of_setmodel (nonvisualobject anv_model);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setmodel
//
//	Arguments:		nonvisualobject		the model to link to this calendar
//
//	Returns:  		integer
//						SUCCESS = 1
//						FAILURE = -1
//
//	Description:	Links the passed model to this calendar.  This model must
//						either be inherited from the abstract model class,
//						n_cst_abstractsupercalendarmodel, or it must implement
//						seven methods:  
//							of_getdaytext(date) returns string
//							of_getdaycolor(date) returns long
//							of_getdaypicture(date) returns string
//							of_setdaytext(date,string) returns (None)
//							of_setdaycolor(date,long) returns (None)
//							of_setdaypicture(date,string) returns (None)
//							of_addcalendarlistener(powerobject) returns integer
//
//						The model is responsible for all data associated with
//						the calendar.  When the calendar updates it's display, it
//						will pull the appropriate data from the model.  If the 
//						model is updated it is responsible for notifying the 
//						calendar by	triggering the calendar_daychanged event.  If you
//						are extending the abstractsupercalendarmodel you need only
//						call of_firedaychanged() which will trigger calendar_daychanged.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
n_cst_metaclass lnv_metaclass
string ls_arguments[]

if NOT isvalid(anv_model) then return FAILURE

//We must rely on garbace collection to clean up our old model because we
//cannot assume that this is the only object that has a reference to it and
//therefore we cannot destroy it.

//Verify model's interface
if lnv_metaclass.of_isancestorclass(anv_model.classdefinition,"n_cst_abstractsupercalendarmodel") then
	//The model has inherited the interface from the default model
else
	ls_arguments[1] = "date"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_getdaytext",ls_arguments) then
		return FAILURE
	end if
	
	ls_arguments[1] = "date"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_getdaycolor",ls_arguments) then
		return FAILURE
	end if
	
	ls_arguments[1] = "date"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_getdaypicture",ls_arguments) then
		return FAILURE
	end if
	
	ls_arguments[1] = "powerobject"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_addcalendarlistener",ls_arguments) then
		return FAILURE
	end if
	
	ls_arguments[1] = "date"
	ls_arguments[2] = "string"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_setdaytext",ls_arguments) then
		return FAILURE
	end if
		
	ls_arguments[1] = "date"
	ls_arguments[2] = "long"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_setdaycolor",ls_arguments) then
		return FAILURE
	end if
		
	ls_arguments[1] = "date"
	ls_arguments[2] = "string"
	if NOT lnv_metaclass.of_isfunctiondefined(anv_model.classdefinition,"of_setdaypicture",ls_arguments) then
		return FAILURE
	end if
	
end if

inv_model = anv_model

inv_model.function dynamic of_addcalendarlistener(this)

return SUCCESS
end function

public function nonvisualobject of_getmodel ();return inv_model
end function

on u_supercalendar.create
int iCurrent
call super::create
this.pb_nextyear=create pb_nextyear
this.cb_nextmonth=create cb_nextmonth
this.pb_prevyear=create pb_prevyear
this.cb_prevmonth=create cb_prevmonth
this.dw_cal=create dw_cal
this.timing_hover=create timing_hover
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_nextyear
this.Control[iCurrent+2]=this.cb_nextmonth
this.Control[iCurrent+3]=this.pb_prevyear
this.Control[iCurrent+4]=this.cb_prevmonth
this.Control[iCurrent+5]=this.dw_cal
end on

on u_supercalendar.destroy
call super::destroy
destroy(this.pb_nextyear)
destroy(this.cb_nextmonth)
destroy(this.pb_prevyear)
destroy(this.cb_prevmonth)
destroy(this.dw_cal)
destroy(this.timing_hover)
end on

event resize;call super::resize;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			resize
//
//	Description:	Arrgghh this was annoying to code... 
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_daywidth,li_dayheight, li_reps
int li_widthmod,li_heightmod,li_footerheight

setredraw(FALSE)

dw_cal.resize(width,height)

//Determine the width of each day cell
li_daywidth = (unitstopixels(width,xunitstopixels!) - (2*OUTSIDELINEWIDTH) - (6*INSIDELINEWIDTH) - 2)/7
//Now how much is left over
li_widthmod = mod((unitstopixels(width,xunitstopixels!) - (2*OUTSIDELINEWIDTH) - (6*INSIDELINEWIDTH) - 2),7)

//Determine the height of each day cell but it will change if the footer visible
if ib_showdaynameinfooter then
	//Determine the height of each day cell
	li_dayheight = (unitstopixels(height,yunitstopixels!) - HEADERHEIGHT - (2*OUTSIDELINEWIDTH) - (4*INSIDELINEWIDTH) - 2)/6
	//Now how much is left over here too
	li_heightmod = mod((unitstopixels(height,yunitstopixels!) - HEADERHEIGHT - (2*OUTSIDELINEWIDTH) - (4*INSIDELINEWIDTH) - 2),6)
else
	//Determine the height of each day cell
	li_dayheight = (unitstopixels(height,yunitstopixels!) - HEADERHEIGHT)/6
	//Once again we need to see how much is left over
	li_heightmod = mod((unitstopixels(height,yunitstopixels!) - HEADERHEIGHT),6)
end if

//If the footer is visible then determine the footer height
if ib_showdaynameinfooter then
	//If the footer is visible we want it to take up any left over space we 
	//had after we determined the day height
	li_footerheight = FOOTERHEIGHT + (li_heightmod - OUTSIDELINEWIDTH) -1
	dw_cal.modify("datawindow.footer.height = " + string(li_footerheight))
else
	dw_cal.modify("datawindow.footer.height = 0")
end if

//Now set all the dimensions
//First line is the day headers' width, next is the day cells' width, next is the day headers' X position
//next is the day cells' X position, next is the numbers' X position, finally the day cells' height
dw_cal.modify(" t_sunday.width = " + string(li_daywidth) + " t_monday.width = " + string(li_daywidth) + " t_tuesday.width = " + string(li_daywidth) + " t_wednesday.width = " + string(li_daywidth) + " t_thursday.width = " + string(li_daywidth) + " t_friday.width = " + string(li_daywidth) + " t_saturday.width = " + string(li_daywidth) + &
" day_1.width = " + string(li_daywidth) + " day_2.width = " + string(li_daywidth) + " day_3.width = " + string(li_daywidth) + " day_4.width = " + string(li_daywidth) + " day_5.width = " + string(li_daywidth) + " day_6.width = " + string(li_daywidth) + " day_7.width = " + string(li_daywidth + li_widthmod) + &
" t_monday.x = " + string(DAYNAMEINDENT + li_daywidth + INSIDELINEWIDTH) + " t_tuesday.x = " + string(DAYNAMEINDENT + (2*(li_daywidth + INSIDELINEWIDTH))) + " t_wednesday.x = " + string(DAYNAMEINDENT + (3*(li_daywidth + INSIDELINEWIDTH))) + " t_thursday.x = " + string(DAYNAMEINDENT + (4*(li_daywidth + INSIDELINEWIDTH))) + " t_friday.x = " + string(DAYNAMEINDENT + (5*(li_daywidth + INSIDELINEWIDTH))) + " t_saturday.x = " + string(DAYNAMEINDENT + (6*(li_daywidth + INSIDELINEWIDTH))) + &
" day_2.x = " + string(OUTSIDELINEWIDTH + li_daywidth + INSIDELINEWIDTH) + " day_3.x = " + string(OUTSIDELINEWIDTH + (2*(li_daywidth + INSIDELINEWIDTH))) + " day_4.x = " + string(OUTSIDELINEWIDTH + (3*(li_daywidth + INSIDELINEWIDTH))) + " day_5.x = " + string(OUTSIDELINEWIDTH + (4*(li_daywidth + INSIDELINEWIDTH))) + " day_6.x = " + string(OUTSIDELINEWIDTH + (5*(li_daywidth + INSIDELINEWIDTH))) + " day_7.x = " + string(OUTSIDELINEWIDTH + (6*(li_daywidth + INSIDELINEWIDTH))) + &
" number_2.x = " + string(OUTSIDELINEWIDTH + li_daywidth + INSIDELINEWIDTH) + " number_3.x = " + string(OUTSIDELINEWIDTH + (2*(li_daywidth + INSIDELINEWIDTH))) + " number_4.x = " + string(OUTSIDELINEWIDTH + (3*(li_daywidth + INSIDELINEWIDTH))) + " number_5.x = " + string(OUTSIDELINEWIDTH + (4*(li_daywidth + INSIDELINEWIDTH))) + " number_6.x = " + string(OUTSIDELINEWIDTH + (5*(li_daywidth + INSIDELINEWIDTH))) + " number_7.x = " + string(OUTSIDELINEWIDTH + (6*(li_daywidth + INSIDELINEWIDTH))) + &
" picture_1.x = " + string(OUTSIDELINEWIDTH + li_daywidth - 11) + " picture_2.x = " + string(OUTSIDELINEWIDTH + li_daywidth + INSIDELINEWIDTH + li_daywidth - 11) + " picture_3.x = " + string(OUTSIDELINEWIDTH + (2*(li_daywidth + INSIDELINEWIDTH)) + li_daywidth - 11) + " picture_4.x = " + string(OUTSIDELINEWIDTH + (3*(li_daywidth + INSIDELINEWIDTH)) + li_daywidth - 11) + " picture_5.x = " + string(OUTSIDELINEWIDTH + (4*(li_daywidth + INSIDELINEWIDTH)) + li_daywidth - 11) + " picture_6.x = " + string(OUTSIDELINEWIDTH + (5*(li_daywidth + INSIDELINEWIDTH)) + li_daywidth - 11) + " picture_7.x = " + string(OUTSIDELINEWIDTH + (6*(li_daywidth + INSIDELINEWIDTH)) + li_daywidth - 11 + li_widthmod) + &
" datawindow.detail.height = " + string(li_dayheight) + " day_1.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_2.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_3.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_4.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_5.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_6.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_7.height = " + string(li_dayheight - INSIDELINEWIDTH))

//Sometimes the above resize, even though we did some pretty little calculations, will cause the
//last row to be move to the next page (ie. disappear of the dw unless we scroll down).  This code will
//shorten the day cells' height to make sure all the cells appear correctly.
Do Until dw_cal.object.datawindow.lastrowonpage = "42" or li_reps > 10
	
	li_dayheight --
	
	//Set a way to break out of the loop in case the object was resized so small
	//that all the rows will never display.
	li_reps ++
	
	dw_cal.modify(" datawindow.detail.height = " + string(li_dayheight) + " day_1.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_2.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_3.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_4.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_5.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_6.height = " + string(li_dayheight - INSIDELINEWIDTH) + " day_7.height = " + string(li_dayheight - INSIDELINEWIDTH))
	
Loop

of_resizebuttons()

setredraw(TRUE)
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			constructor
//
//	Description:	Set the initial display to today's month and start the timing
//						object to handle the hover features.
//						Create new default model.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
n_cst_defaultsupercalendarmodel lnv_model

timing_hover.start(.1)

lnv_model = create n_cst_defaultsupercalendarmodel
of_setmodel(lnv_model)

of_setmonth(today())
end event

type pb_nextyear from u_pb within u_supercalendar
integer x = 2263
integer y = 16
integer width = 91
integer height = 64
integer taborder = 40
string text = ""
boolean originalsize = false
string picturename = "nextyear.bmp"
end type

event clicked;call super::clicked;setpointer(hourglass!)

of_incrementyear()
end event

type cb_nextmonth from u_cb within u_supercalendar
integer x = 2354
integer y = 16
integer width = 91
integer height = 64
integer taborder = 30
integer textsize = -12
fontcharset fontcharset = symbol!
fontfamily fontfamily = anyfont!
string facename = "Marlett"
string text = "4"
end type

event clicked;call super::clicked;setpointer(hourglass!)

of_incrementmonth()
end event

type pb_prevyear from u_pb within u_supercalendar
integer x = 2171
integer y = 16
integer width = 91
integer height = 64
integer taborder = 30
string text = ""
boolean originalsize = false
string picturename = "prevyear.bmp"
end type

event clicked;call super::clicked;setpointer(hourglass!)

of_decrementyear()
end event

type cb_prevmonth from u_cb within u_supercalendar
integer x = 2080
integer y = 16
integer width = 91
integer height = 64
integer taborder = 20
integer textsize = -12
fontcharset fontcharset = symbol!
fontfamily fontfamily = anyfont!
string facename = "Marlett"
string text = "3"
end type

event clicked;call super::clicked;setpointer(hourglass!)

of_decrementmonth()
end event

type dw_cal from u_dw within u_supercalendar
event mousemove pbm_dwnmousemove
integer width = 2510
integer height = 1064
integer taborder = 10
string dataobject = "d_supercalendar"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
end type

event mousemove;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			mousemove
//
//	Description:	Hover features implemented here.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
date ld_day

if ib_monthdropdown then
	if isnull(dwo) then
		if NOT ib_monthmenuopen then this.object.t_monthborder.border = 0
	else
		if dwo.name = "t_month" or dwo.name = "t_dwnarrow" or dwo.name = "t_monthborder" then
			if this.object.t_monthborder.border = "0" then
				this.object.t_monthborder.border = 6
			end if
		else
			if NOT ib_monthmenuopen then this.object.t_monthborder.border = 0
		end if
	end if
end if

if ib_showdaynameinfooter or ib_colordayonhover then
	if row <> ii_hoverrow then
	
		if ii_hoverrow <> 0 then
		
			dw_cal.modify("t_daytext.text = ''")
			dw_cal.setitem(ii_hoverrow,"ishovering",0)
			ii_hoverrow = 0
			
			dw_cal.setredraw(TRUE)
			
		end if
	
		if row > 0 then
			if getitemnumber(row,"number") > 0 and (left(dwo.name,3) = "day" or left(dwo.name,6) = "number" or left(dwo.name,7) = "picture") then
				ld_day = date(ii_year,ii_month,getitemnumber(row,"number"))
				if ib_showdaynameinfooter then modify("t_daytext.text = '" + string(ld_day,"mmmm dd, yyyy") + "'")
				if ib_colordayonhover then setitem(row,"ishovering",1)
				ii_hoverrow = row
			end if
		end if
		
	end if
end if

end event

event constructor;call super::constructor;
of_setrowselect(TRUE)
inv_rowselect.of_setkeyboard(FALSE)
end event

event clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			clicked
//
//	Description:	ANCESTOR OVERRIDEN.  The row selection service behavior 
//						had to be altered so it was easiest to override a few events
//						including this one.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
//ANCESTOR OVERRIDEN
//ANCESTOR OVERRIDEN

//ANCESTOR OVERRIDEN
//ANCESTOR OVERRIDEN


m_calendar_monthselection lm_months
window lw_parent,lw_sheet,lw_frame,lw_childparent
boolean lb_frame

IF IsValid (inv_RowSelect) THEN
	if isvalid(dwo) then
		if dwo.name <> "datawindow" then
			if of_canselectrow(row) and getselectedrow(0) <> row then
				if inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo ) = SUCCESS then
				parent.event calendar_dayselected(date(ii_year,ii_month,getitemnumber(row,"number")))
				end if
			end if
		end if
	end if
END IF

if isvalid(dwo) and ib_monthdropdown then
	if dwo.name = "t_month" or dwo.name = "t_dwnarrow" or dwo.name = "t_monthborder" then
		
		// Determine parent window for PointerX, PointerY offset
		this.of_GetParentWindow (lw_parent)
		if IsValid (lw_parent) then
			// Get the MDI frame window if available
			lw_frame = lw_parent
			do while IsValid (lw_frame)
				if lw_frame.windowtype = mdi! or lw_frame.windowtype = mdihelp! then
					lb_frame = true
					exit
				else
					lw_frame = lw_frame.ParentWindow()
					exit
				end if
			loop
			
			if lb_frame then
				// If MDI frame window is available, use it as the reference point for the
				// popup menu for sheets (windows opened with OpenSheet function) or child windows
				if lw_parent.windowtype = child! then
					lw_parent = lw_frame
				else
					lw_sheet = lw_frame.GetFirstSheet()
					if IsValid (lw_sheet) then
						do
							// Use frame reference for popup menu if the parentwindow is a sheet
							if lw_sheet = lw_parent then
								lw_parent = lw_frame
								exit
							end if
							lw_sheet = lw_frame.GetNextSheet (lw_sheet)
						loop until IsNull(lw_sheet) Or not IsValid (lw_sheet)
					end if
				end if
			else
				// SDI application.  All windows except for child windows will use the parent
				// window of the control as the reference point for the popmenu
				if lw_parent.windowtype = child! then
					lw_childparent = lw_parent.ParentWindow()
					if IsValid (lw_childparent) then
						lw_parent = lw_childparent
					end if
				end if
			end if
		else
			return 1
		end if		
		
		this.object.t_monthborder.border = 5
		
		lm_months = create m_calendar_monthselection
		
		lm_months.iu_requestor = parent
		
		parent.event calendar_premonthmenu(lm_months)
		
		ib_monthmenuopen = TRUE
		
//		lm_months.m_popup.popmenu(lw_parent.pointerx() - pixelstounits(xpos,xpixelstounits!) + 60,lw_parent.pointery() - pixelstounits(ypos,ypixelstounits!) + 72 + 12 + 10)
		lm_months.m_popup.popmenu(gw_frame.pointerx() - pixelstounits(xpos,xpixelstounits!) + 60,gw_frame.pointery() - pixelstounits(ypos,ypixelstounits!) + 72 + 12 + 10)
//		lm_months.m_popup.popmenu(this.pointerx() ,this.pointery() )
		ib_monthmenuopen = false

		this.object.t_monthborder.border = 0

	end if
end if
end event

event rbuttondown;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			rbuttondown
//
//	Description:	ANCESTOR OVERRIDEN.  The row selection service behavior 
//						had to be altered so it was easiest to override a few events
//						including this one.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
//ANCESTOR OVERRIDEN
//ANCESTOR OVERRIDEN

//ANCESTOR OVERRIDEN
//ANCESTOR OVERRIDEN

if IsValid (inv_rowselect) then
	if isvalid(dwo) then
		if dwo.name <> "datawindow" then 
			if of_canselectrow(row) and getselectedrow(0) <> row then
				inv_rowselect.event pfc_rbuttondown (xpos, ypos, row, dwo)
				parent.event calendar_dayselected(date(ii_year,ii_month,getitemnumber(row,"number")))
			end if
		end if
	end if
end if


end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			doubleclicked
//
//	Description:	Trigger the calendar_daydoubleclicked event if appropriate.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_number
date ld_day
long ll_color
string ls_text

if row < 1 then return

if row <> getselectedrow(0) then return

li_number = getitemnumber(row,"number")

if li_number = 0 then return

ld_day = date(ii_year,ii_month,li_number)

parent.event calendar_daydoubleclicked(ld_day)
end event

event rbuttonup;call super::rbuttonup;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			rbuttonup
//
//	Description:	Trigger the calendar_dayrightclicked event if appropriate.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_number
date ld_day
long ll_color
string ls_text

if row < 1 then return

if row <> getselectedrow(0) then return

li_number = getitemnumber(row,"number")

if li_number = 0 then return

ld_day = date(ii_year,ii_month,li_number)

parent.event calendar_dayrightclicked(ld_day)
end event

type timing_hover from timing within u_supercalendar descriptor "pb_nvo" = "true" 
end type

event timer;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			timer
//
//	Description:	Part of the hover functionality.  This event will turn off
//						any hovering currently displayed if the mouse has moved off
//						the calendar.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
string ls_obj 

ls_obj = dw_cal.getobjectatpointer()

ls_obj = left(ls_obj,pos(ls_obj,"~t") - 1)

if ls_obj <> "t_month" and ls_obj <> "t_dwnarrow" and ls_obj <> "t_monthborder" then
	if NOT ib_monthmenuopen then dw_cal.object.t_monthborder.border = 0
end if

if left(ls_obj,3) <> "day" and left(ls_obj,6) <> "number" and left(ls_obj,7) <> "picture" and ii_hoverrow <> 0 then
	dw_cal.setitem(ii_hoverrow,"ishovering",0)
	dw_cal.modify("t_daytext.text = ''")
	ii_hoverrow = 0
end if
end event

on timing_hover.create
call super::create
TriggerEvent( this, "constructor" )
end on

on timing_hover.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


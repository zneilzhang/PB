HA$PBExportHeader$n_cst_abstractsupercalendarmodel.sru
forward
global type n_cst_abstractsupercalendarmodel from nonvisualobject
end type
end forward

global type n_cst_abstractsupercalendarmodel from nonvisualobject
end type
global n_cst_abstractsupercalendarmodel n_cst_abstractsupercalendarmodel

type variables

Private:

powerobject ipo_calendars[]
end variables

forward prototypes
public function string of_getdaypicture (date ad_day)
public function long of_getdaycolor (date ad_day)
public function string of_getdaytext (date ad_day)
public subroutine of_setdaytext (date ad_day, string as_text)
public subroutine of_setdaypicture (date ad_day, string as_picture)
public subroutine of_setdaycolor (date ad_day, long al_color)
public function integer of_addcalendarlistener (readonly powerobject apo_fullsizecalendar)
protected function integer of_firedaychanged (date ad_day)
end prototypes

public function string of_getdaypicture (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaypicture
//
//	Arguments:		date
//
//	Returns:  		string	filename of the picture associated with the given day.
//
//	Description:	ABSTRACT FUNCTION.  You must provide the implementation.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
string ls_null
setnull(ls_null)

return ls_null
end function

public function long of_getdaycolor (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaycolor
//
//	Arguments:		date		
//
//	Returns:  		long		RGB value for the color associated with the given day.
//
//	Description:	ABSTRACT FUNCTION.  You must provide the implementation in
//						the descendant (concrete) class.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_null
setnull(ll_null)

return ll_null
end function

public function string of_getdaytext (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaytext
//
//	Arguments:		date
//
//	Returns:  		string	text associated with the given day.
//
//	Description:	ABSTRACT FUNCTION.  You must provide the implementation.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
string ls_null
setnull(ls_null)

return ls_null
end function

public subroutine of_setdaytext (date ad_day, string as_text);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaytext
//
//	Arguments:		date		date whose text you wish to update
//						string	text to be assigned to the given day
//
//	Description:	ABSTRACT FUNCTION.  You must provide the implementation.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return
end subroutine

public subroutine of_setdaypicture (date ad_day, string as_picture);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaypicture
//
//	Arguments:		date		date whose picture you wish to change
//						string	filename to be used for the given day's picture
//
//	Description:	ABSTRACT FUNCTION.  You must provide the implementation.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return 
end subroutine

public subroutine of_setdaycolor (date ad_day, long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaycolor
//
//	Arguments:		date		date whose color you wish to update
//						long		rgb color you wish to use for the given day.
//
//	Description:	ABSTRACT FUNCTION.  You must provide the implementation.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////

return
end subroutine

public function integer of_addcalendarlistener (readonly powerobject apo_fullsizecalendar);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_addcalendarlistener
//
//	Arguments:		powerobject		object to be notified when the data is updated
//
//	Returns:  		1 = SUCCESS
//						-1 = FAILURE
//
//	Description:	Called by the u_supercalendar.of_setmodel() function.  You
//						can call this function to add your own listeners as long as
//						they define the calendar_daychanged event.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
ClassDefinition lcd_listener
integer li_scripts,li_c = 1
boolean lb_found

if not isvalid(apo_fullsizecalendar) then return -1

//Check listener's interface, make sure it has the calendar_daychange event
lcd_listener = apo_fullsizecalendar.classdefinition

li_scripts = upperBound (lcd_listener.scriptlist)
do while li_c <= li_scripts and not lb_found
	if lcd_listener.scriptlist[li_c].name = "calendar_daychanged" and lcd_listener.scriptlist[li_c].kind = scriptevent! then
		lb_found = true
	else
		li_c++
	end if
loop

if NOT lb_found then return -1

ipo_calendars[upperbound(ipo_calendars) + 1] = apo_fullsizecalendar

return 1
end function

protected function integer of_firedaychanged (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_firedaychanged
//
//	Arguments:		date		Date of the day whose data was updated.
//
//	Returns:  		1
//
//	Description:	Notifies all registered listeners that the data has changed.
//						Custom models (i.e any model inherited from this class) 
//						should call this function after any date's data has changed.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
int li_c,li_ub

li_ub = upperbound(ipo_calendars[])

For li_c = 1 to li_ub
	if isvalid(ipo_calendars[li_c]) then
		ipo_calendars[li_c].event dynamic calendar_daychanged(ad_day)
	end if
Next

return 1
end function

on n_cst_abstractsupercalendarmodel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_abstractsupercalendarmodel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


HA$PBExportHeader$n_cst_defaultsupercalendarmodel.sru
forward
global type n_cst_defaultsupercalendarmodel from n_cst_abstractsupercalendarmodel
end type
end forward

global type n_cst_defaultsupercalendarmodel from n_cst_abstractsupercalendarmodel
end type
global n_cst_defaultsupercalendarmodel n_cst_defaultsupercalendarmodel

type variables


date		id_day[]
string	is_daytext[]
long		il_daycolor[]
string	is_daypicture[]
end variables

forward prototypes
public function long of_getdaycolor (date ad_day)
public function string of_getdaypicture (date ad_day)
public function string of_getdaytext (date ad_day)
public subroutine of_setdaycolor (date ad_day, long al_color)
public subroutine of_setdaypicture (date ad_day, string as_picture)
public subroutine of_setdaytext (date ad_day, string as_text)
private function long of_findindex (date ad_day)
end prototypes

public function long of_getdaycolor (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaycolor
//
//	Arguments:		date		day whose color you want
//
//	Returns:  		long		RGB value for the day's color, or NULL if the day
//									hasn't been assigned a specific color.
//
//	Description:	Get the day's background color
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index
long ll_null

ll_index = of_findindex(ad_day)

if ll_index < 1 then 
	setnull(ll_null)
	return ll_null
end if

return il_daycolor[ll_index]
end function

public function string of_getdaypicture (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaypicture
//
//	Arguments:		date		day whose picture you want
//
//	Returns:  		string 	filename of the day's picture, or empty if one
//									hasn't been assigned.
//
//	Description:	Get the day's associated picture.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index

ll_index = of_findindex(ad_day)

if ll_index < 1 then return ""

return is_daypicture[ll_index]
end function

public function string of_getdaytext (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_getdaytext
//
//	Arguments:		date		day whose text you want
//
//	Returns:  		string	the day's text
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index

ll_index = of_findindex(ad_day)

if ll_index < 1 then return ""

return is_daytext[ll_index]
end function

public subroutine of_setdaycolor (date ad_day, long al_color);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaycolor
//
//	Arguments:		date		day whose color you want to change
//						long		RGB value for the new color
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index

ll_index = of_findindex(ad_day)

if ll_index = 0 then
	ll_index = upperbound(id_day) + 1
	id_day[ll_index] = ad_day
	is_daytext[ll_index] = ""
	is_daypicture[ll_index] = ""
end if

il_daycolor[ll_index] = al_color

post of_firedaychanged(ad_day)

return
end subroutine

public subroutine of_setdaypicture (date ad_day, string as_picture);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaypicture
//
//	Arguments:		date		day whose picture you want to change
//						string	filename of the new picture
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index,ll_null
setnull(ll_null)

ll_index = of_findindex(ad_day)

if ll_index = 0 then
	ll_index = upperbound(id_day) + 1
	id_day[ll_index] = ad_day
	is_daytext[ll_index] = ""
	il_daycolor[ll_index] = ll_null
end if

is_daypicture[ll_index] = as_picture

post of_firedaychanged(ad_day)

return
end subroutine

public subroutine of_setdaytext (date ad_day, string as_text);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_setdaytext
//
//	Arguments:		date		day whose text you want to change
//						string	text for the day
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index,ll_null
setnull(ll_null)

ll_index = of_findindex(ad_day)

if ll_index = 0 then
	ll_index = upperbound(id_day) + 1
	id_day[ll_index] = ad_day
	il_daycolor[ll_index] = ll_null
	is_daypicture[ll_index] = ""
end if

is_daytext[ll_index] = as_text

post of_firedaychanged(ad_day)

return
end subroutine

private function long of_findindex (date ad_day);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_findindex
//
//	Arguments:		date		get the index for the given day
//
//	Returns:  		The index of the date or a 0 if the day hasn't been added
//						to the array
//
//	Description:	PRIVATE.  Used by accessor methods to determine which array
//						value they must get/set or if they need to add a new item.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Author:		Chris Gross
//					cgross@ix.netcom.com
//
//////////////////////////////////////////////////////////////////////////////
long ll_index
long ll_c,ll_ub

ll_ub = upperbound(id_day)

if ll_ub = 0 then return 0

For ll_c = 1 to ll_ub
	if ad_day = id_day[ll_c] then
		EXIT
	end if
Next

ll_index = ll_c

if ll_index > ll_ub then ll_index = 0

return ll_index
end function

on n_cst_defaultsupercalendarmodel.create
call super::create
end on

on n_cst_defaultsupercalendarmodel.destroy
call super::destroy
end on


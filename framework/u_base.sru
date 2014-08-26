HA$PBExportHeader$u_base.sru
$PBExportComments$Extension Visual Ancestor class
forward
global type u_base from pfc_u_base
end type
end forward

global type u_base from pfc_u_base
end type
global u_base u_base

forward prototypes
public subroutine of_settheme (string as_color)
end prototypes

public subroutine of_settheme (string as_color);// -----------------------------------------------------------------------------
// SCRIPT:		of_SetTheme
//
// PURPOSE:		This function can be called from the window object for
//					all tabpages. Within each tabpage, call of_SetTheme on
//					each advanced GUI control.
//
// ARGUMENTS:	as_color - Name of the theme
//
// RETURN:		None
// -----------------------------------------------------------------------------







end subroutine

on u_base.create
call super::create
end on

on u_base.destroy
call super::destroy
end on


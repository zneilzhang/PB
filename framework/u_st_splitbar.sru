HA$PBExportHeader$u_st_splitbar.sru
$PBExportComments$Extension SplitBar class
forward
global type u_st_splitbar from pfc_u_st_splitbar
end type
end forward

global type u_st_splitbar from pfc_u_st_splitbar
end type
global u_st_splitbar u_st_splitbar

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Pone el color de la barra de split (Appworkspace)
of_SetBarColor(268435456)
end event

on u_st_splitbar.create
call super::create
end on

on u_st_splitbar.destroy
call super::destroy
end on


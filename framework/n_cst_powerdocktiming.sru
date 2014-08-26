HA$PBExportHeader$n_cst_powerdocktiming.sru
forward
global type n_cst_powerdocktiming from timing
end type
end forward

global type n_cst_powerdocktiming from timing
end type
global n_cst_powerdocktiming n_cst_powerdocktiming

type variables
u_cst_powerdockpanel i_parent
end variables

on n_cst_powerdocktiming.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_powerdocktiming.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event timer;i_parent.of_Hide()
end event


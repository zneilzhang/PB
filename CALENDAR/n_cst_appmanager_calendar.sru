HA$PBExportHeader$n_cst_appmanager_calendar.sru
forward
global type n_cst_appmanager_calendar from n_cst_appmanager
end type
end forward

global type n_cst_appmanager_calendar from n_cst_appmanager
end type
global n_cst_appmanager_calendar n_cst_appmanager_calendar

on n_cst_appmanager_calendar.create
call super::create
end on

on n_cst_appmanager_calendar.destroy
call super::destroy
end on

event pfc_open;call super::pfc_open;
open(w_main_calendarexample)
end event


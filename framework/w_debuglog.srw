HA$PBExportHeader$w_debuglog.srw
$PBExportComments$Extension display debuglog utility window used by the debug service
forward
global type w_debuglog from pfc_w_debuglog
end type
end forward

global type w_debuglog from pfc_w_debuglog
boolean visible = true
end type
global w_debuglog w_debuglog

on w_debuglog.create
call super::create
end on

on w_debuglog.destroy
call super::destroy
end on

event activate;//
end event

type dw_debuglog from pfc_w_debuglog`dw_debuglog within w_debuglog
end type

type cb_print from pfc_w_debuglog`cb_print within w_debuglog
end type

type cb_clear from pfc_w_debuglog`cb_clear within w_debuglog
end type

type cb_close from pfc_w_debuglog`cb_close within w_debuglog
end type

type cb_dlghelp from pfc_w_debuglog`cb_dlghelp within w_debuglog
end type


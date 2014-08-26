HA$PBExportHeader$w_sortmulti.srw
$PBExportComments$Extension DDLB-style Sort dialog window
forward
global type w_sortmulti from pfc_w_sortmulti
end type
end forward

global type w_sortmulti from pfc_w_sortmulti
string title = "Ordenar"
end type
global w_sortmulti w_sortmulti

on w_sortmulti.create
call super::create
end on

on w_sortmulti.destroy
call super::destroy
end on

type dw_sort from pfc_w_sortmulti`dw_sort within w_sortmulti
end type

type cb_add from pfc_w_sortmulti`cb_add within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Agregar"
end type

type cb_delete from pfc_w_sortmulti`cb_delete within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Borrar"
end type

type cb_insert from pfc_w_sortmulti`cb_insert within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Insertar"
end type

type cb_ok from pfc_w_sortmulti`cb_ok within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Aceptar"
end type

type cb_cancel from pfc_w_sortmulti`cb_cancel within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Cancelar"
end type

type gb_sort from pfc_w_sortmulti`gb_sort within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Ordenar por"
end type

type cb_dlghelp from pfc_w_sortmulti`cb_dlghelp within w_sortmulti
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "A&yuda"
end type


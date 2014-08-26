HA$PBExportHeader$w_sortdragdrop.srw
$PBExportComments$Extension Drag/Drop Style Sort dialog window
forward
global type w_sortdragdrop from pfc_w_sortdragdrop
end type
end forward

global type w_sortdragdrop from pfc_w_sortdragdrop
string title = "Ordenar"
end type
global w_sortdragdrop w_sortdragdrop

on w_sortdragdrop.create
call super::create
end on

on w_sortdragdrop.destroy
call super::destroy
end on

type dw_sorted from pfc_w_sortdragdrop`dw_sorted within w_sortdragdrop
string dragicon = "DataWindow5!"
end type

type st_3 from pfc_w_sortdragdrop`st_3 within w_sortdragdrop
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Columnas para ordenamiento"
end type

type st_4 from pfc_w_sortdragdrop`st_4 within w_sortdragdrop
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Ascendente"
end type

type st_2 from pfc_w_sortdragdrop`st_2 within w_sortdragdrop
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Columnas disponibles para ordenar"
end type

type dw_sortcolumns from pfc_w_sortdragdrop`dw_sortcolumns within w_sortdragdrop
string dragicon = "DataWindow5!"
end type

type cb_ok from pfc_w_sortdragdrop`cb_ok within w_sortdragdrop
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Aceptar"
end type

type cb_cancel from pfc_w_sortdragdrop`cb_cancel within w_sortdragdrop
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Cancelar"
end type

type cb_dlghelp from pfc_w_sortdragdrop`cb_dlghelp within w_sortdragdrop
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "A&yuda"
end type


HA$PBExportHeader$n_cst_winsrv_statusbar.sru
$PBExportComments$Extension Statusbar service
forward
global type n_cst_winsrv_statusbar from pfc_n_cst_winsrv_statusbar
end type
end forward

global type n_cst_winsrv_statusbar from pfc_n_cst_winsrv_statusbar
end type
global n_cst_winsrv_statusbar n_cst_winsrv_statusbar

on n_cst_winsrv_statusbar.create
call super::create
end on

on n_cst_winsrv_statusbar.destroy
call super::destroy
end on

event pfc_statusbardoubleclick;call super::pfc_statusbardoubleclick;If IsValid(iw_requestor) Then
	iw_requestor.dynamic event ue_statusbardoubleclick(ai_xpos, ai_ypos, as_name)
End If
end event

event pfc_statusbarclicked;call super::pfc_statusbarclicked;If IsValid(iw_requestor) Then
	iw_requestor.dynamic event ue_statusbarclicked(ai_xpos, ai_ypos, as_name)
End If
end event


HA$PBExportHeader$w_sqlspy.srw
$PBExportComments$Extension SQL Spy window
forward
global type w_sqlspy from pfc_w_sqlspy
end type
end forward

global type w_sqlspy from pfc_w_sqlspy
boolean visible = true
end type
global w_sqlspy w_sqlspy

on w_sqlspy.create
call super::create
end on

on w_sqlspy.destroy
call super::destroy
end on

type cb_print from pfc_w_sqlspy`cb_print within w_sqlspy
end type

type cb_save from pfc_w_sqlspy`cb_save within w_sqlspy
end type

type cbx_batchmode from pfc_w_sqlspy`cbx_batchmode within w_sqlspy
end type

type mle_history from pfc_w_sqlspy`mle_history within w_sqlspy
end type

type cb_clear from pfc_w_sqlspy`cb_clear within w_sqlspy
end type

type cb_dlghelp from pfc_w_sqlspy`cb_dlghelp within w_sqlspy
end type

type cb_close from pfc_w_sqlspy`cb_close within w_sqlspy
end type

type gb_sqlhistory from pfc_w_sqlspy`gb_sqlhistory within w_sqlspy
end type

type st_history from pfc_w_sqlspy`st_history within w_sqlspy
end type


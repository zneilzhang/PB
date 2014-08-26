HA$PBExportHeader$n_cst_findattrib.sru
$PBExportComments$Extension Find/Replace attributes
forward
global type n_cst_findattrib from pfc_n_cst_findattrib
end type
end forward

global type n_cst_findattrib from pfc_n_cst_findattrib
end type

type variables
//Var. para el dw requestor
u_dw	idw_requestor
end variables

on n_cst_findattrib.create
call super::create
end on

on n_cst_findattrib.destroy
call super::destroy
end on


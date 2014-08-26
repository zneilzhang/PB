HA$PBExportHeader$n_cst_dayattrib.sru
forward
global type n_cst_dayattrib from n_cst_baseattrib
end type
end forward

global type n_cst_dayattrib from n_cst_baseattrib autoinstantiate
end type

type variables

date		id_day

string	is_text
long		il_color
string	is_picture

end variables
on n_cst_dayattrib.create
call super::create
end on

on n_cst_dayattrib.destroy
call super::destroy
end on


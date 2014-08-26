HA$PBExportHeader$u_tab_catalogos.sru
$PBExportComments$Extension Tab class
forward
global type u_tab_catalogos from pfc_u_tab
end type
type tabpage_generales from userobject within u_tab_catalogos
end type
type tabpage_generales from userobject within u_tab_catalogos
end type
end forward

global type u_tab_catalogos from pfc_u_tab
tabpage_generales tabpage_generales
end type
global u_tab_catalogos u_tab_catalogos

on u_tab_catalogos.create
this.tabpage_generales=create tabpage_generales
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_generales
end on

on u_tab_catalogos.destroy
call super::destroy
destroy(this.tabpage_generales)
end on

type tabpage_generales from userobject within u_tab_catalogos
integer x = 18
integer y = 100
integer width = 859
integer height = 496
long backcolor = 79741120
string text = "Generales"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
end type


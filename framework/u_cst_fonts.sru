HA$PBExportHeader$u_cst_fonts.sru
forward
global type u_cst_fonts from nonvisualobject
end type
end forward

global type u_cst_fonts from nonvisualobject
end type
global u_cst_fonts u_cst_fonts

type prototypes
PUBLIC FUNCTION Long EnumFontFamilies(Long hdc, String lpszFamily, Long lpEnumFontFamProc, Long lParam) LIBRARY "gdi32" ALIAS FOR "EnumFontFamiliesW"
end prototypes

on u_cst_fonts.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_cst_fonts.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


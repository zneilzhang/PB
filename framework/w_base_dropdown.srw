HA$PBExportHeader$w_base_dropdown.srw
forward
global type w_base_dropdown from w_popup
end type
end forward

global type w_base_dropdown from w_popup
boolean visible = false
integer x = 214
integer y = 221
integer width = 617
integer height = 428
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean palettewindow = true
end type
global w_base_dropdown w_base_dropdown

on w_base_dropdown.create
call super::create
end on

on w_base_dropdown.destroy
call super::destroy
end on

event key;call super::key;IF key = KeyEscape! THEN
//	IF ISVALID(inv_dropdown) THEN inv_dropdown.of_cancel()
	close(this)
END IF
end event

event deactivate;call super::deactivate;	close(this)
end event


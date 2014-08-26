HA$PBExportHeader$w_powerdockdocker.srw
forward
global type w_powerdockdocker from window
end type
type uo_right from u_cst_groupbox within w_powerdockdocker
end type
type uo_left from u_cst_groupbox within w_powerdockdocker
end type
type uo_bottom from u_cst_groupbox within w_powerdockdocker
end type
type uo_top from u_cst_groupbox within w_powerdockdocker
end type
end forward

global type w_powerdockdocker from window
boolean visible = false
integer width = 114
integer height = 100
boolean border = false
windowtype windowtype = popup!
long backcolor = 16776960
string icon = "AppIcon!"
event lbuttonup pbm_lbuttonup
uo_right uo_right
uo_left uo_left
uo_bottom uo_bottom
uo_top uo_top
end type
global w_powerdockdocker w_powerdockdocker

type prototypes
FUNCTION Long SetWindowLong(Long hWnd, Long offset, Long attributes) LIBRARY 'user32.dll' ALIAS FOR "SetWindowLongA"
FUNCTION Long SetLayeredWindowAttributes(ULong hWnd, ULong colorref, Char Transparency, ULong flag) LIBRARY 'user32.dll' alias for "SetLayeredWindowAttributes"

Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

FUNCTION long PtInRegion(ulong hrgn, int nx, int ny) LIBRARY "GDI32.dll"
FUNCTION ulong CreatePolygonRgn(ref POINT ppoint[], int count, int fillMode) Library "GDI32.DLL"

FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION boolean GetCursorPos(ref POINT lpPoint) Library "USER32.DLL"
FUNCTION ulong ChildWindowFromPoint(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
function boolean DeleteObject(ulong hgdiobject) library "gdi32.dll" 
end prototypes

type variables
CONSTANT Long GWL_EXSTYLE = -20
CONSTANT ULong WS_EX_LAYERED = 524288
CONSTANT ULong LWA_ALPHA = 2

u_cst_powerdock iuo_parent

Long il_x, il_y

Long il_clickedpanel

Point ist_TopPoint[]
Point ist_BottomPoint[]
Point ist_LeftPoint[]
Point ist_RightPoint[]

Boolean ib_InTop = FALSE
Boolean ib_InBottom = FALSE
Boolean ib_InLeft = FALSE
Boolean ib_InRight = FALSE
end variables

forward prototypes
public function integer of_settheme (long al_theme)
public function boolean of_isoverobject (string as_object)
public subroutine of_resize ()
end prototypes

event lbuttonup;u_cst_powerdockpanel uo_from
UserObject uo_object
string ls_text, ls_image

iuo_parent.SetRedraw(FALSE)

CHOOSE CASE il_clickedpanel
	CASE iuo_parent.TOP
		uo_from = iuo_parent.uo_powerdockpaneltop
	CASE iuo_parent.BOTTOM
		uo_from = iuo_parent.uo_powerdockpanelbottom
	CASE iuo_parent.LEFT
		uo_from = iuo_parent.uo_powerdockpanelleft
	CASE iuo_parent.RIGHT
		uo_from = iuo_parent.uo_powerdockpanelright
END CHOOSE

uo_object = uo_from.of_CurrentObject()

IF ib_InTop THEN
	IF il_clickedpanel <> iuo_parent.TOP THEN
		ls_text = uo_from.of_GetText(uo_object)
		ls_image = uo_from.of_GetImage(uo_object)
		uo_from.of_RemoveItem(uo_object)
		iuo_parent.of_AddDockItem(iuo_parent.TOP, uo_object, ls_text, ls_image)
	END IF
END IF

IF ib_InBottom THEN
	IF il_clickedpanel <> iuo_parent.BOTTOM THEN
		ls_text = uo_from.of_GetText(uo_object)
		ls_image = uo_from.of_GetImage(uo_object)
		uo_from.of_RemoveItem(uo_object)
		iuo_parent.of_AddDockItem(iuo_parent.BOTTOM, uo_object, ls_text, ls_image)
	END IF
END IF

IF ib_InLeft THEN
	IF il_clickedpanel <> iuo_parent.LEFT THEN
		ls_text = uo_from.of_GetText(uo_object)
		ls_image = uo_from.of_GetImage(uo_object)
		uo_from.of_RemoveItem(uo_object)
		iuo_parent.of_AddDockItem(iuo_parent.LEFT, uo_object, ls_text, ls_image)
	END IF
END IF

IF ib_InRight THEN
	IF il_clickedpanel <> iuo_parent.RIGHT THEN
		ls_text = uo_from.of_GetText(uo_object)
		ls_image = uo_from.of_GetImage(uo_object)
		uo_from.of_RemoveItem(uo_object)
		iuo_parent.of_AddDockItem(iuo_parent.RIGHT, uo_object, ls_text, ls_image)
	END IF
END IF

IF ib_InTop OR ib_InBottom OR ib_InLeft OR ib_InRight THEN

	CHOOSE CASE il_clickedpanel
		CASE iuo_parent.TOP, iuo_parent.BOTTOM
			
			IF uo_from.of_GetItemCount() = 0 THEN
				uo_from.#Docked = FALSE
				uo_from.Height = 0
				uo_from.inv_timer.Stop()
				uo_from.of_Undock()
			END IF
			
		CASE iuo_parent.LEFT, iuo_parent.RIGHT
			
			IF uo_from.of_GetItemCount() = 0 THEN
				uo_from.#Docked = FALSE
				uo_from.Width = 0
				uo_from.inv_timer.Stop()
				uo_from.of_Undock()
			END IF
			
	END CHOOSE
	
END IF

ib_InTop = FALSE
ib_InBottom = FALSE
ib_InLeft = FALSE
ib_InRight = FALSE

iuo_parent.ReleaseCapture()

iuo_parent.uo_powerdockpanelright.ib_headerclicked = FALSE
iuo_parent.uo_powerdockpanelleft.ib_headerclicked = FALSE
iuo_parent.uo_powerdockpaneltop.ib_headerclicked = FALSE
iuo_parent.uo_powerdockpanelbottom.ib_headerclicked = FALSE

THIS.Hide()

iuo_parent.POST SetRedraw(TRUE)
end event

public function integer of_settheme (long al_theme);uo_top.of_SetTheme(al_theme)
uo_bottom.of_SetTheme(al_theme)
uo_left.of_SetTheme(al_theme)
uo_right.of_SetTheme(al_theme)

RETURN 1
end function

public function boolean of_isoverobject (string as_object);
CHOOSE CASE as_object
	CASE "TOP"
		IF il_x > uo_top.X AND &
		   il_x < uo_top.X + uo_top.Width AND &
			il_y > uo_top.Y AND &
			il_y < uo_top.Y + uo_top.Height THEN
			RETURN TRUE
		END IF
	CASE "BOTTOM"
		IF il_x > uo_bottom.X AND &
		   il_x < uo_bottom.X + uo_bottom.Width AND &
			il_y > uo_bottom.Y AND &
			il_y < uo_bottom.Y + uo_bottom.Height THEN
			RETURN TRUE
		END IF
	CASE "LEFT"
		IF il_x > uo_left.X AND &
		   il_x < uo_left.X + uo_left.Width AND &
			il_y > uo_left.Y AND &
			il_y < uo_left.Y + uo_left.Height THEN
			RETURN TRUE
		END IF
	CASE "RIGHT"
		IF il_x > uo_right.X AND &
		   il_x < uo_right.X + uo_right.Width AND &
			il_y > uo_right.Y AND &
			il_y < uo_right.Y + uo_right.Height THEN
			RETURN TRUE
		END IF
END CHOOSE

RETURN FALSE
end function

public subroutine of_resize ();Long ll_centerh
Long ll_centerv
Long ll_hpadding = 500
Long ll_vpadding = 750

ll_centerh = Width / 2
ll_centerv = Height / 2

uo_Top.Move(ll_centerh - (uo_top.Width / 2), ll_hpadding)
uo_Bottom.Move(ll_centerh - (uo_Bottom.Width / 2), Height - uo_Bottom.Height - ll_hpadding)
uo_Left.Move(ll_vpadding, ll_centerv - (uo_Left.Height / 2))
uo_Right.Move(Width - uo_Right.Width - ll_vpadding, ll_centerv - (uo_Right.Height / 2))
end subroutine

on w_powerdockdocker.create
this.uo_right=create uo_right
this.uo_left=create uo_left
this.uo_bottom=create uo_bottom
this.uo_top=create uo_top
this.Control[]={this.uo_right,&
this.uo_left,&
this.uo_bottom,&
this.uo_top}
end on

on w_powerdockdocker.destroy
destroy(this.uo_right)
destroy(this.uo_left)
destroy(this.uo_bottom)
destroy(this.uo_top)
end on

event open;SetWindowLong(Handle(THIS), GWL_EXSTYLE, WS_EX_LAYERED)
SetLayeredWindowAttributes(Handle(THIS), RGB(0,255,255), char(128), 1)
end event

event mousemove;il_x = xpos
il_y = ypos

IF of_IsOverObject("TOP") THEN
	ib_InTop = TRUE
	uo_top.of_VGradient(TRUE)
ELSE
	ib_InTop = FALSE
	uo_top.of_VGradient(FALSE)
END IF

IF of_IsOverObject("BOTTOM") THEN
	ib_InBottom = TRUE
	uo_bottom.of_VGradient(TRUE)
ELSE
	ib_InBottom = FALSE
	uo_bottom.of_VGradient(FALSE)
END IF

IF of_IsOverObject("LEFT") THEN
	ib_InLeft = TRUE
	uo_left.of_VGradient(TRUE)
ELSE
	ib_InLeft = FALSE
	uo_left.of_VGradient(FALSE)
END IF

IF of_IsOverObject("RIGHT") THEN
	ib_InRight = TRUE
	uo_right.of_VGradient(TRUE)
ELSE
	ib_InRight = FALSE
	uo_right.of_VGradient(FALSE)
END IF
end event

type uo_right from u_cst_groupbox within w_powerdockdocker
integer x = 2144
integer y = 572
integer width = 224
integer height = 268
integer taborder = 50
long backcolor = 16776960
long #fontsize = 3
string #text = "`"
boolean #themeaware = true
long #style = 1
end type

on uo_right.destroy
call u_cst_groupbox::destroy
end on

type uo_left from u_cst_groupbox within w_powerdockdocker
integer x = 105
integer y = 580
integer width = 224
integer height = 268
integer taborder = 40
long backcolor = 16776960
long #fontsize = 3
string #text = "`"
boolean #themeaware = true
long #style = 1
end type

on uo_left.destroy
call u_cst_groupbox::destroy
end on

type uo_bottom from u_cst_groupbox within w_powerdockdocker
integer x = 974
integer y = 1172
integer width = 507
integer height = 172
integer taborder = 30
long backcolor = 16776960
long #fontsize = 3
string #text = "`"
boolean #themeaware = true
long #style = 1
end type

on uo_bottom.destroy
call u_cst_groupbox::destroy
end on

type uo_top from u_cst_groupbox within w_powerdockdocker
integer x = 942
integer y = 40
integer width = 507
integer height = 172
integer taborder = 20
long backcolor = 16776960
long #fontsize = 3
string #text = "`"
boolean #themeaware = true
long #style = 1
end type

on uo_top.destroy
call u_cst_groupbox::destroy
end on


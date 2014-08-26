HA$PBExportHeader$u_cst_toolbarchevron.sru
forward
global type u_cst_toolbarchevron from u_cst_canvas
end type
end forward

global type u_cst_toolbarchevron from u_cst_canvas
integer width = 59
integer height = 88
long backcolor = 67108864
string pointer = "HyperLink!"
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event mousewithin pbm_mousemove
event mouseenter ( )
event mouseleave ( )
event paint pbm_paint
event clicked pbm_lbuttonup
end type
global u_cst_toolbarchevron u_cst_toolbarchevron

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
end prototypes

type variables
u_cst_toolbarstrip iuo_parent

n_cst_toolbarstrip_gradient in_Gradient

Boolean ib_selected
Boolean ib_mousecaptured
Boolean ib_mouseleave
Boolean ib_mousedown
Boolean ib_mouseover

Long il_hover1 = RGB(255,255,220)
Long il_hover2 = RGB(247,192,91)
Long il_backcolor1 = RGB(203,225,252)
Long il_backcolor2 = RGB(126,166,225)

ToolbarItem iToolbarItems[]
end variables

forward prototypes
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_drawchevron (long ahdc)
public function integer of_setparent (u_cst_toolbarstrip auo_parent)
public function integer of_clearitems ()
public function integer of_registeritem (toolbaritem luo_item)
end prototypes

event mousewithin;if NOT of_ismousecaptured() then 
		
		of_capturemouse()
		
		this.event mouseenter()
		
	else
		
		if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
			
			//IF NOT ib_selected THEN
				of_releasemouse()
				
				this.event post mouseleave()
			//ELSE
				ib_mouseleave = TRUE
				SetRedraw(TRUE)
			//END IF
		ELSE
			IF ib_selected THEN
				ib_mouseleave = FALSE
				SetRedraw(TRUE)
			END IF
		end if
		
	end if
	
	IF NOT IsValid(THIS) THEN
		RETURN
	END IF
end event

event mouseenter();//TriggerEvent("paint")
SetRedraw(TRUE)
end event

event mouseleave();ib_mouseover = FALSE
ib_mousecaptured = FALSE
ib_selected = FALSE

SetRedraw(TRUE)
end event

event clicked;m_toolbarstripmenu lm_menu
Menu l_menu
Long ll_count, ll_index, ll_item
Boolean lb_line = FALSE
ToolbarItem luo_button

l_menu = CREATE Menu

ll_count = UpperBound(iToolbarItems)

FOR ll_index = 1 TO ll_count
	lm_menu = CREATE m_toolbarstripmenu
	
	lm_menu.Text = ""
	
	IF NOT iToolbarItems[ll_index].Separator AND NOT iToolbarItems[ll_index].ObjectType THEN
		luo_button = iToolbarItems[ll_index]
		lm_menu.Text = luo_button.Text
		lb_line = FALSE
	ELSE
		IF NOT iToolbarItems[ll_index].ObjectType THEN
			lm_menu.Text = "-"
		END IF
	END IF
	
	IF lm_menu.Text <> "" AND NOT lb_line THEN
		ll_item++
		lm_menu.iuo_parent = iuo_parent
		l_menu.Item[ll_item] = lm_menu
	END IF
	
	IF lm_menu.Text = "-" THEN
		lb_line = TRUE
	END IF
NEXT

IF UpperBound(l_menu.Item) > 0 THEN
	l_menu.PopMenu(iuo_parent.iw_parent.PointerX() - xpos, iuo_parent.iw_parent.PointerY() + (height - ypos - 10))
END IF

IF IsValid(THIS) THEN
	of_releasemouse()
	this.event post mouseleave()
	SetRedraw(TRUE)
END IF
end event

public function integer of_capturemouse ();
if of_ismousecaptured() then Return -1

SetCapture(handle(this))

ib_mousecaptured = TRUE

return 1
end function

public function boolean of_ismousecaptured ();
return ib_mousecaptured
end function

public function integer of_releasemouse ();
if NOT of_ismousecaptured() then return -1

ReleaseCapture()

ib_mousecaptured = FALSE

Return 1
end function

public function integer of_drawchevron (long ahdc);Long ll_x, ll_y
Long ll_index

//ll_start = UnitsToPixels(Width / 2, XUnitsToPixels!) - 16


IF iuo_parent.il_CurrentOrientation = iuo_parent.HORIZONTAL THEN
	ll_y = UnitsToPixels(25, YUnitsToPixels!)
	ll_x = UnitsToPixels(15, XUnitsToPixels!)
ELSE
	ll_y = 4
	ll_x = 4
END IF

FOR ll_index = 1 TO 5
	SetPixel(ahdc, ll_x, ll_y, 0)
	SetPixel(ahdc, ll_x + 1, ll_y, 0)
	SetPixel(ahdc, ll_x + 3, ll_y, 0)
	SetPixel(ahdc, ll_x + 4, ll_y, 0)
	
	ll_y = ll_y + 1
	IF ll_index < 3 THEN
		ll_x = ll_x + 1
	ELSE
		ll_x = ll_x - 1
	END IF
	
NEXT

IF iuo_parent.il_CurrentOrientation = iuo_parent.HORIZONTAL THEN
	ll_y = ll_y + 4
	ll_x = ll_x + 1
ELSE
	ll_y = 5
	ll_x = ll_x + 12
END IF

FOR ll_index = 1 TO 5
	SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
NEXT

ll_y = ll_y + 1
ll_x = ll_x + 1

FOR ll_index = 1 TO 3
	SetPixel(ahdc, ll_x + ll_index, ll_y, 0)
NEXT

ll_y = ll_y + 1
ll_x = ll_x + 2

SetPixel(ahdc, ll_x, ll_y, 0)

RETURN 1
end function

public function integer of_setparent (u_cst_toolbarstrip auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_clearitems ();ToolbarItem ToolbarItems[]
iToolbarItems = ToolbarItems
RETURN 1
end function

public function integer of_registeritem (toolbaritem luo_item);iToolbarItems[UpperBound(iToolbarItems) + 1] = luo_item
RETURN 1
end function

on u_cst_toolbarchevron.create
call super::create
end on

on u_cst_toolbarchevron.destroy
call super::destroy
end on

event onpaint;call super::onpaint;Long ll_parm, ll_textcolor
Long ll_color1, ll_color2
Boolean lb_Horizontal

IF NOT IsValid(iuo_parent) THEN
	RETURN 0
END IF

IF iuo_parent.ib_solidbackground THEN
	ll_color1 = iuo_parent.of_GetColor("BACKGROUND3")
	ll_color2 = iuo_parent.of_GetColor("BACKGROUND3")
ELSE
	ll_color1 = iuo_parent.of_GetColor("BACKGROUND1")
	ll_color2 = iuo_parent.of_GetColor("BACKGROUND2")
END IF
		
IF iuo_parent.il_CurrentOrientation = iuo_parent.HORIZONTAL THEN
	lb_Horizontal = TRUE
ELSE
	lb_Horizontal = FALSE
END IF

in_Gradient.of_SetHDC(hdc)
IF ib_mousecaptured THEN
	of_SetTransparent(FALSE)
	IF ib_selected AND NOT ib_mouseleave THEN
		in_Gradient.of_XPGradient (iuo_parent.of_GetColor("SELECTED1"), iuo_parent.of_GetColor("SELECTED2"), THIS,TRUE,iuo_parent.of_GetColor("HIGHLIGHTBORDER"), lb_Horizontal)			
	ELSE
		in_Gradient.of_XPGradient (iuo_parent.of_GetColor("HIGHLIGHT1"), iuo_parent.of_GetColor("HIGHLIGHT2"), THIS,TRUE,iuo_parent.of_GetColor("HIGHLIGHTBORDER"), lb_Horizontal)			
	END IF
ELSE
	of_SetTransparent(TRUE)
	/*
	CHOOSE CASE iuo_parent.il_CurrentStyle
		CASE iuo_parent.XP
			in_Gradient.of_XPGradient(ll_color1, ll_color2, THIS,FALSE,0, lb_Horizontal)
		CASE iuo_parent.VISTAEMBOSSED
			in_Gradient.of_Vista1Gradient(ll_color1, ll_color2, THIS,FALSE,0, lb_Horizontal)
		CASE iuo_parent.VISTAORIGINAL
			in_Gradient.of_Vista2Gradient(ll_color1, ll_color2, THIS,FALSE,0, lb_Horizontal)
		CASE iuo_parent.VISTAGLASS
			in_Gradient.of_Vista3Gradient(ll_color1, ll_color2, THIS,FALSE,0, lb_Horizontal)	
	END CHOOSE
*/
//	in_Gradient.of_XPGradient (ll_color1, ll_color2, THIS,FALSE,0, lb_Horizontal)	
END IF
	
of_DrawChevron(hdc)

RETURN 1
end event


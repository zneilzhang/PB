HA$PBExportHeader$u_cst_powerdockclose.sru
forward
global type u_cst_powerdockclose from u_cst_canvas
end type
end forward

global type u_cst_powerdockclose from u_cst_canvas
integer width = 114
integer height = 100
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event clicked pbm_lbuttonup
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
end type
global u_cst_powerdockclose u_cst_powerdockclose

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
Function Long GetPixel(Long ahdc, int aX, int aY) Library "Gdi32.dll"

Function ulong CreatePen  (ulong nPenStyle, ulong nWidth, ulong crColor) LIBRARY "Gdi32.dll"
Function ulong CreateRectRgn (Long X1, Long Y1 , Long X2 , Long Y2 ) LIBRARY "Gdi32.dll"
Function ULONG FillRgn (Long hdc6, Long hRgn , Long hBrush ) LIBRARY "Gdi32.dll"
Function ULONG	SelectObject (uLong hdc4, uLong hObject ) LIBRARY "Gdi32.dll"
function boolean DeleteObject(ulong hgdiobject) library "gdi32.dll" 

FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"

end prototypes

type variables
Boolean ib_selected
Boolean ib_mousecaptured
Boolean ib_mouseleave
Boolean ib_mousedown
Boolean ib_mouseover

Boolean ib_inarrow
Boolean ib_inx

Boolean ib_displayclose

Long il_x

u_cst_tabcontrol iuo_parent
n_cst_tabstrip_gradient in_Gradient
end variables

forward prototypes
public function integer of_drawx (long ahdc)
public function integer of_drawarrow (long ahdc)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_drawbackground (long hdc)
public function integer of_displayclosebutton (boolean ab_switch)
end prototypes

event clicked;

of_releasemouse()
this.event post mouseleave()
end event

event mouseleave();ib_mouseover = FALSE
ib_mousecaptured = FALSE
ib_selected = FALSE
ib_inarrow = FALSE
ib_inx = FALSE

SetRedraw(TRUE)
end event

event mousemove;if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
	
	il_x = UnitsToPixels(xpos, XUnitsToPixels!)
		IF il_x < 16 THEN
			ib_inarrow = TRUE
			ib_inx = FALSE
		ELSE
			IF il_x > 18 THEN
				ib_inarrow = FALSE
				ib_inx = TRUE
			ELSE
				ib_inarrow = FALSE
				ib_inx = FALSE
			END IF
		END IF
		
		SetRedraw(TRUE)
	
else
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
		
		of_releasemouse()
		this.event post mouseleave()

	ELSE
		il_x = UnitsToPixels(xpos, XUnitsToPixels!)
		IF il_x < 16 THEN
			ib_inarrow = TRUE
			ib_inx = FALSE
		ELSE
			IF il_x > 18 THEN
				ib_inarrow = FALSE
				ib_inx = TRUE
			ELSE
				ib_inarrow = FALSE
				ib_inx = FALSE
			END IF
		END IF
		
		SetRedraw(TRUE)
	end if
	
end if

end event

public function integer of_drawx (long ahdc);Long ll_y

ll_y = 2

SetPixel(ahdc, 22, 4 + ll_y, 0)
SetPixel(ahdc, 23, 4 + ll_y, 0)
SetPixel(ahdc, 29, 4 + ll_y, 0)
SetPixel(ahdc, 30, 4 + ll_y, 0)

SetPixel(ahdc, 23, 5 + ll_y, 0)
SetPixel(ahdc, 24, 5 + ll_y, 0)
SetPixel(ahdc, 28, 5 + ll_y, 0)
SetPixel(ahdc, 29, 5 + ll_y, 0)

SetPixel(ahdc, 24, 6 + ll_y, 0)
SetPixel(ahdc, 25, 6 + ll_y, 0)
SetPixel(ahdc, 27, 6 + ll_y, 0)
SetPixel(ahdc, 28, 6 + ll_y, 0)

SetPixel(ahdc, 25, 7 + ll_y, 0)
SetPixel(ahdc, 26, 7 + ll_y, 0)
SetPixel(ahdc, 27, 7 + ll_y, 0)

SetPixel(ahdc, 25, 8 + ll_y, 0)
SetPixel(ahdc, 26, 8 + ll_y, 0)
SetPixel(ahdc, 27, 8 + ll_y, 0)

SetPixel(ahdc, 24, 9 + ll_y, 0)
SetPixel(ahdc, 25, 9 + ll_y, 0)
SetPixel(ahdc, 27, 9 + ll_y, 0)
SetPixel(ahdc, 28, 9 + ll_y, 0)

SetPixel(ahdc, 23, 10 + ll_y, 0)
SetPixel(ahdc, 24, 10 + ll_y, 0)
SetPixel(ahdc, 28, 10 + ll_y, 0)
SetPixel(ahdc, 29, 10 + ll_y, 0)

SetPixel(ahdc, 22, 11 + ll_y, 0)
SetPixel(ahdc, 23, 11 + ll_y, 0)
SetPixel(ahdc, 29, 11 + ll_y, 0)
SetPixel(ahdc, 30, 11 + ll_y, 0)

RETURN 1

end function

public function integer of_drawarrow (long ahdc);Long ll_y

ll_y = 2

SetPixel(ahdc, 4, 6 + ll_y, 0)
SetPixel(ahdc, 5, 6 + ll_y, 0)
SetPixel(ahdc, 6, 6 + ll_y, 0)
SetPixel(ahdc, 7, 6 + ll_y, 0)
SetPixel(ahdc, 8, 6 + ll_y, 0)
SetPixel(ahdc, 9, 6 + ll_y, 0)
SetPixel(ahdc, 10, 6 + ll_y, 0)
SetPixel(ahdc, 11, 6 + ll_y, 0)

SetPixel(ahdc, 5, 7 + ll_y, 0)
SetPixel(ahdc, 6, 7 + ll_y, 0)
SetPixel(ahdc, 7, 7 + ll_y, 0)
SetPixel(ahdc, 8, 7 + ll_y, 0)
SetPixel(ahdc, 9, 7 + ll_y, 0)
SetPixel(ahdc, 10, 7 + ll_y, 0)

SetPixel(ahdc, 6, 8 + ll_y, 0)
SetPixel(ahdc, 7, 8 + ll_y, 0)
SetPixel(ahdc, 8, 8 + ll_y, 0)
SetPixel(ahdc, 9, 8 + ll_y, 0)

SetPixel(ahdc, 7, 9 + ll_y, 0)
SetPixel(ahdc, 8, 9 + ll_y, 0)

RETURN 1

end function

public function integer of_capturemouse ();
if of_ismousecaptured() then Return -1

SetCapture(handle(this))

ib_mousecaptured = TRUE

return 1
end function

public function boolean of_ismousecaptured ();return ib_mousecaptured
end function

public function integer of_releasemouse ();
if NOT of_ismousecaptured() then return -1

ReleaseCapture()

ib_mousecaptured = FALSE

Return 1
end function

public function integer of_drawbackground (long hdc);Long ll_color
Long ll_dc
Long ll_index1, ll_index2
Long ll_x, ll_y, ll_height

ll_x = 0
ll_y = 0

//ll_dc = GetDC(Handle(iuo_parent.iw_parent))
//ll_color = GetPixel(ll_dc, ll_x, ll_y)
//ReleaseDC(Handle(iuo_parent.iw_parent), ll_dc)
ll_color = iuo_parent.of_GetColor('TABBACK1')

ll_height = UnitsToPixels(THIS.Height, YUnitsToPixels!)

FOR ll_index1 = 0 TO 34
	
	FOR ll_index2 = 0 TO ll_height
		SetPixel(hdc, ll_index1, ll_index2, ll_color)
	NEXT
	
NEXT

RETURN 1
end function

public function integer of_displayclosebutton (boolean ab_switch);ib_displayclose = ab_switch

IF ab_switch THEN
	THIS.Width = PixelsToUnits(34, XPixelsToUnits!)
ELSE
	THIS.Width = PixelsToUnits(18, XPixelsToUnits!)
END IF

RETURN 1
end function

on u_cst_powerdockclose.create
call super::create
end on

on u_cst_powerdockclose.destroy
call super::destroy
end on

event onpaint;call super::onpaint;long hRgn, hRPen

of_DrawBackground(hdc)

IF ib_mousecaptured THEN
	IF il_x < 16 THEN
		
		hRgn = CreateRectRgn (0, 2 , 16 , 18 )
		hRPen = CreatePen(0,0,RGB(49,106,197))
		FillRgn (hdc, hRgn , hRPen )
		DeleteObject(hRPen)
		DeleteObject(hRgn)
		
		hRgn = CreateRectRgn (1, 3 , 15 , 17 )
		hRPen = CreatePen(0,0,RGB(193,210,238))
		FillRgn (hdc, hRgn , hRPen )
		DeleteObject(hRPen)
		DeleteObject(hRgn)
	ELSE
		IF il_x > 18 THEN
			
			hRgn = CreateRectRgn (18, 2 , 34 , 18 )
			hRPen = CreatePen(0,0,RGB(49,106,197))
			FillRgn (hdc, hRgn , hRPen )
			DeleteObject(hRPen)
			DeleteObject(hRgn)
			
			hRgn = CreateRectRgn (19, 3 , 33 , 17 )
			hRPen = CreatePen(0,0,RGB(193,210,238))
			FillRgn (hdc, hRgn , hRPen )
			DeleteObject(hRPen)
			DeleteObject(hRgn)
		END IF
	END IF
END IF

of_DrawArrow(hdc)
of_DrawX(hdc)

Long ll_x1, ll_x2, ll_y1, ll_y2
	
IF iuo_parent.il_CurrentPosition = iuo_parent.Top THEN
	ll_x1 = 0
	ll_y1 = Height - 4
	ll_x2 = Width
	ll_y2 = Height - 4
ELSE
	ll_x1 = 0
	ll_y1 = 1
	ll_x2 = Width
	ll_y2 = 1
END IF

in_Gradient.of_SetHDC(hdc)
in_Gradient.of_DrawLine(ll_x1, ll_y1, ll_x2, ll_y2, iuo_parent.of_GetColor('BORDER'), FALSE)

RETURN 1
end event

event constructor;call super::constructor;THIS.Width = PixelsToUnits(34, XPixelsToUnits!)
//THIS.Height = PixelsToUnits(16, YPixelsToUnits!)

Post SetRedraw(TRUE)
end event


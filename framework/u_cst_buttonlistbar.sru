HA$PBExportHeader$u_cst_buttonlistbar.sru
forward
global type u_cst_buttonlistbar from u_cst_canvas
end type
type uo_scrolldown from u_cst_buttonlistbarscroll within u_cst_buttonlistbar
end type
type uo_scrollup from u_cst_buttonlistbarscroll within u_cst_buttonlistbar
end type
type lv_imagelistlarge from listview within u_cst_buttonlistbar
end type
type lv_imagelistxlarge from listview within u_cst_buttonlistbar
end type
type lv_imagelistmedium from listview within u_cst_buttonlistbar
end type
type lv_imagelistsmall from listview within u_cst_buttonlistbar
end type
type st_buttonlistbarlabel from statictext within u_cst_buttonlistbar
end type
type size from structure within u_cst_buttonlistbar
end type
end forward

type size from structure
	long		cx
	long		cy
end type

global type u_cst_buttonlistbar from u_cst_canvas
integer width = 599
integer height = 596
event resize pbm_size
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
event type long selectionchanging ( long oldindex,  long newindex )
event selectionchanged ( long oldindex,  long newindex )
uo_scrolldown uo_scrolldown
uo_scrollup uo_scrollup
lv_imagelistlarge lv_imagelistlarge
lv_imagelistxlarge lv_imagelistxlarge
lv_imagelistmedium lv_imagelistmedium
lv_imagelistsmall lv_imagelistsmall
st_buttonlistbarlabel st_buttonlistbarlabel
end type
global u_cst_buttonlistbar u_cst_buttonlistbar

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"

Function Long SetPixel(Long ahdc, int aX, int aY, Long crColor) Library "Gdi32.dll"
Function Long GetPixel(Long ahdc, int aX, int aY) Library "Gdi32.dll"

Function ulong SelectObject ( &
	ulong hdc, &
	ulong hWnd &
	) Library "gdi32.dll"

Function boolean GetTextExtentPoint32 ( &
	ulong hdcr, &
	string lpString, &
	long nCount, &
	Ref SIZE size &
	) Library "gdi32.dll" Alias For "GetTextExtentPoint32W"
end prototypes

type variables
n_cst_buttonlistbar_gradient in_gradient

Long il_y = 20

Long il_imagelistsmall
Long il_imagelistmedium
Long il_imagelistlarge
Long il_imagelistxlarge

Long il_imagelist

Long il_speed = 10

Long il_index
Long il_selected
Long il_nextindex = 0
Boolean ib_mousecaptured
String is_images[]
Boolean ib_boldselected
Boolean ib_dirty

n_cst_imagelist inv_ImageList

Buttons ist_buttons[]

Long il_CurrentOrientation

CONSTANT Long VERTICAL = 1
CONSTANT Long HORIZONTAL = 2


CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0

CONSTANT Long BLUE = RGB(185,210,248)
CONSTANT Long SILVER = RGB(232,232,240)
CONSTANT Long OLIVE = RGB(234,234,207)
CONSTANT Long CLASSIC = RGB(242,243,246)
CONSTANT Long DEFAULT = 0

CONSTANT Long LINK = 1
CONSTANT Long LABEL = 2
CONSTANT Long LINE = 3
CONSTANT Long OBJECT = 4

CONSTANT Long SMALL = 16
CONSTANT Long MEDIUM = 24
CONSTANT Long LARGE = 36
CONSTANT Long XLARGE = 48

CONSTANT Long BUTTON = 1
CONSTANT Long LIST = 2

Long il_CurrentSize = MEDIUM
Long il_CurrentTheme = BLUE
Long il_CurrentStyle = BUTTON

Constant Integer WM_GETFONT = 49

window	iw_parent

// Mimics the treeviewitem or listviewitem property DATA
Protected:
Any	ia_data[]
end variables

forward prototypes
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function long of_getcolor (string as_color)
public function integer of_reorganize (long al_y)
public function integer of_scrolldown ()
public function integer of_scrollup ()
public function integer of_settheme (long al_color)
public function integer of_settheme (string as_color)
public function integer of_addimage (string as_image)
public function integer of_setsize (integer ai_size)
public function integer of_updatepoints ()
public function integer of_indexfrompoint (long xpos, long ypos)
public function integer of_mouseover (long al_index)
public function integer of_mouseleave ()
public function integer of_selectbutton (long al_selected)
public function integer of_setenabled (long al_index, boolean ab_enabled)
public function integer of_setenabled (string as_text, boolean ab_enabled)
public function string of_gettext (long al_index)
public function integer of_selectbutton (string as_text)
public function integer of_setscrollspeed (long al_speed)
public function integer of_additem (string as_text, string as_image, any aa_data)
public function any of_getdata (integer ai_index)
public function window of_getparentwindow ()
public function long of_additem (string as_text, string as_image)
public function integer of_settext (long al_item, string as_text)
public function integer of_settext (string as_item, string as_text)
private function integer of_getarrayposition (long al_index)
public function integer of_gettextwidth (string as_text)
public function integer of_setstyle (long al_style)
public function integer of_updatepointsbutton ()
public function integer of_updatepointslist ()
public function integer of_reset ()
end prototypes

event resize;uo_scrollup.Width = Width
uo_scrolldown.Width = Width
uo_scrolldown.Y = Height - uo_scrolldown.height

of_Reorganize(il_y)

SetRedraw(TRUE)
end event

event mouseenter();SetRedraw(TRUE)
end event

event mouseleave();of_MouseLeave()
end event

event mousemove;Long ll_index

if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
		
else
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height OR &
	   (PointerY() < uo_scrolldown.Height) OR &
		(PointerY() > uo_scrolldown.Y) then
	
		of_releasemouse()
		
		this.event post mouseleave()
	
	ELSE
		ll_index = of_IndexFromPoint(xpos, ypos)
		IF il_index <> ll_index THEN
			of_MouseOver(ll_index)
			
			IF il_index > 0 THEN
//				IF Len(Trim(of_GetTipText(iuo_parent.il_index))) > 0 THEN
//					Long li_X, li_Y, ll_return
//		
//					IF il_Id > 0 THEN
//						li_X = 0//UnitsToPixels( Integer( X ),XUnitsToPixels! )
//						li_Y = 0//UnitsToPixels( Integer( Y ), YUnitsToPixels! )
//						inv_tooltip.of_UpdatetipRect( This, il_ID, &
//														li_x, li_y, &
//														li_x + UnitsToPixels( Integer( Width ), XUnitsToPixels! ), &
//														li_y + UnitsToPixels( Integer( Height ), YUnitsToPixels! ) )
//							
//						
//						inv_tooltip.Of_SetTipText( This, il_Id, iuo_parent.of_GetTipText(ll_index)) 
//					END IF
//				ELSE
//					inv_tooltip.of_UpdatetipRect( This, il_ID, &
//														0, 0, &
//														0, &
//														0 )
//				END IF
			END IF
		END IF
	
	end if

end if
end event

event lbuttonup;IF il_index > 0 THEN
	of_SelectButton(il_index)
END IF
end event

event type long selectionchanging(long oldindex, long newindex);//Return 0 to cancel change
RETURN 1
end event

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

public function long of_getcolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "BORDER"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(108,138,181)
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = RGB(99,122,68)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
			CASE DEFAULT
//				ll_color = GetSysColor(16)
		END CHOOSE
	CASE "ITEMBORDER"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(4,56,148)
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = RGB(99,122,68)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
			CASE DEFAULT
//				ll_color = GetSysColor(16)
		END CHOOSE
	CASE "HOVER1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,255,220)
			CASE SILVER
				ll_color = RGB(255,255,220)
			CASE OLIVE
				ll_color = RGB(255,255,220)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
			CASE DEFAULT
				ll_color = 16777215
		END CHOOSE
	CASE "HOVER2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(247,192,91)
			CASE SILVER
				ll_color = RGB(247,192,91)
			CASE OLIVE
				ll_color = RGB(247,192,91)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
			CASE DEFAULT
				ll_color = 16777215
		END CHOOSE
	CASE "BACKGROUND1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(122,161,230)
			CASE SILVER
				ll_color = RGB(196,200,212)
			CASE OLIVE
				ll_color = RGB(204,217,173)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE "BACKGROUND2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(99,117,214)
			CASE SILVER
				ll_color = RGB(177,179,200)
			CASE OLIVE
				ll_color = RGB(165,189,132)
			CASE CLASSIC
				ll_color = RGB(255,255,255)
		END CHOOSE
	CASE "HOVERSELECTED1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(232,127,8)
			CASE SILVER
				ll_color = RGB(232,127,8)
			CASE OLIVE
				ll_color = RGB(232,127,8)
			CASE CLASSIC
				ll_color = RGB(133,146,181)
			CASE DEFAULT
//				ll_color = GetSysColor (11)		
		END CHOOSE
	CASE "HOVERSELECTED2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(247,219,124)
			CASE SILVER
				ll_color = RGB(247,219,124)
			CASE OLIVE
				ll_color = RGB(247,219,124)
			CASE CLASSIC
				ll_color = RGB(133,146,181)
			CASE DEFAULT
//				ll_color = GetSysColor (11)				
		END CHOOSE
	CASE "SELECTED1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(247,219,124)
			CASE SILVER
				ll_color = RGB(251,230,148)
			CASE OLIVE
				ll_color = RGB(251,230,148)
			CASE CLASSIC
				ll_color = RGB(212,213,216)
			CASE DEFAULT
//				ll_color = GetSysColor (0)		
		END CHOOSE
	CASE "SELECTED2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(238,150,21)
			CASE SILVER
				ll_color = RGB(238,150,21)
			CASE OLIVE
				ll_color = RGB(238,150,21)
			CASE CLASSIC
				ll_color = RGB(212,213,216)
			CASE DEFAULT
//				ll_color = GetSysColor (0)			
		END CHOOSE
	CASE "ITEMTEXT"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = 0
			CASE SILVER
				ll_color = 0
			CASE OLIVE
				ll_color = 0
			CASE CLASSIC
				ll_color = 0
			CASE DEFAULT
				ll_color = 0			
		END CHOOSE
	CASE 'SCROLLBAR'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(169,199,240)
			CASE SILVER
				ll_color = RGB(192,192,211)
			CASE OLIVE
				ll_color = RGB(197,212,159)
			CASE CLASSIC
				ll_color = RGB(212,208,200)
		END CHOOSE
	CASE 'SCROLLBARSELECTED'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,238,194)
			CASE SILVER
				ll_color = RGB(255,238,194)
			CASE OLIVE
				ll_color = RGB(255,238,194)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
		END CHOOSE
	CASE 'SCROLLBARBORDER'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(127,157,185)
			CASE SILVER
				ll_color = RGB(165,172,178)
			CASE OLIVE
				ll_color = RGB(164,185,127)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE
	CASE 'SCROLLBARSELECTEDBORDER'
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(0,0,128)
			CASE SILVER
				ll_color = RGB(75,75,111)
			CASE OLIVE
				ll_color = RGB(63,93,56)
			CASE CLASSIC
				ll_color = RGB(10,36,106)
		END CHOOSE
END CHOOSE

RETURN ll_color

end function

public function integer of_reorganize (long al_y);Long ll_index, ll_count, ll_y

il_y = al_y
ll_y = al_y

IF ll_y > Height THEN
	uo_scrolldown.Show()
ELSE
	uo_scrolldown.Hide()	
END IF

IF il_y < 20 THEN
	uo_scrollup.Show()
ELSE
	uo_scrollup.Hide()
END IF

ib_dirty = TRUE
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_scrolldown ();Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

DO UNTIL NOT uo_scrolldown.ib_mousecaptured OR NOT uo_scrolldown.Visible
	Yield()
	
	//of_Reorganize(il_y - il_speed)
	FOR ll_index = 1 TO ll_count
		ist_buttons[ll_index].ast_point[1].py = ist_buttons[ll_index].ast_point[1].py - il_speed
		ist_buttons[ll_index].ast_point[2].py = ist_buttons[ll_index].ast_point[2].py - il_speed
		ist_buttons[ll_index].ast_point[3].py = ist_buttons[ll_index].ast_point[3].py - il_speed
		ist_buttons[ll_index].ast_point[4].py = ist_buttons[ll_index].ast_point[4].py - il_speed
	NEXT
	
	IF ist_buttons[1].ast_point[1].py < 10 THEN
		uo_scrollup.Show()
	ELSE
		uo_scrollup.Hide()
		il_y = 20
		of_Reorganize(il_y)
	END IF
	
	IF PixelsToUnits(ist_buttons[ll_count].ast_point[4].py, YPixelsToUnits!) > Height THEN
		uo_scrolldown.Show()
	ELSE
		uo_scrolldown.Hide()
	END IF
	
	ib_dirty = FALSE
	SetRedraw(TRUE)
	
LOOP

RETURN 1
end function

public function integer of_scrollup ();Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

DO UNTIL NOT uo_scrollup.ib_mousecaptured OR NOT uo_scrollup.Visible
	Yield()
	
	//of_Reorganize(il_y + il_speed)
	FOR ll_index = 1 TO ll_count
		ist_buttons[ll_index].ast_point[1].py = ist_buttons[ll_index].ast_point[1].py + il_speed
		ist_buttons[ll_index].ast_point[2].py = ist_buttons[ll_index].ast_point[2].py + il_speed
		ist_buttons[ll_index].ast_point[3].py = ist_buttons[ll_index].ast_point[3].py + il_speed
		ist_buttons[ll_index].ast_point[4].py = ist_buttons[ll_index].ast_point[4].py + il_speed
	NEXT
	
	IF ist_buttons[1].ast_point[1].py < 0 THEN
		uo_scrollup.Show()
	ELSE
		uo_scrollup.Hide()
		il_y = 20
		of_Reorganize(il_y)
	END IF
	
	IF PixelsToUnits(ist_buttons[ll_count].ast_point[4].py, YPixelsToUnits!) > Height THEN
		uo_scrolldown.Show()
	ELSE
		uo_scrolldown.Hide()
	END IF
	
	ib_dirty = FALSE
	SetRedraw(TRUE)
	
LOOP

RETURN 1
end function

public function integer of_settheme (long al_color);Long ll_index, ll_loop

il_currenttheme = al_color

ib_dirty = TRUE
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settheme (string as_color);CHOOSE CASE Upper(as_color)
	CASE 'BLUE'
		of_SetTheme(BLUE)
	CASE 'SILVER'
		of_SetTheme(SILVER)
	CASE 'OLIVE'
		of_SetTheme(OLIVE)
	CASE 'CLASSIC'
		of_SetTheme(CLASSIC)
	CASE 'DEFAULT'
		of_SetTheme(DEFAULT)
	CASE ELSE
		of_SetTheme(CLASSIC)
END CHOOSE
		
RETURN 1
end function

public function integer of_addimage (string as_image);Long ll_item

ll_item = UpperBound(is_images) + 1

is_images[ll_item] = as_image

lv_imagelistsmall.AddLargePicture ( as_image )
lv_imagelistmedium.AddLargePicture ( as_image )
lv_imagelistlarge.AddLargePicture ( as_image )
lv_imagelistxlarge.AddLargePicture ( as_image )

il_imagelistsmall = Send(Handle(lv_imagelistsmall), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistmedium = Send(Handle(lv_imagelistmedium), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistlarge = Send(Handle(lv_imagelistlarge), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistxlarge = Send(Handle(lv_imagelistxlarge), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)

CHOOSE CASE il_CurrentSize
	CASE SMALL
		il_imagelist = il_imagelistsmall
	CASE MEDIUM
		il_imagelist = il_imagelistmedium
	CASE LARGE
		il_imagelist = il_imagelistlarge
	CASE XLARGE
		il_imagelist = il_imagelistxlarge
END CHOOSE

RETURN ll_item
end function

public function integer of_setsize (integer ai_size);il_CurrentSize = ai_size

CHOOSE CASE il_CurrentSize
	CASE SMALL
		il_imagelist = il_imagelistsmall
	CASE MEDIUM
		il_imagelist = il_imagelistmedium
	CASE LARGE
		il_imagelist = il_imagelistlarge
	CASE XLARGE
		il_imagelist = il_imagelistxlarge
END CHOOSE

ib_dirty = TRUE
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_updatepoints ();CHOOSE CASE il_CurrentStyle
	CASE BUTTON
		RETURN of_UpdatePointsButton()
	CASE LIST
		RETURN of_UpdatePointsList()
END CHOOSE

RETURN 0
end function

public function integer of_indexfrompoint (long xpos, long ypos);//find out if a tab was clicked
long ll_count, ll_index
ulong lul_rgn
integer lix, liy

lix = UnitsToPixels(xpos, XUnitsToPixels!)
liy = UnitsToPixels(ypos, YUnitsToPixels!)

ll_count = UPPERBOUND(ist_buttons)
FOR ll_index = 1 to ll_count
	//skip if disabled
	IF NOT ist_buttons[ll_index].ab_enabled THEN CONTINUE
	lul_rgn = in_Gradient.CreatePolygonRgn(ist_buttons[ll_index].ast_point, UPPERBOUND(ist_buttons[ll_index].ast_point), 1)
	IF in_Gradient.PtInRegion(lul_rgn, lix, liy) <> 0 THEN
		in_Gradient.DeleteObject(lul_rgn)
		RETURN ll_index
	ELSE
		in_Gradient.DeleteObject(lul_rgn)
	END IF
NEXT

RETURN -1
end function

public function integer of_mouseover (long al_index);IF il_index > 0 THEN
	IF il_selected = il_index THEN
		ist_buttons[il_index].ab_mouseover = FALSE
		ist_buttons[il_index].ab_selected = TRUE
		ist_buttons[il_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_buttons[il_index].al_backcolor2 = of_GetColor('SELECTED2')
	ELSE
		ist_buttons[il_index].ab_mouseover = FALSE
		ist_buttons[il_index].ab_selected = FALSE
		ist_buttons[il_index].al_backcolor1 = 0
		ist_buttons[il_index].al_backcolor2 = 0
	END IF
END IF

IF al_index > 0 THEN
	IF il_selected = al_index THEN
		ist_buttons[al_index].ab_mouseover = TRUE
		ist_buttons[al_index].ab_selected = TRUE
		ist_buttons[al_index].al_backcolor1 = of_GetColor('HOVERSELECTED1')
		ist_buttons[al_index].al_backcolor2 = of_GetColor('HOVERSELECTED2')
	ELSE
		ist_buttons[al_index].ab_mouseover = TRUE
		ist_buttons[al_index].ab_selected = FALSE
		ist_buttons[al_index].al_backcolor1 = of_GetColor('HOVER1')
		ist_buttons[al_index].al_backcolor2 = of_GetColor('HOVER2')
	END IF
END IF

il_index = al_index

ib_dirty = FALSE
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_mouseleave ();IF il_index > 0 THEN
	IF il_selected = il_index THEN
		
		ist_buttons[il_index].ab_mouseover = FALSE
		ist_buttons[il_index].al_backcolor1 = of_GetColor('SELECTED1')
		ist_buttons[il_index].al_backcolor2 = of_GetColor('SELECTED2')
	ELSE
		ist_buttons[il_index].ab_selected = FALSE
		ist_buttons[il_index].ab_mouseover = FALSE
		ist_buttons[il_index].al_backcolor1 = of_GetColor('BACKCOLOR1')
		ist_buttons[il_index].al_backcolor2 = of_GetColor('BACKCOLOR2')
	END IF
END IF

il_index = 0

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_selectbutton (long al_selected);Long ll_old, ll_index, ll_count
Long ll_array_selected

ll_array_selected = of_GetArrayPosition(al_selected)

IF al_selected <= 0 THEN RETURN 0
IF NOT ist_buttons[ll_array_selected].ab_Enabled THEN RETURN 0

IF Event SelectionChanging(ist_buttons[al_selected].al_index, al_selected) = 1 THEN
	ll_old = il_selected
	il_selected = ll_array_selected
	
	IF il_selected <> ll_old THEN
		ist_buttons[ll_array_selected].ab_mouseover = FALSE
		ist_buttons[ll_array_selected].ab_selected = TRUE
		ist_buttons[ll_array_selected].al_backcolor1 = of_GetColor('SELECTED1')
		ist_buttons[ll_array_selected].al_backcolor2 = of_GetColor('SELECTED2')
	END IF
	
	IF ll_old > 0 AND ll_old <> il_selected THEN
		ist_buttons[ll_old].ab_mouseover = FALSE
		ist_buttons[ll_old].ab_selected = FALSE
		ist_buttons[ll_old].al_backcolor1 = 0
		ist_buttons[ll_old].al_backcolor2 = 0
	END IF

	SetRedraw(TRUE)
	
	IF ll_old > 0 THEN
		ll_old = ist_buttons[ll_old].al_index
	END IF
	
	EVENT SelectionChanged(ll_old, ist_buttons[il_selected].al_index)
	
END IF

RETURN 1
end function

public function integer of_setenabled (long al_index, boolean ab_enabled);Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

FOR ll_index = 1 TO ll_count
	IF ist_buttons[ll_index].al_index = al_index THEN
		ist_buttons[al_index].ab_enabled = ab_enabled
		EXIT
	END IF
NEXT

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setenabled (string as_text, boolean ab_enabled);Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

FOR ll_index = 1 TO ll_count
	IF Lower(ist_buttons[ll_index].as_text) = Lower(as_text) THEN
		of_SetEnabled(ist_buttons[ll_index].al_index, ab_enabled)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function string of_gettext (long al_index);RETURN ist_buttons[of_GetArrayPosition(al_index)].as_text
end function

public function integer of_selectbutton (string as_text);Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

FOR ll_index = 1 TO ll_count
	IF Lower(ist_buttons[ll_index].as_text) = Lower(as_text) THEN
		of_SelectButton(ll_index)
		EXIT
	END IF
NEXT

RETURN 1
end function

public function integer of_setscrollspeed (long al_speed);il_speed = al_speed
RETURN 1
end function

public function integer of_additem (string as_text, string as_image, any aa_data);//////////////////////////////////////////////////////////////////////////////////////////
//
// Description : Overloaded of_AddItem to accommodate the DATA parameter w/c mimics the 
//					  DATA property of a Treeviewitem or ListviewItem. This will hold the information
//					  on which object or data to be opened or how to be opened from by the 
//               parent window/object
//
//////////////////////////////////////////////////////////////////////////////////////////
Long	l_upper
int	i_retval

l_upper = upperbound(ia_data) + 1

ia_data[l_upper] = aa_data

i_retval = this.of_additem( as_text, as_image )

RETURN i_retval
end function

public function any of_getdata (integer ai_index);//////////////////////////////////////////////////////////////////////////////////////////
//
// Description : Obtains the property DATA(Any) per item link of this UO 
//
//////////////////////////////////////////////////////////////////////////////////////////
any a_null

SetNull(a_null)

IF ai_index <= 0 THEN RETURN a_null

RETURN ia_data[of_GetArrayPosition(ai_index)]
end function

public function window of_getparentwindow ();PowerObject	po_parent
window		w_parent

IF IsValid(iw_parent) THEN RETURN iw_parent

po_parent = GetParent()

do while IsValid (po_parent) and po_parent.TypeOf() <> window! 
	po_parent = po_parent.GetParent()
loop

IF IsValid(po_parent) THEN
	w_parent = po_parent
ELSE
	SetNull(w_parent)
END IF

iw_parent = w_parent

RETURN w_parent
end function

public function long of_additem (string as_text, string as_image);Long ll_item

ll_item = UpperBound(ist_buttons) + 1
il_nextindex++

ist_buttons[ll_item].as_text = as_text
ist_buttons[ll_item].al_image = of_AddImage(as_image)
ist_buttons[ll_item].ab_enabled = TRUE
ist_buttons[ll_item].al_index = il_nextindex
ist_buttons[ll_item].ab_invalid = FALSE

ist_buttons[ll_item].ast_point[1].px = 0
ist_buttons[ll_item].ast_point[1].py = 0
ist_buttons[ll_item].ast_point[2].px = 0
ist_buttons[ll_item].ast_point[2].py = 0
ist_buttons[ll_item].ast_point[3].px = 0
ist_buttons[ll_item].ast_point[3].py = 0
ist_buttons[ll_item].ast_point[4].px = 0
ist_buttons[ll_item].ast_point[4].py = 0

of_Reorganize(il_y)

SetRedraw(TRUE)

RETURN il_nextindex
end function

public function integer of_settext (long al_item, string as_text);Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

FOR ll_index = 1 TO ll_count
	
	IF ist_buttons[ll_index].al_index = al_item THEN
		ist_buttons[ll_index].as_text = as_text
		EXIT
	END IF
NEXT

ib_dirty = TRUE

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settext (string as_item, string as_text);Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

FOR ll_index = 1 TO ll_count
	
	IF ist_buttons[ll_index].as_text = as_text THEN
		of_SetText(ist_buttons[ll_index].al_index, as_text)
		EXIT
	END IF
NEXT

RETURN 1
end function

private function integer of_getarrayposition (long al_index);Long ll_index, ll_count

ll_count = UpperBound(ist_buttons)

FOR ll_index = 1 TO ll_count
	IF ist_buttons[ll_index].al_index = al_index THEN
		RETURN ll_index
	END IF
NEXT

RETURN 0
end function

public function integer of_gettextwidth (string as_text);ULong lul_Handle, lul_hDC, lul_hFont
SIZE lstr_size

lul_Handle = Handle(st_buttonlistbarlabel)
lul_hDC = GetDC(lul_Handle)
// get handle to the font used by statictext
lul_hFont = Send(lul_Handle, WM_GETFONT, 0, 0)
// Select it into the device context
SelectObject(lul_hDC, lul_hFont)

GetTextExtentPoint32(lul_hDC, as_text, Len(as_text), lstr_Size)
ReleaseDC(lul_Handle, lul_hDC)

RETURN lstr_Size.cx + 4
 
end function

public function integer of_setstyle (long al_style);il_currentstyle = al_style

il_y = 20

ib_dirty = true

SetRedraw(TRUE)

RETURN 1

end function

public function integer of_updatepointsbutton ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth, ll_item
Long ll_width, ll_height, ll_dc
point lp_empty[]
n_cst_buttonlistbar_gradient ln_gradient

ll_count = UpperBound(ist_buttons)

IF il_CurrentOrientation = VERTICAL THEN
	ll_y = UnitsToPixels(il_y, YUnitsToPixels!)
	ll_x = 10
	ll_width = UnitsToPixels(Width, XUnitsToPixels!)
	ll_height = il_CurrentSize
ELSE
	ll_y = 10
	ll_x = 10
	ll_width = il_CurrentSize
	ll_height = UnitsToPixels(Height, YUnitsToPixels!)
END IF

ll_dc = GetDC(Handle(st_buttonlistbarlabel))
ln_gradient.of_SetHDC(ll_dc)

FOR ll_index = 1 TO ll_count
	IF ist_buttons[ll_index].ab_Invalid THEN
		CONTINUE
	END IF
	
	ll_item++
	ist_buttons[ll_index].ast_point = lp_empty
	
	IF il_index = ll_index THEN
		IF il_selected = ll_index THEN
			ist_buttons[ll_index].ab_selected = TRUE
			ist_buttons[ll_index].ab_mouseover = TRUE
			ist_buttons[ll_index].al_backcolor1 = of_GetColor('HOVERSELECTED1')
			ist_buttons[ll_index].al_backcolor2 = of_GetColor('HOVERSELECTED2')
		ELSE
			ist_buttons[ll_index].ab_selected = FALSE
			ist_buttons[ll_index].ab_mouseover = TRUE
			ist_buttons[ll_index].al_backcolor1 = of_GetColor('HOVER1')
			ist_buttons[ll_index].al_backcolor2 = of_GetColor('HOVER2')
		END IF
	ELSE
		IF il_selected = ll_index THEN
			ist_buttons[ll_index].ab_mouseover = FALSE
			ist_buttons[ll_index].ab_selected = TRUE
			ist_buttons[ll_index].al_backcolor1 = of_GetColor('SELECTED1')
			ist_buttons[ll_index].al_backcolor2 = of_GetColor('SELECTED2')
		ELSE
			ist_buttons[ll_index].ab_mouseover = FALSE
			ist_buttons[ll_index].ab_selected = FALSE
			ist_buttons[ll_index].al_backcolor1 = 0
			ist_buttons[ll_index].al_backcolor2 = 0
		END IF
	END IF
	
	
	
	IF il_CurrentOrientation = VERTICAL THEN
		
		ln_gradient.of_DrawText(st_buttonlistbarlabel, &
				ist_buttons[ll_index].as_text, &
				0, &
				'tahoma', &
				11, FALSE, ln_gradient.ALIGN_CENTER, &
				0, &
				0, &
				ll_width - ll_x - ll_x, &
				0, &
				FALSE, FALSE, FALSE, TRUE)
				
		ll_height = il_CurrentSize + ln_gradient.il_NewHeight + 2
		
		ist_buttons[ll_index].ast_point[1].px = ll_x
		ist_buttons[ll_index].ast_point[1].py = ll_y
		ist_buttons[ll_index].ast_point[2].px = ll_width - ll_x
		ist_buttons[ll_index].ast_point[2].py = ll_y
		ist_buttons[ll_index].ast_point[3].px = ll_width - ll_x
		ist_buttons[ll_index].ast_point[3].py = ll_y + ll_height + 10
		ist_buttons[ll_index].ast_point[4].px = ll_x
		ist_buttons[ll_index].ast_point[4].py = ll_y + ll_height + 10
		
		ll_y = ll_y + ll_height + 12
	ELSE
		
		ll_textwidth = of_GetTextWidth(ist_buttons[ll_index].as_text)
		
		IF il_CurrentSize > ll_textwidth THEN
			ll_width = il_CurrentSize
		ELSE
			ll_width = ll_textwidth
		END IF
		
		ist_buttons[ll_index].ast_point[1].px = ll_x
		ist_buttons[ll_index].ast_point[1].py = ll_y
		ist_buttons[ll_index].ast_point[2].px = ll_width + ll_x
		ist_buttons[ll_index].ast_point[2].py = ll_y
		ist_buttons[ll_index].ast_point[3].px = ll_width + ll_x
		ist_buttons[ll_index].ast_point[3].py = ll_height - ll_y
		ist_buttons[ll_index].ast_point[4].px = ll_x
		ist_buttons[ll_index].ast_point[4].py = ll_height - ll_y
		
		ll_x = ll_x + ll_width + 12
	END IF

NEXT

ReleaseDC (Handle(st_buttonlistbarlabel), ll_dc)

IF PixelsToUnits(ll_y, YPixelsToUnits!) > Height THEN
	uo_scrolldown.Show()
ELSE
	uo_scrolldown.Hide()
END IF

RETURN 1
end function

public function integer of_updatepointslist ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth, ll_item
Long ll_width, ll_height, ll_dc
point lp_empty[]
n_cst_buttonlistbar_gradient ln_gradient

ll_count = UpperBound(ist_buttons)

ll_y = UnitsToPixels(il_y, YUnitsToPixels!)
ll_x = 10
ll_width = UnitsToPixels(Width, XUnitsToPixels!)
ll_height = il_CurrentSize

ll_dc = GetDC(Handle(st_buttonlistbarlabel))
ln_gradient.of_SetHDC(ll_dc)

FOR ll_index = 1 TO ll_count
	IF ist_buttons[ll_index].ab_Invalid THEN
		CONTINUE
	END IF
	
	ll_item++
	ist_buttons[ll_index].ast_point = lp_empty
	
	IF il_index = ll_index THEN
		IF il_selected = ll_index THEN
			ist_buttons[ll_index].ab_selected = TRUE
			ist_buttons[ll_index].ab_mouseover = TRUE
			ist_buttons[ll_index].al_backcolor1 = of_GetColor('HOVERSELECTED1')
			ist_buttons[ll_index].al_backcolor2 = of_GetColor('HOVERSELECTED2')
		ELSE
			ist_buttons[ll_index].ab_selected = FALSE
			ist_buttons[ll_index].ab_mouseover = TRUE
			ist_buttons[ll_index].al_backcolor1 = of_GetColor('HOVER1')
			ist_buttons[ll_index].al_backcolor2 = of_GetColor('HOVER2')
		END IF
	ELSE
		IF il_selected = ll_index THEN
			ist_buttons[ll_index].ab_mouseover = FALSE
			ist_buttons[ll_index].ab_selected = TRUE
			ist_buttons[ll_index].al_backcolor1 = of_GetColor('SELECTED1')
			ist_buttons[ll_index].al_backcolor2 = of_GetColor('SELECTED2')
		ELSE
			ist_buttons[ll_index].ab_mouseover = FALSE
			ist_buttons[ll_index].ab_selected = FALSE
			ist_buttons[ll_index].al_backcolor1 = 0
			ist_buttons[ll_index].al_backcolor2 = 0
		END IF
	END IF
	
	ln_gradient.of_DrawText(st_buttonlistbarlabel, &
			ist_buttons[ll_index].as_text, &
			0, &
			'tahoma', &
			11, FALSE, ln_gradient.ALIGN_LEFT, &
			0, &
			0, &
			ll_width - ll_x - ll_x - il_CurrentSize - 8, &
			0, &
			FALSE, FALSE, FALSE, TRUE)
	
	IF ln_gradient.il_NewHeight > il_CurrentSize THEN
		ll_height = ln_gradient.il_NewHeight + 4
	ELSE
		ll_height = il_CurrentSize + 4
	END IF
	
	ist_buttons[ll_index].al_textheight = ln_gradient.il_NewHeight
	
	ist_buttons[ll_index].ast_point[1].px = ll_x
	ist_buttons[ll_index].ast_point[1].py = ll_y
	ist_buttons[ll_index].ast_point[2].px = ll_width - ll_x
	ist_buttons[ll_index].ast_point[2].py = ll_y
	ist_buttons[ll_index].ast_point[3].px = ll_width - ll_x
	ist_buttons[ll_index].ast_point[3].py = ll_y + ll_height
	ist_buttons[ll_index].ast_point[4].px = ll_x
	ist_buttons[ll_index].ast_point[4].py = ll_y + ll_height
	
	ll_y = ll_y + ll_height + 2

NEXT

ReleaseDC (Handle(st_buttonlistbarlabel), ll_dc)

IF PixelsToUnits(ll_y, YPixelsToUnits!) > Height THEN
	uo_scrolldown.Show()
ELSE
	uo_scrolldown.Hide()
END IF

RETURN 1
end function

public function integer of_reset ();Buttons l_buttons[]
String ls[]
Any a_data[]

il_y = 20
ist_buttons = l_buttons
ia_data = a_data

lv_imagelistxlarge.DeleteLargePictures ( )
lv_imagelistxlarge.DeleteSmallPictures ( )

lv_imagelistlarge.DeleteLargePictures ( )
lv_imagelistlarge.DeleteSmallPictures ( )

lv_imagelistsmall.DeleteLargePictures ( )
lv_imagelistsmall.DeleteSmallPictures ( )

lv_imagelistmedium.DeleteLargePictures ( )
lv_imagelistmedium.DeleteSmallPictures ( )

il_index = 0
il_selected = 0
il_nextindex = 0
ib_mousecaptured = FALSE
is_images = ls

SetRedraw(TRUE)

RETURN 1
end function

on u_cst_buttonlistbar.create
int iCurrent
call super::create
this.uo_scrolldown=create uo_scrolldown
this.uo_scrollup=create uo_scrollup
this.lv_imagelistlarge=create lv_imagelistlarge
this.lv_imagelistxlarge=create lv_imagelistxlarge
this.lv_imagelistmedium=create lv_imagelistmedium
this.lv_imagelistsmall=create lv_imagelistsmall
this.st_buttonlistbarlabel=create st_buttonlistbarlabel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_scrolldown
this.Control[iCurrent+2]=this.uo_scrollup
this.Control[iCurrent+3]=this.lv_imagelistlarge
this.Control[iCurrent+4]=this.lv_imagelistxlarge
this.Control[iCurrent+5]=this.lv_imagelistmedium
this.Control[iCurrent+6]=this.lv_imagelistsmall
this.Control[iCurrent+7]=this.st_buttonlistbarlabel
end on

on u_cst_buttonlistbar.destroy
call super::destroy
destroy(this.uo_scrolldown)
destroy(this.uo_scrollup)
destroy(this.lv_imagelistlarge)
destroy(this.lv_imagelistxlarge)
destroy(this.lv_imagelistmedium)
destroy(this.lv_imagelistsmall)
destroy(this.st_buttonlistbarlabel)
end on

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

in_Gradient.of_VerticalGradient (of_GetColor("BACKGROUND1"), of_GetColor("BACKGROUND2"), THIS,TRUE,of_GetColor("BORDER"), 0)

IF ib_dirty THEN
	of_UpdatePoints()
	ib_dirty = FALSE
END IF

in_Gradient.of_DrawButtons (THIS, ist_buttons, of_GetColor("ITEMBORDER"), il_imagelist, ib_boldselected, il_CurrentSize, UnitsToPixels(Height, YUnitsToPixels!), il_currentstyle)

RETURN 1
end event

event constructor;call super::constructor;Long ll_color1, ll_color2, ll_index
n_cst_theme lnv_Theme

IF Height > Width THEN
	il_CurrentOrientation = VERTICAL
ELSE
	il_CurrentOrientation = HORIZONTAL
END IF

If lnv_Theme.of_IsAppThemed() And lnv_Theme.of_IsWindowsXp() Then
	ll_Color1 = lnv_Theme.of_GetColor( 1, 1, 3821 )
	ll_Color2 = lnv_Theme.of_GetColor( 1, 1, 3805 )
	Choose Case ll_Color1
		Case 15029248	// Blue
			of_SetTheme(BLUE)
		Case 12493732	//	Silver
			of_SetTheme(SILVER)
		Case 8829098	// olive green
			of_SetTheme(OLIVE)
		Case Else
			of_SetTheme(CLASSIC)
	End Choose
Else
	IF lnv_Theme.of_IsWindowsVista() THEN
		of_SetTheme(BLUE)
	ELSE
		of_SetTheme(CLASSIC)
	END IF
End If

TriggerEvent('resize')

of_GetParentWindow()
end event

type uo_scrolldown from u_cst_buttonlistbarscroll within u_cst_buttonlistbar
integer y = 544
integer taborder = 20
end type

on uo_scrolldown.destroy
call u_cst_buttonlistbarscroll::destroy
end on

event constructor;call super::constructor;of_SetParent(PARENT)
of_SetArrow('down')
end event

event mouseenter;call super::mouseenter;of_ScrollDown()
end event

event mouseleave;call super::mouseleave;PARENT.SetRedraw(TRUE)
end event

type uo_scrollup from u_cst_buttonlistbarscroll within u_cst_buttonlistbar
integer taborder = 10
end type

event constructor;call super::constructor;of_SetParent(PARENT)
of_SetArrow('up')
end event

on uo_scrollup.destroy
call u_cst_buttonlistbarscroll::destroy
end on

event mouseenter;call super::mouseenter;of_ScrollUp()
end event

event mouseleave;call super::mouseleave;PARENT.SetRedraw(TRUE)
end event

type lv_imagelistlarge from listview within u_cst_buttonlistbar
boolean visible = false
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 12632256
integer smallpicturewidth = 32
integer smallpictureheight = 32
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = LARGE
THIS.LargePictureWidth = LARGE
end event

type lv_imagelistxlarge from listview within u_cst_buttonlistbar
boolean visible = false
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = XLARGE
THIS.LargePictureWidth = XLARGE
end event

type lv_imagelistmedium from listview within u_cst_buttonlistbar
boolean visible = false
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = MEDIUM
THIS.LargePictureWidth = MEDIUM
end event

type lv_imagelistsmall from listview within u_cst_buttonlistbar
boolean visible = false
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer largepicturewidth = 16
integer largepictureheight = 16
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = SMALL
THIS.LargePictureWidth = SMALL
end event

type st_buttonlistbarlabel from statictext within u_cst_buttonlistbar
integer width = 10002
integer height = 10000
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "  Button Listbar"
boolean focusrectangle = false
end type

event constructor;Hide()
end event


HA$PBExportHeader$u_cst_toolbarstrip.sru
forward
global type u_cst_toolbarstrip from u_cst_canvas
end type
type lv_imagelistxlarge from listview within u_cst_toolbarstrip
end type
type lv_imagelistlarge from listview within u_cst_toolbarstrip
end type
type lv_imagelistmedium from listview within u_cst_toolbarstrip
end type
type lv_imagelistsmall from listview within u_cst_toolbarstrip
end type
type st_1 from statictext within u_cst_toolbarstrip
end type
type uo_toolbarchevron from u_cst_toolbarchevron within u_cst_toolbarstrip
end type
end forward

global type u_cst_toolbarstrip from u_cst_canvas
integer width = 498
integer height = 104
event ue_buttonclicked ( string as_button )
event ue_mousemove ( string as_button,  integer ai_xpos,  integer ai_ypos )
event ue_mouseenter ( string as_button )
event ue_mouseleave ( string as_button )
event resize pbm_size
event mousemove pbm_mousemove
event mouseenter ( long xpos,  long ypos )
event mouseleave ( )
event lbuttondown pbm_lbuttondown
event lbuttonup pbm_lbuttonup
lv_imagelistxlarge lv_imagelistxlarge
lv_imagelistlarge lv_imagelistlarge
lv_imagelistmedium lv_imagelistmedium
lv_imagelistsmall lv_imagelistsmall
st_1 st_1
uo_toolbarchevron uo_toolbarchevron
end type
global u_cst_toolbarstrip u_cst_toolbarstrip

type prototypes
PUBLIC FUNCTION Long SetParent(Long lChild, Long lParent) LIBRARY "user32.dll"
Function Boolean TrackMouseEvent ( ref trackmouseevent lpTrackMouseEvent ) Library 'user32.dll' alias for "TrackMouseEvent"

Function ulong GetDC ( &
	ulong hWnd &
	) Library "user32.dll"

Function ulong SelectObject ( &
	ulong hdc, &
	ulong hWnd &
	) Library "gdi32.dll"
	
Function long ReleaseDC ( &
	ulong hWnd, &
	ulong hdcr &
	) Library "user32.dll"
	
	Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
end prototypes

type variables
CONSTANT Long BLUE = RGB(185,210,248)
CONSTANT Long SILVER = RGB(232,232,240)
CONSTANT Long OLIVE = RGB(234,234,207)
CONSTANT Long CLASSIC = RGB(242,243,246)
CONSTANT Long DEFAULT = 0

CONSTANT Long LINK = 1
CONSTANT Long LABEL = 2
CONSTANT Long LINE = 3

CONSTANT Long XP = 0
CONSTANT Long VISTAEMBOSSED = 1
CONSTANT Long VISTAORIGINAL = 2
CONSTANT Long VISTAGLASS = 3
CONSTANT Long CUSTOM = 4

CONSTANT Long LEFT = 1
CONSTANT Long RIGHT = 2

//Text Position
CONSTANT Long TEXTTOP = 1
CONSTANT Long TEXTBOTTOM = 2
CONSTANT Long TEXTRIGHT = 3
CONSTANT Long TEXTLEFT = 4

Long il_CurrentTextPosition = TEXTRIGHT

String FontName = 'Tahoma'
Long FontSize = 11
Long FontColor = 0
Boolean Bold = FALSE

//BCW - 2.0.0
CONSTANT Long HORIZONTAL = 1
CONSTANT Long VERTICAL = 2
Long il_CurrentOrientation = 1
//BCW - 2.0.0

Long il_CurrentStyle = XP
Long il_CurrentTheme = BLUE

Long il_TextHeight

Boolean ib_displaytext = FALSE
Boolean ib_displayborder = TRUE
Boolean ib_raisedborder = FALSE
Boolean ib_solidbackground = FALSE

boolean ib_mousecaptured = FALSE
long il_index
long il_ID
long il_MOIndex
boolean ib_mouseover = FALSE
boolean ib_mouseleave = FALSE
boolean ib_selected = FALSE
boolean ib_mousedown = FALSE
n_cst_tooltip inv_tooltip

//u_cst_toolbarstripitem iuo_leftitems[]
//u_cst_toolbarstripitem iuo_rightitems[]

ToolbarItem ToolbarItemsLeft[]
ToolbarItem ToolbarItemsRight[]

window iw_parent
n_cst_toolbarstrip_gradient in_Gradient

CONSTANT Long SMALL = 16
CONSTANT Long MEDIUM = 24
CONSTANT Long LARGE = 32
CONSTANT Long XLARGE = 48

Long il_CurrentSize = SMALL
Long il_imagelistsmall
Long il_imagelistmedium
Long il_imagelistlarge
Long il_imagelistxlarge

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0

Long ImageCount
Long il_LeftEndPoint
boolean ib_LeftHidden

trackmouseevent istr_TRACKMOUSEEVENT

constant ulong WM_MOUSELEAVE = 675 
constant uLong TME_LEAVE = 2 

menu im_ekmenu
boolean ib_menuenkontrol = FALSE
end variables

forward prototypes
public function integer of_settheme (long al_color)
public function integer of_settheme (string as_color)
public function integer of_getwindow ()
public function integer of_reorganize ()
public function integer of_additem (string as_text, string as_image)
public function integer of_addseparator ()
public function integer of_displaytext (boolean ab_display)
public function long of_getcolor (string as_color)
public function integer of_displayborder (boolean ab_border)
public function integer of_addobject (string as_text, dragobject ado_object)
public function integer of_setenabled (string as_item, boolean ab_switch)
public function integer of_setstyle (long al_style)
public function integer of_setimage (string as_item, string as_image)
public function string of_getimage (string as_item)
public function integer of_displayraisedborder (boolean ab_show)
public function integer of_toggle (string as_item)
public function boolean of_istoggleon (string as_item)
public function integer of_additem (string as_text, string as_image, string as_tiptext)
public function integer of_displaytext (string as_item, boolean ab_display)
public function integer of_settext (string as_item, string as_text)
public function integer of_settiptext (string as_item, string as_text)
public function integer of_settext (long al_item, string as_text)
public function integer of_settiptext (long al_item, string as_text)
public function integer of_displaytext (long al_item, boolean ab_display)
public function integer of_toggle (long al_item)
public function integer of_setenabled (long al_item, boolean ab_switch)
public function integer of_displaysolidbackground (boolean ab_switch)
public function integer of_removeitem (string as_text)
public function integer of_additem (string as_text, string as_image, integer al_position)
public function integer of_additem (string as_text, string as_image, string as_tiptext, integer al_position)
public function integer of_addseparator (integer al_position)
public function integer of_displaytext (long al_item, boolean ab_display, long al_position)
public function integer of_setenabled (long al_item, boolean ab_switch, integer al_position)
public function integer of_settext (long al_item, string as_text, integer al_position)
public function integer of_settiptext (long al_item, string as_text, integer al_position)
public function integer of_toggle (long al_item, integer al_position)
public function integer of_reorganizeright ()
public function integer of_setvisible (long al_item, boolean ab_switch, integer al_position)
public function integer of_setvisible (long al_item, boolean ab_switch)
public function integer of_setvisible (string as_item, boolean ab_switch)
public function integer of_settextposition (integer al_position)
public function integer of_reset ()
public function integer of_setfontname (string as_font)
public function integer of_setfontcolor (long al_color)
public function integer of_setfontsize (integer ai_fontsize)
public function integer of_getfontsize ()
public function point of_gettextwidth (string as_text, boolean ab_bold)
public function integer of_addimage (string as_image)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_indexfrompoint (long xpos, long ypos)
private function integer of_getwidth ()
private function boolean of_isinobject (long xpos, long ypos)
public function boolean of_isvisible (string as_item)
public function boolean of_isenabled (string as_item)
public function integer of_setsize (integer al_size)
public function integer of_addobject (string as_text, dragobject ado_object, integer al_position)
public function integer of_updatepointsleft ()
public function integer of_updatepointsright ()
public function integer of_updatepoints ()
private function integer of_getheight ()
private function integer of_cargaekmenu (menu am_menu)
public function integer of_setekmenu (menu am_menu, boolean ab_activo)
private function integer of_ekmenuclicked (menu am_menu, string as_opcion)
public function integer of_actualizamenuek (menu am_menu)
public function integer of_toggle (string as_item, boolean ab_toogle)
end prototypes

event ue_buttonclicked(string as_button);// button item clicked on


IF ib_menuenkontrol THEN 
	
	of_EKMenuClicked(im_ekmenu, as_button)
	
END IF
end event

event ue_mousemove(string as_button, integer ai_xpos, integer ai_ypos);// mouse moved over button item

end event

event ue_mouseenter(string as_button);// mouse entered button item

end event

event ue_mouseleave(string as_button);// mouse leaving button item

end event

event resize;of_UpdatePoints()
end event

event mousemove;Long ll_index

if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	ib_mouseleave = FALSE
	this.event mouseenter(xpos, ypos)
		
end if
	
	if xpos < 0 or ypos < 0 or xpos > of_GetWidth() or ypos > height or of_IsInObject(xpos, ypos) then
			IF NOT ib_selected THEN
				of_releasemouse()
				
				this.event post mouseleave()
			ELSE
				ib_mouseleave = TRUE
				of_UpdatePoints()
				SetRedraw(TRUE)
			END IF
	
	ELSE
		ib_mouseleave = FALSE
		
		Long ll_MOIndex
		ll_MOIndex = of_IndexFromPoint(xpos, ypos)
		
		IF ib_MouseDown THEN
			IF ll_MOIndex <> il_MOIndex THEN
				il_MOIndex = ll_MOIndex
				of_UpdatePoints()
				SetRedraw(TRUE)
			END IF
		END IF

		
		IF NOT ib_MouseDown THEN
			ll_index = of_IndexFromPoint(xpos, ypos)
			
			
			IF il_index <> ll_index THEN				
				il_index = ll_index
			
				of_UpdatePoints()
				SetRedraw(TRUE)
				
			   IF il_index > 0 THEN
					EVENT ue_mouseenter(ToolbarItemsLeft[il_index].TipText)
				END IF
				
					IF il_index > 0 THEN
						IF Len(Trim(ToolbarItemsLeft[il_index].TipText)) > 0 AND &
					      NOT ToolbarItemsLeft[il_index].Hidden THEN
							Long li_X, li_Y, ll_return
				
							IF il_Id > 0 THEN
								li_X = 0//UnitsToPixels( Integer( X ),XUnitsToPixels! )
								li_Y = 0//UnitsToPixels( Integer( Y ), YUnitsToPixels! )
								inv_tooltip.of_UpdatetipRect( This, il_ID, &
																li_x, li_y, &
																li_x + UnitsToPixels( Integer( Width ), XUnitsToPixels! ), &
																li_y + UnitsToPixels( Integer( Height ), YUnitsToPixels! ) )
									
								
								inv_tooltip.Of_SetTipText( This, il_Id, ToolbarItemsLeft[il_index].TipText) 
							END IF
						END IF
					ELSE
						inv_tooltip.of_UpdatetipRect( This, il_ID, &
															0, 0, &
															0, &
															0 )
					END IF
			
			END IF
		END IF
	end if

//end if
end event

event mouseenter(long xpos, long ypos);Long li_X, li_Y, ll_return

TrackMouseEvent(istr_TRACKMOUSEEVENT) 

//TriggerEvent("paint")
//il_index = of_IndexFromPoint(xpos, ypos)
//il_MOIndex = il_index
//of_UpdatePoints()
//SetRedraw(TRUE)

// trigger event on parent
//If il_currenttype = BUTTON Then
//	Event ue_MouseEnter(ToolbarItemsLeft[il_index].Text)
//Else
//	Event ue_MouseEnter(ido_object.ClassName())
//End If

end event

event mouseleave();ib_mouseover = FALSE
ib_mousecaptured = FALSE

IF NOT ib_mousedown THEN
	il_index = 0
END IF

of_UpdatePoints()
SetRedraw(TRUE)

// trigger event on parent
//If il_currenttype = BUTTON Then
//	Event ue_MouseLeave(ToolbarItemsLeft[il_index].Text)
//Else
//	iuo_parent.Event ue_MouseLeave(ido_object.ClassName())
//End If

end event

event lbuttondown;ib_mousedown = TRUE
ib_selected = TRUE
il_index = of_IndexFromPoint(xpos, ypos)
il_MOIndex = il_index
of_UpdatePoints()
SetRedraw(TRUE)
end event

event lbuttonup;Boolean ib_click

IF ib_selected AND NOT ib_mouseleave AND il_index = il_MOIndex THEN
	ib_click = TRUE
END IF

Long ll_index
ll_index = il_index

ib_selected = FALSE
ib_mouseleave = FALSE
ib_mousedown = FALSE
of_ReleaseMouse()
il_index = of_IndexFromPoint(xpos, ypos)
il_MOIndex = il_index
of_UpdatePoints()
SetRedraw(TRUE)

IF ib_click AND ll_index > 0 THEN
	Event ue_ButtonClicked(ToolbarItemsLeft[ll_index].Text)
END IF
end event

public function integer of_settheme (long al_color);Long ll_index, ll_loop

il_currenttheme = al_color

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

public function integer of_getwindow ();PowerObject	lpo_parent
Window lw_window

IF IsValid(iw_parent) THEN RETURN 0

// loop thru parents until a window is found
lpo_parent = GetParent()
//Do While lpo_parent.TypeOf() <> Window! and IsValid(lpo_parent)
//	lpo_parent = lpo_parent.GetParent()
//Loop

do while IsValid (lpo_parent)
	If lpo_parent.TypeOf() = window! Then Exit
	lpo_parent = lpo_parent.GetParent()
loop

// set return to the window or null if not found
If IsValid (lpo_parent) Then
	lw_window = lpo_parent
Else
	SetNull(lw_window)
	RETURN -1
End If

iw_parent = lw_window

RETURN 1
end function

public function integer of_reorganize ();//Long ll_index, ll_count, ll_loop, ll_item, ll_width, ll_height
//
//SetRedraw(FALSE)
//
//uo_toolbarchevron.Visible = FALSE
//uo_toolbarchevron.of_ClearItems()
//
////BCW - 2.0.0
//IF il_CurrentOrientation = HORIZONTAL THEN
//	ll_count = UpperBound(iuo_leftitems)
//	ll_width = 8
//	
//	FOR ll_index = 1 TO ll_count
//		IF iuo_leftitems[ll_index].ib_visible THEN
//		
//			iuo_leftitems[ll_index].X = ll_width
//			
//			ll_width = ll_width + iuo_leftitems[ll_index].Width + 4
//			
//			IF iuo_leftitems[ll_index].X + iuo_leftitems[ll_index].Width > &
//				(THIS.Width - uo_toolbarchevron.Width) THEN
//				
//				uo_toolbarchevron.of_RegisterItem(iuo_leftitems[ll_index])
//				iuo_leftitems[ll_index].Visible = FALSE
//				uo_toolbarchevron.Visible = TRUE
//			ELSE
//				iuo_leftitems[ll_index].Visible = TRUE
//			END IF
//		END IF
//	NEXT
//ELSE
//	ll_count = UpperBound(iuo_leftitems)
//	ll_height = 8
//	
//	FOR ll_index = 1 TO ll_count
//		IF iuo_leftitems[ll_index].ib_visible THEN
//			iuo_leftitems[ll_index].Y = ll_height
//			
//			ll_height = ll_height + iuo_leftitems[ll_index].Height + 4
//			
//			IF iuo_leftitems[ll_index].Y + iuo_leftitems[ll_index].Height > &
//				(THIS.Height - uo_toolbarchevron.Height) THEN
//				
//				uo_toolbarchevron.of_RegisterItem(iuo_leftitems[ll_index])
//				iuo_leftitems[ll_index].Visible = FALSE
//				uo_toolbarchevron.Visible = TRUE
//			ELSE
//				iuo_leftitems[ll_index].Visible = TRUE
//			END IF
//		END IF
//	NEXT
//END IF
//
//of_ReorganizeRight()
//
////SetRedraw(TRUE)

RETURN 1
end function

public function integer of_additem (string as_text, string as_image);RETURN of_AddItem(as_text, as_image, as_text, LEFT)
end function

public function integer of_addseparator ();RETURN of_AddSeparator(LEFT)
end function

public function integer of_displaytext (boolean ab_display);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	ToolbarItemsLeft[ll_index].DisplayText = ab_display
NEXT

of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
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
		END CHOOSE	
	CASE "BACKGROUND1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(221,236,254)
			CASE SILVER
				ll_color = RGB(243,244,250)
			CASE OLIVE
				ll_color = RGB(244,247,222)
			CASE CLASSIC
				ll_color = RGB(245,244,242)
		END CHOOSE
	CASE "BACKGROUND2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(129,169,226)
			CASE SILVER
				ll_color = RGB(153,151,181)
			CASE OLIVE
				ll_color = RGB(183,198,145)
			CASE CLASSIC
				ll_color = RGB(213,210,202)
		END CHOOSE
	CASE "BACKGROUND3"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(182,207,242)
			CASE SILVER
				ll_color = RGB(201,201,218)
			CASE OLIVE
				ll_color = RGB(213,222,183)
			CASE CLASSIC
				ll_color = RGB(230,228,223)
		END CHOOSE
	CASE "HIGHLIGHT1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,245,204)
			CASE SILVER
				ll_color = RGB(255,244,204)
			CASE OLIVE
				ll_color = RGB(255,244,204)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
		END CHOOSE
	CASE "HIGHLIGHT2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,208,145)
			CASE SILVER
				ll_color = RGB(255,208,145)
			CASE OLIVE
				ll_color = RGB(255,208,145)
			CASE CLASSIC
				ll_color = RGB(182,189,210)
		END CHOOSE
	CASE "HIGHLIGHTBORDER"
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
	CASE "SELECTED1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(254,145,78)
			CASE SILVER
				ll_color = RGB(254,145,78)
			CASE OLIVE
				ll_color = RGB(254,145,78)
			CASE CLASSIC
				ll_color = RGB(133,146,181)
		END CHOOSE
	CASE "SELECTED2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(255,211,142)
			CASE SILVER
				ll_color = RGB(255,211,142)
			CASE OLIVE
				ll_color = RGB(255,211,142)
			CASE CLASSIC
				ll_color = RGB(133,146,181)
		END CHOOSE
	CASE "SEPARATOR"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(106,140,203)
			CASE SILVER
				ll_color = RGB(110,109,143)
			CASE OLIVE
				ll_color = RGB(96,128,88)
			CASE CLASSIC
				ll_color = RGB(166,166,166)
		END CHOOSE
	CASE "CAP"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(59,97,156)
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = RGB(99,122,68)
			CASE CLASSIC
				ll_color = RGB(128,128,128)
		END CHOOSE
END CHOOSE

RETURN ll_color
end function

public function integer of_displayborder (boolean ab_border);ib_displayborder = ab_border

of_UpdatePoints()

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_addobject (string as_text, dragobject ado_object);RETURN of_AddObject(as_text, ado_object, LEFT)
end function

public function integer of_setenabled (string as_item, boolean ab_switch);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN of_SetEnabled(ll_index, ab_switch, LEFT)
	END IF
	
NEXT

RETURN 1
end function

public function integer of_setstyle (long al_style);il_CurrentStyle = al_style
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setimage (string as_item, string as_image);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		ToolbarItemsLeft[ll_index].Image = as_image
		ToolbarItemsLeft[ll_index].ImageIndex = of_AddImage(as_image)
		
		of_UpdatePoints()
		SetRedraw(TRUE)
		RETURN 1
	END IF
	
NEXT




RETURN 1
end function

public function string of_getimage (string as_item);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN ToolbarItemsLeft[ll_index].Image
	END IF
	
NEXT

RETURN ''
end function

public function integer of_displayraisedborder (boolean ab_show);ib_raisedborder = ab_show
of_DisplayBorder(FALSE)
RETURN 1
end function

public function integer of_toggle (string as_item);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN of_Toggle(ll_index, LEFT)
	END IF
	
NEXT

RETURN 1
end function

public function boolean of_istoggleon (string as_item);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN ToolbarItemsLeft[ll_index].Toggle
	END IF
	
NEXT

RETURN FALSE
end function

public function integer of_additem (string as_text, string as_image, string as_tiptext);RETURN of_AddItem(as_text, as_image, as_tiptext, LEFT)
end function

public function integer of_displaytext (string as_item, boolean ab_display);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	IF Lower(ToolbarItemsLeft[ll_index].Text) = Lower(as_item) THEN
		of_DisplayText(ll_index, ab_display, LEFT)
		RETURN 1
	END IF
NEXT


RETURN 0
end function

public function integer of_settext (string as_item, string as_text);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	IF Lower(ToolbarItemsLeft[ll_index].Text) = Lower(as_item) THEN
		ToolbarItemsLeft[ll_index].Text = as_text
		RETURN 1
	END IF
NEXT


RETURN 1
end function

public function integer of_settiptext (string as_item, string as_text);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	IF Lower(ToolbarItemsLeft[ll_index].Text) = Lower(as_item) THEN
		ToolbarItemsLeft[ll_index].TipText = as_text
		RETURN 1
	END IF
NEXT

RETURN 1
end function

public function integer of_settext (long al_item, string as_text);RETURN of_SetText(al_item, as_text, LEFT)
end function

public function integer of_settiptext (long al_item, string as_text);RETURN of_SetTipText(al_item, as_text, LEFT)
end function

public function integer of_displaytext (long al_item, boolean ab_display);RETURN of_DisplayText(al_item, ab_display, LEFT)
end function

public function integer of_toggle (long al_item);RETURN of_Toggle(al_item, LEFT)
end function

public function integer of_setenabled (long al_item, boolean ab_switch);RETURN of_SetEnabled(al_item, ab_switch, LEFT)
end function

public function integer of_displaysolidbackground (boolean ab_switch);ib_solidbackground = ab_switch
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_removeitem (string as_text);Long ll_index, ll_count, ll_loop, ll_item, ll_width
ToolBarItem luo_item
ToolBarItem luo_newitems[]

SetRedraw(FALSE)

ll_item = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_item
	IF ToolbarItemsLeft[ll_index].Text <> as_text THEN
		ll_count++
		luo_newitems[ll_count] = ToolbarItemsLeft[ll_index]
	END IF
NEXT

ToolbarItemsLeft = luo_newitems

of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_additem (string as_text, string as_image, integer al_position);RETURN of_AddItem(as_text, as_image, as_text, al_position)
end function

public function integer of_additem (string as_text, string as_image, string as_tiptext, integer al_position);Long ll_index, ll_count, ll_loop, ll_item, ll_width

ToolbarItem tbiButton

SetRedraw(FALSE)

tbiButton.Text = as_text
tbiButton.TipText = as_tiptext
tbiButton.Image = as_image
tbiButton.Enabled = TRUE
tbiButton.Visible = TRUE
tbiButton.DisplayText = ib_displaytext
tbiButton.separator = FALSE
tbiButton.ImageIndex = of_AddImage(as_image)
tbiButton.Position = al_position

ll_item = UpperBound(ToolbarItemsLeft) + 1

ToolbarItemsLeft[ll_item] = tbiButton

of_UpdatePoints()

SetRedraw(TRUE)

RETURN ll_item
end function

public function integer of_addseparator (integer al_position);Long ll_index, ll_count, ll_loop, ll_item, ll_width
ToolbarItem tbiButton

SetRedraw(FALSE)

tbiButton.Separator = TRUE
tbiButton.Visible = TRUE
tbiButton.Position = al_position

ll_item = UpperBound(ToolbarItemsLeft) + 1

ToolbarItemsLeft[ll_item] = tbiButton

of_UpdatePoints()

SetRedraw(TRUE)

RETURN ll_item
end function

public function integer of_displaytext (long al_item, boolean ab_display, long al_position);
ToolbarItemsLeft[al_item].DisplayText = ab_display
of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setenabled (long al_item, boolean ab_switch, integer al_position);ToolbarItemsLeft[al_item].Enabled = ab_switch

of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settext (long al_item, string as_text, integer al_position);ToolbarItemsLeft[al_item].Text = as_text

of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settiptext (long al_item, string as_text, integer al_position);ToolbarItemsLeft[al_item].TipText = as_text

RETURN 1
end function

public function integer of_toggle (long al_item, integer al_position);ToolbarItemsLeft[al_item].Toggle = NOT ToolbarItemsLeft[al_item].Toggle

of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_reorganizeright ();//Long ll_count, ll_index, ll_width, ll_height
//
////BCW - 2.0.0
//IF il_CurrentOrientation = HORIZONTAL THEN
//	ll_count = UpperBound(iuo_rightitems)
//	ll_width = 8
//	
//	FOR ll_index = 1 TO ll_count
//		IF iuo_rightitems[ll_index].Visible THEN
//			iuo_rightitems[ll_index].X = THIS.Width - iuo_rightitems[ll_index].Width - ll_width
//			
//			ll_width = ll_width + iuo_rightitems[ll_index].Width + 4
//		END IF
//	NEXT
//ELSE
//	ll_count = UpperBound(iuo_rightitems)
//	ll_height = 8
//	
//	FOR ll_index = 1 TO ll_count
//		IF iuo_rightitems[ll_index].Visible THEN
//			iuo_rightitems[ll_index].Y = THIS.Height - iuo_rightitems[ll_index].Height - ll_height
//			
//			ll_height = ll_height + iuo_rightitems[ll_index].Height + 4
//		END IF
//	NEXT
//END IF
//
//SetRedraw(TRUE)
//
RETURN 1
end function

public function integer of_setvisible (long al_item, boolean ab_switch, integer al_position);IF al_item < 1 OR al_item > UpperBound(ToolbarItemsLeft) THEN RETURN 0
ToolbarItemsLeft[al_item].Visible = ab_switch

of_UpdatePoints()
SetRedraw(TRUE)
	
RETURN 1
end function

public function integer of_setvisible (long al_item, boolean ab_switch);RETURN of_SetVisible(al_item, ab_switch, LEFT)
end function

public function integer of_setvisible (string as_item, boolean ab_switch);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN of_SetVisible(ll_index, ab_switch, LEFT)
	END IF
	
NEXT

RETURN 1
end function

public function integer of_settextposition (integer al_position);

RETURN 1
end function

public function integer of_reset ();ToolBarItem luo_leftitems[]

lv_imagelistxlarge.DeleteLargePictures()
lv_imagelistlarge.DeleteLargePictures()
lv_imagelistmedium.DeleteLargePictures()
lv_imagelistsmall.DeleteLargePictures()

ImageCount = 0

ToolbarItemsLeft = luo_leftitems
of_UpdatePoints()
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setfontname (string as_font);FontName = as_font
of_GetFontSize()
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_setfontcolor (long al_color);FontColor = al_color
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_setfontsize (integer ai_fontsize);FontSize = ai_fontsize
of_GetFontSize()
of_UpdatePoints()
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_getfontsize ();ULong lul_Handle, lul_hDC, lul_hFont
String ls_text
long ll_x
n_cst_xplistbar_gradient lnv_gradient

ll_x = 0

lul_Handle = Handle(st_1)
lul_hDC = GetDC(lul_Handle)

lnv_gradient.of_SetHdc(lul_hDC)
ls_text = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
lnv_gradient.of_DrawText(THIS, ls_text, 0, FontName, FontSize, Bold, lnv_gradient.ALIGN_LEFT, 0, 0, 0, 50,FALSE, FALSE, false, false) 

ReleaseDC(lul_Handle, lul_hDC)

Point p

p.PX = lnv_gradient.il_newWidth
p.PY = lnv_gradient.il_newHeight

il_TextHeight = p.PY

RETURN 1
end function

public function point of_gettextwidth (string as_text, boolean ab_bold);ULong lul_Handle, lul_hDC, lul_hFont
POINT lstr_size
long ll_x
n_cst_toolbarstrip_gradient lnv_gradient
Point p

ll_x = 0

lul_Handle = Handle(st_1)
lul_hDC = GetDC(lul_Handle)

lnv_gradient.of_SetHdc(lul_hDC)

IF il_CurrentOrientation = HORIZONTAL THEN
	lnv_gradient.of_DrawText(THIS, as_text, 0, FontName, FontSize, ab_bold, lnv_gradient.ALIGN_LEFT, 0, 0, 0, 50,FALSE, FALSE, false, false) 
	p.PX = UnitsToPixels(lnv_gradient.il_newWidth, XUnitsToPixels!) + 4
	p.PY = UnitsToPixels(lnv_gradient.il_newHeight, YUnitsToPixels!) + 4
ELSE
	lnv_gradient.of_DrawVerticalText(THIS, as_text, 0, FontName, FontSize, ab_bold, lnv_gradient.ALIGN_LEFT, 0, 0, 0, 0,FALSE, FALSE, false, false) 	
	p.PX = lnv_gradient.il_newWidth
	p.PY = lnv_gradient.il_newHeight + 2
END IF	

ReleaseDC(lul_Handle, lul_hDC)



RETURN p
 
end function

public function integer of_addimage (string as_image);ImageCount = ImageCount + 1

lv_imagelistmedium.LargePictureHeight = MEDIUM
lv_imagelistmedium.LargePictureWidth = MEDIUM

lv_imagelistxlarge.LargePictureHeight = XLARGE
lv_imagelistxlarge.LargePictureWidth = XLARGE

lv_imagelistsmall.AddLargePicture ( as_image )
lv_imagelistmedium.AddLargePicture ( as_image )
lv_imagelistlarge.AddLargePicture ( as_image )
lv_imagelistxlarge.AddLargePicture ( as_image )

il_imagelistsmall = Send(Handle(lv_imagelistsmall), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistmedium = Send(Handle(lv_imagelistmedium), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistlarge = Send(Handle(lv_imagelistlarge), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistxlarge = Send(Handle(lv_imagelistxlarge), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)


RETURN ImageCount
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

public function integer of_indexfrompoint (long xpos, long ypos);//find out if a tab was clicked
long ll_count, ll_index
ulong lul_rgn
integer lix, liy

lix = UnitsToPixels(xpos, XUnitsToPixels!)
liy = UnitsToPixels(ypos, YUnitsToPixels!)

ll_count = UPPERBOUND(ToolbarItemsLeft)
FOR ll_index = 1 to ll_count
	//skip if disabled
	IF NOT ToolbarItemsLeft[ll_index].Enabled THEN CONTINUE
	IF NOT ToolbarItemsLeft[ll_index].Visible THEN CONTINUE
	IF ToolbarItemsLeft[ll_index].Hidden THEN CONTINUE
	
	lul_rgn = in_Gradient.CreatePolygonRgn(ToolbarItemsLeft[ll_index].PaintRegion, UPPERBOUND(ToolbarItemsLeft[ll_index].PaintRegion), 1)
	IF in_Gradient.PtInRegion(lul_rgn, lix, liy) <> 0 THEN
		in_Gradient.DeleteObject(lul_rgn)
		RETURN ll_index
	ELSE
		in_Gradient.DeleteObject(lul_rgn)
	END IF
NEXT

RETURN -1
end function

private function integer of_getwidth ();//IF uo_toolbarchevron.Visible THEN
IF il_CurrentOrientation = HORIZONTAL THEN
	RETURN Width - uo_toolbarchevron.Width
ELSE
	RETURN Width
END IF
end function

private function boolean of_isinobject (long xpos, long ypos);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	IF ToolbarItemsLeft[ll_index].ObjectType THEN
		IF ToolbarItemsLeft[ll_index].ObjectReference.Visible AND &
			xpos > ToolbarItemsLeft[ll_index].ObjectReference.X AND &
			xpos < ToolbarItemsLeft[ll_index].ObjectReference.X + &
					 ToolbarItemsLeft[ll_index].ObjectReference.Width AND &
			ypos > ToolbarItemsLeft[ll_index].ObjectReference.Y AND &
			ypos < ToolbarItemsLeft[ll_index].ObjectReference.Y + &
			       ToolbarItemsLeft[ll_index].ObjectReference.Height &
		THEN
			RETURN TRUE
		END IF
	END IF
NEXT

RETURN FALSE
end function

public function boolean of_isvisible (string as_item);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN ToolbarItemsLeft[ll_index].Visible
	END IF
	
NEXT

RETURN FALSE
end function

public function boolean of_isenabled (string as_item);Long ll_index, ll_count

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		RETURN ToolbarItemsLeft[ll_index].Enabled
	END IF
	
NEXT

RETURN FALSE
end function

public function integer of_setsize (integer al_size);il_CurrentSize = al_size

IF il_CurrentOrientation = HORIZONTAL THEN
	
	CHOOSE CASE il_CurrentSize
		CASE SMALL
			THIS.Height = 104
		CASE MEDIUM
			THIS.Height = 135
		CASE LARGE
			THIS.Height = 175
		CASE XLARGE
			THIS.Height = 235
	END CHOOSE
ELSE
	CHOOSE CASE il_CurrentSize
		CASE SMALL
			THIS.Width = 121
		CASE MEDIUM
			THIS.Width = 155
		CASE LARGE
			THIS.Width = 193
		CASE XLARGE
			THIS.Width = 263
	END CHOOSE
END IF

RETURN 1
end function

public function integer of_addobject (string as_text, dragobject ado_object, integer al_position);Long ll_index, ll_count, ll_loop, ll_item, ll_width
ToolbarItem tbiButton

IF il_CurrentOrientation = VERTICAL THEN
	RETURN -1
END IF

SetRedraw(FALSE)

of_GetWindow()

SetParent(Handle(ado_object), Handle(THIS))
tbiButton.ObjectReference = ado_object
tbiButton.ObjectType = TRUE
tbiButton.Visible = TRUE
tbiButton.Text = as_text
tbiButton.Position = al_position

ll_item = UpperBound(ToolbarItemsLeft) + 1

ToolbarItemsLeft[ll_item] = tbiButton

of_UpdatePoints()

SetRedraw(TRUE)

RETURN ll_item
end function

public function integer of_updatepointsleft ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth, ll_item
Long ll_width, ll_height, ll_dc, ll_controlWidth
boolean lb_SomeHidden = FALSE
point lp_empty[]
n_cst_toolbarstrip_gradient ln_gradient
Point p

ll_count = UpperBound(ToolbarItemsLeft)

ll_y = 3
ll_x = 2
ll_height = UnitsToPixels(Height, YUnitsToPixels!)
ll_controlWidth = UnitsToPixels(Width, XUnitsToPixels!)

ll_dc = GetDC(Handle(st_1))
ln_gradient.of_SetHDC(ll_dc)

uo_toolbarchevron.of_ClearItems()

FOR ll_index = 1 TO ll_count
	IF NOT ToolbarItemsLeft[ll_index].Visible OR ToolbarItemsLeft[ll_index].Position = RIGHT THEN
		CONTINUE
	END IF
	
	ll_item++
	ToolbarItemsLeft[ll_index].PaintRegion = lp_empty
	
	ToolbarItemsLeft[ll_index].BackColor1 = -1
	ToolbarItemsLeft[ll_index].BackColor2 = -1
	
	IF ll_index = il_index THEN
		IF ib_mousedown AND NOT ib_mouseleave AND il_MOIndex = ll_index THEN
			ToolbarItemsLeft[ll_index].BackColor1 = of_GetColor('SELECTED1')
			ToolbarItemsLeft[ll_index].BackColor2 = of_GetColor('SELECTED2')
			ToolbarItemsLeft[ll_index].BorderColor = of_GetColor("HIGHLIGHTBORDER")
		ELSE
			ToolbarItemsLeft[ll_index].BackColor1 = of_GetColor("HIGHLIGHT1")
			ToolbarItemsLeft[ll_index].BackColor2 = of_GetColor("HIGHLIGHT2")
			ToolbarItemsLeft[ll_index].BorderColor = of_GetColor("HIGHLIGHTBORDER")
		END IF
	END IF
	
	IF ToolbarItemsLeft[ll_index].Toggle THEN
		ToolbarItemsLeft[ll_index].BackColor1 = of_GetColor("HIGHLIGHT1")
		ToolbarItemsLeft[ll_index].BackColor2 = of_GetColor("HIGHLIGHT2")
		ToolbarItemsLeft[ll_index].BorderColor = of_GetColor("HIGHLIGHTBORDER")				
	ELSE
		
	END IF

	
	IF il_CurrentOrientation = VERTICAL THEN
		
		IF ToolbarItemsLeft[ll_index].Separator THEN
			ToolbarItemsLeft[ll_index].SeparatorColor = of_GetColor('SEPARATOR')
			
			ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x + 3
			ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y
			ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_controlWidth - ll_x - 3 - 1
			ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_y
			
			IF ToolbarItemsLeft[ll_index].PaintRegion[2].py > UnitsToPixels(of_GetHeight(), XUnitsToPixels!) THEN
				ToolbarItemsLeft[ll_index].Hidden = TRUE
				uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
				lb_SomeHidden = TRUE
			ELSE
				ToolbarItemsLeft[ll_index].Hidden = FALSE
			END IF
			
			ll_y = ll_y + 4
		ELSE 
			IF ToolbarItemsLeft[ll_index].ObjectType THEN
				ToolbarItemsLeft[ll_index].ObjectReference.Visible = FALSE
			ELSE
				IF ToolbarItemsLeft[ll_index].DisplayText THEN
					
					p = of_GetTextWidth(ToolbarItemsLeft[ll_index].Text, FALSE)
					ll_textwidth = p.PY
					ToolbarItemsLeft[ll_index].TextWidth = p.PX
				ELSE
					ll_textwidth = 0
				END IF
				
				IF Len(ToolbarItemsLeft[ll_index].Image) > 0 THEN
					ToolbarItemsLeft[ll_index].ImageSize = il_CurrentSize
					ll_width = 2 + il_CurrentSize + 2 + ll_textwidth + 2
				ELSE
					ToolbarItemsLeft[ll_index].ImageSize = 0
					ll_width = 2 + ll_textwidth + 2
				END IF
			
				IF ToolbarItemsLeft[ll_index].DisplayText THEN
					ll_width += 5
				END IF
			
				ToolbarItemsLeft[ll_index].TextHeight = ll_textwidth
			
				ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_controlWidth - ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[3].py = ll_width + ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[3].px = ll_controlWidth - ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[4].py = ll_width + ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[4].px = ll_x
			
				
				IF ToolbarItemsLeft[ll_index].PaintRegion[3].py + 12 > UnitsToPixels(of_GetHeight(), YUnitsToPixels!) THEN
					ToolbarItemsLeft[ll_index].Hidden = TRUE
					uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
					lb_SomeHidden = TRUE
				ELSE
					ToolbarItemsLeft[ll_index].Hidden = FALSE
				END IF
				
				ll_y = ll_y + ll_width + 2
			END IF
		END IF
	ELSE
		
		IF ToolbarItemsLeft[ll_index].Separator THEN
			ToolbarItemsLeft[ll_index].SeparatorColor = of_GetColor('SEPARATOR')
			
			ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x
			ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y + 3
			ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_x
			ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_height - ll_y - 1 - 3
			
			IF ToolbarItemsLeft[ll_index].PaintRegion[2].px > UnitsToPixels(of_GetWidth(), XUnitsToPixels!) THEN
				ToolbarItemsLeft[ll_index].Hidden = TRUE
				uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
				lb_SomeHidden = TRUE
			ELSE
				ToolbarItemsLeft[ll_index].Hidden = FALSE
			END IF
			
			ll_x = ll_x + 5
		ELSE 
			IF ToolbarItemsLeft[ll_index].ObjectType THEN
				
				IF Len(Trim(ToolbarItemsLeft[ll_index].Text)) > 0 THEN
					p = of_GetTextWidth(ToolbarItemsLeft[ll_index].Text, FALSE)
					ToolbarItemsLeft[ll_index].TextWidth = p.PX
					ToolbarItemsLeft[ll_index].TextHeight = p.PY
					ToolbarItemsLeft[ll_index].PaintRegion[3].py = UnitsToPixels(Height, YUnitsToPixels!)
					ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x
					ll_textwidth = p.PX + 2
				ELSE
					ll_textwidth = 0
				END IF
				
				ToolbarItemsLeft[ll_index].ObjectReference.Move(PixelsToUnits(ll_textwidth + ll_x + 4, XPixelsToUnits!), &
																				PixelsToUnits(ll_y - 1, XPixelsToUnits!))
				
				
				ll_x = ll_x + ll_textwidth + 4 + UnitsToPixels(ToolbarItemsLeft[ll_index].ObjectReference.Width, XUnitsToPixels!) + 4
			ELSE
				IF ToolbarItemsLeft[ll_index].DisplayText THEN
					
					p = of_GetTextWidth(ToolbarItemsLeft[ll_index].Text, FALSE)
					ll_textwidth = p.PX
					ToolbarItemsLeft[ll_index].TextHeight = p.PY
					
				ELSE
					ll_textwidth = 0
				END IF
				
				IF Len(ToolbarItemsLeft[ll_index].Image) > 0 THEN
					ToolbarItemsLeft[ll_index].ImageSize = il_CurrentSize
					ll_width = 2 + il_CurrentSize + 2 + ll_textwidth + 2
				ELSE
					ToolbarItemsLeft[ll_index].ImageSize = 0
					ll_width = 2 + ll_textwidth + 2
				END IF
			
				ToolbarItemsLeft[ll_index].TextWidth = ll_textwidth
			
				ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_width + ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[3].px = ll_width + ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[3].py = ll_height - ll_y + 1
				ToolbarItemsLeft[ll_index].PaintRegion[4].px = ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[4].py = ll_height - ll_y + 1
				
				IF ToolbarItemsLeft[ll_index].PaintRegion[3].px > UnitsToPixels(of_GetWidth(), XUnitsToPixels!) THEN
					ToolbarItemsLeft[ll_index].Hidden = TRUE
					uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
					lb_SomeHidden = TRUE
				ELSE
					ToolbarItemsLeft[ll_index].Hidden = FALSE
				END IF
				
				IF NOT lb_SomeHidden THEN
					il_LeftEndPoint = ll_x + ll_width + 2
				END IF
				
				ll_x = ll_x + ll_width + 2
			END IF
		END IF
	END IF

NEXT

ReleaseDC (Handle(st_1), ll_dc)

uo_toolbarchevron.Visible = lb_SomeHidden
ib_LeftHidden = lb_somehidden

IF lb_SomeHidden THEN
	CHOOSE CASE il_CurrentOrientation
		CASE HORIZONTAL
			IF ib_displayborder THEN
				uo_toolbarchevron.Height = THIS.Height - 10
				uo_toolbarchevron.Y = 2
				uo_toolbarchevron.X = THIS.Width - uo_toolbarchevron.Width - 4
			ELSE
				uo_toolbarchevron.Height = THIS.Height - 8
				uo_toolbarchevron.Y = 2
				uo_toolbarchevron.X = THIS.Width - uo_toolbarchevron.Width - 2
			END IF
		CASE VERTICAL
			IF ib_displayborder THEN
				uo_toolbarchevron.Height = 50
				uo_toolbarchevron.Width = THIS.Width - 8
				uo_toolbarchevron.X = 4
				uo_toolbarchevron.Y = THIS.Height - uo_toolbarchevron.Height - 8
			ELSE
				uo_toolbarchevron.Height = 50
				uo_toolbarchevron.Width = THIS.Width - 6
				uo_toolbarchevron.X = 4
				uo_toolbarchevron.Y = THIS.Height - uo_toolbarchevron.Height
			END IF
	END CHOOSE
END IF

RETURN 1
end function

public function integer of_updatepointsright ();Long ll_index, ll_count, ll_x, ll_y, ll_textwidth, ll_item
Long ll_width, ll_height, ll_dc, ll_controlWidth
boolean lb_SomeHidden = FALSE
point lp_empty[]
n_cst_toolbarstrip_gradient ln_gradient
Point p

ll_count = UpperBound(ToolbarItemsLeft)

IF il_CurrentOrientation = VERTICAL THEN
	ll_y = UnitsToPixels(Height, YUnitsToPixels!) - 3
ELSE
	ll_y = 3
END IF
	
ll_x = UnitsToPixels(Width, XUnitsToPixels!) - 2
ll_height = UnitsToPixels(Height, YUnitsToPixels!)
ll_controlWidth = UnitsToPixels(Width, XUnitsToPixels!)

ll_dc = GetDC(Handle(st_1))
ln_gradient.of_SetHDC(ll_dc)


FOR ll_index = 1 TO ll_count
	
	IF NOT ToolbarItemsLeft[ll_index].Visible OR ToolbarItemsLeft[ll_index].Position = LEFT THEN
		CONTINUE
	END IF
	
	IF uo_toolbarchevron.Visible THEN
		ToolbarItemsLeft[ll_index].Hidden = TRUE
		uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
		CONTINUE
	END IF
	
	ll_item++
	ToolbarItemsLeft[ll_index].PaintRegion = lp_empty
	
	ToolbarItemsLeft[ll_index].Hidden = FALSE
	
	ToolbarItemsLeft[ll_index].BackColor1 = -1
	ToolbarItemsLeft[ll_index].BackColor2 = -1
	
	IF ll_index = il_index THEN
		IF ib_mousedown AND NOT ib_mouseleave AND il_MOIndex = ll_index THEN
			ToolbarItemsLeft[ll_index].BackColor1 = of_GetColor('SELECTED1')
			ToolbarItemsLeft[ll_index].BackColor2 = of_GetColor('SELECTED2')
			ToolbarItemsLeft[ll_index].BorderColor = of_GetColor("HIGHLIGHTBORDER")
		ELSE
			ToolbarItemsLeft[ll_index].BackColor1 = of_GetColor("HIGHLIGHT1")
			ToolbarItemsLeft[ll_index].BackColor2 = of_GetColor("HIGHLIGHT2")
			ToolbarItemsLeft[ll_index].BorderColor = of_GetColor("HIGHLIGHTBORDER")
		END IF
	END IF
	
	IF ToolbarItemsLeft[ll_index].Toggle THEN
		ToolbarItemsLeft[ll_index].BackColor1 = of_GetColor("HIGHLIGHT1")
		ToolbarItemsLeft[ll_index].BackColor2 = of_GetColor("HIGHLIGHT2")
		ToolbarItemsLeft[ll_index].BorderColor = of_GetColor("HIGHLIGHTBORDER")				
	ELSE
		
	END IF

	
	IF il_CurrentOrientation = VERTICAL THEN
		
		IF ToolbarItemsLeft[ll_index].Separator THEN
			ToolbarItemsLeft[ll_index].SeparatorColor = of_GetColor('SEPARATOR')
			
			ToolbarItemsLeft[ll_index].PaintRegion[1].px = 5
			ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y - 2
			ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_controlWidth - 5 - 1
			ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_y - 2
			
			ll_y = ll_y - 4
		ELSE 
			IF ToolbarItemsLeft[ll_index].ObjectType THEN
				ToolbarItemsLeft[ll_index].ObjectReference.Visible = FALSE
			ELSE
				IF ToolbarItemsLeft[ll_index].DisplayText THEN
					
					p = of_GetTextWidth(ToolbarItemsLeft[ll_index].Text, FALSE)
					ll_textwidth = p.PY
					ToolbarItemsLeft[ll_index].TextWidth = p.PX
				ELSE
					ll_textwidth = 0
				END IF
				
				IF Len(ToolbarItemsLeft[ll_index].Image) > 0 THEN
					ToolbarItemsLeft[ll_index].ImageSize = il_CurrentSize
					ll_width = 2 + il_CurrentSize + 2 + ll_textwidth + 2
				ELSE
					ToolbarItemsLeft[ll_index].ImageSize = 0
					ll_width = 2 + ll_textwidth + 2
				END IF
			
				IF ToolbarItemsLeft[ll_index].DisplayText THEN
					ll_width += 5
				END IF
			
				ToolbarItemsLeft[ll_index].TextWidth = ll_textwidth
			
				ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y - ll_width
				ToolbarItemsLeft[ll_index].PaintRegion[1].px = 2
				ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_y - ll_width
				ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_controlWidth - 2
				ToolbarItemsLeft[ll_index].PaintRegion[3].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[3].px = ll_controlWidth - 2
				ToolbarItemsLeft[ll_index].PaintRegion[4].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[4].px = 2
			
				/*
				IF ToolbarItemsLeft[ll_index].PaintRegion[3].px > UnitsToPixels(Height, XUnitsToPixels!) THEN
					ToolbarItemsLeft[ll_index].Hidden = TRUE
					uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
					lb_SomeHidden = TRUE
				ELSE
					ToolbarItemsLeft[ll_index].Hidden = FALSE
				END IF
				*/
				ll_y = ll_y - ll_width - 2
			END IF
		END IF
	ELSE
		
		IF ToolbarItemsLeft[ll_index].Separator THEN
			ToolbarItemsLeft[ll_index].SeparatorColor = of_GetColor('SEPARATOR')
			
			ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x - 2
			ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y + 3
			ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_x - 2
			ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_height - ll_y - 1 - 3
			
			IF ToolbarItemsLeft[ll_index].PaintRegion[1].px < il_LeftEndPoint THEN
				ToolbarItemsLeft[ll_index].Hidden = TRUE
				uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
				lb_SomeHidden = TRUE
			ELSE
				ToolbarItemsLeft[ll_index].Hidden = FALSE
			END IF
			
			ll_x = ll_x - 4
		ELSE 
			IF ToolbarItemsLeft[ll_index].ObjectType THEN
				
				Long objectWidth
				
				objectWidth = UnitsToPixels(ToolbarItemsLeft[ll_index].ObjectReference.Width, XUnitsToPixels!)
				
				
				IF Len(Trim(ToolbarItemsLeft[ll_index].Text)) > 0 THEN
					p = of_GetTextWidth(ToolbarItemsLeft[ll_index].Text, FALSE)
					ll_textwidth = p.PX + 2
					ToolbarItemsLeft[ll_index].TextWidth = p.PX
					ToolbarItemsLeft[ll_index].TextHeight = p.PY
					ToolbarItemsLeft[ll_index].PaintRegion[3].py = UnitsToPixels(Height, YUnitsToPixels!)
					ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x - objectWidth - ll_textwidth - 4
					
				ELSE
					ll_textwidth = 0
				END IF
				
				
				ToolbarItemsLeft[ll_index].ObjectReference.Move(PixelsToUnits(ll_x - objectWidth - 4, XPixelsToUnits!), &
																				PixelsToUnits(ll_y - 1, XPixelsToUnits!))
				
				
				ll_x = ll_x - ll_textwidth - 4 - objectWidth - 4
			ELSE
				IF ToolbarItemsLeft[ll_index].DisplayText THEN
					
					p = of_GetTextWidth(ToolbarItemsLeft[ll_index].Text, FALSE)
					ll_textwidth = p.PX
					ToolbarItemsLeft[ll_index].TextHeight = p.PY
					
				ELSE
					ll_textwidth = 0
				END IF
				
				IF Len(ToolbarItemsLeft[ll_index].Image) > 0 THEN
					ToolbarItemsLeft[ll_index].ImageSize = il_CurrentSize
					ll_width = 2 + il_CurrentSize + 2 + ll_textwidth + 2
				ELSE
					ToolbarItemsLeft[ll_index].ImageSize = 0
					ll_width = 2 + ll_textwidth + 2
				END IF
			
				ToolbarItemsLeft[ll_index].TextWidth = ll_textwidth
			
				ToolbarItemsLeft[ll_index].PaintRegion[1].px = ll_x - ll_width
				ToolbarItemsLeft[ll_index].PaintRegion[1].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[2].px = ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[2].py = ll_y
				ToolbarItemsLeft[ll_index].PaintRegion[3].px = ll_x
				ToolbarItemsLeft[ll_index].PaintRegion[3].py = ll_height - ll_y + 1
				ToolbarItemsLeft[ll_index].PaintRegion[4].px = ll_x - ll_width
				ToolbarItemsLeft[ll_index].PaintRegion[4].py = ll_height - ll_y + 1
				
				IF ToolbarItemsLeft[ll_index].PaintRegion[1].px < il_LeftEndPoint THEN
					ToolbarItemsLeft[ll_index].Hidden = TRUE
					uo_toolbarchevron.of_RegisterItem(ToolbarItemsLeft[ll_index])
					lb_SomeHidden = TRUE
				ELSE
					ToolbarItemsLeft[ll_index].Hidden = FALSE
				END IF
				
				ll_x = ll_x - ll_width - 2
			END IF
		END IF
	END IF

NEXT

ReleaseDC (Handle(st_1), ll_dc)

uo_toolbarchevron.Visible = lb_SomeHidden OR ib_LeftHidden


IF lb_SomeHidden THEN
	CHOOSE CASE il_CurrentOrientation
		CASE HORIZONTAL
			IF ib_displayborder THEN
				uo_toolbarchevron.Height = THIS.Height - 10
				uo_toolbarchevron.Y = 2
				uo_toolbarchevron.X = THIS.Width - uo_toolbarchevron.Width - 4
			ELSE
				uo_toolbarchevron.Height = THIS.Height - 8
				uo_toolbarchevron.Y = 2
				uo_toolbarchevron.X = THIS.Width - uo_toolbarchevron.Width - 2
			END IF
		CASE VERTICAL
			IF ib_displayborder THEN
				uo_toolbarchevron.Height = 50
				uo_toolbarchevron.Width = THIS.Width - 8
				uo_toolbarchevron.X = 4
				uo_toolbarchevron.Y = THIS.Height - uo_toolbarchevron.Height - 8
			ELSE
				uo_toolbarchevron.Height = 50
				uo_toolbarchevron.Width = THIS.Width - 6
				uo_toolbarchevron.X = 4
				uo_toolbarchevron.Y = THIS.Height - uo_toolbarchevron.Height
			END IF
	END CHOOSE
END IF

RETURN 1
end function

public function integer of_updatepoints ();of_UpdatePointsLeft()
of_UpdatePointsRight()

return 1
end function

private function integer of_getheight ();//IF uo_toolbarchevron.Visible THEN
IF il_CurrentOrientation = HORIZONTAL THEN
	RETURN Height - uo_toolbarchevron.Height
ELSE
	RETURN Height
END IF
end function

private function integer of_cargaekmenu (menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_CargaEKMenu
//
//  DESCRIPCION		: Asigna las opciones a la barra de herramientas
//
//  ARGUMENTOS			: 
//		am_menu			: nombre del menu
//		
//  DEVUELVE			:
//		  0	: 	No pasa nada
//		  1   :  Todo bien
//		
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  14/JUL/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------


string	ls_menu, ls_texto, ls_imagen , ls_imagentoolbar
boolean  lb_visible, lb_enabled, lb_shiftToRight, lb_visibletoolbar, lb_default
long ll_row, ll_item, ll_total_items, ll_rc

menu	lmarr_items[], lm_menu, lm_padre

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT IsValid(am_menu) THEN RETURN 0

lmarr_items = am_menu.item[]

ll_total_items = upperbound(lmarr_items)

IF ll_total_items = 0 THEN RETURN 0

FOR ll_item = 1 TO ll_total_items
	
	lm_menu    = lmarr_items[ll_item]
	
	IF NOT IsValid(lm_menu) THEN RETURN 0
	
	ls_menu = lmarr_items[ll_item].classname()
	ls_texto = lmarr_items[ll_item].text
	ls_imagen = lmarr_items[ll_item].menuimage
	lb_visible = lmarr_items[ll_item].visible
	lb_visibletoolbar = lmarr_items[ll_item].toolbaritemvisible
	lb_enabled = lmarr_items[ll_item].Enabled
	lb_shiftToRight = lmarr_items[ll_item].shifttoright
	ls_imagentoolbar = lmarr_items[ll_item].toolbaritemname
	lb_default = lmarr_items[ll_item].default
	
	
	ls_texto = gnv_funciones_string.of_globalReplace(ls_texto,"&","")
	
	IF isnull(ls_imagentoolbar) OR len(trim(ls_imagentoolbar)) = 0 THEN ls_imagentoolbar = ls_imagen
	
	IF lb_visibletoolbar THEN
		IF ls_texto = "-" THEN
			of_AddSeparator()
		ELSE
			IF LEN(TRIM(ls_imagentoolbar)) > 0 THEN 
				IF lb_shiftToRight THEN
					of_AddItem(ls_menu, ls_imagentoolbar, ls_texto, RIGHT)
				ELSE
					of_AddItem(ls_menu, ls_imagentoolbar, ls_texto, LEFT)
				END IF
			END IF
			
			IF lb_default THEN
				of_displaytext(ls_menu, lb_default)
				of_settext(ls_menu, ls_texto)
			END IF
		END IF
		
		of_SetEnabled(ls_menu, lb_enabled)
		
		ll_rc = of_CargaEKMenu(lm_menu)
	END IF

NEXT

yield()

RETURN 1
end function

public function integer of_setekmenu (menu am_menu, boolean ab_activo);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_setEKMenu
//
//  DESCRIPCION		: Asigna las opciones a la barra de herramientas
//
//  ARGUMENTOS			: 
//		am_menu			: nombre del menu
//		
//  DEVUELVE			:
//		  -1: 	No se asigno el menu
//		  1   :  Todo bien
//		
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  14/JUL/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_rc
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


IF IsValid(im_ekmenu) THEN DESTROY im_ekmenu

of_Reset()
	
IF ab_activo THEN
	ll_rc = of_CargaEKMenu(am_menu)
	
	IF ll_rc <> 1 THEN RETURN -1
	
END IF

im_ekmenu = am_menu
ib_menuenkontrol = ab_activo

RETURN 1
end function

private function integer of_ekmenuclicked (menu am_menu, string as_opcion);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_EKMenuClicked
//
//  DESCRIPCION		: Asigna las opciones a la barra de herramientas
//
//  ARGUMENTOS			: 
//		am_menu			: nombre del menu
//		
//  DEVUELVE			:
//		  0	: 	No pasa nada
//		  1   :  Todo bien
//		
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  14/JUL/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------


string	ls_menu, ls_texto, ls_imagen 
boolean  lb_visible, lb_enabled
long ll_row, ll_item, ll_total_items, ll_rc

menu	lmarr_items[], lm_menu, lm_padre

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT IsValid(am_menu) THEN RETURN 0

lmarr_items = am_menu.item[]

ll_total_items = upperbound(lmarr_items)

IF ll_total_items = 0 THEN RETURN 0

ll_rc = 0

FOR ll_item = 1 TO ll_total_items
	
	lm_menu    = lmarr_items[ll_item]
	
	IF NOT IsValid(lm_menu) THEN RETURN 0
	
	ls_menu = lmarr_items[ll_item].classname()
	
	IF ls_menu = as_opcion THEN
		lmarr_items[ll_item].event Clicked()
		ll_rc = 1
		EXIT
	ELSE
		ll_rc = of_EKMenuClicked(lm_menu, as_opcion)
		IF ll_rc <> 0 THEN EXIT
	END IF
		
NEXT

RETURN ll_rc

end function

public function integer of_actualizamenuek (menu am_menu);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_CargaEKMenu
//
//  DESCRIPCION		: Asigna las opciones a la barra de herramientas
//
//  ARGUMENTOS			: 
//		am_menu			: nombre del menu
//		
//  DEVUELVE			:
//		  0	: 	No pasa nada
//		  1   :  Todo bien
//		
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  14/JUL/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------


string	ls_menu, ls_texto, ls_imagen , ls_imagentoolbar
boolean  lb_visible, lb_enabled, lb_shiftToRight, lb_visibletoolbar, lb_default, lb_toggle
long ll_row, ll_item, ll_total_items, ll_rc

menu	lmarr_items[], lm_menu, lm_padre

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT IsValid(am_menu) THEN RETURN 0

lmarr_items = am_menu.item[]

ll_total_items = upperbound(lmarr_items)

IF ll_total_items = 0 THEN RETURN 0

FOR ll_item = 1 TO ll_total_items
	
	lm_menu    = lmarr_items[ll_item]
	
	IF NOT IsValid(lm_menu) THEN RETURN 0
	
	ls_menu = lmarr_items[ll_item].classname()
//	ls_texto = lmarr_items[ll_item].text
//	ls_imagen = lmarr_items[ll_item].menuimage
//	lb_visible = lmarr_items[ll_item].visible
	lb_visibletoolbar = lmarr_items[ll_item].toolbaritemvisible
	lb_enabled = lmarr_items[ll_item].Enabled
//	lb_shiftToRight = lmarr_items[ll_item].shifttoright
//	ls_imagentoolbar = lmarr_items[ll_item].toolbaritemname
//	lb_default = lmarr_items[ll_item].default
	lb_toggle =  lmarr_items[ll_item].toolbaritemdown
	
//	ls_texto = gnv_funciones_string.of_globalReplace(ls_texto,"&","")
//	
//	IF isnull(ls_imagentoolbar) OR len(trim(ls_imagentoolbar)) = 0 THEN ls_imagentoolbar = ls_imagen
	
	IF lb_visibletoolbar THEN		
		of_SetEnabled(ls_menu, lb_enabled)
		of_Toggle(ls_menu, lb_toggle)
		
		ll_rc = of_ActualizaMenuEK(lm_menu)
	END IF

NEXT

yield()

RETURN 1
end function

public function integer of_toggle (string as_item, boolean ab_toogle);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_setEKMenu
//
//  DESCRIPCION		: Asigna las opciones a la barra de herramientas
//
//  ARGUMENTOS			: 
//		am_menu			: nombre del menu
//		
//  DEVUELVE			:
//		  -1: 	No se asigno el menu
//		  1   :  Todo bien
//		
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  14/JUL/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Long ll_index, ll_count
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ll_count = UpperBound(ToolbarItemsLeft)

FOR ll_index = 1 TO ll_count
	
	IF Upper(as_item) = Upper(ToolbarItemsLeft[ll_index].Text) THEN
		ToolbarItemsLeft[ll_index].Toggle = ab_toogle
		
		of_UpdatePoints()
		SetRedraw(TRUE)
		
		RETURN 1
//		RETURN of_Toggle(ll_index, LEFT)
	END IF
	
NEXT

RETURN 1


end function

on u_cst_toolbarstrip.create
int iCurrent
call super::create
this.lv_imagelistxlarge=create lv_imagelistxlarge
this.lv_imagelistlarge=create lv_imagelistlarge
this.lv_imagelistmedium=create lv_imagelistmedium
this.lv_imagelistsmall=create lv_imagelistsmall
this.st_1=create st_1
this.uo_toolbarchevron=create uo_toolbarchevron
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_imagelistxlarge
this.Control[iCurrent+2]=this.lv_imagelistlarge
this.Control[iCurrent+3]=this.lv_imagelistmedium
this.Control[iCurrent+4]=this.lv_imagelistsmall
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.uo_toolbarchevron
end on

on u_cst_toolbarstrip.destroy
call super::destroy
destroy(this.lv_imagelistxlarge)
destroy(this.lv_imagelistlarge)
destroy(this.lv_imagelistmedium)
destroy(this.lv_imagelistsmall)
destroy(this.st_1)
destroy(this.uo_toolbarchevron)
end on

event onpaint;call super::onpaint;Long ll_color1, ll_color2

//BCW - 2.0.0
IF ib_solidbackground THEN
	ll_color1 = of_GetColor("BACKGROUND3")
	ll_color2 = of_GetColor("BACKGROUND3")
ELSE
	ll_color1 = of_GetColor("BACKGROUND1")
	ll_color2 = of_GetColor("BACKGROUND2")
END IF

in_Gradient.of_SetHDC(hdc)

boolean lb_Horizontal

IF il_CurrentOrientation = HORIZONTAL THEN
	lb_Horizontal = TRUE
ELSE
	lb_Horizontal = FALSE
END IF
	
CHOOSE CASE il_CurrentStyle
	CASE XP
		in_Gradient.of_XPGradient(ll_color1, ll_color2, THIS,ib_displayborder,of_GetColor("BORDER"), lb_Horizontal)
	CASE VISTAEMBOSSED
		in_Gradient.of_Vista1Gradient(ll_color1, ll_color2, THIS,ib_displayborder,of_GetColor("BORDER"), lb_Horizontal)
	CASE VISTAORIGINAL
		in_Gradient.of_Vista2Gradient(ll_color1, ll_color2, THIS,ib_displayborder,of_GetColor("BORDER"), lb_Horizontal)
	CASE VISTAGLASS
		in_Gradient.of_Vista3Gradient(ll_color1, ll_color2, THIS,ib_displayborder,of_GetColor("BORDER"), lb_Horizontal)	
	CASE CUSTOM
		in_Gradient.of_CustomGradient(ll_color1, ll_color2, THIS,ib_displayborder,of_GetColor("BORDER"), lb_Horizontal)	
END CHOOSE
//BCW - 2.0.0

//of_VerticalGradient (of_GetColor("BACKGROUND1"), of_GetColor("BACKGROUND2"), THIS,ib_displayborder,of_GetColor("BORDER"), il_CurrentStyle)

IF ib_raisedborder THEN
	in_Gradient.of_DrawLine(Width - 3,0,Width - 3, Height, of_GetColor("CAP"))
	in_Gradient.of_DrawLine(0,Height - 3,Width, Height - 3, of_GetColor("CAP"))
END IF

Long il_imagelist
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


in_Gradient.of_DrawButtons(THIS, ToolbarItemsLeft, FontName, FontSize, FontColor, il_ImageList, il_CurrentOrientation)

RETURN 1
end event

event destructor;call super::destructor;of_Reset()
end event

event constructor;call super::constructor;Long ll_color1, ll_color2, ll_index
n_cst_theme lnv_Theme
message l_message

il_ID = inv_ToolTip.of_AddTool( THIS, "" , inv_ToolTip.TTF_SUBCLASS ) 

istr_TrackMouseEvent.cbSize = 16
istr_TrackMouseEvent.dwFlags = TME_LEAVE
istr_TrackMouseEvent.hwndTrack = Handle (THIS) 
istr_TrackMouseEvent.dwHoverTime = 0

of_getwindow()
uo_toolbarchevron.of_setparent(THIS)

//BCW - 2.0.0
IF Width > Height THEN
	il_CurrentOrientation = HORIZONTAL
ELSE
	il_CurrentOrientation = VERTICAL
END IF

of_SetSize(il_CurrentSize)
//BCW - 2.0.0

l_message = CREATE Message
l_message.Handle = Message.Handle
l_message.Number = Message.Number
l_message.WordParm = Message.WordParm
l_message.LongParm = Message.LongParm
l_message.DoubleParm = Message.DoubleParm
l_message.StringParm = Message.StringParm
l_message.PowerObjectParm = Message.PowerObjectParm
l_message.Processed = Message.Processed
l_message.ReturnValue = Message.ReturnValue

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

Message.Handle = l_message.Handle
Message.Number = l_message.Number
Message.WordParm = l_message.WordParm
Message.LongParm = l_message.LongParm
Message.DoubleParm = l_message.DoubleParm
Message.StringParm = l_message.StringParm
Message.PowerObjectParm = l_message.PowerObjectParm
Message.Processed = l_message.Processed
Message.ReturnValue = l_message.ReturnValue

of_GetFontSize()

DESTROY l_message
end event

event other;call super::other;CHOOSE CASE Message.Number 
	CASE WM_MOUSELEAVE
		this.Event MouseLeave() 
END CHOOSE
end event

type lv_imagelistxlarge from listview within u_cst_toolbarstrip
boolean visible = false
integer x = 73
integer y = 44
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = XLARGE
THIS.LargePictureWidth = XLARGE
end event

type lv_imagelistlarge from listview within u_cst_toolbarstrip
boolean visible = false
integer x = 73
integer y = 44
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = LARGE
THIS.LargePictureWidth = LARGE
end event

type lv_imagelistmedium from listview within u_cst_toolbarstrip
boolean visible = false
integer x = 73
integer y = 44
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event constructor;lv_imagelistmedium.LargePictureHeight = MEDIUM
lv_imagelistmedium.LargePictureWidth = MEDIUM
end event

type lv_imagelistsmall from listview within u_cst_toolbarstrip
boolean visible = false
integer x = 73
integer y = 44
integer width = 480
integer height = 400
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
long largepicturemaskcolor = 12632256
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

event constructor;THIS.LargePictureHeight = SMALL
THIS.LargePictureWidth = SMALL
end event

type st_1 from statictext within u_cst_toolbarstrip
integer width = 10002
integer height = 10000
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "   Toolbar Strip"
boolean focusrectangle = false
end type

event constructor;Hide()
end event

type uo_toolbarchevron from u_cst_toolbarchevron within u_cst_toolbarstrip
boolean visible = false
integer x = 439
integer taborder = 10
end type

on uo_toolbarchevron.destroy
call u_cst_toolbarchevron::destroy
end on

event constructor;call super::constructor;THIS.of_SetParent(PARENT)
end event


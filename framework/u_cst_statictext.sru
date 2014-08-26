HA$PBExportHeader$u_cst_statictext.sru
forward
global type u_cst_statictext from u_cst_canvas
end type
type rect from structure within u_cst_statictext
end type
type logfont from structure within u_cst_statictext
end type
type gradient_rect from structure within u_cst_statictext
end type
type trivertex from structure within u_cst_statictext
end type
end forward

type rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

type logfont from structure
	long		lfheight
	long		lfwidth
	long		lfescapement
	long		lforientation
	long		lfweight
	character		lfitalic
	character		lfunderline
	character		lfstrikeout
	character		lfcharset
	character		lfoutprecision
	character		lfclipprecision
	character		lfquality
	character		lfpitchandfamily
	character		lffacename[32]
end type

type gradient_rect from structure
	unsignedlong		upperleft
	unsignedlong		lowerright
end type

type trivertex from structure
	long		x
	long		y
	integer		red
	integer		green
	integer		blue
	integer		alpha
end type

global type u_cst_statictext from u_cst_canvas
long backcolor = 67108864
event lbuttonup pbm_lbuttonup
end type
global u_cst_statictext u_cst_statictext

type prototypes
Function ulong CreatePen  (ulong nPenStyle, ulong nWidth, ulong crColor) LIBRARY "Gdi32.dll"
Function ULONG	SelectObject (uLong hdc4, uLong hObject ) LIBRARY "Gdi32.dll"
function boolean DeleteObject(ulong hgdiobject) library "gdi32.dll" 

Function ulong CreateRectRgn (Long X1, Long Y1 , Long X2 , Long Y2 ) LIBRARY "Gdi32.dll"
Function ULONG FillRgn (Long hdc6, Long hRgn , Long hBrush ) LIBRARY "Gdi32.dll"
Function Boolean GradientRectangle (Long hdc2, TRIVERTEX pVert[], ULong numVert, GRADIENT_RECT pMesh [], ULong numMesh, ULong dMode) Library 'msimg32' Alias For 'GradientFill'
Function Long GetClientRect (Long hwnd, REF RECT lpRect) Library 'user32' alias for "GetClientRect"

FUNCTION ulong DrawText(ulong lhdc,ref string lpStr,ulong nCount,ref RECT lpRect,ulong wFormat) LIBRARY "user32.dll" ALIAS FOR "DrawTextW"
FUNCTION ulong SetTextColor(ulong lhdc,ulong crColor) LIBRARY "gdi32.dll"
FUNCTION ulong CreateFontIndirect(ref LOGFONT lpLogFont) LIBRARY "gdi32.dll" ALIAS FOR "CreateFontIndirectA;ANSI"

FUNCTION ulong SetBkMode(ulong lhdc,ulong nBkMode) LIBRARY "gdi32.dll"
FUNCTION ulong SetBkColor(ulong lhdc,ulong nColor) LIBRARY "gdi32.dll"

FUNCTION ulong GetSysColor(ulong nIndex) LIBRARY "user32.dll"
end prototypes

type variables
PUBLIC:
Long    #Backcolor2
Boolean #VGradientFill = FALSE
Boolean #HGradientFill = FALSE
Boolean #Transparent = FALSE
String  #Text
String  #FontName
Long	  #FontSize
Long    #FontColor
Boolean #Bold
Boolean #Italic
Boolean #UnderLine
Boolean #Ellipsis
Boolean #Wrap = TRUE
Boolean #Left = TRUE
Boolean #Center
Boolean #Right
Boolean #VTop = TRUE
Boolean #VCenter
Boolean #VBottom
Long    #Escapement = 0
Boolean #StrikeOut

PRIVATE:
ULong iul_font
ULong iul_fontbold

CONSTANT LONG DT_HLEFT = 0
CONSTANT LONG DT_HCENTER = 1
CONSTANT LONG DT_HRIGHT = 2

CONSTANT LONG DT_VTOP = 0
CONSTANT LONG DT_VCENTER = 4
CONSTANT LONG DT_VBOTTOM = 8

CONSTANT LONG DT_WORD_ELLIPSIS = 262144
CONSTANT LONG DT_CALCRECT = 1024
CONSTANT LONG DT_WORDBREAK = 16
CONSTANT LONG DT_SINGLELINE = 32
CONSTANT LONG DT_NOCLIP = 256
CONSTANT ULong GRADIENT_FILL_RECT_H = 0
CONSTANT ULong GRADIENT_FILL_RECT_V = 1

CONSTANT integer SCROLLBAR         = 0
CONSTANT integer BACKGROUND        = 1
CONSTANT integer ACTIVECAPTION     = 2
CONSTANT integer INACTIVECAPTION   = 3
CONSTANT integer MENU              = 4
CONSTANT integer WINDOW            = 5
CONSTANT integer WINDOWFRAME       = 6
CONSTANT integer MENUTEXT          = 7
CONSTANT integer WINDOWTEXT        = 8
CONSTANT integer CAPTIONTEXT       = 9
CONSTANT integer ACTIVEBORDER      = 10
CONSTANT integer INACTIVEBORDER    = 11
CONSTANT integer APPWORKSPACE      = 12
CONSTANT integer HIGHLIGHT         = 13
CONSTANT integer HIGHLIGHTTEXT     = 14
CONSTANT integer BTNFACE           = 15
CONSTANT integer BTNSHADOW         = 16
CONSTANT integer GRAYTEXT          = 17
CONSTANT integer BTNTEXT           = 18
CONSTANT integer INACTIVECAPTIONTEXT = 19
CONSTANT integer BTNHIGHLIGHT      = 20
CONSTANT integer COLOR_3DDKSHADOW        = 21
CONSTANT integer COLOR_3DLIGHT           = 22
CONSTANT integer INFOTEXT          = 23
CONSTANT integer INFOBK            = 24
CONSTANT integer HOTLIGHT          = 26
CONSTANT integer GRADIENTACTIVECAPTION = 27
CONSTANT integer GRADIENTINACTIVECAPTION = 28
CONSTANT integer MENUHILIGHT       = 29
CONSTANT integer MENUBAR           = 30
CONSTANT integer DESKTOP           = BACKGROUND
CONSTANT integer COLOR_3DFACE            = BTNFACE
CONSTANT integer COLOR_3DSHADOW          = BTNSHADOW
CONSTANT integer COLOR_3DHIGHLIGHT       = BTNHIGHLIGHT
CONSTANT integer COLOR_3DHILIGHT         = BTNHIGHLIGHT
CONSTANT integer BTNHILIGHT        = BTNHIGHLIGHT

//PB System Colors
CONSTANT Long PBACTIVE_BORDER = 134217738
CONSTANT Long PBACTIVE_TITLE_BAR = 134217730
CONSTANT Long PBACTIVE_TITLE_BAR_TEXT = 134217737
CONSTANT Long PBAPPLICATION_WORKSPACE = 268435456
CONSTANT Long PBBUTTON_DARK_SHADOW = 134217749
CONSTANT Long PBBUTTON_FACE = 67108864
CONSTANT Long PBBUTTON_HIGHLIGHT = 134217748
CONSTANT Long PBBUTTON_LIGHT_SHADOW = 134217750
CONSTANT Long PBBUTTON_SHADOW = 134217744
CONSTANT Long PBBUTTON_TEXT = 134217746
CONSTANT Long PBDESKTOP = 134217729
CONSTANT Long PBDISABLED_TEXT = 134217745
CONSTANT Long PBHIGHLIGHT = 134217741
CONSTANT Long PBHIGHLIGHT_TEXT = 134217742
CONSTANT Long PBINACTIVE_BORDER = 134217739
CONSTANT Long PBINACTIVE_TITLE_BAR = 134217731
CONSTANT Long PBINACTIVE_TITLE_BAR_TEXT = 134217747
CONSTANT Long PBLINK = 134217856
CONSTANT Long PBLINK_HOVER = 134217857
CONSTANT Long PBLINK_ACTIVE = 134217858
CONSTANT Long PBLINK_VISITED = 134217859
CONSTANT Long PBMENU_BAR = 134217732
CONSTANT Long PBMENU_TEXT = 134217735
CONSTANT Long PBSCROLLBAR = 134217728
//CONSTANT Long PBSCROLL_BAR = SCROLLBAR
CONSTANT Long PBTRANSPARENT = 536870912
CONSTANT Long PBTOOLTIP = 134217752
CONSTANT Long PBTOOLTIP_TEXT = 134217751
CONSTANT Long PBWINDOW_BACKGROUND = 1073741824
CONSTANT Long PBWINDOW_FRAME = 134217734
CONSTANT Long PBWINDOW_TEXT = 33554432
end variables

forward prototypes
public function integer of_drawtext (long ahdc)
public function boolean of_getbit (long al_decimal, integer ai_bit)
public subroutine of_splitrgb (long al_color, ref long red, ref long green, ref long blue)
public function long of_bitwiseand (long al_value1, long al_value2)
public function long of_getcolor (long al_color)
public function integer of_redraw ()
public function integer of_italic (boolean ab_italic)
public function integer of_bold (boolean ab_bold)
public function integer of_underline (boolean ab_underline)
public function integer of_ellipsis (boolean ab_ellipsis)
public function integer of_wrap (boolean ab_wrap)
public function integer of_alignleft ()
public function integer of_aligncenter ()
public function integer of_alignright ()
public function integer of_valigntop ()
public function integer of_valigncenter ()
public function integer of_valignbottom ()
public function integer of_backcolor2 (long al_color)
public function integer of_vgradient (boolean ab_vgradient)
public function integer of_hgradient (boolean ab_hgradient)
public function integer of_text (string as_text)
public function integer of_fontname (string as_font)
public function integer of_fontsize (long al_size)
public function integer of_fontcolor (long al_color)
public function integer of_backcolor (long al_color)
public function integer of_createfont ()
public function integer of_escapement (long al_escapement)
public function integer of_strikeout (boolean ab_stikeout)
public function integer of_transparent (boolean ab_transparent)
public function long of_bitwiseor (long aul_arg1, long aul_arg2)
end prototypes

public function integer of_drawtext (long ahdc);Long ll_parm
RECT l_Rect

of_CreateFont()

IF #Bold THEN
	SelectObject(ahdc, iul_fontbold)
ELSE
	SelectObject(ahdc, iul_font)
END IF

ll_parm = DT_NOCLIP

IF #Center THEN
	ll_parm = of_BitWiseOr(ll_parm, DT_HCENTER)
ELSEIF #Right THEN
	ll_parm = of_BitWiseOr(ll_parm, DT_HRIGHT)
END IF

IF #VCenter THEN
	ll_parm = of_BitWiseOr(ll_parm, DT_VCENTER)
	ll_parm = of_BitWiseOr(ll_parm, DT_SINGLELINE)
ELSEIF #VBottom THEN
	ll_parm = of_BitWiseOr(ll_parm, DT_VBOTTOM)
	ll_parm = of_BitWiseOr(ll_parm, DT_SINGLELINE)
END IF
	
IF #Ellipsis THEN
	ll_parm = of_BitWiseOr(ll_parm, DT_WORD_ELLIPSIS)
END IF

IF #Wrap THEN
	ll_parm = of_BitWiseOr(ll_parm, DT_WORDBREAK)
END IF

SetBkMode(ahdc, 1)

// Position
l_Rect.Left = UnitsToPixels(0, XUnitsToPixels!)
l_Rect.Top = UnitsToPixels(0, YUnitsToPixels!)
IF Border THEN
	IF BorderStyle = StyleBox! THEN
		l_Rect.Right = UnitsToPixels(Width, XUnitsToPixels!) - 2
		l_Rect.Bottom = UnitsToPixels(Height, YUnitsToPixels!) - 2
	ELSE
		l_Rect.Right = UnitsToPixels(Width, XUnitsToPixels!) - 4
		l_Rect.Bottom = UnitsToPixels(Height, YUnitsToPixels!) - 4
	END IF
ELSE
	l_Rect.Right = UnitsToPixels(Width, XUnitsToPixels!)
	l_Rect.Bottom = UnitsToPixels(Height, YUnitsToPixels!)
END IF


SetTextColor(ahdc, #FontColor)

Drawtext(ahdc, #Text, LEN(#Text), l_Rect, ll_parm)

DeleteObject(iul_font)
DeleteObject(iul_fontbold)

RETURN 1
end function

public function boolean of_getbit (long al_decimal, integer ai_bit);Boolean lb_null

//Check parameters
If IsNull(al_decimal) or IsNull(ai_bit) then
	SetNull(lb_null)
	Return lb_null
End If

//Assumption ai_bit is the nth bit counting right to left with
//the leftmost bit being bit one.
//al_decimal is a binary number as a base 10 long.
If Int(Mod(al_decimal / (2 ^(ai_bit - 1)), 2)) > 0 Then
	Return True
End If

Return False
end function

public subroutine of_splitrgb (long al_color, ref long red, ref long green, ref long blue);Red = Mod (al_Color, 256)
Red *= 256

al_Color /= 256
Green	= Mod (al_Color, 256)
Green *= 256

Blue = al_Color / 256
Blue *= 256
end subroutine

public function long of_bitwiseand (long al_value1, long al_value2);Integer		li_Cnt
Long			ll_Result
Boolean		lb_Value1[32], lb_Value2[32]

// Check for nulls
If IsNull(al_Value1) Or IsNull(al_Value2) Then
	SetNull(ll_Result)
	Return ll_Result
End If

// Get all bits for both values
For li_Cnt = 1 To 32
	lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
	lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
Next

// And them together
For li_Cnt = 1 To 32
	If lb_Value1[li_Cnt] And lb_Value2[li_Cnt] Then
		ll_Result = ll_Result + (2^(li_Cnt - 1))
	End If
Next

Return ll_Result
end function

public function long of_getcolor (long al_color);long ll_ret

CHOOSE CASE al_color
	CASE PBACTIVE_BORDER
		ll_ret = GetSysColor(ACTIVEBORDER)
	CASE PBACTIVE_TITLE_BAR
		ll_ret = GetSysColor(ACTIVECAPTION)
	CASE PBACTIVE_TITLE_BAR_TEXT
	CASE PBAPPLICATION_WORKSPACE
		ll_ret = GetSysColor(APPWORKSPACE)
	CASE PBBUTTON_DARK_SHADOW
	CASE PBBUTTON_FACE
		ll_ret = GetSysColor(BTNFACE)
	CASE PBBUTTON_HIGHLIGHT
		ll_ret = GetSysColor(BTNHILIGHT)
	CASE PBBUTTON_LIGHT_SHADOW
	CASE PBBUTTON_SHADOW
		ll_ret = GetSysColor(BTNSHADOW)
	CASE PBBUTTON_TEXT
		ll_ret = GetSysColor(BTNTEXT)
	CASE PBDESKTOP
		ll_ret = GetSysColor(DESKTOP)
	CASE PBDISABLED_TEXT
		ll_ret = GetSysColor(INACTIVECAPTIONTEXT)
	CASE PBHIGHLIGHT
		ll_ret = GetSysColor(HIGHLIGHT)
	CASE PBHIGHLIGHT_TEXT
		ll_ret = GetSysColor(HIGHLIGHTTEXT)
	CASE PBINACTIVE_BORDER
		ll_ret = GetSysColor(INACTIVEBORDER)
	CASE PBINACTIVE_TITLE_BAR
		ll_ret = GetSysColor(INACTIVECAPTION)
	CASE PBINACTIVE_TITLE_BAR_TEXT
		ll_ret = GetSysColor(INACTIVECAPTIONTEXT)
	CASE PBLINK
	CASE PBLINK_HOVER
	CASE PBLINK_ACTIVE
	CASE PBLINK_VISITED
	CASE PBMENU_BAR
		ll_ret = GetSysColor(MENU)
	CASE PBMENU_TEXT
		ll_ret = GetSysColor(MENUTEXT)
	CASE PBSCROLLBAR
		ll_ret = GetSysColor(SCROLLBAR)
	CASE PBTRANSPARENT
		ll_ret = PBTRANSPARENT
	CASE PBTOOLTIP
		ll_ret = GetSysColor(INFOBK)
	CASE PBTOOLTIP_TEXT
		ll_ret = GetSysColor(INFOTEXT)
	CASE PBWINDOW_BACKGROUND
		ll_ret = GetSysColor(WINDOW)
	CASE PBWINDOW_FRAME
		ll_ret = GetSysColor(WINDOWFRAME)
	CASE PBWINDOW_TEXT
		ll_ret = GetSysColor(WINDOWTEXT)
	CASE ELSE
		ll_ret = al_color
END CHOOSE

RETURN ll_ret
end function

public function integer of_redraw ();SetRedraw(TRUE)

RETURN 1
end function

public function integer of_italic (boolean ab_italic);#Italic = ab_italic
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_bold (boolean ab_bold);#Bold = ab_bold
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_underline (boolean ab_underline);#Underline = ab_underline
SetRedraw(TRUE)
RETURN 1
end function

public function integer of_ellipsis (boolean ab_ellipsis);#Ellipsis = ab_ellipsis

IF #Ellipsis THEN
	#Wrap = FALSE
END IF

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_wrap (boolean ab_wrap);#Wrap = ab_wrap

IF #Wrap THEN
	#Ellipsis = FALSE
END IF

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_alignleft ();#Left = TRUE
#Center = FALSE
#Right = FALSE

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_aligncenter ();#Left = FALSE
#Center = TRUE
#Right = FALSE

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_alignright ();#Left = FALSE
#Center = FALSE
#Right = TRUE

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_valigntop ();#VTop = TRUE
#VCenter = FALSE
#VBottom = FALSE

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_valigncenter ();#VTop = FALSE
#VCenter = TRUE
#VBottom = FALSE

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_valignbottom ();#VTop = FALSE
#VCenter = FALSE
#VBottom = TRUE

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_backcolor2 (long al_color);#Backcolor2 = al_color

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_vgradient (boolean ab_vgradient);#VGradientFill = ab_vgradient

IF #VGradientFill THEN
	#HGradientFill = FALSE
END IF

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_hgradient (boolean ab_hgradient);#HGradientFill = ab_hgradient

IF #HGradientFill THEN
	#VGradientFill = FALSE
END IF

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_text (string as_text);#Text = as_text

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_fontname (string as_font);#FontName = as_font

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_fontsize (long al_size);#FontSize = al_size

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_fontcolor (long al_color);#FontColor = al_color

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_backcolor (long al_color);Backcolor = al_color

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_createfont ();LogFont lstr_Lf
uLong lul_Font

lstr_Lf.lffacename = #FontName
lstr_Lf.lfweight = 400
lstr_Lf.lfheight = #FontSize * -1
lstr_Lf.lfPitchAndFamily = '1'
lstr_Lf.lfClipPrecision = Char(2)
lstr_Lf.lfOutPrecision = Char(1)
lstr_Lf.lfQuality = Char(1)
lstr_Lf.lfCharset = Char(1)

IF #Underline THEN
	lstr_Lf.lfunderline = Char(1)
END IF

IF #Italic THEN
	lstr_Lf.lfitalic = Char(1)
END IF

lstr_Lf.lfescapement = (#Escapement * 10)

IF #StrikeOut THEN
	lstr_Lf.lfstrikeout = Char(1)
END IF

iul_font = CreateFontIndirect( lstr_Lf )
lstr_Lf.lfweight = 700
iul_fontbold = CreateFontIndirect( lstr_Lf )

RETURN 1
end function

public function integer of_escapement (long al_escapement);#Escapement = al_escapement

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_strikeout (boolean ab_stikeout);#StrikeOut = ab_stikeout

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_transparent (boolean ab_transparent);#Transparent = ab_transparent
of_SetTransparent(#Transparent)
SetRedraw(TRUE)
RETURN 1
end function

public function long of_bitwiseor (long aul_arg1, long aul_arg2);//Integer		li_Cnt
//Long			ll_Result
//Boolean		lb_Value1[32], lb_Value2[32]
//
//// Check for nulls
//If IsNull(al_Value1) Or IsNull(al_Value2) Then
//	SetNull(ll_Result)
//	Return ll_Result
//End If
//
//// Get all bits for both values
//For li_Cnt = 1 To 32
//	lb_Value1[li_Cnt] = of_getbit(al_Value1, li_Cnt)
//	lb_Value2[li_Cnt] = of_getbit(al_Value2, li_Cnt)
//Next
//
//// Or them together
//For li_Cnt = 1 To 32
//	If lb_Value1[li_Cnt] Or lb_Value2[li_Cnt] Then
//		ll_Result = ll_Result + (2^(li_Cnt - 1))
//	End If
//Next
//
//Return ll_Result

ulong ul_exp, ul_exp_last=1, ul_bit1, ul_bit2, ul_ret
long ll_i

for ll_i = 1 to 31

            ul_exp=2^ll_i
            ul_bit1=mod(aul_arg1,ul_exp)
            ul_bit2=mod(aul_arg2,ul_exp)

            if ul_bit1>0 or ul_bit2>0 then
                        ul_ret+=ul_exp_last
            end if

            ul_exp_last=ul_exp
            aul_arg1 -=ul_bit1
            aul_arg2 -=ul_bit2
next

if aul_arg1>0 or aul_arg2>0 then
            ul_ret+=ul_exp_last
end if


return ul_ret
end function

on u_cst_statictext.create
call super::create
end on

on u_cst_statictext.destroy
call super::destroy
end on

event onpaint;call super::onpaint;Long hRPen, hRgn
RECT lpRect
TRIVERTEX Corner[4]
GRADIENT_RECT l_Gradient[1]
Long ll_backcolor, ll_backcolor2
Long ll_red, ll_green, ll_blue

IF NOT #Transparent THEN
	ll_backcolor = of_GetColor(BackColor)
	
	IF #VGradientFill OR #HGradientFill THEN
		ll_backcolor2 = of_GetColor(#Backcolor2)
	ELSE
		ll_backcolor2 = ll_backcolor
	END IF
	
	GetClientRect (Handle(THIS), lpRect)
	
	Corner[1].X = 0
	Corner[1].Y = 0 
	Corner[2].X = lpRect.Right
	Corner[2].Y = 0
	Corner[3].X = lpRect.Right
	Corner[3].Y = lpRect.Bottom
	Corner[4].X = 0
	Corner[4].Y = lpRect.Bottom
	
	// Set the colors in the first corner (top left)
	of_SplitRGB (ll_backcolor, ll_Red, ll_Green, ll_Blue)
	Corner[1].Red = ll_Red
	Corner[1].Green = ll_Green
	Corner[1].Blue = ll_Blue
	
	// Set the colors in the third corner (bottom right)
	of_SplitRGB (ll_backcolor2, ll_Red, ll_Green, ll_Blue)
	Corner[3].Red = ll_Red
	Corner[3].Green = ll_Green
	Corner[3].Blue = ll_Blue
	
	l_Gradient[1].UpperLeft = 0 // First corner, top left
	l_Gradient[1].LowerRight = 2 // Third corner, bottom right
	
	IF #VGradientFill THEN
		GradientRectangle (hdc, Corner, 4, l_Gradient, 1, GRADIENT_FILL_RECT_V)
	ELSE
		GradientRectangle (hdc, Corner, 4, l_Gradient, 1, GRADIENT_FILL_RECT_H)
	END IF

ELSE
	of_SetTransparent(TRUE)
END IF

of_DrawText(hdc)

RETURN 1
end event

event constructor;call super::constructor;of_SetTransparent(#Transparent)
end event


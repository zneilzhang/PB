HA$PBExportHeader$u_cst_groupbox.sru
forward
global type u_cst_groupbox from u_cst_canvas
end type
type lv_imagelist from listview within u_cst_groupbox
end type
type st_1 from statictext within u_cst_groupbox
end type
end forward

global type u_cst_groupbox from u_cst_canvas
integer width = 910
integer height = 416
long backcolor = 67108864
lv_imagelist lv_imagelist
st_1 st_1
end type
global u_cst_groupbox u_cst_groupbox

type prototypes
FUNCTION ulong GetSysColor(ulong nIndex) LIBRARY "user32.dll"
end prototypes

type variables
String #FontFamily = 'Tahoma'
Long   #FontSize = 12
Long   #FontColor = 0

Boolean #Bold = FALSE
Boolean #Italic
Boolean #UnderLine
Boolean #StrikeOut

String #Text = 'None'

Boolean #VGradientFill = FALSE
Boolean #HGradientFill = FALSE
Long #Gradient1 = 0
Long #Gradient2 = 0

Long #bordercolor = 8421504

String #Image
Boolean #ThemeAware = FALSE

Long #Style = 0

CONSTANT Long BLUE = RGB(185,210,248)
CONSTANT Long SILVER = RGB(232,232,240)
CONSTANT Long OLIVE = RGB(234,234,207)
CONSTANT Long CLASSIC = RGB(242,243,246)

CONSTANT Long NORMAL = 0
CONSTANT Long HEADER = 1

PROTECTED:



PRIVATE:
n_cst_groupbox_gradient in_gradient


Long il_imagelist
Long il_CurrentTheme

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0

Window iw_parent

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
private function long of_getcolor ()
private function integer of_getwindow ()
public function integer of_italic (boolean ab_italic)
public function integer of_bold (boolean ab_bold)
public function integer of_underline (boolean ab_underline)
public function integer of_vgradient (boolean ab_vgradient)
public function integer of_hgradient (boolean ab_hgradient)
public function integer of_text (string as_text)
public function integer of_fontname (string as_font)
public function integer of_fontsize (long al_size)
public function integer of_fontcolor (long al_color)
public function integer of_backcolor (long al_color)
public function integer of_strikeout (boolean ab_stikeout)
public function integer of_setimage (string as_image)
public function long of_getthemecolor (string as_color)
public function integer of_activatetheme (long al_color)
public function integer of_settheme (long al_color)
public function integer of_deactivatetheme ()
public function integer of_setgradientcolor1 (long al_color)
public function integer of_setgradientcolor2 (long al_color)
public function integer of_setbordercolor (long al_color)
public function integer of_setstyle (long al_style)
public function long of_getcurrenttheme ()
end prototypes

private function long of_getcolor ();long ll_ret

CHOOSE CASE THIS.BackColor
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
		ll_ret = THIS.BackColor
END CHOOSE

RETURN ll_ret
end function

private function integer of_getwindow ();PowerObject	lpo_parent
Window lw_window

// loop thru parents until a window is found
lpo_parent = GetParent()
Do While lpo_parent.TypeOf() <> Window! and IsValid(lpo_parent)
	lpo_parent = lpo_parent.GetParent()
Loop

// set return to the window or null if not found
If IsValid (lpo_parent) Then
	lw_window = lpo_parent
Else
	SetNull(lw_window)
End If

iw_parent = lw_window

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

public function integer of_fontname (string as_font);#FontFamily = as_font

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

public function integer of_strikeout (boolean ab_stikeout);#StrikeOut = ab_stikeout

SetRedraw(TRUE)
RETURN 1
end function

public function integer of_setimage (string as_image);#Image = as_image

lv_imagelist.DeleteLargePictures ( )

IF Len(Trim(as_image)) > 0 THEN
	lv_imagelist.AddLargePicture ( #Image )

	il_imagelist = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
ELSE
	il_imagelist = 0
END IF

SetRedraw(TRUE)

RETURN 1
end function

public function long of_getthemecolor (string as_color);Long ll_color

CHOOSE CASE Upper(as_color)
	CASE "BORDER"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(4,56,148)
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
	CASE "HEADER1"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(89,135,214)
			CASE SILVER
				ll_color = RGB(168,167,191)
			CASE OLIVE
				ll_color = RGB(175,192,130)
			CASE ELSE
				ll_color = RGB(128,128,128)
		END CHOOSE
	CASE "HEADER2"
		CHOOSE CASE il_CurrentTheme
			CASE BLUE
				ll_color = RGB(4,56,148)
			CASE SILVER
				ll_color = RGB(112,111,145)
			CASE OLIVE
				ll_color = RGB(99,122,68)
			CASE ELSE
				ll_color = RGB(128,128,128)
		END CHOOSE
END CHOOSE

RETURN ll_color
end function

public function integer of_activatetheme (long al_color);#ThemeAware = TRUE
il_CurrentTheme = al_color
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_settheme (long al_color);il_CurrentTheme = al_color
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_deactivatetheme ();#ThemeAware = FALSE
SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setgradientcolor1 (long al_color);#Gradient1 = al_color

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setgradientcolor2 (long al_color);#Gradient2 = al_color

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setbordercolor (long al_color);#bordercolor = al_color

SetRedraw(TRUE)

RETURN 1
end function

public function integer of_setstyle (long al_style);#Style = al_style
SetRedraw(TRUE)
RETURN 1
end function

public function long of_getcurrenttheme ();RETURN il_currenttheme
end function

on u_cst_groupbox.create
int iCurrent
call super::create
this.lv_imagelist=create lv_imagelist
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_imagelist
this.Control[iCurrent+2]=this.st_1
end on

on u_cst_groupbox.destroy
call super::destroy
destroy(this.lv_imagelist)
destroy(this.st_1)
end on

event onpaint;call super::onpaint;in_Gradient.of_SetHDC(hdc)

strGroupBox lstr_GroupBox

lstr_GroupBox.text = #Text
lstr_GroupBox.fontfamily = #FontFamily
lstr_GroupBox.fontsize = #FontSize
lstr_GroupBox.bold = #Bold
lstr_GroupBox.italics = #Italic
lstr_GroupBox.strikeout = #StrikeOut
lstr_GroupBox.underline = #Underline
lstr_GroupBox.fontcolor = #FontColor
lstr_GroupBox.backcolor = of_GetColor()

IF #themeAware THEN
	IF #VGradientFill OR #HGradientFill THEN
		lstr_GroupBox.gradient1 = of_GetThemeColor("BACKGROUND1")
		lstr_GroupBox.gradient2 = of_GetThemeColor("BACKGROUND2")
	ELSE
		lstr_GroupBox.gradient1 = of_GetThemeColor("BACKGROUND1")
		lstr_GroupBox.gradient2 = of_GetThemeColor("BACKGROUND1")
	END IF
	lstr_GroupBox.bordercolor = of_GetThemeColor("BORDER")
ELSE
	IF #VGradientFill OR #HGradientFill THEN
		lstr_GroupBox.gradient1 = #Gradient1
		lstr_GroupBox.gradient2 = #Gradient2
	ELSE
		lstr_GroupBox.gradient1 = of_GetColor()
		lstr_GroupBox.gradient2 = of_GetColor()
	END IF
	lstr_GroupBox.bordercolor = #bordercolor
END IF

IF #VGradientFill THEN
	lstr_GroupBox.gradientdirection = 'V'
END IF

IF #HGradientFill THEN
	lstr_GroupBox.gradientdirection = 'H'
END IF

lstr_GroupBox.image = il_imagelist
lstr_GroupBox.Width = UnitsToPixels(Width, XUnitsToPixels!)
lstr_GroupBox.Height = UnitsToPixels(Height, YUnitsToPixels!)

lstr_GroupBox.Style = #Style
lstr_GroupBox.HeaderColor1 = of_GetThemeColor("HEADER1")
lstr_GroupBox.HeaderColor2 = of_GetThemeColor("HEADER2")

in_Gradient.of_DrawGroupBox (THIS, lstr_GroupBox)


RETURN 1
end event

event constructor;call super::constructor;Long ll_color1, ll_color2, ll_index
n_cst_theme lnv_Theme

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

of_GetWindow()
end event

type lv_imagelist from listview within u_cst_groupbox
boolean visible = false
integer taborder = 10
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

type st_1 from statictext within u_cst_groupbox
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
string text = "    Custom GroupBox"
boolean focusrectangle = false
end type

event constructor;THIS.Visible = FALSE
end event


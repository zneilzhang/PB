HA$PBExportHeader$n_cst_groupbox_gradient.sru
forward
global type n_cst_groupbox_gradient from nonvisualobject
end type
type gradient_rect from structure within n_cst_groupbox_gradient
end type
type gradient_triangle from structure within n_cst_groupbox_gradient
end type
type rect from structure within n_cst_groupbox_gradient
end type
type trivertex from structure within n_cst_groupbox_gradient
end type
type logfont from structure within n_cst_groupbox_gradient
end type
end forward

type gradient_rect from structure
	unsignedlong		upperleft
	unsignedlong		lowerright
end type

type gradient_triangle from structure
	unsignedlong		vertex1
	unsignedlong		vertex2
	unsignedlong		vertex3
end type

type rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

type trivertex from structure
	long		x
	long		y
	integer		red
	integer		green
	integer		blue
	integer		alpha
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

global type n_cst_groupbox_gradient from nonvisualobject autoinstantiate
end type

type prototypes
FUNCTION ulong SetBkMode(ulong lhdc,ulong nBkMode) LIBRARY "gdi32.dll"
Function Long GetDC (Long hwnd) Library 'user32'
Function Long GetClientRect (Long hwnd, REF RECT lpRect) Library 'user32' alias for "GetClientRect;Ansi"
Function Long ReleaseDC (Long hwnd, Long hdc1) Library 'user32'
Function Boolean GradientRectangle (Long hdc2, TRIVERTEX pVert[], ULong numVert, GRADIENT_RECT pMesh [], ULong numMesh, ULong dMode) Library 'msimg32' Alias For 'GradientFill;Ansi'
Function Boolean GradientTriangle (Long hdc3, TRIVERTEX pVert[], ULong numVert, GRADIENT_TRIANGLE pMesh [], ULong numMesh, ULong dMode) Library 'msimg32' Alias For 'GradientFill;Ansi'

Function ulong Rectangle (ulong hwnd, ulong X1, ulong Y1, ulong X2, ulong Y2) library "gdi32" 
Function ulong CreatePen  (ulong nPenStyle, ulong nWidth, ulong crColor) LIBRARY "Gdi32.dll"
Function ULONG	SelectObject (uLong hdc4, uLong hObject ) LIBRARY "Gdi32.dll"
function boolean DeleteObject(ulong hgdiobject) library "gdi32.dll" 

FUNCTION ulong DrawText(ulong lhdc,ref string lpStr,ulong nCount,ref RECT lpRect,ulong wFormat) LIBRARY "user32.dll" ALIAS FOR "DrawTextW"
FUNCTION ulong SetTextColor(ulong lhdc,ulong crColor) LIBRARY "gdi32.dll"
FUNCTION ulong CreateFontIndirect(ref LOGFONT lpLogFont) LIBRARY "gdi32.dll" ALIAS FOR "CreateFontIndirectA;ANSI"

Function ulong RoundRect (uLong hdc5 , uLong X1, ulong Y1 , ulong X2 , ulong Y2 , ulong X3 , ulong Y3 ) LIBRARY "Gdi32.dll"
Function ULONG FillRgn (Long hdc6, Long hRgn , Long hBrush ) LIBRARY "Gdi32.dll"
Function ulong CreateRectRgn (Long X1, Long Y1 , Long X2 , Long Y2 ) LIBRARY "Gdi32.dll"
Function ulong CreateRoundRectRgn (long X1 , long Y1 , long X2 , long Y2 , long X3 , long Y3 ) LIBRARY "Gdi32.dll"

Function ULONG PolyBezier (Long hdc7, REF RECT lpRect, long cPoints ) LIBRARY "Gdi32.dll" alias for "PolyBezier;Ansi"
Function ULONG Polyline( Long hdc8, GRADIENT_RECT lppt[], int cPoints) LIBRARY "Gdi32.dll" alias for "Polyline;Ansi"

FUNCTION boolean Ellipse(ulong hwnd,long x1,long y1,long x2,long y2) LIBRARY "Gdi32.dll"

FUNCTION ulong CreatePolygonRgn(ref POINT ppoint[], int count, int fillMode) Library "GDI32.DLL" alias for "CreatePolygonRgn;Ansi"
FUNCTION long SelectClipRgn(ulong lhdc, ulong lhrgn) Library "GDI32.DLL"

FUNCTION long PtInRegion(ulong hrgn, int x, int y) LIBRARY "GDI32.dll"

Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
Function boolean ImageList_DrawEx(long himl, long i, long hdcDst, long lx, long ly, long lwidth, long lheight, long lback, long lfore , ulong fStyle) Library "comctl32.dll"

end prototypes

type variables
// MS Windows enumerations
CONSTANT ULong GRADIENT_FILL_RECT_H = 0
CONSTANT ULong GRADIENT_FILL_RECT_V = 1
CONSTANT ULong GRADIENT_FILL_TRIANGLE = 2
CONSTANT ULong GRADIENT_FILL_OP_FLAG = 255

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0
CONSTANT Long ILD_BLEND50 = 4
CONSTANT Long ILD_BLEND25 = 2

// User object enumerations
CONSTANT String TOPLEFT = "TOPLEFT"
CONSTANT String TOPRIGHT = "TOPRIGHT"
CONSTANT String BOTTOMRIGHT = "BOTTOMRIGHT"
CONSTANT String BOTTOMLEFT = "BOTTOMLEFT"

BOOLEAN	ib_displayborder

CONSTANT LONG ALIGN_LEFT = 0
CONSTANT LONG ALIGN_CENTER = 1
CONSTANT LONG ALIGN_RIGHT = 2

CONSTANT LONG DT_WORD_ELLIPSIS = 262144
CONSTANT LONG DT_CALCRECT = 1024
CONSTANT LONG DT_WORDBREAK = 16

Long	il_HDC

Long il_newHeight
Long il_newWidth

PRIVATE:
// Object Handle
Long	HDC

Long	il_ShadowBackColor

ULong iul_font
ULong iul_fontbold

// Dimensions
RECT DC_Rect

// Vertices
TRIVERTEX Corner[4]
TRIVERTEX Header[4]
TRIVERTEX BorderCorner[2]
TRIVERTEX VistaCorner1[4]
TRIVERTEX VistaCorner2[4]
TRIVERTEX VistaCorner3[4]

strgroupbox istrgroupbox
end variables

forward prototypes
public subroutine of_splitrgb (long al_color, ref long red, ref long green, ref long blue)
public function integer of_sethdc (long al_hdc)
public function integer of_drawgroupbox (dragobject ado_palette, strgroupbox al_strgroupbox)
public function unsignedlong of_createfont ()
public function integer of_drawtext (graphicobject ado_palette, long al_x, long al_y)
public function integer of_gettextsize (graphicobject ado_palette)
end prototypes

public subroutine of_splitrgb (long al_color, ref long red, ref long green, ref long blue);Red = Mod (al_Color, 256)
Red *= 256

al_Color /= 256
Green	= Mod (al_Color, 256)
Green *= 256

Blue = al_Color / 256
Blue *= 256
end subroutine

public function integer of_sethdc (long al_hdc);il_HDC = al_hdc

RETURN 1
end function

public function integer of_drawgroupbox (dragobject ado_palette, strgroupbox al_strgroupbox);point lp[], lp_line[]
point lp_empty[]
gradient_rect l_Gradient[1]
GRADIENT_RECT l_Line[]
rect rc
Long	ll_Red, &
		ll_Green, &
		ll_Blue
long hRgn, hRPen, ll_index, ll_count, ll_textcolor, ll_parm
Long ll_inner, ll_innercount
Long ll_textx, ll_regionx, ll_textwidth, ll_y, ll_texty, ll_imagey
Boolean lb_bold

istrgroupbox = al_strGroupBox

of_GetTextSize(ado_palette)

hRgn = CreateRectRgn (0, 0 , al_strGroupBox.width , al_strGroupBox.height )
hRPen = CreatePen(0,0,al_strGroupBox.BackColor)
FillRgn (il_HDC, hRgn , hRPen )
DeleteObject(hRPen)
DeleteObject(hRgn)

l_Gradient[1].UpperLeft = 0
l_Gradient[1].LowerRight = 2
	
Corner[1].X = 2

IF al_strGroupBox.style = 0 THEN
	Corner[1].Y = il_newHeight / 2
ELSE
	Corner[1].Y = 1
END IF

Corner[2].X = al_strGroupBox.width - 1 

IF al_strGroupBox.style = 0 THEN	
	Corner[2].Y = il_newHeight / 2
ELSE
	Corner[2].Y = 1
END IF

Corner[3].X = al_strGroupBox.width - 1
Corner[3].Y = al_strGroupBox.height - 1
Corner[4].X = 2 
Corner[4].Y = al_strGroupBox.height - 1


Header[1].X = 2
Header[1].Y = 1
Header[2].X = al_strGroupBox.width - 1 
Header[2].Y = 1
Header[3].X = al_strGroupBox.width - 1
Header[3].Y = il_newHeight + 7
Header[4].X = 2 
Header[4].Y = il_newHeight + 7
		
// Set the colors in the first corner (top left)
of_SplitRGB (al_strGroupBox.gradient1, ll_Red, ll_Green, ll_Blue)
Corner[1].Red = ll_Red
Corner[1].Green = ll_Green
Corner[1].Blue = ll_Blue
	
// Set the colors in the third corner (bottom right)
of_SplitRGB (al_strGroupBox.gradient2, ll_Red, ll_Green, ll_Blue)
Corner[3].Red = ll_Red
Corner[3].Green = ll_Green
Corner[3].Blue = ll_Blue
	
//Create Polygon
hRPen = CreatePen(0,0,al_strGroupBox.bordercolor)
SelectObject(il_HDC, hRPen)
hRgn = CreateRoundRectRgn( Corner[1].X, Corner[1].Y, Corner[3].X, Corner[3].Y,7,7)
RoundRect( il_HDC, Corner[1].X - 1, Corner[1].Y - 1, Corner[3].X, Corner[3].Y,10,10)
	
SelectClipRgn(il_HDC, hRgn)
	
//Gradient Fill
IF al_strGroupBox.gradientdirection = 'H' THEN
	GradientRectangle (il_HDC, Corner, 4, l_Gradient, 1, GRADIENT_FILL_RECT_H)
ELSE
	GradientRectangle (il_HDC, Corner, 4, l_Gradient, 1, GRADIENT_FILL_RECT_V)
END IF

DeleteObject(hRPen)
DeleteObject(hRgn)

//Draw Header****************************
IF al_strGroupBox.style = 1 THEN
	// Set the colors in the first corner (top left)
	of_SplitRGB (al_strGroupBox.headercolor1, ll_Red, ll_Green, ll_Blue)
	Header[1].Red = ll_Red
	Header[1].Green = ll_Green
	Header[1].Blue = ll_Blue
		
	// Set the colors in the third corner (bottom right)
	of_SplitRGB (al_strGroupBox.headercolor2, ll_Red, ll_Green, ll_Blue)
	Header[3].Red = ll_Red
	Header[3].Green = ll_Green
	Header[3].Blue = ll_Blue
		
	//Create Polygon
	//hRPen = CreatePen(0,0,al_strGroupBox.bordercolor)
	//SelectObject(il_HDC, hRPen)
	hRgn = CreateRoundRectRgn( Header[1].X, Header[1].Y, Header[3].X, Header[3].Y,7,7)
	RoundRect( il_HDC, Header[1].X - 1, Header[1].Y - 1, Header[3].X, Header[3].Y,10,10)
		
	SelectClipRgn(il_HDC, hRgn)
		
	//Gradient Fill
	GradientRectangle (il_HDC, Header, 4, l_Gradient, 1, GRADIENT_FILL_RECT_V)
	
	//DeleteObject(hRPen)
	DeleteObject(hRgn)
END IF
//***************************************

SelectClipRgn(il_HDC, 0)
	
DeleteObject(hRPen)
DeleteObject(hRgn)

IF al_strGroupBox.bold THEN
	lb_bold = TRUE
ELSE
	lb_bold = FALSE
END IF

IF al_strGroupBox.Image = 0 THEN
	ll_textx = 14
	ll_regionx = 12
ELSE
	ll_textx = 32
	ll_regionx = 26
END IF

IF al_strGroupBox.style = 0 THEN
	ll_texty = 0
	ll_imagey = il_newHeight / 2 - 8
ELSE
	ll_texty = 3
	ll_imagey = ((il_newHeight + 7 - 16) / 2)
END IF

IF al_strGroupBox.style = 0 THEN
	hRgn = CreateRectRgn (ll_regionx , 4 , il_newWidth + ll_textx + 2 , il_newHeight )
	hRPen = CreatePen(0,0,al_strGroupBox.backcolor)
	FillRgn (il_HDC, hRgn , hRPen )
	DeleteObject(hRPen)
	DeleteObject(hRgn)
END IF

of_DrawText(ado_palette, &
				ll_textx, ll_texty)
	

ImageList_DrawEx(al_strGroupBox.Image, &
				  0, &
				  il_HDC, &
				  12, &
				  ll_imagey, &
				  16,16, &
				  0, 0, ILD_TRANSPARENT )
	
	
RETURN 1
end function

public function unsignedlong of_createfont ();LogFont lstr_Lf
uLong lul_Font

lstr_Lf.lffacename = istrgroupbox.FontFamily
lstr_Lf.lfweight = 400
lstr_Lf.lfheight = istrgroupbox.FontSize * -1
lstr_Lf.lfPitchAndFamily = '1'
lstr_Lf.lfClipPrecision = Char(2)
lstr_Lf.lfOutPrecision = Char(1)
lstr_Lf.lfQuality = Char(1)
lstr_Lf.lfCharset = Char(1)

IF istrgroupbox.underline THEN
	lstr_Lf.lfunderline = Char(1)
END IF

IF istrgroupbox.italics THEN
	lstr_Lf.lfitalic = Char(1)
END IF

IF istrgroupbox.strikeout THEN
	lstr_Lf.lfstrikeout = Char(1)
END IF

iul_font = CreateFontIndirect( lstr_Lf )
lstr_Lf.lfweight = 700
iul_fontbold = CreateFontIndirect( lstr_Lf )

RETURN 1
end function

public function integer of_drawtext (graphicobject ado_palette, long al_x, long al_y);Long	ll_Red, &
		ll_Green, &
		ll_Blue, &
		ll_DC, ll_parm, ll_sizeparm
GRADIENT_RECT l_Gradient[1]
RECT l_Rect, l_Rectback

LONG hRPen

IF Len(Trim(istrgroupbox.Text)) = 0 THEN
	RETURN 0
END IF


ll_DC = il_HDC

of_CreateFont()

IF istrgroupbox.bold THEN
	SelectObject(ll_DC, iul_fontbold)
ELSE
	SelectObject(ll_DC, iul_font)
END IF

ll_parm = DT_CALCRECT

// Position
l_Rect.Left = al_x
l_Rect.Top = al_y
l_Rect.Right = 0
l_Rect.Bottom = 0

SetTextColor(ll_DC, istrgroupbox.FontColor)

Drawtext(ll_DC, istrgroupbox.Text, LEN(istrgroupbox.Text), l_Rect, ll_parm)

Drawtext(ll_DC, istrgroupbox.Text, LEN(istrgroupbox.Text), l_Rect, ll_sizeparm)

DeleteObject(iul_font)
DeleteObject(iul_fontbold)

RETURN 1
end function

public function integer of_gettextsize (graphicobject ado_palette);Long	ll_Red, &
		ll_Green, &
		ll_Blue, &
		ll_DC, ll_parm, ll_sizeparm
GRADIENT_RECT l_Gradient[1]
RECT l_Rect, l_Rectback

LONG hRPen

IF Len(Trim(istrgroupbox.Text)) = 0 THEN
	RETURN 0
END IF

ll_DC = il_HDC

of_CreateFont()

IF istrgroupbox.bold THEN
	SelectObject(ll_DC, iul_fontbold)
ELSE
	SelectObject(ll_DC, iul_font)
END IF

ll_parm = DT_CALCRECT

SetBkMode(ll_DC, 1)

/*-------------------------------------------------------------------
	Normal text
-------------------------------------------------------------------*/
// Position
l_Rect.Left = 0
l_Rect.Top = 0
l_Rect.Right = 0
l_Rect.Bottom = 0

SetTextColor(ll_DC, istrgroupbox.FontColor)

Drawtext(ll_DC, istrgroupbox.Text, LEN(istrgroupbox.Text), l_Rect, ll_parm)

il_newHeight = l_Rect.Bottom
il_newWidth = l_Rect.Right

DeleteObject(iul_font)
DeleteObject(iul_fontbold)

RETURN 1
end function

on n_cst_groupbox_gradient.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_groupbox_gradient.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


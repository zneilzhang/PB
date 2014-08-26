HA$PBExportHeader$u_cst_shortcutitem.sru
forward
global type u_cst_shortcutitem from u_cst_canvas
end type
type lv_imagelistlarge from listview within u_cst_shortcutitem
end type
type lv_imagelistsmall from listview within u_cst_shortcutitem
end type
end forward

global type u_cst_shortcutitem from u_cst_canvas
integer width = 581
integer height = 106
long backcolor = 67108864
string pointer = "HyperLink!"
event clicked pbm_lbuttonup
event mousewithin pbm_mousemove
event mouseenter ( )
event mouseleave ( )
event resize pbm_size
lv_imagelistlarge lv_imagelistlarge
lv_imagelistsmall lv_imagelistsmall
end type
global u_cst_shortcutitem u_cst_shortcutitem

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function boolean ImageList_Draw(ulong himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"

Function Ulong SetROP2 ( uLong hdc , uLong nDrawMode ) Library "gdi32.dll" 

Function uLong GetColorAdjustment (uLong hdc , ref coloradjustment mystructure) Library "gdi32.dll" 
Function uLong SetColorAdjustment (uLong	hdc , ref coloradjustment mystructure) Library "gdi32.dll" 
Function ULong StretchBlt (Long hdc,Long x2, Long y2, Long nWidth, Long nHeight, Long hSrcDC, Long xSrc, Long ySrc, Long nSrcWidth, Long nSrcHeight,Long dwRop) Library "gdi32.dll"
Function ULong SetStretchBltMode (Long hdc, Long nStretchMode) Library "gdi32.dll"
Function Ulong	GetStretchBltMode (Long hdc) Library "gdi32.dll"
end prototypes

type variables
Boolean ib_selected
Boolean ib_used
Boolean ib_mousecaptured
Boolean ib_DisplayCloseButton = FALSE
Boolean ib_Enabled = TRUE

Long il_BorderColor

Long il_dc
ULong il_imagelistsmall, il_imagelistlarge

String is_image
String is_text

n_cst_shortcutbar_gradient	in_gradient

u_cst_shortcutbar iuo_parent

DragObject iuo_object

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0

// for color adjustment
coloradjustment mystructure1

n_cst_imagelist inv_imagelist
end variables

forward prototypes
public function integer of_setparent (u_cst_shortcutbar auo_parent)
public function integer of_settext (string as_text)
public function string of_gettext ()
public function integer of_position (long al_x, long al_y, long al_width, long al_height)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function string of_getimage ()
public function integer of_setimage (string as_image)
public function integer of_drawtext ()
public function integer of_drawpattern ()
public function integer of_drawimage (long ahdc)
public function integer of_setsize (long al_size)
public function boolean of_enabled (boolean ab_enabled)
public function integer of_drawdisabled (long ahdc)
public function integer of_drawclosebutton (long al_color)
end prototypes

event clicked;IF xpos > THIS.Width - 120 AND ypos < THIS.Height - 65 AND ib_displayclosebutton THEN
	iuo_parent.of_HideItem(is_text)
ELSE
	iuo_parent.of_SetSelected(THIS)
END IF
end event

event mousewithin;

if NOT of_ismousecaptured() then 
	
	of_capturemouse()
	
	this.event mouseenter()
		
else
	
	if xpos < 0 or ypos < 0 or xpos > width or ypos > height then
	
		of_releasemouse()
		
		this.event post mouseleave()
		
	end if

end if

IF ib_mousecaptured AND ib_DisplayCloseButton THEN
	SetRedraw(TRUE)
END IF
end event

event mouseenter();SetRedraw(TRUE)//TriggerEvent("paint")
end event

event mouseleave();SetRedraw(TRUE)//TriggerEvent("paint")
end event

public function integer of_setparent (u_cst_shortcutbar auo_parent);iuo_parent = auo_parent

RETURN 1
end function

public function integer of_settext (string as_text);//st_text.Text = as_text
is_Text = as_text


RETURN 1
end function

public function string of_gettext ();RETURN is_text//st_text.Text
end function

public function integer of_position (long al_x, long al_y, long al_width, long al_height);iuo_object.Move(al_x, al_y)
iuo_object.Resize(al_width, al_height)

RETURN 1
end function

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

public function string of_getimage ();RETURN is_image//p_1.PictureName
end function

public function integer of_setimage (string as_image);is_image = as_image

IF Len(Trim(is_image)) > 0 THEN
	lv_imagelistsmall.AddLargePicture ( is_image )
	lv_imagelistlarge.AddLargePicture ( is_image )
END IF

il_imagelistsmall = Send(Handle(lv_imagelistsmall), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)
il_imagelistlarge = Send(Handle(lv_imagelistlarge), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)

//inv_ImageList.of_AddImage(is_image)
//
//il_imagelistsmall = inv_ImageList.of_GetImageList(inv_ImageList.SMALL)
//il_imagelistlarge = inv_ImageList.of_GetImageList(inv_ImageList.MEDIUM)
//
RETURN 1
end function

public function integer of_drawtext ();//in_Gradient.of_DrawText(THIS, is_text, iuo_parent.of_GetColor('ITEMTEXT'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 130, 36, Width - 120, 64, iuo_parent.of_ShadowText()) 
IF iuo_parent.il_CurrentSize = iuo_parent.SMALL THEN
	in_Gradient.of_DrawText(THIS, is_text, iuo_parent.of_GetColor('ITEMTEXT'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 130, 36, Width - 120, 64,iuo_parent.of_ShadowText()) 
ELSE
	in_Gradient.of_DrawText(THIS, is_text, iuo_parent.of_GetColor('ITEMTEXT'), 'Tahoma', 11, TRUE, in_Gradient.ALIGN_LEFT, 160, 40, Width - 120, 64,iuo_parent.of_ShadowText()) 
END IF

RETURN 1
end function

public function integer of_drawpattern ();//CHOOSE CASE iuo_parent.of_GetPattern()
//	CASE iuo_parent.NOPATTERN
//		//
//	CASE iuo_parent.SOLIDCIRCLE
//		in_Gradient.of_DrawPattern(THIS, 'l',iuo_parent.of_GetColor('BACKCOLOR1'),'wingdings', 12, Width, Height)
//	CASE iuo_parent.HOLLOWCIRCLE
//		in_Gradient.of_DrawPattern(THIS, 'm',iuo_parent.of_GetColor('BACKCOLOR1'),'wingdings', 12, Width, Height)
//	CASE iuo_parent.SOLIDSQUARE
//		in_Gradient.of_DrawPattern(THIS, 'n',iuo_parent.of_GetColor('BACKCOLOR1'),'wingdings', 12, Width, Height)
//	CASE iuo_parent.HOLLOWSQUARE
//		in_Gradient.of_DrawPattern(THIS, 'o',iuo_parent.of_GetColor('BACKCOLOR1'),'wingdings', 12, Width, Height)
//	CASE iuo_parent.STAR
//		in_Gradient.of_DrawPattern(THIS, 'i',iuo_parent.of_GetColor('BACKCOLOR1'),'wingdings', 12, Width, Height)
//	CASE iuo_parent.WAVE
//		in_Gradient.of_DrawPattern(THIS, '$$HEX1$$b000$$ENDHEX$$',iuo_parent.of_GetColor('BACKCOLOR1'),'terminal', 12, Width, Height)
//	CASE iuo_parent.BAR
//		in_Gradient.of_DrawPattern(THIS, '$$HEX1$$ba00$$ENDHEX$$',iuo_parent.of_GetColor('BACKCOLOR1'),'terminal', 12, Width, Height)
//	CASE iuo_parent.DIAMOND
//		in_Gradient.of_DrawPattern(THIS, '$$HEX1$$b300$$ENDHEX$$',iuo_parent.of_GetColor('BACKCOLOR1'),'wingdings 2', 12, Width, Height)
//END CHOOSE
//		

RETURN 1
end function

public function integer of_drawimage (long ahdc);//ImageList_Draw(il_imagelist, 0, ahdc, UnitsToPixels(30, XUnitsToPixels!), UnitsToPixels(30, YUnitsToPixels!), ILD_TRANSPARENT )
IF iuo_parent.il_CurrentSize = iuo_parent.SMALL THEN
	ImageList_Draw(il_imagelistsmall, 0, ahdc, UnitsToPixels(30, XUnitsToPixels!), UnitsToPixels(30, YUnitsToPixels!), ILD_TRANSPARENT )
ELSE // PICTURE SIZE IS 24
	ImageList_Draw(il_imagelistlarge, 0, ahdc, UnitsToPixels(30, XUnitsToPixels!), UnitsToPixels(20, YUnitsToPixels!), ILD_TRANSPARENT )
END IF	

RETURN 1
end function

public function integer of_setsize (long al_size);CHOOSE CASE al_size
	CASE iuo_parent.SMALL
		THIS.Height = 122
	CASE iuo_parent.LARGE
		THIS.Height = 134
END CHOOSE

RETURN 1
end function

public function boolean of_enabled (boolean ab_enabled);ib_enabled = ab_enabled

Return ib_enabled
end function

public function integer of_drawdisabled (long ahdc);// Created by Serge Samson on Nov 06, 2006
Integer	li_counter

// we need to apply this twice to have a nicer fade effect
FOR li_counter = 0 to 2
	
	GetColorAdjustment (ahdc , mystructure1)

	// There is several potential 
	mystructure1.caBrightness 		= +100	//+60	// +80	// +100
	mystructure1.caColorfulness 	= -10		//-40 // -30		// -10
	mystructure1.caContrast 		= -34		//-10 // -14		// - 34
	
	// Can also be used for diff. effects
//	mystructure1.caredgreentint	 = +20
//	mystructure1.caIlluminantIndex = 1
//	mystructure1.careferencewhite = 0
//	mystructure1.careferenceblack	= -20
//	
	IF GetStretchBltMode(ahdc) <> 4 THEN
		SetStretchBltMode (ahdc, 4)
	ELSE
		SetStretchBltMode (ahdc, 3)
	END IF
	
	SetColorAdjustment (ahdc , mystructure1)
		
	StretchBlt (ahdc,1, 1, UnitsToPixels(THIS.Width, XUnitsToPixels!) - 2, THIS.Height, ahdc, 1,1,UnitsToPixels(THIS.Width, XUnitsToPixels!) - 2, THIS.Height, 13369376)
Next

Return 1
end function

public function integer of_drawclosebutton (long al_color);// added by Serge Samson on Nov, 6, 2006

in_Gradient.of_DrawText(THIS, 'r', al_color, 'Marlett', 10, TRUE, in_Gradient.ALIGN_LEFT, Width - 80, 20, Width - 120, 64,FALSE) 

RETURN 1
end function

on u_cst_shortcutitem.create
int iCurrent
call super::create
this.lv_imagelistlarge=create lv_imagelistlarge
this.lv_imagelistsmall=create lv_imagelistsmall
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lv_imagelistlarge
this.Control[iCurrent+2]=this.lv_imagelistsmall
end on

on u_cst_shortcutitem.destroy
call super::destroy
destroy(this.lv_imagelistlarge)
destroy(this.lv_imagelistsmall)
end on

event constructor;THIS.Height = 122
end event

event onpaint;call super::onpaint;
in_Gradient.of_SetHDC(hdc)
IF ib_selected THEN
	IF ib_mousecaptured THEN
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("HOVERSELECTED1"), iuo_parent.of_GetColor("HOVERSELECTED2"), THIS,TRUE,iuo_parent.of_GetColor("BORDER"), iuo_parent.of_GetStyle())
	ELSE
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("SELECTED1"), iuo_parent.of_GetColor("SELECTED2"), THIS,TRUE,iuo_parent.of_GetColor("BORDER"), iuo_parent.of_GetStyle())
	END IF 
ELSE
	IF ib_mousecaptured THEN
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("HOVER1"), iuo_parent.of_GetColor("HOVER2"), THIS,TRUE,iuo_parent.of_GetColor("BORDER"), iuo_parent.of_GetStyle())
	ELSE
		in_Gradient.of_VerticalGradient (iuo_parent.of_GetColor("BACKCOLOR1"), iuo_parent.of_GetColor("BACKCOLOR2"), THIS,TRUE,iuo_parent.of_GetColor("BORDER"), iuo_parent.of_GetStyle())
		of_DrawPattern()
	END IF

END IF

of_DrawImage(hdc)
of_DrawText()

IF ib_enabled = FALSE THEN 
	of_DrawDisabled(hdc)
ELSE
	IF ib_mousecaptured AND ib_DisplayCloseButton THEN
		
		IF PointerX() > THIS.Width - 120 AND PointerY() < THIS.Height - 65 THEN
			of_DrawCloseButton(iuo_parent.of_GetColor("BORDER"))
		ELSE
			of_DrawCloseButton(iuo_parent.of_GetColor("SELECTED2"))
		END IF
	END IF
END IF


RETURN 0

end event

type lv_imagelistlarge from listview within u_cst_shortcutitem
boolean visible = false
integer x = 421
integer y = 77
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

event constructor;THIS.LargePictureHeight = 24
THIS.LargePictureWidth = 24
end event

type lv_imagelistsmall from listview within u_cst_shortcutitem
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
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type


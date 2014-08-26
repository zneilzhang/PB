HA$PBExportHeader$u_cst_xplistbaritem.sru
forward
global type u_cst_xplistbaritem from u_cst_canvas
end type
type st_1 from statictext within u_cst_xplistbaritem
end type
type lv_imagelist from listview within u_cst_xplistbaritem
end type
type size from structure within u_cst_xplistbaritem
end type
end forward

type size from structure
	long		cx
	long		cy
end type

global type u_cst_xplistbaritem from u_cst_canvas
integer height = 68
string pointer = "HyperLink!"
event mouseenter ( )
event mouseleave ( )
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
st_1 st_1
lv_imagelist lv_imagelist
end type
global u_cst_xplistbaritem u_cst_xplistbaritem

type prototypes
Function ulong SetCapture(ulong hWnd) Library "USER32.DLL"
Function BOOLEAN ReleaseCapture() Library "USER32.DLL"
Function boolean ImageList_Draw(long himl, long i, long hdcDst, long lx, long ly, ulong fStyle) Library "comctl32.dll"
FUNCTION long GetDC (ulong hWnd) Library "USER32.DLL"
FUNCTION int ReleaseDC (ulong hWnd, ulong hDC) Library "USER32.DLL"
end prototypes

type variables
n_cst_xplistbar_gradient in_Gradient

u_cst_xplistbargroup iuo_parent
DragObject iuo_object

Boolean ib_used
Boolean ib_selected
Boolean ib_mousecaptured

String is_text
String is_image

Long il_imagelistsmall
Long il_style

Long il_height = 64

CONSTANT Long ILD_TRANSPARENT = 1
CONSTANT Long LVM_GETIMAGELIST = 4098
CONSTANT Long LVSIL_NORMAL = 0

// this will hold the index if the item type is LINK (1) which will be passed as additional parameter 
// to itemselected event of the last parent (u_cst_xplistbar), with this we will be able to obtain the
// correct DATA attribute of each link from u_cst_xplistbar.
Long	il_link_idx
end variables

forward prototypes
public function integer of_setparent (u_cst_xplistbargroup auo_parent)
public function integer of_settext (string as_text)
public function integer of_setimage (string as_image)
public function integer of_capturemouse ()
public function boolean of_ismousecaptured ()
public function integer of_releasemouse ()
public function integer of_drawline ()
public function String of_gettext ()
public function integer of_gettextsize (string as_text)
end prototypes

event mouseenter();SetRedraw(TRUE)
end event

event mouseleave();SetRedraw(TRUE)
end event

event mousemove;IF il_style = iuo_parent.iuo_parent.Link THEN
	if NOT of_ismousecaptured() then 
		
		of_capturemouse()
		
		this.event mouseenter()
			
	else
		
		if xpos < 0 or ypos < 0 or xpos > width or ypos > height OR &
			(iuo_parent.iuo_parent.PointerY() < iuo_parent.iuo_parent.uo_scrolldown.Height) OR &
			(iuo_parent.iuo_parent.PointerY() > iuo_parent.iuo_parent.uo_scrolldown.Y) then
		
			of_releasemouse()
			
			this.event post mouseleave()
			
		end if
		
	end if
END IF
end event

event lbuttonup;

Long	l_link_idx

// check if style is link then assign the link index;
// otherwise set it to 0
IF this.il_style = iuo_parent.iuo_parent.LINK THEN
	l_link_idx = il_link_idx
ELSE
	l_link_idx = 0
END IF

iuo_parent.iuo_parent.Trigger Dynamic Event itemselected ( iuo_parent.of_GetText(),  is_text, l_link_idx)

end event

public function integer of_setparent (u_cst_xplistbargroup auo_parent);iuo_parent = auo_parent
	
RETURN 1
end function

public function integer of_settext (string as_text);is_text = as_text

RETURN 1
end function

public function integer of_setimage (string as_image);is_image = as_image

lv_imagelist.DeleteLargePictures ( )

IF Len(Trim(is_image)) > 0 THEN
	lv_imagelist.AddLargePicture ( is_image )
END IF

il_imagelistsmall = Send(Handle(lv_imagelist), LVM_GETIMAGELIST, LVSIL_NORMAL, 0)


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

public function integer of_drawline ();Long ll_x1, ll_x2, ll_y1, ll_y2

ll_x1 = 50
ll_y1 = Height / 2 + 5
ll_x2 = Width - 40
ll_y2 = ll_y1

in_Gradient.of_DrawLine(ll_x1, ll_y1, ll_x2, ll_y2, iuo_parent.iuo_parent.of_GetColor('LINE'))

RETURN 1

end function

public function String of_gettext ();RETURN is_text
end function

public function integer of_gettextsize (string as_text);ULong lul_Handle, lul_hDC, lul_hFont
SIZE lstr_size
long ll_x
n_cst_xplistbar_gradient lnv_gradient

IF is_image = '' THEN
	ll_x = 60
ELSE
	ll_x = 160
END IF

lul_Handle = Handle(st_1)
lul_hDC = GetDC(lul_Handle)

lnv_gradient.of_SetHdc(lul_hDC)
lnv_gradient.of_DrawText(THIS, as_text, 0, 'Tahoma', 11, FALSE, lnv_gradient.ALIGN_LEFT, ll_x, 10, Width - 60, il_height,FALSE, FALSE, false, TRUE) 

ReleaseDC(lul_Handle, lul_hDC)

il_height = lnv_gradient.il_NewHeight
Height = lnv_gradient.il_NewHeight + 4

RETURN 1
end function

on u_cst_xplistbaritem.create
int iCurrent
call super::create
this.st_1=create st_1
this.lv_imagelist=create lv_imagelist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.lv_imagelist
end on

on u_cst_xplistbaritem.destroy
call super::destroy
destroy(this.st_1)
destroy(this.lv_imagelist)
end on

event onpaint;call super::onpaint;Long ll_color, ll_selcolor, ll_x
Boolean lb_underline

IF IsValid(iuo_parent) THEN
	IF IsValid(iuo_parent.iuo_parent) THEN

		CHOOSE CASE il_style
			CASE iuo_parent.iuo_parent.LINK
				ll_color = iuo_parent.iuo_parent.of_GetColor('ITEMTEXT')
				ll_selcolor = iuo_parent.iuo_parent.of_GetColor('ITEMTEXTSELECTED')
				lb_underline = TRUE
			CASE iuo_parent.iuo_parent.LABEL
				ll_color = 0
				ll_selcolor = 0
				lb_underline = FALSE
		END CHOOSE
		
		in_Gradient.of_SetHDC(hdc)
		in_Gradient.of_HorizontalGradient(iuo_parent.iuo_parent.of_GetColor('ITEMBACK1'), iuo_parent.iuo_parent.of_GetColor('ITEMBACK2'), THIS, FALSE)
		
		IF is_image = '' THEN
			ll_x = 60
		ELSE
			ll_x = 160
			ImageList_Draw(il_imagelistsmall, 0, hdc, UnitsToPixels(60, XUnitsToPixels!), UnitsToPixels(2, YUnitsToPixels!), ILD_TRANSPARENT )
		END IF
		
		IF ib_mousecaptured THEN
			in_Gradient.of_DrawText(THIS, is_text, ll_selcolor, 'Tahoma', 11, FALSE, in_Gradient.ALIGN_LEFT, ll_x, 10, Width - 60, il_height,FALSE, FALSE, lb_underline, TRUE) 
		ELSE
			in_Gradient.of_DrawText(THIS, is_text, ll_color, 'Tahoma', 11, FALSE, in_Gradient.ALIGN_LEFT, ll_x, 10, Width - 60, il_height,FALSE, FALSE, FALSE, TRUE) 

		END IF
		
//		IF in_Gradient.il_NewHeight + 4 <> Height AND &
//		   (il_style = iuo_parent.iuo_parent.LABEL OR il_style = iuo_parent.iuo_parent.LINK)THEN
//			il_height = in_Gradient.il_NewHeight
//			Height = in_Gradient.il_NewHeight + 4
//			iuo_parent.of_Reorganize()
//		END IF
		
		IF il_style = iuo_parent.iuo_parent.LINE THEN
			of_DrawLine()
		END IF
		
	END IF
END IF

RETURN 0
end event

type st_1 from statictext within u_cst_xplistbaritem
boolean visible = false
integer x = 151
integer y = 16
integer width = 411
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type lv_imagelist from listview within u_cst_xplistbaritem
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
long smallpicturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type


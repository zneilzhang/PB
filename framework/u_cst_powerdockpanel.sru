HA$PBExportHeader$u_cst_powerdockpanel.sru
forward
global type u_cst_powerdockpanel from userobject
end type
type uo_panelheader from u_cst_powerdockpanelheader within u_cst_powerdockpanel
end type
type uo_paneltoolbarstrip from u_cst_toolbarstrip within u_cst_powerdockpanel
end type
type st_1 from statictext within u_cst_powerdockpanel
end type
type uo_paneltabcontrol from u_cst_tabcontrol within u_cst_powerdockpanel
end type
end forward

global type u_cst_powerdockpanel from userobject
integer width = 846
integer height = 460
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize pbm_size
uo_panelheader uo_panelheader
uo_paneltoolbarstrip uo_paneltoolbarstrip
st_1 st_1
uo_paneltabcontrol uo_paneltabcontrol
end type
global u_cst_powerdockpanel u_cst_powerdockpanel

type prototypes
FUNCTION boolean ScreenToClient(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
FUNCTION boolean GetCursorPos(ref POINT lpPoint) Library "USER32.DLL"
FUNCTION ulong ChildWindowFromPoint(ulong hWnd, ref POINT lpPoint) Library "USER32.DLL"
end prototypes

type variables
Boolean #Docked
Long #Orientation

CONSTANT LONG TOP = 1
CONSTANT LONG BOTTOM = 2
CONSTANT LONG LEFT = 3
CONSTANT LONG RIGHT = 4

Boolean ib_headerclicked

Long ll_width = 800
Long ll_height = 500

powerdockitems str_items[]

u_cst_powerdock iuo_parent
n_cst_powerdocktiming inv_timer

Long il_clickedx, il_clickedy

String is_entered
end variables

forward prototypes
public function integer of_dock ()
public function integer of_undock ()
public function integer of_additem (ref userobject uo_object, string as_text, string as_image)
public function integer of_settheme (long al_color)
public function integer of_hide ()
public function integer of_expand ()
public function integer of_removeitem (userobject uo_object)
public function userobject of_currentobject ()
public function long of_getitemcount ()
public function string of_getimage (userobject uo_object)
public function string of_gettext (userobject uo_object)
public function integer of_autohide ()
public function integer of_setfocus (integer al_index)
public function integer of_closeitem (userobject uo_object)
public function integer of_collapse ()
public function integer of_setfocus (userobject uo_object)
public function integer of_expand (boolean ab_pinned)
end prototypes

event resize;Long ll_x, ll_y

SetRedraw(FALSE)

CHOOSE CASE #Orientation
	CASE LEFT 
		uo_paneltoolbarstrip.Height = Height
	CASE RIGHT
		uo_paneltoolbarstrip.Height = Height
		uo_paneltoolbarstrip.X = Width - uo_paneltoolbarstrip.Width
	CASE TOP
		uo_paneltoolbarstrip.Width = Width
	CASE BOTTOM
		uo_paneltoolbarstrip.Width = Width
		uo_paneltoolbarstrip.Y = Height - uo_paneltoolbarstrip.Height
END CHOOSE

IF #Docked THEN
	ll_width = Width
	ll_height = Height
	CHOOSE CASE #Orientation
		CASE LEFT
			uo_paneltabcontrol.Move(0,uo_panelheader.Height)
			uo_panelheader.X = 0
		CASE RIGHT, BOTTOM
			uo_paneltabcontrol.Move(0,uo_panelheader.Height)
		CASE TOP			
			uo_paneltabcontrol.Move(0,0)
			uo_panelheader.Y = Height - uo_panelheader.Height
	END CHOOSE
	
	uo_paneltabcontrol.Resize(Width, Height - uo_panelheader.Height)
	uo_panelheader.Width = Width
ELSE
	
	CHOOSE CASE #Orientation
		CASE LEFT
			uo_paneltabcontrol.Move(uo_paneltoolbarstrip.Width,uo_panelheader.Height)
			uo_paneltabcontrol.Resize(Width - uo_paneltoolbarstrip.Width, Height - uo_panelheader.Height)
			uo_panelheader.Width = Width - uo_paneltoolbarstrip.Width
			uo_panelheader.X = uo_paneltoolbarstrip.Width
		CASE RIGHT
			uo_paneltabcontrol.Move(0,uo_panelheader.Height)
			uo_paneltabcontrol.Resize(Width - uo_paneltoolbarstrip.Width, Height - uo_panelheader.Height)
			uo_panelheader.Width = Width - uo_paneltoolbarstrip.Width
		CASE TOP
			uo_paneltabcontrol.Move(0,uo_paneltoolbarstrip.Height)
			uo_paneltabcontrol.Resize(Width, Height - uo_paneltoolbarstrip.Height - uo_panelheader.Height)
			uo_panelheader.Y = Height - uo_panelheader.Height
			uo_panelheader.Width = Width
		CASE BOTTOM
			uo_paneltabcontrol.Move(0,uo_panelheader.Height)
			uo_paneltabcontrol.Resize(Width, Height - uo_paneltoolbarstrip.Height - uo_panelheader.Height)
			uo_panelheader.Width = Width

	END CHOOSE

END IF

SetRedraw(TRUE)
IF IsValid(iuo_parent) THEN iuo_parent.POST SetRedraw(TRUE)
end event

public function integer of_dock ();#Docked = TRUE
of_Expand(TRUE)
uo_paneltoolbarstrip.Hide()

IF uo_paneltabcontrol.of_GetTabCount() > 1 THEN
	uo_paneltabcontrol.of_ShowTabs()
END IF

THIS.TriggerEvent("Resize")

iuo_parent.iw_parent.POST SetFocus()

iuo_parent.Event PanelPinned(#Orientation)

RETURN 1
end function

public function integer of_undock ();IF #Docked THEN
	#Docked = FALSE
	of_collapse()
END IF

uo_paneltoolbarstrip.Show()
uo_paneltabcontrol.of_HideTabs()
iuo_parent.TriggerEvent("Resize")

iuo_parent.iw_parent.POST SetFocus()

iuo_parent.Event PanelUnPinned(#Orientation)

RETURN 1
end function

public function integer of_additem (ref userobject uo_object, string as_text, string as_image);Long ll_image
Long ll_tab
powerdockitems str_item

str_item.as_text = as_text
str_item.as_image = as_image
str_item.ado_object = uo_object
str_items[UpperBound(str_items) + 1] = str_item

IF Len(Trim(as_image)) > 0 THEN
	ll_image = uo_paneltabcontrol.of_AddImage(as_image)
END IF

ll_tab = uo_paneltabcontrol.of_OpenTab(uo_object, as_text, ll_image)
uo_paneltabcontrol.of_SelectTab(ll_tab)

uo_paneltoolbarstrip.of_AddItem(as_text, as_image)

uo_paneltoolbarstrip.of_DisplayText(TRUE)

IF uo_paneltabcontrol.of_GetTabCount() > 1 AND &
   #Docked THEN
	
	uo_paneltabcontrol.of_ShowTabs()
END IF

RETURN ll_tab
end function

public function integer of_settheme (long al_color);uo_paneltoolbarstrip.of_SetTheme(al_color)
uo_paneltabcontrol.of_SetTheme(al_color)
uo_panelheader.of_SetTheme(al_color)

RETURN 1
end function

public function integer of_hide ();POINT lp
ulong ll
ulong lul

IF of_GetItemCount() <= 0 THEN
	RETURN 0
END IF

lul = Handle(this)

GetCursorPos(lp)
Screentoclient(lul, lp)

IF lp.px < 0 OR lp.px > UnitsToPixels(this.width, XUnitsToPixels!) OR &
	lp.py < 0 OR lp.py > UnitsToPixels(this.height, YUnitsToPixels!) THEN
	
	IF inv_timer.Interval = .1 THEN
		inv_timer.Stop()
		inv_timer.Start(.75)
		RETURN 0
	END IF
	of_AutoHide()
	
	iuo_parent.iw_parent.POST SetFocus()
ELSE
	IF inv_timer.Interval = .75 THEN
		inv_timer.Stop()
		inv_timer.Start(.1)
		RETURN 0
	END IF
END IF

RETURN 1
end function

public function integer of_expand ();RETURN of_Expand(FALSE)
end function

public function integer of_removeitem (userobject uo_object);Long ll_index, ll_count, ll_newcount
powerdockitems str_newitems[]
boolean lb_found = FALSE
long ll_rc

ll_rc = 1

ll_count = UpperBound(str_items)

FOR ll_index = 1 TO ll_count
	IF str_items[ll_index].ado_object = uo_object THEN
		lb_found = TRUE
		uo_paneltabcontrol.of_RemoveTab(uo_object)
		uo_paneltoolbarstrip.of_RemoveItem(str_items[ll_index].as_text)
	ELSE
		ll_newcount++
		str_newitems[ll_newcount] = str_items[ll_index]
	END IF
NEXT

IF uo_paneltabcontrol.of_GetTabCount() > 0 THEN
	uo_paneltabcontrol.of_SelectTab(1)
END IF

IF uo_paneltabcontrol.of_GetTabCount() = 1 THEN
	uo_paneltabcontrol.of_HideTabs()
END IF

//  04/AGO/10	LEC Si es el ultimo oculta el espacio del panel
IF lb_found AND uo_paneltabcontrol.of_GetTabCount() = 0 THEN
	of_undock()
//	uo_paneltoolbarstrip.Hide()
	ll_rc = 2
END IF

str_items = str_newitems

iuo_parent.TriggerEvent("Resize")

RETURN ll_rc
end function

public function userobject of_currentobject ();RETURN uo_paneltabcontrol.of_GetObject(uo_paneltabcontrol.of_GetSelectedTab())
end function

public function long of_getitemcount ();RETURN uo_paneltabcontrol.of_GetTabCount()
end function

public function string of_getimage (userobject uo_object);Long ll_index, ll_count

ll_count = UpperBound(str_items)

FOR ll_index = 1 TO ll_count
	IF str_items[ll_index].ado_object = uo_object THEN
		RETURN str_items[ll_index].as_image
	END IF
NEXT

RETURN ""
end function

public function string of_gettext (userobject uo_object);Long ll_index, ll_count

ll_count = UpperBound(str_items)

FOR ll_index = 1 TO ll_count
	IF str_items[ll_index].ado_object = uo_object THEN
		RETURN str_items[ll_index].as_text
	END IF
NEXT


RETURN ""
end function

public function integer of_autohide ();inv_timer.Stop()

iuo_parent.SetRedraw(FALSE)

ll_width = Width
ll_height = Height

CHOOSE CASE #Orientation
	CASE LEFT
		Width = uo_paneltoolbarstrip.Width
	CASE RIGHT
		Width = uo_paneltoolbarstrip.Width
	CASE TOP, BOTTOM
		Height = uo_paneltoolbarstrip.Height
END CHOOSE

iuo_parent.TriggerEvent("Resize")

RETURN 1
end function

public function integer of_setfocus (integer al_index);RETURN uo_paneltabcontrol.of_SelectTab(al_index)
end function

public function integer of_closeitem (userobject uo_object);Long ll_index, ll_count, ll_newcount
Boolean lb_found
powerdockitems str_newitems[]

ll_count = UpperBound(str_items)

FOR ll_index = 1 TO ll_count
	IF str_items[ll_index].ado_object = uo_object THEN
		lb_found = TRUE
		uo_paneltabcontrol.of_CloseTab(uo_object)
		uo_paneltoolbarstrip.of_RemoveItem(str_items[ll_index].as_text)
	ELSE
		ll_newcount++
		str_newitems[ll_newcount] = str_items[ll_index]
	END IF
NEXT

IF lb_found THEN
	IF uo_paneltabcontrol.of_GetTabCount() > 0 THEN
		uo_paneltabcontrol.of_SelectTab(1)
	END IF
	
	IF uo_paneltabcontrol.of_GetTabCount() = 1 THEN
		uo_paneltabcontrol.of_HideTabs()
	END IF
	
	str_items = str_newitems
	
	iuo_parent.TriggerEvent("Resize")
END IF

RETURN 1
end function

public function integer of_collapse ();ll_width = Width
ll_height = Height

CHOOSE CASE #Orientation
	CASE LEFT
		Width = uo_paneltoolbarstrip.Width
	CASE RIGHT
		X = iuo_parent.Width - uo_paneltoolbarstrip.Width
		Width = uo_paneltoolbarstrip.Width
	CASE TOP
		Height = uo_paneltoolbarstrip.Height
	CASE BOTTOM
		Y = iuo_parent.Height - uo_paneltoolbarstrip.Height
		Height = uo_paneltoolbarstrip.Height
END CHOOSE

BringToTop = TRUE

RETURN 1
end function

public function integer of_setfocus (userobject uo_object);RETURN uo_paneltabcontrol.of_SelectTab(uo_object)
end function

public function integer of_expand (boolean ab_pinned);CHOOSE CASE #Orientation
	CASE LEFT
		Width = ll_width
	CASE RIGHT
		X = iuo_parent.Width - ll_width
		Width = ll_width
	CASE TOP
		Height = ll_height
	CASE BOTTOM
		Y = iuo_parent.Height - ll_height
		Height = ll_height
END CHOOSE

BringToTop = TRUE

IF NOT ab_pinned THEN
	iuo_parent.Event PanelExpanded(#Orientation)
END IF

RETURN 1
end function

on u_cst_powerdockpanel.create
this.uo_panelheader=create uo_panelheader
this.uo_paneltoolbarstrip=create uo_paneltoolbarstrip
this.st_1=create st_1
this.uo_paneltabcontrol=create uo_paneltabcontrol
this.Control[]={this.uo_panelheader,&
this.uo_paneltoolbarstrip,&
this.st_1,&
this.uo_paneltabcontrol}
end on

on u_cst_powerdockpanel.destroy
destroy(this.uo_panelheader)
destroy(this.uo_paneltoolbarstrip)
destroy(this.st_1)
destroy(this.uo_paneltabcontrol)
end on

event constructor;st_1.Hide()

inv_timer = CREATE n_cst_powerdocktiming
inv_timer.i_parent = THIS

uo_panelheader.iuo_parent = THIS 

uo_paneltabcontrol.of_HideCloseButton()
//uo_paneltabcontrol.of_SetStyle(uo_paneltabcontrol.EXCEL)
uo_paneltoolbarstrip.of_DisplaySolidBackground(TRUE)

CHOOSE CASE #Orientation
	CASE LEFT
		uo_paneltoolbarstrip.il_CurrentOrientation = 2
		uo_paneltabcontrol.of_SetTabPosition(uo_paneltabcontrol.BOTTOM)
	CASE RIGHT
		uo_paneltoolbarstrip.il_CurrentOrientation = 2
		uo_paneltabcontrol.of_SetTabPosition(uo_paneltabcontrol.BOTTOM)
	CASE TOP
		uo_paneltoolbarstrip.il_CurrentOrientation = 1
		uo_paneltabcontrol.of_SetTabPosition(uo_paneltabcontrol.TOP)
	CASE BOTTOM
		uo_paneltoolbarstrip.il_CurrentOrientation = 1
		uo_paneltabcontrol.of_SetTabPosition(uo_paneltabcontrol.BOTTOM)
END CHOOSE



IF #Docked THEN
	uo_paneltoolbarstrip.Hide()
ELSE
	uo_paneltabcontrol.of_HideTabs()
END IF

THIS.TriggerEvent("Resize")

end event

type uo_panelheader from u_cst_powerdockpanelheader within u_cst_powerdockpanel
integer height = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_panelheader.destroy
call u_cst_powerdockpanelheader::destroy
end on

event clicked;call super::clicked;Boolean lb_dock

IF NOT THIS.of_IsOverPin(xpos, ypos) THEN
	RETURN
END IF

lb_dock = NOT #Docked

PARENT.iuo_parent.SetRedraw(FALSE)

IF NOT lb_dock THEN
	inv_timer.Stop()
	of_UnDock()
ELSE
	inv_timer.Stop()
	of_Dock()
END IF

PARENT.iuo_parent.TriggerEvent("Resize")
POST SetFocus(PARENT.iuo_parent.iw_parent)
end event

event mousewithin;call super::mousewithin;IF KeyDown(KeyLeftButton!) AND ib_headerclicked AND #Docked AND &
   NOT THIS.of_IsOverPin(il_clickedx, il_clickedy) THEN
	IF Abs(il_clickedx - xpos) > 20 OR &
		Abs(il_clickedy - ypos) > 15 THEN
		PARENT.iuo_parent.of_ShowDocker(#Orientation)
	END IF
END IF
end event

event lbuttonup;call super::lbuttonup;ib_headerclicked = FALSE
end event

event lbuttondown;call super::lbuttondown;ib_headerclicked = TRUE

il_clickedx = xpos
il_clickedy = ypos
end event

type uo_paneltoolbarstrip from u_cst_toolbarstrip within u_cst_powerdockpanel
integer width = 160
integer height = 276
integer taborder = 10
boolean bringtotop = true
end type

on uo_paneltoolbarstrip.destroy
call u_cst_toolbarstrip::destroy
end on

event ue_mouseenter;call super::ue_mouseenter;Long ll_index, ll_count

is_entered = as_button

Time lt_now

lt_now = Now()

DO WHILE SecondsAfter ( lt_now, Now() ) < 1
	Yield()
LOOP

IF NOT IsValid(THIS) THEN
	RETURN
END IF

IF is_entered <> as_button THEN
	RETURN
END IF

ll_count = UpperBound(str_items)

FOR ll_index = 1 TO ll_count
	IF str_items[ll_index].as_text = as_button THEN
		IF uo_paneltabcontrol.of_GetObject(uo_paneltabcontrol.of_GetSelectedTab()) <> &
		   str_items[ll_index].ado_object THEN
			
			uo_paneltabcontrol.of_SelectTab(str_items[ll_index].ado_object)
		END IF
		
		iuo_parent.EVENT PanelObjectDisplayed(str_items[ll_index].ado_object)
	END IF
NEXT

PARENT.of_Expand()

uo_panelheader.of_SetText(as_button, uo_panelheader.LEFT)


inv_timer.Start(.1)
end event

event constructor;call super::constructor;THIS.of_DisplayBorder(TRUE)
end event

event ue_mouseleave;call super::ue_mouseleave;IF is_entered = as_button THEN
	is_entered = ''
END IF
end event

event ue_buttonclicked;call super::ue_buttonclicked;Event ue_mouseenter(as_button)
end event

type st_1 from statictext within u_cst_powerdockpanel
integer width = 5001
integer height = 5000
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
string text = "  PowerDockPanel"
boolean focusrectangle = false
end type

type uo_paneltabcontrol from u_cst_tabcontrol within u_cst_powerdockpanel
integer width = 562
integer height = 276
integer taborder = 20
end type

on uo_paneltabcontrol.destroy
call u_cst_tabcontrol::destroy
end on

event selectionchanging;call super::selectionchanging;uo_panelheader.of_SetText(of_GetText(newindex), uo_panelheader.LEFT)

iuo_parent.EVENT PanelObjectDisplayed(THIS.of_getobject(newindex))
end event


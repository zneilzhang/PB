HA$PBExportHeader$w_find.srw
$PBExportComments$Extension Find window
forward
global type w_find from pfc_w_find
end type
type dw_find_what from datawindow within w_find
end type
end forward

global type w_find from pfc_w_find
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda"
dw_find_what dw_find_what
end type
global w_find w_find

on w_find.create
int iCurrent
call super::create
this.dw_find_what=create dw_find_what
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_find_what
end on

on w_find.destroy
call super::destroy
destroy(this.dw_find_what)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////////////
// OVERRIDE
//////////////////////////////////////////////////////////////////////////////
// ADECUADO LAC
//	- Que ponga seleccionado por default el campo actual del requestor
//////////////////////////////////////////////////////////////////////////////
//
//	Event:  open
//
//	Arguments: none
//	
// Returns:  none
//
//	Description:  	This event is used to initialize the window using the 
//						passed in nvo-structure.
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//	6.0	Corrected clipping problems when lower controls not visible
//			Adjust resizing of window to accomodate help button
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
integer 	li_count=0
integer	li_i=0
integer	li_adjust=0
integer	li_windowHeightAdjust
integer	li_origWindowHeight

//LAC:
string	ls_campo_activo
integer	li_indice_default

li_windowHeightAdjust = 50
li_origWindowHeight = this.height

//Make a local copy of attributes.
inv_findattrib = message.powerobjectparm

//Allow window to close without the CloseQuery checks being performed.
ib_disableclosequery = True

//////////////////////////////////////////////////////////////////////////////
// Set the Enabled/Visible attributes for the appropriate controls.
//////////////////////////////////////////////////////////////////////////////

//The Whole Word control.
cbx_wholeword.Visible = inv_findattrib.ib_wholewordvisible
cbx_wholeword.Enabled = inv_findattrib.ib_wholewordenabled

//The Match Case control.
cbx_matchcase.Visible = inv_findattrib.ib_matchcasevisible
cbx_matchcase.Enabled = inv_findattrib.ib_matchcaseenabled

//The lookup controls.
ddlb_findwhere.Visible = inv_findattrib.ib_lookvisible
st_findwhere.Visible = inv_findattrib.ib_lookvisible
ddlb_findwhere.Enabled = inv_findattrib.ib_lookenabled
st_findwhere.Enabled = inv_findattrib.ib_lookenabled

//The direction controls.
ddlb_searchdirection.Visible = inv_findattrib.ib_directionvisible
st_searchdirection.Visible = inv_findattrib.ib_directionvisible
ddlb_searchdirection.Enabled = inv_findattrib.ib_directionenabled
st_searchdirection.Enabled = inv_findattrib.ib_directionenabled

//////////////////////////////////////////////////////////////////////////////
// Initialize controls with the appropriate data.
//////////////////////////////////////////////////////////////////////////////
//Set the lookup values.
If ddlb_findwhere.visible Then
	li_count = upperbound(inv_findattrib.is_lookdata)
	li_indice_default = 1
	if li_count >0  THEN 
		for li_i=1 TO li_count
			ddlb_findwhere.additem(inv_findattrib.is_lookdisplay[li_i])
			//LAC: Obtiene el $$HEX1$$ed00$$ENDHEX$$ndice de la columna seleccionada
			ls_campo_activo = inv_findattrib.idw_requestor.getcolumnname()
			if upper(ls_campo_activo) = upper(inv_findattrib.is_lookdata[li_i]) then li_indice_default = li_i
		next
	end if
	If inv_findattrib.ii_lookindex > 0 Then
		ddlb_findwhere.SelectItem(inv_findattrib.ii_lookindex)	
	Else
		ddlb_findwhere.SelectItem(li_indice_default)	
	End If
End If

//Set text to Find What.
sle_findwhat.text = inv_findattrib.is_find

//Set the WholeWord flag.
If cbx_wholeword.Visible Then
	cbx_wholeword.Checked = inv_findattrib.ib_wholeword
End If

//Set the MatchCase flag.
If cbx_matchcase.Visible Then
	cbx_matchcase.Checked = inv_findattrib.ib_matchcase
End If	

//Set the Direction attribute.
If ddlb_searchdirection.visible Then
	If Lower(inv_findattrib.is_direction)= 'arriba' Then
		ddlb_searchdirection.Text = 'Arriba'
	Else
		ddlb_searchdirection.Text = 'Abajo'
	End If
End If

//////////////////////////////////////////////////////////////////////////////
// Resize window and Move controls, if appropriate.
//////////////////////////////////////////////////////////////////////////////

//If the lookup controls are not visible, moving of other controls is required.
if ddlb_findwhere.visible = False then
	// calculate Y position to adjust.
	li_adjust = sle_findwhat.y - ddlb_findwhere.y

	// move other controls up.
	cbx_matchcase.y = cbx_matchcase.y - li_adjust
	cbx_wholeword.y = cbx_wholeword.y - li_adjust
	ddlb_searchdirection.y = ddlb_searchdirection.y - li_adjust
	sle_findwhat.y = sle_findwhat.y - li_adjust
	st_searchdirection.y = st_searchdirection.y - li_adjust
	st_searchfor.y = st_searchfor.y - li_adjust

	//Resize the window to match the adjustment
	this.height = this.height - li_windowHeightAdjust
	
	//Set focus on the appropriate control.
	sle_findwhat.SetFocus()	
end if

//If the wholeword is not visible, move the matchcase control.
If cbx_wholeword.visible = False and cbx_matchcase.Visible Then
	cbx_matchcase.Y = cbx_wholeword.Y

	// Only resize window height if not previously resized
	if this.height = li_origWindowHeight then
		this.height = this.height - li_windowHeightAdjust
	end if
End If

//If all bottom conrols are not visible, adjust the size of the window.
If ddlb_searchdirection.Visible=False And cbx_wholeword.visible = False And &
	cbx_matchcase.Visible= False Then

	// Only resize window height if not previously resized
	if this.height = li_origWindowHeight then
		this.height = this.height - li_windowHeightAdjust
	end if
End If
end event

event pfc_default();//////////////////////////////////////////////////////////////////////////////
// OVERRIDE
//////////////////////////////////////////////////////////////////////////////
//	Event: 			pfc_default
//	Arguments: 		None
//	Returns:  		None
//	Description:  Gather all information entered by the user and call event
// 					on requestor to search for the text
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
//						7.0	Set FindItem Start Index to 0
//////////////////////////////////////////////////////////////////////////////
//	Copyright $$HEX2$$a9002000$$ENDHEX$$1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////

//Set Find Where index (this index is the array number the user selected).
inv_findattrib.ii_lookindex = ddlb_findwhere.finditem(ddlb_findwhere.text,0)

//Set text to Find What.
inv_findattrib.is_find = sle_findwhat.text

//Set the Direction value.
inv_findattrib.is_direction = ddlb_searchdirection.text

//Set the WholeWord flag.
inv_findattrib.ib_wholeword = cbx_wholeword.Checked

//Set the MatchCase flag.
inv_findattrib.ib_matchcase = cbx_matchcase.Checked

//Call event to process.
If inv_findattrib.ipo_requestor.dynamic event pfc_findnext(inv_findattrib) = 0 Then
	of_Messagebox("pfc_find_finishsearch", this.Title, &
		"La b$$HEX1$$fa00$$ENDHEX$$squeda ha finalizado", Information!, OK!, 1)
end if

end event

type st_findwhere from pfc_w_find`st_findwhere within w_find
string text = "Buscar dentro de"
end type

type st_searchfor from pfc_w_find`st_searchfor within w_find
string text = "Buscar"
end type

type ddlb_findwhere from pfc_w_find`ddlb_findwhere within w_find
end type

type st_searchdirection from pfc_w_find`st_searchdirection within w_find
string text = "Direcci$$HEX1$$f300$$ENDHEX$$n"
end type

type cbx_wholeword from pfc_w_find`cbx_wholeword within w_find
string text = "Toda la palabra"
end type

type cbx_matchcase from pfc_w_find`cbx_matchcase within w_find
string text = "Coincidir may$$HEX1$$fa00$$ENDHEX$$sculas y min$$HEX1$$fa00$$ENDHEX$$sculas"
end type

type cb_findnext from pfc_w_find`cb_findnext within w_find
integer width = 430
string text = "&Buscar siguiente"
end type

type cb_cancel from pfc_w_find`cb_cancel within w_find
integer width = 430
string text = "&Cancelar"
end type

type sle_findwhat from pfc_w_find`sle_findwhat within w_find
integer y = 420
integer taborder = 0
end type

event sle_findwhat::constructor;call super::constructor;this.visible=false
end event

type ddlb_searchdirection from pfc_w_find`ddlb_searchdirection within w_find
string item[] = {"Abajo","Arriba"}
end type

type cb_dlghelp from pfc_w_find`cb_dlghelp within w_find
integer width = 430
string text = "&Ayuda"
end type

type dw_find_what from datawindow within w_find
integer x = 571
integer y = 172
integer width = 1047
integer height = 112
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_find_what"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;
//--------------------------------------
// DECLARACIONES LOCALES
//--------------------------------------
	LONG	ll_find
	LONG	ll_count_data
	STRING	ls_type
	STRING	ls_FIND
	STRING	ls_mask
	STRING	ls_data
	string   ls_expresion
	integer  li_posicion
//--------------------------------------
// C$$HEX1$$d300$$ENDHEX$$DIGO DE LA RUTINA
//--------------------------------------	
li_posicion = ddlb_findwhere.FindItem(ddlb_findwhere.text,0)
ls_type 	= inv_findattrib.idw_requestor.Describe(inv_findattrib.is_lookdata[li_posicion] + ".Coltype")
ls_type	= Upper(left(ls_type,4))
ls_mask	=	inv_findattrib.idw_requestor.Describe(inv_findattrib.idw_requestor.getColumnname() + ".EditMask.Mask")
	CHOOSE CASE ls_type
		CASE	"CHAR"
					ls_expresion = ("upper(" + inv_findattrib.is_lookdata[li_posicion]+") LIKE '%"  + upper(data) + "%'")  

		CASE "DATE"			
				IF ls_mask = '' THEN
					ls_expresion = "pos(string(" + inv_findattrib.is_lookdata[li_posicion] + "), '" + data + "') = 1"					
				ELSE
					ls_expresion =  inv_findattrib.is_lookdata[li_posicion] + " = date('" + data + "')"
				END IF
		CASE ELSE
				IF ls_mask = '' THEN
					ls_expresion = "pos(string(" + inv_findattrib.is_lookdata[li_posicion] + "), '" + data + "') = 1"	
				ELSE
					ls_expresion = "MATCH(string(" + inv_findattrib.is_lookdata[li_posicion] + "),'^" + data + "')"
				END IF
	END CHOOSE		

ll_find = inv_findattrib.idw_requestor.find(ls_expresion,0, inv_findattrib.idw_requestor.rowCount())						

IF ll_find > 0 THEN
	inv_findattrib.idw_requestor.setrow(ll_find)
	inv_findattrib.idw_requestor.scrolltorow(ll_find)
	inv_findattrib.idw_requestor.selectrow(0, FALSE)				
	inv_findattrib.idw_requestor.selectrow(ll_find, TRUE)		
END IF


sle_findwhat.text = data
end event

event constructor;InsertRow ( 0 )
end event


HA$PBExportHeader$w_find_response.srw
forward
global type w_find_response from pfc_w_find_response
end type
type dw_findwhat from datawindow within w_find_response
end type
end forward

global type w_find_response from pfc_w_find_response
string title = "B$$HEX1$$fa00$$ENDHEX$$squeda"
dw_findwhat dw_findwhat
end type
global w_find_response w_find_response

on w_find_response.create
int iCurrent
call super::create
this.dw_findwhat=create dw_findwhat
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_findwhat
end on

on w_find_response.destroy
call super::destroy
destroy(this.dw_findwhat)
end on

type st_findwhere from pfc_w_find_response`st_findwhere within w_find_response
string text = "Buscar dentro de"
end type

type st_searchfor from pfc_w_find_response`st_searchfor within w_find_response
string text = "Buscar"
end type

type ddlb_findwhere from pfc_w_find_response`ddlb_findwhere within w_find_response
end type

type st_searchdirection from pfc_w_find_response`st_searchdirection within w_find_response
string text = "Direcci$$HEX1$$f300$$ENDHEX$$n"
end type

type cbx_wholeword from pfc_w_find_response`cbx_wholeword within w_find_response
string text = "Toda la palabra"
end type

type cbx_matchcase from pfc_w_find_response`cbx_matchcase within w_find_response
string text = "Coincidir may$$HEX1$$fa00$$ENDHEX$$sculas y min$$HEX1$$fa00$$ENDHEX$$sculas"
end type

type cb_findnext from pfc_w_find_response`cb_findnext within w_find_response
integer width = 430
string text = "&Buscar siguiente"
end type

type cb_cancel from pfc_w_find_response`cb_cancel within w_find_response
integer width = 430
string text = "&Cancelar"
end type

type sle_findwhat from pfc_w_find_response`sle_findwhat within w_find_response
integer y = 408
integer taborder = 0
end type

event sle_findwhat::constructor;call super::constructor;this.visible=false
end event

type ddlb_searchdirection from pfc_w_find_response`ddlb_searchdirection within w_find_response
string item[] = {"Abajo","Arriba"}
end type

type cb_dlghelp from pfc_w_find_response`cb_dlghelp within w_find_response
integer width = 430
string text = "&Ayuda"
end type

type dw_findwhat from datawindow within w_find_response
integer x = 581
integer y = 176
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


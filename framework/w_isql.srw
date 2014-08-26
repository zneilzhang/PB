HA$PBExportHeader$w_isql.srw
forward
global type w_isql from w_popup
end type
type pb_2 from picturebutton within w_isql
end type
type st_tiempo from statictext within w_isql
end type
type st_rows from statictext within w_isql
end type
type pb_4 from picturebutton within w_isql
end type
type pb_3 from picturebutton within w_isql
end type
type pb_ejecutar from picturebutton within w_isql
end type
type pb_1 from picturebutton within w_isql
end type
type st_2 from statictext within w_isql
end type
type rb_2 from radiobutton within w_isql
end type
type rb_dataset from radiobutton within w_isql
end type
type dw_dataset from u_dw within w_isql
end type
type st_split from u_st_splitbar within w_isql
end type
type mle_sql from multilineedit within w_isql
end type
end forward

global type w_isql from w_popup
integer x = 214
integer y = 221
integer width = 3154
integer height = 1624
string title = "Interactive ISQL ~~~~(,, ,,$$HEX2$$b000b000$$ENDHEX$$>"
boolean center = true
pb_2 pb_2
st_tiempo st_tiempo
st_rows st_rows
pb_4 pb_4
pb_3 pb_3
pb_ejecutar pb_ejecutar
pb_1 pb_1
st_2 st_2
rb_2 rb_2
rb_dataset rb_dataset
dw_dataset dw_dataset
st_split st_split
mle_sql mle_sql
end type
global w_isql w_isql

type variables


boolean ib_seleccionado
end variables

on w_isql.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.st_tiempo=create st_tiempo
this.st_rows=create st_rows
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_ejecutar=create pb_ejecutar
this.pb_1=create pb_1
this.st_2=create st_2
this.rb_2=create rb_2
this.rb_dataset=create rb_dataset
this.dw_dataset=create dw_dataset
this.st_split=create st_split
this.mle_sql=create mle_sql
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.st_tiempo
this.Control[iCurrent+3]=this.st_rows
this.Control[iCurrent+4]=this.pb_4
this.Control[iCurrent+5]=this.pb_3
this.Control[iCurrent+6]=this.pb_ejecutar
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.rb_2
this.Control[iCurrent+10]=this.rb_dataset
this.Control[iCurrent+11]=this.dw_dataset
this.Control[iCurrent+12]=this.st_split
this.Control[iCurrent+13]=this.mle_sql
end on

on w_isql.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.st_tiempo)
destroy(this.st_rows)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_ejecutar)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.rb_2)
destroy(this.rb_dataset)
destroy(this.dw_dataset)
destroy(this.st_split)
destroy(this.mle_sql)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_row
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ib_disableclosequery = TRUE
//	Habilita el servicio de resize
of_setresize(true)

//	Registra los objetos para el resize
inv_resize.of_Register(mle_sql, 0, 0, 100, 0)

inv_resize.of_Register (st_split, 0, 0, 100, 0)

inv_resize.of_Register(dw_dataset, 0, 0, 100, 100)



end event

event close;call super::close;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


dw_dataset.width = width - dw_dataset.x - 80
dw_dataset.height  = height - dw_dataset.y - 160
st_split.width = dw_dataset.width
mle_sql.width = dw_dataset.width
end event

event key;call super::key;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

CHOOSE CASE key
	CASE keyF9! 
		ib_seleccionado = TRUE
	CASE keyF5!
		ib_seleccionado = FALSE
	CASE ELSE
		RETURN
END CHOOSE

pb_ejecutar.event clicked()
ib_seleccionado = FALSE

end event

type pb_2 from picturebutton within w_isql
integer x = 1170
integer y = 32
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Table!"
alignment htextalign = left!
string powertiptext = "Exporta el resultado"
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------



dw_dataset.setFilter(gs_nulo)
dw_dataset.filter()
st_rows.text = "Rows: "+string(dw_dataset.rowcount())
end event

type st_tiempo from statictext within w_isql
integer x = 1362
integer y = 4
integer width = 768
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 20273446
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_rows from statictext within w_isql
integer x = 1362
integer y = 72
integer width = 768
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 20273446
long backcolor = 67108864
boolean focusrectangle = false
end type

type pb_4 from picturebutton within w_isql
integer x = 1056
integer y = 32
integer width = 101
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Export5!"
alignment htextalign = left!
string powertiptext = "Exporta el resultado"
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF dw_dataset.rowcount() = 0 THEN
	messagebox(gs_nombreapp, "No hay resultados para exportar",exclamation!)
	RETURN
END IF

dw_dataset.event pfc_saveas()
end event

type pb_3 from picturebutton within w_isql
integer x = 951
integer y = 32
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Save!"
alignment htextalign = left!
string powertiptext = "Guarda cambios en el resultado"
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF dw_dataset.rowcount() = 0 THEN
	messagebox(gs_nombreapp, "No hay resultados",exclamation!)
	RETURN
END IF

IF dw_dataset.event pfc_update(true,false) <> 1 THEN
	rollback;
	messagebox(Gs_nombreapp,"Ocurr$$HEX1$$ed00$$ENDHEX$$o un error al actualizar la informaci$$HEX1$$f300$$ENDHEX$$n",exclamation!)
	RETURN
END IF

dw_dataset.resetupdate()

COMMIT;
end event

type pb_ejecutar from picturebutton within w_isql
integer x = 846
integer y = 32
integer width = 101
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "VCRNext!"
alignment htextalign = left!
string powertiptext = "Ejecuta SQL"
end type

event clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rc
string ls_sql
time lt_inicio, lt_final
long ll_segundos
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT isvalid(SQLCA) THEN
	Messagebox(gs_nombreapp,"La conexi$$HEX1$$f300$$ENDHEX$$n no es valida",exclamation!)
	RETURN
END IF


ls_sql = mle_sql.text

IF len(trim(ls_sql)) = 0 THEN
	messagebox(gs_nombreapp,"No existen sentencias SQL a ejecutar",exclamation!)
	RETURN
END IF

IF mle_sql.SelectedLength() > 0 AND ib_seleccionado THEN
	ls_sql = mle_sql.SelectedText ( )
END IF

IF len(trim(ls_sql)) = 0 THEN
	messagebox(gs_nombreapp,"No existen sentencias SQL a ejecutar",exclamation!)
	RETURN
END IF

st_rows.text = ""
st_tiempo.text = ""

lt_inicio = now()
IF rb_dataset.checked THEN
	dw_dataset.of_AgrupadorColumnas(FALSE)
	dw_dataset.of_create(ls_sql, SQLCA)
	dw_dataset.of_setReqColumn(TRUE)
	//Activa el Servicio de Panel Agrupador
	dw_dataset.of_SetAgrupador(true)
	st_rows.text = "Rows: "+string(dw_dataset.rowcount())
	//of_create(dw_dataset, ls_sql, itr_cnx)
ELSE
	li_rc = SQLCA.of_ejecuta_sql( mle_sql.text, true, true)
END IF
lt_final = now()
ll_segundos = SecondsAfter(lt_inicio, lt_final)
st_tiempo.text = "Tiempo ejecuci$$HEX1$$f300$$ENDHEX$$n: "+string(ll_segundos,"#,##0")

end event

type pb_1 from picturebutton within w_isql
integer x = 846
integer y = 36
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "VCRNext!"
alignment htextalign = left!
end type

type st_2 from statictext within w_isql
integer x = 23
integer y = 28
integer width = 384
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
string text = "Regresa DataSet"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_isql
integer x = 640
integer y = 28
integer width = 183
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "No"
end type

type rb_dataset from radiobutton within w_isql
integer x = 439
integer y = 28
integer width = 183
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "S$$HEX1$$ed00$$ENDHEX$$"
boolean checked = true
end type

type dw_dataset from u_dw within w_isql
integer x = 37
integer y = 676
integer width = 3072
integer height = 836
integer taborder = 20
boolean hscrollbar = true
end type

type st_split from u_st_splitbar within w_isql
integer x = 27
integer y = 640
integer width = 3072
end type

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_Register(mle_sql, ABOVE)

of_Register(dw_dataset, BELOW)
end event

type mle_sql from multilineedit within w_isql
event keydown pbm_keydown
integer x = 27
integer y = 148
integer width = 3072
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

event keydown;IF keyflags = 2 and key = keyA! THEN
	
	this.SelectText ( 1, len(this.text) )
END IF
end event


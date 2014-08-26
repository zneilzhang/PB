HA$PBExportHeader$w_ayuda.srw
$PBExportComments$(DT) Ventana para el F1
forward
global type w_ayuda from w_response
end type
type dw_busqueda from u_dw within w_ayuda
end type
type st_compania from u_st within w_ayuda
end type
type pb_salir from u_pb within w_ayuda
end type
type pb_copiar from u_pb within w_ayuda
end type
type st_descripcion from u_st within w_ayuda
end type
type dw_configuracion_ayuda from u_dw within w_ayuda
end type
type dw_ayuda from u_dw within w_ayuda
end type
end forward

global type w_ayuda from w_response
integer width = 1970
integer height = 1624
string title = "Ayuda"
boolean center = true
long il_handle = 56213028
dw_busqueda dw_busqueda
st_compania st_compania
pb_salir pb_salir
pb_copiar pb_copiar
st_descripcion st_descripcion
dw_configuracion_ayuda dw_configuracion_ayuda
dw_ayuda dw_ayuda
end type
global w_ayuda w_ayuda

type variables
gstr_param_ayuda istr_param_ayuda

end variables

on w_ayuda.create
int iCurrent
call super::create
this.dw_busqueda=create dw_busqueda
this.st_compania=create st_compania
this.pb_salir=create pb_salir
this.pb_copiar=create pb_copiar
this.st_descripcion=create st_descripcion
this.dw_configuracion_ayuda=create dw_configuracion_ayuda
this.dw_ayuda=create dw_ayuda
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_busqueda
this.Control[iCurrent+2]=this.st_compania
this.Control[iCurrent+3]=this.pb_salir
this.Control[iCurrent+4]=this.pb_copiar
this.Control[iCurrent+5]=this.st_descripcion
this.Control[iCurrent+6]=this.dw_configuracion_ayuda
this.Control[iCurrent+7]=this.dw_ayuda
end on

on w_ayuda.destroy
call super::destroy
destroy(this.dw_busqueda)
destroy(this.st_compania)
destroy(this.pb_salir)
destroy(this.pb_copiar)
destroy(this.st_descripcion)
destroy(this.dw_configuracion_ayuda)
destroy(this.dw_ayuda)
end on

event open;call super::open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
istr_param_ayuda = Message.PowerObjectParm	
string ls_sintaxis, ls_sql,ls_error, ls_nombre, ls_nombre_nuevo, ls_dbparm, &
		ls_groupby, ls_orderby
long ll_total_columnas, ll_renglon, ll_longitud
integer li_contador
string ls_dsn, ls_nombre_cia, ls_clave_cia, ls_tipo
long ll_posicion_ini,ll_posicion_fin, li_longitud_campo, ll_aux, ll_aux_max
boolean lb_seleccion

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Obtiene la configuraci$$HEX1$$f300$$ENDHEX$$n para la ayuda
dw_configuracion_ayuda.of_settransobject(istr_param_ayuda.conexion_cia)
dw_configuracion_ayuda.setfilter("cve_ayuda='"+ istr_param_ayuda.cve_ayuda + "'")
dw_configuracion_ayuda.filter()
dw_configuracion_ayuda.event pfc_retrieve()
if dw_configuracion_ayuda.rowcount() <= 0 then
	messagebox(gs_nombreapp, "La ayuda con clave '" + istr_param_ayuda.cve_ayuda + "' no existe")
	post event pfc_close()
end if

if istr_param_ayuda.ab_seleccion_multiple then
	dw_ayuda.inv_rowselect.of_SetStyle(dw_ayuda.inv_rowselect.EXTENDED)
else
	dw_ayuda.inv_rowselect.of_SetStyle(dw_ayuda.inv_rowselect.SINGLE)
end if

If istr_param_ayuda.titulo = '' Then
	This.Title = dw_configuracion_ayuda.object.titulo_ayuda[1]
Else	
   This.Title = istr_param_ayuda.titulo
End if
st_descripcion.text = dw_configuracion_ayuda.object.descripcion_ayuda[1]

////////////////////////////////////////////
//Crea la consulta sql a partir de los parametros o de la configuraci$$HEX1$$f300$$ENDHEX$$n
////////////////////////////////////////////
//...Obtiene el cuerpo principal del sql
ls_sql = dw_configuracion_ayuda.object.sql[1] 

ls_sql = gnv_funciones_string.of_globalreplace( ls_sql, ":gi_nivelcc", string(gi_nivelcc))

//...Obtiene el where
If istr_param_ayuda.where <> '' Then
	ls_sql = ls_sql + " " + istr_param_ayuda.where
Else
	If string(dw_configuracion_ayuda.object.where[1])	 <> '' Then
		ls_sql = ls_sql + " " + dw_configuracion_ayuda.object.where[1]	
	End if
End if

//...Obtiene el group by
ls_groupby = dw_configuracion_ayuda.object.group_by[1]
if not isnull(ls_groupby) and trim(ls_groupby) <> '' then
	ls_sql = ls_sql + " " + dw_configuracion_ayuda.object.group_by[1]	
end if

//...Obtiene el order by
ls_orderby = dw_configuracion_ayuda.object.order_by[1]
if not isnull(ls_orderby) and trim(ls_orderby) <> '' then
	ls_sql = ls_sql + " " + dw_configuracion_ayuda.object.order_by[1]	
end if

//If istr_param_ayuda.where <> '' Then
//	ls_sql = dw_configuracion_ayuda.object.sql[1] + " " + istr_param_ayuda.where
//Else
//	If string(dw_configuracion_ayuda.object.where[1])	 <> '' Then
//		ls_sql = dw_configuracion_ayuda.object.sql[1] + " " + dw_configuracion_ayuda.object.where[1]	
//	Else
//		ls_sql = dw_configuracion_ayuda.object.sql[1]
//	End if
//End if


//Asigna un DW si se tiene registrado en la configuraci$$HEX1$$f300$$ENDHEX$$n, sino crea el formato
If dw_configuracion_ayuda.object.dw_sintaxis[1] <> '' Then
	ls_sintaxis = istr_param_ayuda.conexion_cia.SyntaxFromSQL(ls_sql,dw_configuracion_ayuda.object.dw_sintaxis[1],ls_error)
Else
	ls_sintaxis = istr_param_ayuda.conexion_cia.SyntaxFromSQL(ls_sql, &
	"Style(Type=grid )" + & 
	"Style ( Detail_Top_Margin = 0 ) " + &
	"Style ( Detail_Bottom_Margin = 0 ) " + &
	"Style ( Header_Top_Margin = 5 )" + &
	"Style ( Header_Bottom_Margin = 8 )" + &
	"Style ( horizontal_spread = 0 ) " + &
	"Datawindow(Color = 67108864) " + &
	 "Text(Alignment=2 Border=6 color=1073741824 background.mode=2 background.color=268435456)" + &  
	 "Column(Border=0)",ls_error)
End if

if len(ls_error) > 0 then
	messagebox("syntaxs", ls_error)
	return -1
end if

dw_ayuda.Create( ls_sintaxis, ls_error)
if len(ls_error) > 0 then
	messagebox("Create", ls_error)
	return -1
end if

dw_ayuda.Modify("DataWindow.Header.Color= '78682240'")
//No permitir mover las columnas
dw_ayuda.modify("DataWindow.Grid.ColumnMove=No")
dw_ayuda.modify("DataWindow.Selected.Mouse=No")

//Total de columnas generadas 
ll_total_columnas = long(dw_ayuda.describe("datawindow.column.count"))

//Ciclo para obtener la altura m$$HEX1$$e100$$ENDHEX$$xima de las columans e igualarlas
ll_aux_max = 0
for li_contador = 1 to ll_total_columnas
	ls_nombre = dw_ayuda.describe("#" + string(li_contador) + ".Name")
	ll_aux = long(dw_ayuda.describe(ls_nombre + "_t.height"))
	if ll_aux_max < ll_aux then
		ll_aux_max = ll_aux
	end if
next

//Ciclo para proteger columnas generadas y poner titulos
dw_ayuda.SetTransObject ( istr_param_ayuda.conexion_cia )
for li_contador = 1 to ll_total_columnas
	dw_ayuda.Modify ( "#" + string(li_contador) + ".protect='1'" )
   ls_nombre = dw_ayuda.describe("#" + string(li_contador) + ".Name")
   
   //toma los titulos almacenados en la configuraci$$HEX1$$f300$$ENDHEX$$n de ayuda
	ls_nombre_nuevo = gnv_funciones_string.of_desglosa_string(dw_configuracion_ayuda.object.titulos_columnas[1], li_contador, ",")
	dw_ayuda.Modify(ls_nombre + "_t.text='" + ls_nombre_nuevo + "'")
	
   //para longitud de los campos
   ls_tipo = dw_ayuda.Describe( ls_nombre + ".ColType")
	if match(ls_tipo,'char') Then
           ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(' + ls_nombre + ') for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )' 
	else
           ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(string(' + ls_nombre + ')) for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
	end if
   dw_ayuda.Modify(ls_sintaxis)  
   dw_ayuda.retrieve()
	li_longitud_campo = 0
	if dw_ayuda.rowcount() >0 then
       li_longitud_campo = dw_ayuda.object.compute_1[1] 
	end if
	if len(ls_nombre_nuevo) > li_longitud_campo Then
      li_longitud_campo = len(ls_nombre_nuevo)
   End if
	ll_longitud = li_longitud_campo * 40
   dw_ayuda.Modify(ls_nombre + ".width='" + string(ll_longitud) + "'")	
	dw_ayuda.Modify("destroy compute_1")
	
	//Iguala el alto de los t$$HEX1$$ed00$$ENDHEX$$tulos
	dw_ayuda.Modify(ls_nombre + "_t.height='" + string(ll_aux_max) + "'")
	
next

//PARA OBTENER EL NOMBRE Y CLAVE DE LA CIA  
SELECT clave_compania, nombre
INTO :ls_clave_cia, :ls_nombre_cia
FROM datos_compania
USING istr_param_ayuda.conexion_cia;

IF istr_param_ayuda.conexion_cia.sqlcode = 100 THEN
	ls_nombre_cia = '?'
	ls_clave_cia = '?'
END IF

//ls_dbparm = istr_param_ayuda.conexion_cia.DBParm 
//ls_dbparm = lower(ls_dbparm)
//ll_posicion_ini = LastPos(ls_dbparm, "dsn=") + 4
//ll_posicion_fin = Pos(ls_dbparm, ";", ll_posicion_ini)
//
//ls_dsn = Mid(ls_dbparm, ll_posicion_ini, ll_posicion_fin - ll_posicion_ini)
//ll_renglon = gds_kontrol_ini.Find ("dsn='"+ ls_dsn + "'", 0, gds_kontrol_ini.RowCount()) 
//if ll_renglon > 0 then
//	ls_nombre_cia = gds_kontrol_ini.object.nom[ll_renglon]
//	ls_clave_cia = gds_kontrol_ini.object.cve[ll_renglon]
//else
//	ls_nombre_cia = '?'
//	ls_clave_cia = '?'
//end if
st_compania.text = 'Informaci$$HEX1$$f300$$ENDHEX$$n de : ' + ls_clave_cia + ' -  ' +  ls_nombre_cia

//Muestra la informacion
dw_ayuda.retrieve()




end event

event pfc_postopen();call super::pfc_postopen;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
visible = true

//Registra la barra de ayudas
dw_busqueda.post event ue_registrar(dw_ayuda)
end event

type dw_busqueda from u_dw within w_ayuda
event type integer ue_registrar ( u_dw adw_origen )
event ue_verticalscroll pbm_vscroll
string tag = "0"
integer x = 9
integer y = 236
integer width = 1934
integer height = 84
integer taborder = 10
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event type integer ue_registrar(u_dw adw_origen);//------------------------------------------------------------------
//  EVENTO/FUNCION	:	ue_registrar
//
//  DESCRIPCION		:	Evento para registrar el dw al cual se le va		
// 							a generar la barra de ayuda
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  13/JUL/04	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_sintaxis, ls_error
long		ll_total_columnas, ll_contador

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Crea la barra de ayuda 
ls_sintaxis = adw_origen.object.datawindow.syntax
create(ls_sintaxis, ls_error)

//Oculta el encabezado
object.dataWindow.header.height = 0

//Inserta el rengl$$HEX1$$f300$$ENDHEX$$n
insertrow(0)
//insertrow(0)

//Acomoda el objeto
x = adw_origen.x
y = adw_origen.y - height + 5

//Barre las columnas para habilitarlas
ll_total_columnas = long(object.datawindow.column.count)
modify("DataWindow.Detail.Height='90'")

for ll_contador = 1 to ll_total_columnas
	SetTabOrder ( ll_contador, 0 )			
	SetTabOrder ( ll_contador, ll_contador )
	Modify ( "#" + string(ll_contador) + ".protect='0'" )
	Modify( "#" + string(ll_contador) +".Background.Color='1090519039'")	
	Modify("#" + string(ll_contador) + ".Background.Mode='0'")
	Modify("#" + string(ll_contador) + ".Height='68'")
	Modify("#" + string(ll_contador) + ".font.face='Arial'")
	Modify("#" + string(ll_contador) + ".font.height='-8'")
	if upper(describe("#" + string(ll_contador) + ".Edit.NilIsNull")) = 'NO' then
		modify(getColumnName() + ".Edit.NilIsNull = 'yes'")
	end if
next

if long(adw_origen.Describe("DataWindow.VerticalScrollMaximum")) > 0 then vscrollbar = adw_origen.vscrollbar

setredraw(true)
setcolumn(1)
tag = '0'

return 0
end event

event ue_verticalscroll;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Esta rutina se usa para evitar el scroll con el mouse
return 1
end event

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_setupdateable(false)
ib_rmbmenu = false

end event

event editchanged;call super::editchanged;//---------------------------------------
// DECLARACIONES LOCALES
//---------------------------------------
long ll_total_columnas,ll_find
integer li_contador
string ls_nombre,ls_find,ls_type,ls_dato, ls_criterio

//---------------------------------------
// C$$HEX1$$d300$$ENDHEX$$DIGO DE LA RUTINA
//---------------------------------------
if data = '' then
	ls_criterio = ''
else
	ls_nombre = dwo.name
	ls_type 	= dw_ayuda.Describe(ls_nombre + ".Coltype")
	ls_type	= Upper(left(ls_type,4))
	
	choose case ls_type
		case	"CHAR"
			ls_criterio = "UPPER(" + ls_nombre + ") LIKE '%" + upper(data) + "%'"
			
		case	else
			ls_criterio = "UPPER(string(" + ls_nombre + ")) LIKE '%" + upper(data) + "%'"
			
	end choose
end if

dw_ayuda.setfilter(ls_criterio)
dw_ayuda.filter()	

dw_ayuda.selectrow(0, FALSE)		
if dw_ayuda.rowcount() > 0 then
	dw_ayuda.selectrow(1, TRUE)			
end if

////Total de columnas generadas 
//ll_total_columnas = long(dw_ayuda.describe("datawindow.column.count"))
//ls_find=''
//for li_contador = 1 to ll_total_columnas
//   ls_nombre = dw_ayuda.describe("#" + string(li_contador) + ".Name")
//	if len(ls_find)>0 Then ls_find=ls_find + ' AND '
//	//ls_find = ls_find + ls_nombre
//   ls_type 	= dw_ayuda.Describe(ls_nombre + ".Coltype")
//	ls_type	= Upper(left(ls_type,4))
//  
//   if ls_type="CHAR" then
//       ls_dato = dw_busqueda.getitemstring(1,li_contador)
//	else
//		 ls_dato =string(dw_busqueda.getitemnumber(1,li_contador))
//	end if
//	CHOOSE CASE ls_type
//		CASE	"CHAR"
//			if dwo.name = ls_nombre then
//         	IF pos(data, '*',1) = 0		THEN		
//					ls_find = ls_find + "pos(upper(" + ls_nombre + "),upper('" + data  + "')) = 1"						
//				ELSE
//					ls_find = ls_find + "pos(upper(" + ls_nombre + "),upper('" + right(data, len(data) - 1)  + "')) > 1"
//				END IF
//			else  
//				   if trim(ls_dato) = '' or IsNull(ls_dato) then
//						ls_find = ls_find + " 0 = 0 " 
//					else
//						IF pos(ls_dato, '*',1) = 0		THEN		
//							ls_find = ls_find + "pos(upper(" + ls_nombre + "),upper('" + ls_dato  + "')) = 1"						
//						ELSE
//							ls_find = ls_find + "pos(upper(" + ls_nombre + "),upper('" + right(ls_dato, len(data) - 1)  + "')) > 1"
//						END IF
//					end if
//			end if
//		CASE  ELSE
//			if dwo.name = ls_nombre then
//					ls_find = ls_find + "pos(string(" + ls_nombre + "), '" + data + "') = 1"	
//			else
//				   if trim(ls_dato) = '' or IsNull(ls_dato) then
//						ls_find = ls_find + " 0 = 0 " 										
//					else
//						ls_find = ls_find + "pos(string(" + ls_nombre + "), '" + ls_dato + "') = 1"	
//					end if
//		   end if
//	END CHOOSE		 
//next
//
//debugbreak()
//ll_find = dw_ayuda.find(ls_find,0, dw_ayuda.rowCount())						
//
//
//IF ll_find > 0 THEN
//	dw_ayuda.setrow(ll_find)
//	dw_ayuda.scrolltorow(ll_find)
//	dw_ayuda.selectrow(0, FALSE)				
//	dw_ayuda.selectrow(ll_find, TRUE)		
//END IF




end event

event scrollhorizontal;call super::scrollhorizontal;dw_ayuda.Object.DataWindow.HorizontalScrollPosition = scrollpos
end event

event rowfocuschanging;call super::rowfocuschanging;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
return long(tag)
end event

type st_compania from u_st within w_ayuda
integer x = 9
integer y = 164
integer width = 1934
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 32768
string text = "Informaci$$HEX1$$f300$$ENDHEX$$n de : 16 - Compa$$HEX2$$f100ed00$$ENDHEX$$a Dieciseis"
alignment alignment = center!
end type

event constructor;call super::constructor;text = ''
end event

type pb_salir from u_pb within w_ayuda
integer x = 1586
integer y = 1408
integer width = 357
integer height = 116
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;call super::clicked;Close(w_ayuda)
end event

type pb_copiar from u_pb within w_ayuda
integer x = 1138
integer y = 1408
integer width = 357
integer height = 116
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "C&opiar"
end type

event clicked;call super::clicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
long ll_renglon, llarr_seleccionados[], ll_aux
string ls_resultado,ls_tipo_dato,ls_resultado_final,ls_regresa, lsarr_regreso[]
integer li_contador

//------------------------------------------------------------------
// C$$HEX1$$d300$$ENDHEX$$DIGO DE LA RUTINA
//------------------------------------------------------------------

//Ciclo para los renglones marcados
dw_ayuda.inv_rowselect.of_SelectedCount ( llarr_seleccionados )

if upperbound(llarr_seleccionados) = 0 then
	messagebox(gs_nombreapp, "No hay informaci$$HEX1$$f300$$ENDHEX$$n seleccionada", exclamation!)
	return
end if

for ll_aux = 1 to upperbound(llarr_seleccionados)
	ls_resultado_final = ''
	li_contador = 1
	ll_renglon = llarr_seleccionados[ll_aux]
	
	//Obtiene los campos de regreso...
	ls_regresa = gnv_funciones_string.of_desglosa_string(istr_param_ayuda.regresa_ayuda, li_contador, ",")

	Do While ls_regresa <> '' 
		if isnumber(ls_regresa) then
			ls_regresa = dw_ayuda.describe("#" + ls_regresa + ".Name")
		end if
		
		ls_tipo_dato = Upper(dw_ayuda.Describe(ls_regresa + ".coltype"))
		
		If Match(ls_tipo_dato,'CHAR') Then
				ls_resultado = dw_ayuda.GetItemString(ll_renglon,ls_regresa)
		End If
		
		If Match(ls_tipo_dato,'DATE')  Then
				ls_resultado = string(dw_ayuda.GetItemDate(ll_renglon,ls_regresa))
		End If
		
		If Match(ls_tipo_dato,'NUMERIC') Or Match(ls_tipo_dato,'DECIMAL') Or Match(ls_tipo_dato,'DOUBLE') Or Match(ls_tipo_dato,'INTEGER') Or Match(ls_tipo_dato,'LONG') Or Match(ls_tipo_dato,'REAL') Then
				ls_resultado = string(dw_ayuda.GetItemNumber(ll_renglon,ls_regresa))
		End If
		
		If ls_resultado_final <>'' Then ls_resultado_final = ls_resultado_final + ','
		ls_resultado_final = ls_resultado_final + ls_resultado
		li_contador++
		ls_regresa = gnv_funciones_string.of_desglosa_string(istr_param_ayuda.regresa_ayuda, li_contador, ",")
	Loop
	lsarr_regreso[upperbound(lsarr_regreso) + 1] = ls_resultado_final
next

//Arma la cadena de regreso la cual ir$$HEX2$$e1002000$$ENDHEX$$separada por dos pipes ||
ls_resultado_final = ""
for ll_aux = 1 to upperbound(lsarr_regreso)
	ls_resultado = lsarr_regreso[ll_aux]
	ls_resultado_final = ls_resultado_final + ls_resultado + "||"
next

//Quita los pipes finales
ls_resultado_final = left(ls_resultado_final, len(ls_resultado_final) - 2)

CloseWithReturn(Parent,ls_resultado_final)


end event

type st_descripcion from u_st within w_ayuda
integer x = 9
integer y = 8
integer width = 1934
integer height = 152
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long textcolor = 0
long backcolor = 1073741824
string text = "Descripci$$HEX1$$f300$$ENDHEX$$n"
alignment alignment = center!
boolean border = true
end type

type dw_configuracion_ayuda from u_dw within w_ayuda
integer x = 206
integer y = 612
integer width = 1362
integer taborder = 0
string dataobject = "d_config_ayuda"
end type

event constructor;call super::constructor;of_setupdateable(false)

visible = false
end event

type dw_ayuda from u_dw within w_ayuda
integer x = 9
integer y = 328
integer width = 1934
integer height = 1056
integer taborder = 20
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;////------------------------------------------------------------------
//// DECLARACIONES LOCALES
////------------------------------------------------------------------
//
////------------------------------------------------------------------
//// CODIGO DE LA RUTINA
////------------------------------------------------------------------
//if ancestorreturnvalue <> 0 then return ancestorreturnvalue
//
//if row > 0 then
//	if row <> this.getrow() then
//			this.scrolltorow(row)
//			this.selectrow(0,false)
//			this.selectrow(row,true)
//	end if
//end if
end event

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_setupdateable(false)

//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(True)
inv_rowselect.of_SetStyle(inv_rowselect.SINGLE)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(True)

//Servicio de ordenamiento por columnas
of_SetSort(True)
inv_sort.of_SetStyle (inv_sort.DRAGDROP)
inv_sort.of_SetColumnHeader(TRUE)

//ib_rmbmenu = false

//Registra el servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//No permitir mover las columnas
modify("DataWindow.Grid.ColumnMove=No")

end event

event doubleclicked;call super::doubleclicked;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

if dwo.type = "column" then pb_copiar.TriggerEvent (clicked!) 
end event

event pfc_prermbmenu(ref m_dw am_dw);call super::pfc_prermbmenu;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

m_dw.m_table.m_cut.visible = false
m_dw.m_table.m_copy.visible = false
m_dw.m_table.m_paste.visible = false
m_dw.m_table.m_selectall.visible = false
m_dw.m_table.m_dash11.visible = false
m_dw.m_table.m_addrow.visible = false
m_dw.m_table.m_delete.visible = false
m_dw.m_table.m_dash14.visible = false
m_dw.m_table.m_f1.visible = false
end event

event scrollhorizontal;call super::scrollhorizontal;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Sincroniza el movimiento de la barra de ayudas
dw_busqueda.Object.DataWindow.HorizontalScrollPosition = scrollpos
end event

event ue_postlbuttonup();call super::ue_postlbuttonup;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//Actualiza la barra de ayuda
dw_busqueda.event ue_registrar(this)
end event


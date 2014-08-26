HA$PBExportHeader$n_ds.sru
$PBExportComments$Extension Datastore class
forward
global type n_ds from pfc_n_ds
end type
end forward

global type n_ds from pfc_n_ds
end type
global n_ds n_ds

forward prototypes
public function integer of_create (string as_sql, n_tr atr_conexion)
end prototypes

public function integer of_create (string as_sql, n_tr atr_conexion);
long ll_rc, ll_total_columnas, li_contador, li_longitud_campo, ll_longitud, ll_aux, ll_aux_max
string ls_sintaxis, ls_error, ls_nombre, ls_tipo, ls_rtn

//crea la dw din$$HEX1$$e100$$ENDHEX$$micamente
ls_sintaxis = atr_conexion.SyntaxFromSQL(as_sql, &
	"Style(Type=grid )" + & 
	"Style ( Detail_Top_Margin = 0 ) " + &
	"Style ( Detail_Bottom_Margin = 0 ) " + &
	"Style ( Header_Top_Margin = 5 )" + &
	"Style ( Header_Bottom_Margin = 8 )" + &
	"Style ( horizontal_spread = 0 ) " + &
	 "Text(Alignment=2 Border=2 color=1073741824 background.mode=2 background.color=268435456)" ,ls_error)

//	"Text(Alignment=2 Border=6 " ,ls_error)
	
//	"Datawindow(Color = 67108864) " + &
//	 "Text(Alignment=2 Border=6 " ,ls_error)
//	 "Text(Alignment=2 Border=6 color=1073741824 background.mode=2 background.color=268435456)" ,ls_error)
//	 "Column(Border=0 font.face = 'Tahoma')",ls_error)
////	 "Column(Border=0 font.face='Tahoma' font.height='-108' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' ", ls_error)


if len(ls_error) > 0 then 
	IF isvalid(gnv_app.inv_debug) THEN gnv_app.inv_debug.of_message("rtn = 3 -> "+ls_error)		
	RETURN -3
END IF

//Crea contenedor local apartir de la sintaxis de DW
this.Create( ls_sintaxis, ls_error)

if len(ls_error) > 0 then 
	IF isvalid(gnv_app.inv_debug) THEN gnv_app.inv_debug.of_message("rtn = 4 -> "+ls_error)
	RETURN -4
END IF

//Asigna objeto de la transaccion
this.of_setTransObject(atr_conexion)

if this.Retrieve() <= 0 then 
//	messagebox(gs_nombreapp, "No se pudo obtener informaci$$HEX1$$f300$$ENDHEX$$n de los renglones", exclamation!)
	ll_rc = -5
END IF
RETURN rowcount()

//this.Modify("DataWindow.Header.Color= '78682240'")
////No permitir mover las columnas
//this.modify("DataWindow.Grid.ColumnMove=No")
//this.modify("DataWindow.Selected.Mouse=No")
//
////Total de columnas generadas 
//ll_total_columnas = long(this.describe("datawindow.column.count"))
//
////Ciclo para obtener la altura m$$HEX1$$e100$$ENDHEX$$xima de las columans e igualarlas
//ll_aux_max = 0
//for li_contador = 1 to ll_total_columnas
//	ls_nombre = this.describe("#" + string(li_contador) + ".Name")
//	ll_aux = long(this.describe(ls_nombre + "_t.height"))
//	if ll_aux_max < ll_aux then
//		ll_aux_max = ll_aux
//	end if
//next


////Ciclo para proteger columnas generadas y poner titulos
//for li_contador = 1 to ll_total_columnas
//	this.Modify ( "#" + string(li_contador) + ".protect='1'" )
//	ls_nombre = this.describe("#" + string(li_contador) + ".Name")
//	
//	//para longitud de los campos
//	ls_tipo = this.Describe( ls_nombre + ".ColType")
//	if match(ls_tipo,'char') Then
//			  ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(' + ls_nombre + ') for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )' 
//	else
//			  ls_sintaxis = 'create compute(band=detail alignment="0" expression="max(len(string(' + ls_nombre + ')) for all) "border="0" color="33554432" x="5" y="12" height="76" width="251" format="[GENERAL]" html.valueishtml="0"  name=compute_1 visible="1"  font.face="Arial" font.height="-12" font.weight="400"  font.family="2" font.pitch="2" font.charset="0" background.mode="2" background.color="1073741824" )'
//	end if
//	this.Modify(ls_sintaxis)  
//	
//	li_longitud_campo = 0
//	if this.rowcount() >0 then
//		 li_longitud_campo = this.object.compute_1[1] 
//	end if
//	if len(ls_nombre) > li_longitud_campo Then
//		li_longitud_campo = len(ls_nombre)
//	End if
//	
//	ll_longitud = li_longitud_campo * 40
//	
//	ls_rtn = this.Modify(ls_nombre + ".width='" + string(ll_longitud) + "'")	
//	ls_rtn = this.Modify("destroy compute_1")
//	
//	//Iguala el alto de los t$$HEX1$$ed00$$ENDHEX$$tulos
////	idw_requestor.Modify(ls_nombre + "_t.height='" + string(ll_aux_max) + "'")
//	
//next


RETURN SUCCESS


end function

on n_ds.create
call super::create
end on

on n_ds.destroy
call super::destroy
end on


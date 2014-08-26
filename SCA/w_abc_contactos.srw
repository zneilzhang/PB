HA$PBExportHeader$w_abc_contactos.srw
forward
global type w_abc_contactos from w_catalogo_tabdetalle
end type
type tabpage_1 from userobject within tab_datos
end type
type dw_perfila from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_datos
dw_perfila dw_perfila
end type
end forward

global type w_abc_contactos from w_catalogo_tabdetalle
end type
global w_abc_contactos w_abc_contactos

type variables
u_dw idw_autoriza
string isarr_liga_autoriza[5]
end variables

on w_abc_contactos.create
int iCurrent
call super::create
end on

on w_abc_contactos.destroy
call super::destroy
end on

event open;call super::open;


//Var. para indicar si se realiza el retrieve al cargar
ib_retrieve_inicio = false


inv_resize.of_register( idw_autoriza ,0, 0, 100, 100)

// liga las dw
isarr_liga_maestro[1] = 'numcte'
isarr_liga_detalle[1] = 'numcte'
isarr_liga_adicional[1] = 'numcte'
isarr_liga_autoriza[1] = 'numcte'

dw_maestro.sharedata(idw_detalle )
dw_maestro.sharedata(idw_autoriza )




end event

event pfc_postopen;call super::pfc_postopen;Integer li_contador

// Aqu$$HEX2$$ed002000$$ENDHEX$$se activa el servicio de Linkage para el dw detalle
if idw_autoriza.of_SetLinkage(TRUE) < 0 then messagebox (gs_nombreapp, "Adicional no encadenado", Exclamation!)

// Aqu$$HEX2$$ed002000$$ENDHEX$$se establece la relacion Maestro-Detalle
if idw_autoriza.inv_linkage.of_SetMaster(dw_maestro) <> 1 then messagebox (gs_nombreapp, "No se encontr$$HEX2$$f3002000$$ENDHEX$$el dw master", Exclamation!)

// Se definen los campos liga de cada DW
for li_contador = 1 to Upperbound(isarr_liga_maestro)
	idw_autoriza.inv_linkage.of_Register(isarr_liga_maestro[li_contador], isarr_liga_detalle[li_contador])	
next

// Se define la forma de accesar (RETRIEVE, SCROLL, FILTER)
idw_autoriza.inv_linkage.of_SetStyle(idw_autoriza.inv_linkage.RETRIEVE)


idw_autoriza.inv_linkage.of_SetUpdateOnRowChange (FALSE)
idw_autoriza.inv_linkage.of_SetConfirmOnRowChange (FALSE)


dw_maestro.setfocus( )

end event

event ue_ajusta_objetos;call super::ue_ajusta_objetos;

idw_autoriza.width = tab_datos.width - 50
idw_autoriza.height = tab_datos.height - 50
end event

event ue_busqueda;call super::ue_busqueda;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

String		ls_valor, ls_where , ls_nombre
Long		ll_punto_venta

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

choose case is_columna_activa 
		
	case 'numcte'
		gf_f1("CONTACTOS","","","1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		idw_active.setitem( 1, 'numcte', long(ls_valor))
		idw_active.event itemchanged( 1, idw_active.object.numcte, ls_valor)		
		
		
	case 'id_punto_venta'
		
		ls_where  = 'WHERE sm_punto_venta.id_identificador IN (SELECT so_identificador_cc.id_identificador	 FROM ek010ab JOIN ek090ab ON ek010ab.nivelcc = ek090ab.nivel JOIN ek091ab ON ek090ab.nivel = ek091ab.nivel JOIN so_identificador_cc ON so_identificador_cc.id_identificador = ek091ab.id_identificador  WHERE ek010ab.num = '+ string(gi_numope)  +') AND sm_punto_venta.activo =1'		
		
		gf_f1("PUNTO_VENTA","",ls_where,"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		idw_active.setitem( 1, 'id_punto_venta', long(ls_valor))
		idw_active.event itemchanged( 1, idw_active.object.id_punto_venta, ls_valor)
		
	case 'empleado'
		ls_where = 'where id_categoria = 8'
		gf_f1("AGENTES","",ls_where,"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0

		idw_active.setitem( 1, 'empleado', long(ls_valor))
		idw_active.event itemchanged( 1, idw_active.object.empleado, ls_valor)
		
	case 'nombre_empresa'
		
		gf_f1("EMPRESAS","",'',"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		
		select nombre_empresa
		into :ls_nombre
		from sm_empresa
		where id_empresa = :ls_valor;
		
		
		idw_active.setitem( 1, 'id_empresa', long(ls_valor))
		idw_active.setitem( 1, 'nombre_empresa', ls_nombre)
		
	case 'encargado'
		
		gf_f1("AGENTES","",'',"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0

		idw_active.setitem( 1, 'encargado', long(ls_valor))
		idw_active.event itemchanged( 1, idw_active.object.encargado, ls_valor)
		
		
		

		
		
		
end choose



return 1

end event

type tab_datos from w_catalogo_tabdetalle`tab_datos within w_abc_contactos
integer y = 1092
tabpage_1 tabpage_1
end type

on tab_datos.create
this.tabpage_1=create tabpage_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_1
end on

on tab_datos.destroy
call super::destroy
destroy(this.tabpage_1)
end on

type tabpage_detalle from w_catalogo_tabdetalle`tabpage_detalle within tab_datos
string text = "Datos Basicos"
end type

type dw_det from w_catalogo_tabdetalle`dw_det within tabpage_detalle
string dataobject = "d_brow_contactos_grales"
boolean ib_isupdateable = false
end type

event dw_det::constructor;call super::constructor;string ls_sql



of_SetRowSelect(false)

ls_sql = ' SELECT	ek_estado.id_estado, 						'+&
			'			ek_estado.nombre_completo,			'+&
			'			ek_estado.abreviacion,					'+&
			'			ek_estado.id_pais,							'+&
			'			ek_pais.nombre_completo				'+&
			'	FROM ek_estado JOIN ek_pais					'+&
			'ORDER BY ek_estado.nombre_completo ASC '
			
inv_dwutil.of_genera_dddw_char("estado", ls_sql, 2, "", false, SQLCA)
inv_dwutil.of_propiedades_dddw("estado", "PercentWidth=150,useasborder=yes")
inv_dwutil.of_setvisible_child( "estado", "1", false, true)

ls_sql = 'SELECT id_num_tiporelacion,  nom_tiporelacion FROM sm_tiporelacion    WHERE id_num_tiporelacion > 7 order by 1 '
inv_dwutil.of_genera_dddw_char("parentesco_ref1", ls_sql, 2, "", false, SQLCA)
inv_dwutil.of_propiedades_dddw("parentesco_ref1", "PercentWidth=150,useasborder=yes")
inv_dwutil.of_setvisible_child( "parentesco_ref1", "1", false, true)

inv_dwutil.of_genera_dddw_char("parentesco_ref2", ls_sql, 2, "", false, SQLCA)
inv_dwutil.of_propiedades_dddw("parentesco_ref2", "PercentWidth=150,useasborder=yes")
inv_dwutil.of_setvisible_child( "parentesco_ref2", "1", false, true)


end event

event dw_det::itemchanged;call super::itemchanged;string ls_sql
long ll_cp


choose case dwo.name
	case 'estado'	
		
		ls_sql = 'select id_ciudad, nombre_completo from ek_ciudad where id_estado =  ' + data						
		inv_dwutil.of_genera_dddw_char("ciudad", ls_sql, 2, "", false, SQLCA)
		inv_dwutil.of_propiedades_dddw("ciudad", "PercentWidth=150,useasborder=yes")
		inv_dwutil.of_setvisible_child( "ciudad", "1", false, true)
		
		
		ls_sql = 'select id_municipio, nombre_completo from ek_municipio where id_estado =  ' + data						
		inv_dwutil.of_genera_dddw_char("municipio", ls_sql, 2, "", false, SQLCA)
		inv_dwutil.of_propiedades_dddw("municipio", "PercentWidth=150,useasborder=yes")
		inv_dwutil.of_setvisible_child( "municipio", "1", false, true)
		
	case 'municipio'
		
		ls_sql = 'select id_colonia, nombre_completo from ek_colonia where id_municipio =  ' + data						
		inv_dwutil.of_genera_dddw_char("colonia", ls_sql, 2, "", false, SQLCA)
		inv_dwutil.of_propiedades_dddw("colonia", "PercentWidth=150,useasborder=yes")
		inv_dwutil.of_setvisible_child( "colonia", "1", false, true)

	case 'colonia'
		
		select codigo_postal
		into :ll_cp
		from ek_colonia 
		where id_colonia = :data;
		
		this.setitem( 1, 'cp', string(ll_cp))
		
		
end choose
end event

type tabpage_adicional from w_catalogo_tabdetalle`tabpage_adicional within tab_datos
boolean visible = true
string text = "Bitacora"
end type

type dw_adicional from w_catalogo_tabdetalle`dw_adicional within tabpage_adicional
string dataobject = "d_brow_detalle_contactos"
end type

event dw_adicional::pfc_postinsertrow;call super::pfc_postinsertrow;
long ll_numcte

ll_numcte = dw_maestro.getitemnumber( 1, 'numcte')


//this.setitem( al_row, 'numcte', ll_numcte)
this.setitem( al_row, 'fec_llamada', now())
this.setitem( al_row, 'empleado', gi_agente)
this.setitem( al_row, 'nom_agente', gs_nom_agente)

this.setcolumn( 'observaciones')
this.sort( )

end event

type uo_header from w_catalogo_tabdetalle`uo_header within w_abc_contactos
end type

type dw_detalle from w_catalogo_tabdetalle`dw_detalle within w_abc_contactos
end type

type dw_maestro from w_catalogo_tabdetalle`dw_maestro within w_abc_contactos
integer height = 612
string dataobject = "d_brow_abc_contactos"
end type

event dw_maestro::buttonclicked;call super::buttonclicked;
choose case dwo.name
	case 'b_nuevo'
			
		dw_maestro.reset( )
		dw_maestro.of_setlinkage( false)
		dw_maestro.insertrow(0 )
		parent.event pfc_postopen( )
//		idw_detalle.event pfc_insertrow( )
//		idw_autoriza.event pfc_insertrow( )
end choose


end event

event dw_maestro::constructor;call super::constructor;of_SetRowSelect(false)
//Servicio para validar los campos requeridos

event pfc_insertrow( )

idw_detalle.event pfc_insertrow( )
idw_autoriza.event pfc_insertrow( )
end event

event dw_maestro::pfc_preupdate;call super::pfc_preupdate;
LONG ll_numcte


//verifica si es cliente nuevo
ll_numcte = this.getitemnumber( 1, 'numcte')

if isnull(ll_numcte) then
	
	select coalesce(max(numcte),0) +1
	into :ll_numcte
	from sca_contactos
	;
	
	this.setitem( 1,'numcte', ll_numcte )
	idw_detalle.setitem( 1,'numcte', ll_numcte )
	this.setitem( 1, 'fec_registro', today())
	
//	idw_detalle.setitem( 1,'numcte', ll_numcte )
//	idw_autoriza.setitem( 1,'numcte', ll_numcte )
	
	
end if 

return 1
end event

event dw_maestro::pfc_postinsertrow;call super::pfc_postinsertrow;
this.setcolumn( 'ap_paterno_cte')
end event

event dw_maestro::itemchanged;call super::itemchanged;string  ls_descripcion
long ll_numcte

choose case dwo.name
	case'numcte'
	
		select numcte
		into :ll_numcte 
		from sca_contactos
		where numcte = :data; 
		
		if sqlca.sqlcode <> 0 then 
			messagebox("Aviso","El contacto proporcionado no es correcto, favor de verificar", exclamation! )
			return 1			
		end if 
		
		this.retrieve( long(data))
		
	case 'id_punto_venta'
		
		SELECT sm_punto_venta.descripcion_pv
		INTO :ls_descripcion
		FROM sm_punto_venta 
		WHERE sm_punto_venta.id_identificador IN 
					(SELECT so_identificador_cc.id_identificador	 
					FROM ek010ab JOIN ek090ab ON ek010ab.nivelcc = ek090ab.nivel
							JOIN ek091ab ON ek090ab.nivel = ek091ab.nivel 
							JOIN so_identificador_cc ON so_identificador_cc.id_identificador = ek091ab.id_identificador  
					WHERE ek010ab.num = :gi_numope ) AND 
				sm_punto_venta.activo =1 and
				sm_punto_venta.id_punto_venta = :data
		;
		
		if sqlca.sqlcode <> 0 then 
				messagebox('Aviso','El punto de Venta no es valido', exclamation!)
				return 1
		end if
		this.setitem( row, 'nom_punto_vta', ls_descripcion)
		
		
	
		
	case 'empleado'
		
		select nom_empleado + ' ' +ap_paterno_empleado + ' '+ ap_materno_empleado
		into :ls_descripcion
		from sm_agente
		where empleado = :data and
				 id_categoria = 8 ;
		
		if sqlca.sqlcode <> 0 then 
				messagebox('Aviso','El Empleado no es valido', exclamation!)
				return 1
		end if
		this.setitem( row, 'nom_agente', ls_descripcion)
		
		
	
		
	
		
end choose
end event

event dw_maestro::retrieveend;call super::retrieveend;
string ls_sql, ls_dato

	ls_dato = idw_detalle.getitemstring( 1,'estado')
	ls_sql = 'select id_ciudad, nombre_completo from ek_ciudad where id_estado =  ' + ls_dato				
	idw_detalle.inv_dwutil.of_genera_dddw_char("ciudad", ls_sql, 2, "", false, SQLCA)
	idw_detalle.inv_dwutil.of_propiedades_dddw("ciudad", "PercentWidth=150,useasborder=yes")
	idw_detalle.inv_dwutil.of_setvisible_child( "ciudad", "1", false, true)
			
	ls_sql = 'select id_municipio, nombre_completo from ek_municipio where id_estado =  ' + ls_dato						
	idw_detalle.inv_dwutil.of_genera_dddw_char("municipio", ls_sql, 2, "", false, SQLCA)
	idw_detalle.inv_dwutil.of_propiedades_dddw("municipio", "PercentWidth=150,useasborder=yes")
	idw_detalle.inv_dwutil.of_setvisible_child( "municipio", "1", false, true)
	
	
	ls_dato = idw_detalle.getitemstring( 1,'municipio')	
	ls_sql = 'select id_colonia, nombre_completo from ek_colonia where id_municipio =  ' + ls_dato				
	idw_detalle.inv_dwutil.of_genera_dddw_char("colonia", ls_sql, 2, "", false, SQLCA)
	idw_detalle.inv_dwutil.of_propiedades_dddw("colonia", "PercentWidth=150,useasborder=yes")
	idw_detalle.inv_dwutil.of_setvisible_child( "colonia", "1", false, true)

end event

type st_split_horizontal from w_catalogo_tabdetalle`st_split_horizontal within w_abc_contactos
end type

type gb_maestro from w_catalogo_tabdetalle`gb_maestro within w_abc_contactos
integer height = 740
end type

type gb_detalle from w_catalogo_tabdetalle`gb_detalle within w_abc_contactos
end type

type tabpage_1 from userobject within tab_datos
integer x = 18
integer y = 112
integer width = 3081
integer height = 776
long backcolor = 79741120
string text = "Autorizaci$$HEX1$$f300$$ENDHEX$$n"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_perfila dw_perfila
end type

on tabpage_1.create
this.dw_perfila=create dw_perfila
this.Control[]={this.dw_perfila}
end on

on tabpage_1.destroy
destroy(this.dw_perfila)
end on

type dw_perfila from u_dw within tabpage_1
integer x = 27
integer y = 28
integer width = 3031
integer height = 740
integer taborder = 11
string dataobject = "d_brow_perfila_autoriza"
boolean border = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

this.settrans( sqlca)

//** AQU$$HEX2$$cd002000$$ENDHEX$$SE DEBEN DE HABILITAR TODOS LO SERVICIOS NECESARIOS **//
//Servicio de selecci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowSelect(true)
inv_rowselect.post of_SetStyle(inv_rowselect.SINGLE)

//Servicio de administraci$$HEX1$$f300$$ENDHEX$$n de renglones
of_SetRowManager(True)

//Servicio de b$$HEX1$$fa00$$ENDHEX$$squeda
of_setfind(true)

//Servicio de ordenamiento por columnas
of_SetSort(True)
inv_sort.of_SetStyle (inv_sort.DRAGDROP)
inv_sort.of_SetColumnHeader(TRUE)

//Servicio para validar los campos requeridos
of_SetReqColumn(TRUE)

//Asigna los valores default para el usuario que modifica
Modify("usuario_modifica.Initial='" + Upper(gs_id_usuario) + "'")

//Asigna los valores default para la fecha de modificaci$$HEX1$$f300$$ENDHEX$$n
Modify("fecha_movimiento.Initial='" + String(SQLCA.of_fechaservidor(), "dd/mm/yyyy hh:mm") + "'")

//	Pone visible el dw
Visible = True


// crea la instancia de la DW
idw_autoriza = THIS

of_SetRowSelect(false)


end event

event itemchanged;call super::itemchanged;string ls_descripcion



choose case dwo.name
	case 'encargado'
		
		select nom_empleado + ' ' +ap_paterno_empleado + ' '+ ap_materno_empleado
		into :ls_descripcion
		from sm_agente
		where empleado = :data ;
		
		if sqlca.sqlcode <> 0 then 
				messagebox('Aviso','El Empleado no es valido', exclamation!)
				return 1
		end if
		this.setitem( row, 'nom_empleado', ls_descripcion)
end choose
end event


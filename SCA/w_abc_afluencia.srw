HA$PBExportHeader$w_abc_afluencia.srw
forward
global type w_abc_afluencia from w_catalogo_n2a
end type
end forward

global type w_abc_afluencia from w_catalogo_n2a
end type
global w_abc_afluencia w_abc_afluencia

type variables

n_cst_powerfilter inv_powerfilter 
end variables

on w_abc_afluencia.create
int iCurrent
call super::create
end on

on w_abc_afluencia.destroy
call super::destroy
end on

event open;call super::open;

//Var. para indicar si se realiza el retrieve al cargar
ib_retrieve_inicio = false


isarr_liga_maestro[1] = 'numcte'
isarr_liga_detalle[1] = 'numcte'
end event

event ue_busqueda;call super::ue_busqueda;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

String		ls_valor, ls_where 
Long		ll_punto_venta

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

choose case is_columna_activa 
	case 'numcte'
		gf_f1("AFLUENTES","","","1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		dw_maestro.setitem( 1, 'numcte', long(ls_valor))
		dw_maestro.event itemchanged( 1, dw_maestro.object.numcte, ls_valor)		
		
	case 'id_punto_venta'
		
		ls_where  = 'WHERE sm_punto_venta.id_identificador IN (SELECT so_identificador_cc.id_identificador	 FROM ek010ab JOIN ek090ab ON ek010ab.nivelcc = ek090ab.nivel JOIN ek091ab ON ek090ab.nivel = ek091ab.nivel JOIN so_identificador_cc ON so_identificador_cc.id_identificador = ek091ab.id_identificador  WHERE ek010ab.num = '+ string(gi_numope)  +') AND sm_punto_venta.activo =1'		
		
		gf_f1("PUNTO_VENTA","",ls_where,"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		dw_maestro.setitem( 1, 'id_punto_venta', long(ls_valor))
		dw_maestro.event itemchanged( 1, dw_maestro.object.id_punto_venta, ls_valor)
		
	case 'empleado'
		
		gf_f1("AGENTES","",'',"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		dw_maestro.setitem( 1, 'empleado', long(ls_valor))
		dw_maestro.event itemchanged( 1, dw_maestro.object.empleado, ls_valor)
		
	case 'id_num_canal'
		ll_punto_venta = dw_maestro.getitemnumber(1,'id_punto_venta')
		
		ls_where = ' WHERE smc.id_num_medio = sm_mediopublicidad.id_num_mediopublicidad '+& 
								'AND sm_punto_venta.id_punto_venta = '+string(ll_punto_venta)+ ' '+&
								'AND  smc.activo = 1'
		
		gf_f1("CANAL_VTA","",ls_where,"1",FALSE,SQLCA)
		
		ls_valor = message.stringparm 
		if ls_valor = '' then return 0
		dw_maestro.setitem( 1, 'id_num_canal', long(ls_valor))
		dw_maestro.event itemchanged( 1, dw_maestro.object.id_num_canal, ls_valor)
		
	case 'encargado'
		
		
		
end choose


return 1



end event

type uo_header from w_catalogo_n2a`uo_header within w_abc_afluencia
end type

type dw_detalle from w_catalogo_n2a`dw_detalle within w_abc_afluencia
string dataobject = "d_brow_detalle_afluencia"
end type

event dw_detalle::pfc_postinsertrow;call super::pfc_postinsertrow;long ll_numcte

ll_numcte = dw_maestro.getitemnumber( 1, 'numcte')


//this.setitem( al_row, 'numcte', ll_numcte)
this.setitem( al_row, 'fec_llamada', now())
this.setitem( al_row, 'empleado', gi_agente)
this.setitem( al_row, 'nom_agente', gs_nom_agente)

this.setcolumn( 'observaciones')

end event

event dw_detalle::retrieveend;call super::retrieveend;
//called from menu to toggle powerfilter
inv_powerfilter.ib_checked = TRUE
inv_powerfilter.event ue_clicked()
end event

event dw_detalle::constructor;call super::constructor;
inv_powerfilter = create n_cst_powerfilter
inv_powerfilter.of_setdw(this)
end event

event dw_detalle::resize;call super::resize;

if isvalid(inv_powerfilter) then
	inv_powerfilter.event ue_positionbuttons()
END IF
end event

event dw_detalle::ue_dwlbuttonup;call super::ue_dwlbuttonup;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//post an event to either reposition the powerfilter buttons or handle a buttonclick. ue_buttonclicked will call ue_positionbuttons
inv_powerfilter.event post ue_buttonclicked(dwo)
end event

type dw_maestro from w_catalogo_n2a`dw_maestro within w_abc_afluencia
string dataobject = "d_brow_abc_afluencia"
end type

event dw_maestro::constructor;call super::constructor;
of_SetRowSelect(false)
//Servicio para validar los campos requeridos

event pfc_insertrow( )

end event

event dw_maestro::itemchanged;call super::itemchanged;string 	ls_descripcion
long		ll_punto_venta, ll_numcte



choose case dwo.name
	case'numcte'
	
	
		select numcte
		into :ll_numcte 
		from sca_afluencia
		where numcte = :data; 
		
		if sqlca.sqlcode <> 0 then 
			messagebox("Aviso","El afluente proporcionado no es correcto, favor de verificar", exclamation! )
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
		this.setitem( row, 'descripcion_pv', ls_descripcion)
		
		
	case 'id_num_canal'
		ll_punto_venta = dw_maestro.getitemnumber(1,'id_punto_venta')
		
		SELECT smc.nom_canal
		INTO :ls_descripcion
		FROM sm_mediopublicidad_canal  smc JOIN sm_punto_venta ON smc.id_identificador = sm_punto_venta.id_identificador, sm_mediopublicidad  
		WHERE smc.id_num_medio = sm_mediopublicidad.id_num_mediopublicidad and
					sm_punto_venta.id_punto_venta = :ll_punto_venta and
					smc.activo = 1	and
					smc.id_num_canal = :data
					;
					
		if sqlca.sqlcode <> 0 then 
				messagebox('Aviso','El punto de Venta no es valido', exclamation!)
				return 1
		end if
		this.setitem( row, 'nom_canal', ls_descripcion)
		
		
	case 'empleado'
		
		select nom_empleado + ' ' +ap_paterno_empleado + ' '+ ap_materno_empleado
		into :ls_descripcion
		from sm_agente
		where empleado = :data ;
		
		if sqlca.sqlcode <> 0 then 
				messagebox('Aviso','El Empleado no es valido', exclamation!)
				return 1
		end if
		this.setitem( row, 'nombre_empleado', ls_descripcion)
		
		
	case 'encargado'
		
		select nom_empleado + ' ' +ap_paterno_empleado + ' '+ ap_materno_empleado
		into :ls_descripcion
		from sm_agente
		where empleado = :data ;
		
		if sqlca.sqlcode <> 0 then 
				messagebox('Aviso','El Empleado no es valido', exclamation!)
				return 1
		end if
		this.setitem( row, 'nombre_encargado', ls_descripcion)
		
	case 'id_motivo_visita'
		
end choose
		
end event

event dw_maestro::buttonclicked;call super::buttonclicked;

choose case dwo.name
	case 'b_nuevo'
		dw_maestro.reset( )
		dw_maestro.event pfc_insertrow( )
end choose


end event

event dw_maestro::pfc_postinsertrow;call super::pfc_postinsertrow;
this.setcolumn( 'ap_paterno_cte')

end event

event dw_maestro::pfc_preupdate;call super::pfc_preupdate;
LONG ll_numcte


//verifica si es cliente nuevo
ll_numcte = this.getitemnumber( 1, 'numcte')

if isnull(ll_numcte) then
	
	select coalesce(max(numcte),0) +1
	into :ll_numcte
	from sca_afluencia
	;
	
	this.setitem( 1,'numcte', ll_numcte )
	this.setitem( 1, 'fecha_registro', today())
	
end if 

return 1
end event

type st_split_horizontal from w_catalogo_n2a`st_split_horizontal within w_abc_afluencia
end type

type gb_maestro from w_catalogo_n2a`gb_maestro within w_abc_afluencia
end type

type gb_detalle from w_catalogo_n2a`gb_detalle within w_abc_afluencia
end type


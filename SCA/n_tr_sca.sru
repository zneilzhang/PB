HA$PBExportHeader$n_tr_sca.sru
forward
global type n_tr_sca from n_tr
end type
end forward

global type n_tr_sca from n_tr
end type
global n_tr_sca n_tr_sca

type prototypes
subroutine sp_sun716(string cc,decimal numero) RPCFUNC ALIAS FOR "~"dba~".~"sp_sun716~""
subroutine sp_genera_detalle(string an_obra,long ai_tab,string as_tipop,ref long ai_error) RPCFUNC ALIAS FOR "sp_genera_detalle"
subroutine sp_genera_explosion(string an_obra,long ai_tab,string as_tipo,string as_tipop,ref long ai_error) RPCFUNC ALIAS FOR "sp_genera_explosion"
subroutine sp_tarjeta_en_basico(string an_obra,decimal an_insumo,decimal an_tarjeta,ref long ai_encontro) RPCFUNC ALIAS FOR "sp_tarjeta_en_basico"
subroutine sp_act_precio_insumo(string an_obra,long ai_tabulador,decimal an_insumo,decimal an_precio) RPCFUNC ALIAS FOR "sp_act_precio_insumo"
subroutine sp_valua_mo_tarjeta(string an_obra,decimal an_tarjeta,ref decimal an_importe,ref string as_proceso,ref long ai_error) RPCFUNC ALIAS FOR "sp_valua_mo_tarjeta"
subroutine sp_gral_explo(string as_tipo,long ai_tabulador,string an_obra,decimal an_frente,decimal an_partida,ref long an_id_explo,string as_tipop,ref long ai_error) RPCFUNC ALIAS FOR "sp_gral_explo"
subroutine sp_copia_tarjetas(string an_obra,string as_tipo,ref long ai_error) RPCFUNC ALIAS FOR "sp_copia_tarjetas"
subroutine sp_copia_explo(long ai_tabulador,string an_obra,string as_tipop,ref long ai_error) RPCFUNC ALIAS FOR "sp_copia_explo"
subroutine sp_explosion_tar_kontrol(string an_obra,long ai_id_explo,decimal an_tarjeta,ref long ai_error) RPCFUNC ALIAS FOR "sp_explosion_tar_kontrol"
subroutine sp_genera_det_kontrol(string an_obra,long an_presup,long an_explo,string as_tipop,decimal an_tarjeta,long an_secuencia,ref long ai_error) RPCFUNC ALIAS FOR "sp_genera_det_kontrol"

// Modificados por MARC el 31/Ago/2000 Se les agrego el Tipo de Presupuesto (B, I, K)
// M$$HEX1$$f300$$ENDHEX$$dulo de PRESUPUESTOS
subroutine sp_actualizar_frentes(string as_obra,long an_frente,string as_desc_frente,decimal an_factor,string as_desc_factor,string as_operacion,string an_tipo_presupuesto,ref string as_error,ref long ai_error) RPCFUNC ALIAS FOR "sp_actualizar_frentes"
subroutine sp_actualizar_partidas( string CVEOPERACION, string OLD_AS_OBRA, decimal OLD_AN_PARTIDA, string OLD_AS_DS_PARTIDA, string NEW_AS_OBRA, decimal NEW_AN_PARTIDA, string NEW_AS_DS_PARTIDA, decimal NEW_AN_FRENTE, string NEW_AS_TIPO, decimal NEW_mnvaluacion, decimal NEW_indirectos, ref long AI_ESTADO, ref string AS_MENSAJE_ERROR ) RPCFUNC ALIAS FOR "sp_actualizar_partidas"
//subroutine sp_actualizar_partidas( string CveOperacion, string old_as_obra, decimal old_an_partida, string old_as_ds_partida, string new_as_obra, decimal new_an_partida, string new_as_ds_partida, decimal new_an_frente, string new_an_tipo, ref long ai_estado, ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualizar_partidas"

// Modificado el 6/Nov/2000
subroutine sp_actualizar_ppto_tarjetas(string CveOperacion,string old_as_obra,decimal old_an_frente,decimal old_an_partida,string old_as_tipo,decimal old_an_tarjeta,long old_an_secuencia,long old_an_id_mascara,decimal old_an_id,string new_as_obra,decimal new_an_frente,decimal new_an_partida,string new_as_tipo,decimal new_an_tarjeta,long new_an_secuencia,string new_as_referencia,decimal new_an_cantidad,decimal new_an_precio,decimal new_an_importe,long new_an_id_mascara,decimal new_orden,ref long ai_estado,ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualizar_ppto_tarjetas"
subroutine sp_actualizar_su_ppto_mascaras(string CveOperacion, decimal old_an_id_mascara, string old_as_ds_mascara, decimal old_an_id, string new_as_ds_mascara, decimal new_an_id, ref long ai_estado, ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualizar_su_ppto_mascaras"

// Modificado el 2/Ene/2001, se le quit$$HEX2$$f3002000$$ENDHEX$$la descripcion vieja y se agrego el campo orden
subroutine sp_actualizar_su_ppto_titulo(string CveOperacion,string old_as_obra,decimal old_an_frente,decimal old_an_partida,string old_as_tipo,long old_an_secuencia,decimal old_an_id_titulo,string new_as_obra,decimal new_an_frente,decimal new_an_partida,string new_as_tipo,long new_an_secuencia,string new_as_ds_titulo,decimal new_an_orden,ref long ai_estado,ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualizar_su_ppto_titulo"

subroutine sp_validar_copiar_tarjeta(long an_tarjeta_origen,long an_tarjeta_destino,string an_obra_origen,string an_obra_destino,string as_operacion,ref long ai_error) RPCFUNC ALIAS FOR "sp_validar_copiar_tarjeta"

subroutine sp_explosion_tarjeta_gral( string an_obra,integer an_frente,integer an_partida,string as_tipo_explosion,long an_explosion,long an_tabulador,long an_tarjeta,long an_cantidad_tarjetas,decimal an_monto_tarjeta,ref long ai_error) RPCFUNC ALIAS FOR "sp_explosion_tarjeta_gral"
subroutine sp_explosion_principal( string an_obra,string as_tipo_explosion,long ai_tabulador,ref long ai_error) RPCFUNC ALIAS FOR "sp_explosion_principal"
subroutine sp_act_insumo_obra( string an_obra,decimal an_insumo,decimal an_tarjeta, string as_descripcion, string as_unidad) RPCFUNC ALIAS FOR "sp_act_insumo_obra"

// MARC 26/Oct/2000
subroutine sp_actualiza_su_precios_insumo(	string CveOperacion,string as_obra,long an_tabulador,decimal an_insumo,decimal new_an_precio_insumo,date new_ad_fe_precio,ref long ai_error,ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualiza_su_precios_insumo"
// jar SE DEJE DE UTILIZAR ESTE SP POR LO QUE HAY QUE DEPURARLO
// jar 09-09-2003
//subroutine sp_actualiza_insumos(	string CveOperacion,decimal an_insumo,string as_descripcion,string as_unidad,decimal an_tipo,decimal an_grupo,ref long ai_error,ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualiza_insumos"
subroutine sp_calc_ind_x_obra(string as_obra,decimal an_monto,long an_tabulador) RPCFUNC ALIAS FOR "sp_calc_ind_x_obra"
subroutine sp_inicializar_explosion(string as_obra,long ai_tab,string as_tipo_explosion,ref long ai_error) RPCFUNC ALIAS FOR "sp_inicializar_explosion"



// SP explosion general
subroutine sp_generar_expl_kontrol(string as_obra,long an_tabulador, string as_tipop, ref string as_proceso,ref long an_error) RPCFUNC ALIAS FOR "sp_generar_expl_kontrol"

// sp_generacion de ppto Base
subroutine sp_inicializar_ppto_base(string as_obra,ref long ai_error) RPCFUNC ALIAS FOR "sp_inicializar_ppto_base"
subroutine sp_registrando_ppto_base(string as_obra,long an_tabulador,ref long ai_error) RPCFUNC ALIAS FOR "sp_registrando_ppto_base"

// MARC  14/Ene/2001
subroutine sp_actualiza_su_precios_insumos_base(string CveOperacion,string as_obra,decimal an_insumo,long an_tabulador,decimal an_precio_insumo,ref long ai_error,ref string as_mensaje_error) RPCFUNC ALIAS FOR "sp_actualiza_su_precios_insumos_base"

// JAR 1701/2001
// Proceso de actualizacion de amortizaciones
subroutine sp_proceso_actualizaciones_amortiza(string as_obra,decimal an_estimacion_id,ref long ai_error) RPCFUNC ALIAS FOR "sp_proceso_actualizaciones_amortiza"
subroutine sp_desactualizar_estimacion(string as_obra,long an_estimacion_id,ref long ai_error) RPCFUNC ALIAS FOR "sp_desactualizar_estimacion"

// JAR 19/01/2001
subroutine sp_obtener_indirectos(string as_obra,decimal an_tarjeta,ref decimal an_monto_indirectos,ref long ai_error) RPCFUNC ALIAS FOR "sp_obtener_indirectos"


// MARC  26/Ene/2001
subroutine sp_carga_obra(string as_obra,string as_tipo_ppto) RPCFUNC ALIAS FOR "sp_carga_obra"

// JAR 07/02/2001
// LAC:14/02/2005: Agregue parametro de LAB
//subroutine sp_generar_ordenes_compra(string as_obra,decimal an_estimacion_id,decimal an_contratista_ini,decimal an_contratista_fin,decimal an_solicito,decimal an_autorizo,decimal an_vobo,decimal an_comprador,long an_libre_abordo, long ai_error) RPCFUNC ALIAS FOR "sp_generar_ordenes_compra"
subroutine sp_generar_ordenes_compra(string as_obra,decimal an_estimacion_id,decimal an_contratista_ini,decimal an_contratista_fin,decimal an_solicito,decimal an_autorizo,decimal an_vobo,decimal an_comprador,date ad_fecha_oc,long an_libre_abordo, long ai_error) RPCFUNC ALIAS FOR "sp_generar_ordenes_compra"


// JAR 022020001 
subroutine sp_actualizar_estimaciones_cte(string as_obra,decimal an_estimacion_id,string as_tipo_proceso,long ai_error) RPCFUNC ALIAS FOR "sp_actualizar_estimaciones_cte"
subroutine sp_desactualizar_estimaciones_ctes(string as_obra,decimal an_estimacion_id,long ai_error) RPCFUNC ALIAS FOR "sp_desactualizar_estimaciones_ctes"

//VGA 13/03/01
subroutine sp_insertar_tarjeta_base(string AS_OBRA_ORIGEN,string AS_ORIGEN,long AN_TARJETA_INSERTAR,long AN_ID_BASE,long AI_FRENTE,long AI_PARTIDA,long AI_SEC,decimal AN_CANT,decimal AN_PRECIO,long an_folio_orden , long AI_ERROR) RPCFUNC ALIAS FOR "sp_insertar_tarjeta_base"

// JAR 27/mar/2001 Se habilito la opcion de eliminar obra
subroutine sp_eliminar_obra(string AS_OBRA,decimal AN_OPCION,ref long An_ERROR) RPCFUNC ALIAS FOR "sp_eliminar_obra"

// JAR 9/04/2001 opcion de Actualizacion de Consumos Reales
subroutine sp_actualizar_consumos_reales(string as_obra,decimal an_estimacion_id,long ai_error) RPCFUNC ALIAS FOR "sp_actualizar_consumos_reales"

// JAR 26/04/2001 Opcion de copia de tabuladores de obra
subroutine sp_copiar_tabulador_a_obra(string as_obra_origen,string as_obra_destino,long an_tabulador_origen,long an_tabulador_destino,decimal an_remplazar_existentes,decimal an_factor,long an_insumo_inicial,long an_insumo_final ,decimal an_error) RPCFUNC ALIAS FOR "sp_copiar_tabulador_a_obra"

//JAR 03/06/2001 COPIAS INTERCIOMPANIAS
subroutine sp_cpy_intercia_save(long an_opcion, string as_obra_origen, string as_obra_destino, long an_tarjeta_ini, long an_tarjeta_fin) RPCFUNC ALIAS FOR "sp_cpy_intercia_save"
subroutine sp_cpy_inter_cia_create(long an_opcion,ref string as_tabla,ref string as_select) RPCFUNC ALIAS FOR "sp_cpy_inter_cia_create"

// JAR 04/08/2001 AVANCE DE OBRA
subroutine sp_inicializar_avances_ajustados(string AS_OBRA,ref long AN_ERROR) RPCFUNC ALIAS FOR "sp_inicializar_avances_ajustados"

// JAR 22/08/2001 ACTUALIZAR PARA TARJETAS de UNA OBRA UNIVERSAL
subroutine sp_actualizar_tarjetas_del_universal(string ls_obra_actualizar,long an_error) RPCFUNC ALIAS FOR "sp_actualizar_tarjetas_del_universal"

// JAR 02/10/2001 Obtener los avances de Obra en base a Avances a Clientes
subroutine sp_ao_convertir_avances(string as_obra,decimal an_estimacion_id, decimal an_estimacion_id_fin) RPCFUNC ALIAS FOR "sp_ao_convertir_avances"
subroutine sp_ao_explosion_avance_ctes(string as_obra,decimal an_estimacion_id) RPCFUNC ALIAS FOR "sp_ao_explosion_avance_ctes"
subroutine sp_ao_convertir_avances_mat(string as_obra,decimal an_estimacion_id) RPCFUNC ALIAS FOR "sp_ao_convertir_avances_mat"


// JAR 10/10/2001
subroutine sp_generar_ppto_kontrol(string as_obra) RPCFUNC ALIAS FOR "sp_generar_ppto_kontrol"

// JAR 25/10/2001
//subroutine sp_generar_consumos_reales_contratistas(string as_obra,long an_estimacion_ini,long an_estimacion_fin,long an_tipo_opcion) RPCFUNC ALIAS FOR "sp_generar_consumos_reales_contratistas"
subroutine sp_generar_consumos_reales_contratistas(string as_obra,long an_estimacion_ini,long an_estimacion_fin,long an_tipo_opcion,date ad_fecha_ini,date ad_fecha_fin,long an_tipo_consumos) RPCFUNC ALIAS FOR "sp_generar_consumos_reales_contratistas"


//13/12/2001 sp para mostrar solo los insumos que se encuentran participando dentro de la obnra
subroutine sp_obtener_insumos_obra(string as_obra) RPCFUNC ALIAS FOR "sp_obtener_insumos_obra"


// 12/02/2002 sp para consumos de area cuenta para deme
subroutine sp_obtener_consumos_acta(string as_obra,string as_cc,date ad_fecha_ini,date ad_fecha_fin) RPCFUNC ALIAS FOR "sp_obtener_consumos_acta"


// 28/02/2002 SP PARA LA COPIA DE PARTIDAS
subroutine sp_copia_obra_fte_pda_local(string AS_OBRA_ORIGEN,decimal AN_FTE_ORIGEN,decimal AN_PDA_ORIGEN,string AS_OBRA_DESTINO,decimal AN_FTE_DESTINO,decimal AN_PDA_DESTINO,ref long AI_ERROR) RPCFUNC ALIAS FOR "sp_copia_obra_fte_pda_local"

// 04/03/2002 JAR	Copia las tarjetas de una obra hacia otra obra de destino
subroutine sp_remplaza_tarjeta(string AS_obra_origen,long an_tarjeta_origen,string as_obra_destino) RPCFUNC ALIAS FOR "sp_remplaza_tarjeta"

//06/03/2002 JAR 
subroutine sp_sun333_01(string as_obra) RPCFUNC ALIAS FOR "sp_sun333_01"

//14/03/2002 JAR
subroutine sp_saldos_contratistas_x_cc(string as_cc,date an_fecha_generacion) RPCFUNC ALIAS FOR "sp_saldos_contratistas_x_cc"

//25/04/2002 EGC
subroutine sp_sun320_01(string as_obra, integer ai_tabulador ) RPCFUNC ALIAS FOR "sp_sun320_01"

//07/05/2002 JAR
subroutine sp_sun301_01(string AS_oBRA) RPCFUNC ALIAS FOR "sp_sun301_01"

//1105/2002
subroutine sp_ek_225_01(long AN_INSUMO,ref long AN_EXISTE_INSUMO,ref string as_descripcion) RPCFUNC ALIAS FOR "sp_ek_225_01"

//30/05/2002 EGC
Subroutine sp_registro_ppto_cte(String as_obra) RPCFUNC Alias For "sp_registro_ppto_cte"

//04/06/2002 jar
subroutine sp_actualiza_aditiva_cte(string AS_OBRA_ORIGEN,string AS_ORIGEN,long AN_TARJETA_INSERTAR,decimal AN_ID_BASE,long AI_FRENTE,long AI_PARTIDA,long AI_SEC,decimal AN_CANT,decimal AN_PRECIO,long AN_TIPO_MOV,long AN_FOLIO_OC,long AI_ERROR) RPCFUNC ALIAS FOR "sp_actualiza_aditiva_cte"
subroutine sp_sun708_01(string as_obra,long an_estimacion_id,string as_tipo_proceso,long ai_error) RPCFUNC ALIAS FOR "sp_sun708_01"

//12/06/2002 egc
Subroutine sp_aplica_avance_masivo(string as_obra, integer an_estimacion) RPCFUNC Alias For "sp_aplica_avance_masivo"
subroutine sp_copia_precios(string AS_OBRA,long AN_TAB_DEST,long AN_TAB_ORIG,double AN_PORCENTAJE) RPCFUNC ALIAS FOR "sp_copia_precios"
// 18/07/2002
subroutine sp_sun375_01(string as_obra) RPCFUNC ALIAS FOR "sp_sun375_01"
subroutine sp_sun375_02(string AS_OBRA) RPCFUNC ALIAS FOR "sp_sun375_02"

// 01/AGO/20002
subroutine sp_sun_898_01_01(decimal AN_PROYECTO,string as_obra) RPCFUNC ALIAS FOR "sp_sun_898_01_01"
subroutine sp_sun898_20(decimal AN_PROYECTO,string as_obra) RPCFUNC ALIAS FOR "sp_sun898_20"
subroutine sp_sun_898_30_01(decimal AN_PROYECTO,string as_obra,date AD_FECHA_FIN) RPCFUNC ALIAS FOR "sp_sun_898_30_01"
subroutine sp_sun_898_40_01(decimal AN_PROYECTO,string as_obra,date AD_FECHA_FIN) RPCFUNC ALIAS FOR "sp_sun_898_40_01"
subroutine sp_sun_898_60_01(decimal AN_PROYECTO,string as_obra,date AD_FECHA_FIN) RPCFUNC ALIAS FOR "sp_sun_898_60_01"
subroutine sp_sun898_01(decimal AN_PROYECTO,decimal AN_INSUMO,decimal AN_TIPO_IMPORTE,decimal AN_CANTIDAD,decimal AN_IMPORTE) RPCFUNC ALIAS FOR "sp_sun898_01"
subroutine sp_sun898_01_02(decimal AN_PROYECTO,string AS_OBRA,decimal AN_TIPO_IMPORTE) RPCFUNC ALIAS FOR "sp_sun898_01_02"
subroutine sp_sun898_10(decimal AN_PROYECTO,string as_obra) RPCFUNC ALIAS FOR "sp_sun898_10"
subroutine sp_sun898_30(decimal AN_PROYECTO,string as_obra,date AD_FECHA_FIN) RPCFUNC ALIAS FOR "sp_sun898_30"
subroutine sp_sun898_40(decimal AN_PROYECTO,string as_obra,date AD_FECHA_FIN) RPCFUNC ALIAS FOR "sp_sun898_40"
subroutine sp_sun898_50(decimal AN_PROYECTO,string as_obra) RPCFUNC ALIAS FOR "sp_sun898_50"
subroutine sp_sun898_60(decimal AN_PROYECTO,string as_obra,date AD_FECHA_FIN) RPCFUNC ALIAS FOR "sp_sun898_60"
subroutine sp_sun898_70(decimal AN_PROYECTO,string as_cc,date ad_fecha_FIN,ref long an_error) RPCFUNC ALIAS FOR "sp_sun898_70"
subroutine sp_sun898_80(decimal AN_PROYECTO,string as_obra,string as_cc,date ad_fecha_fin,ref long an_error) RPCFUNC ALIAS FOR "sp_sun898_80"
subroutine sp_sun898_90(decimal AN_PROYECTO,string as_obra,string as_cc,date ad_fecha_fin,ref long an_error) RPCFUNC ALIAS FOR "sp_sun898_90"
subroutine sp_sun898_100(decimal AN_PROYECTO,string as_obra,string as_cc,date ad_fecha_fin,ref long an_error) RPCFUNC ALIAS FOR "sp_sun898_100"
subroutine sp_sun898_120(decimal AN_PROYECTO,string as_obra,string as_cc,date ad_fecha_fin,ref long an_error) RPCFUNC ALIAS FOR "sp_sun898_120"

// copias del presupuesto
subroutine sp_sun441_02(string as_obra_origen,decimal an_frente_origen,decimal an_partida_origen,decimal an_secuencia_origen,string as_tipo_origen,string as_obra_destino,decimal an_frente_destino,decimal an_partida_destino,decimal an_secuencia_destino,string as_tipo_destino, long an_tarjeta) RPCFUNC ALIAS FOR "sp_sun441_02"
subroutine sp_sun441_03(string as_obra_origen,decimal an_frente_origen,decimal an_partida_origen,string as_tipo_origen,string as_obra_destino,decimal an_frente_destino,decimal an_partida_destino,string as_tipo_destino) RPCFUNC ALIAS FOR "sp_sun441_03"
subroutine sp_sun441_04(string as_obra_origen,decimal an_frente_origen,string as_tipo_origen,string as_obra_destino,decimal an_frente_destino,string as_tipo_destino) RPCFUNC ALIAS FOR "sp_sun441_04"

// procedumientos para consultas de basicos
subroutine sp_sun336_01(string as_obra) RPCFUNC ALIAS FOR "sp_sun336_01"



subroutine sp_corredor_scripts(string as_instruccion) RPCFUNC ALIAS FOR "sp_corredor_scripts"

subroutine sp_sun766_01(string AS_OBRA,long AN_FRENTE,long AN_FACTOR_FRENTE,long AN_SECTOR_ID,string as_cc) RPCFUNC ALIAS FOR "sp_sun766_01"
subroutine sp_sun767_01(string AS_CC) RPCFUNC ALIAS FOR "sp_sun767_01"

// proceso de generacion del insumos de presupuesto de kontrol
subroutine sp_sun511_05(string AS_OBRA) RPCFUNC ALIAS FOR "sp_sun511_05"

// proceso para extraer el monto del tipo de insumo para una tarjeta
subroutine sp_obtener_mto_tipo(string as_obra,decimal an_tarjeta,decimal an_tipo_insumo,decimal an_cantidad_ins,ref decimal an_monto_tipo,long an_error) RPCFUNC ALIAS FOR "sp_obtener_mto_tipo"

// proceso para copiar tarjetas al arrastrarlas
subroutine sp_sun330_05(string AS_obra_origen,decimal an_tarjeta_origen,string as_obra_destino) RPCFUNC ALIAS FOR "sp_sun330_05"

// MARC 09/02/2001
subroutine sp_copiar_insumos_tarjeta(decimal an_tarjeta_origen,decimal an_tarjeta_destino,string as_obra_origen,string as_obra_destino,decimal an_tabulador,string as_operacion,decimal an_basico,decimal an_tipo,decimal an_grupo,ref decimal ai_error ) RPCFUNC ALIAS FOR "sp_copiar_insumos_tarjeta"

// calculo de porcentajes de lotes
subroutine sp_calcular_rangos_avance(string as_obra,decimal an_estimacion_id) RPCFUNC ALIAS FOR "sp_calcular_rangos_avance"

end prototypes

on n_tr_sca.create
call super::create
end on

on n_tr_sca.destroy
call super::destroy
end on


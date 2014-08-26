HA$PBExportHeader$n_cst_principal_appmanager_sca.sru
forward
global type n_cst_principal_appmanager_sca from n_cst_principal_appmanager
end type
end forward

global type n_cst_principal_appmanager_sca from n_cst_principal_appmanager
end type
global n_cst_principal_appmanager_sca n_cst_principal_appmanager_sca

type variables

string is_id_identificador, is_logorep

end variables

forward prototypes
public function integer of_carga_kontrol_ini (ref n_ds ads_kontrol_ini)
end prototypes

public function integer of_carga_kontrol_ini (ref n_ds ads_kontrol_ini);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_Carga_Kontrol_ini
//
//  DESCRIPCION		: Carga en un datastore el contenido de kontrol.ini
//								las companias definidas en el ini
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  10/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	- Modificacion
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_contador, li_total, li_contador2, li_total2
long		ll_renglon, ll_id_grupo_usuario
string	lsarr_secciones[], lsarr_key[], ls_vacio[], ls_seccion, &
			ls_criterio, ls_ini_file, ls_key, ls_valor, ls_lista_objetos
n_cst_inifile  lnv_ini_handler

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF isvalid(ads_kontrol_ini) THEN DESTROY ads_kontrol_ini

ads_kontrol_ini = create n_ds
ads_kontrol_ini.dataobject = 'd_ex_gr_kontrol_ini'

RETURN 1 //NO CARGA EL KONTROL INI EN MEMORIA

ls_ini_file = gnv_app.of_GetAppINIFile()
ls_lista_objetos = upper(ads_kontrol_ini.Describe("datawindow.objects"))

//Obtiene el listado de secciones de companias del kontrol.ini
li_total = lnv_ini_handler.of_GetSections(ls_ini_file, lsarr_secciones)

for li_contador = 1 to li_total
	ls_seccion = lsarr_secciones[li_contador]
	
	//Checa si es una seccion de compania valida
	if isnumber(ls_seccion) then
		//revisa si no existe ya la compania dada de alta
		ls_criterio = "cia = '" + ls_seccion + "'"
		if ads_kontrol_ini.find(ls_criterio, 1, ads_kontrol_ini.rowcount()) > 0 then continue
		ll_renglon = ads_kontrol_ini.insertrow(0)
		ads_kontrol_ini.setitem(ll_renglon, "cia",ls_seccion)
		lsarr_key = ls_vacio
		li_total2 = lnv_ini_handler.of_GetKeys (ls_ini_file, ls_seccion, lsarr_key )
		for li_contador2 = 1 to li_total2
			ls_key = lsarr_key[li_contador2]
			//Checa si el key es correcto
			if pos(ls_lista_objetos, ls_key ) = 0 then continue
			ls_valor = profilestring ( ls_ini_file, ls_seccion, ls_key, '' )
			ads_kontrol_ini.setitem(ll_renglon, ls_key, ls_valor)
		next
	end if
next

return 1
end function

on n_cst_principal_appmanager_sca.create
call super::create
end on

on n_cst_principal_appmanager_sca.destroy
call super::destroy
end on

event constructor;call super::constructor;
gs_version	=	'1.0.0.0.0'
gs_sistema = "SCA"

// Nombre de la aplicaci$$HEX1$$f300$$ENDHEX$$n
iapp_object.DisplayName="Sistema de Contactos y Afluencia" 
end event

event pfc_logon;call super::pfc_logon;//------------------------------------------------------------------
//  MODULO/FUNCION	: pfc_logon
//
//  DESCRIPCION		: Aqu$$HEX2$$ed002000$$ENDHEX$$se realiza la conexi$$HEX1$$f300$$ENDHEX$$n a la Base de Datos
//							  de acuerdo a los par$$HEX1$$e100$$ENDHEX$$metros dados de usuario y
//							  password
// 
//  EVENTO/ARGUMENTOS: 
//		as_userid	:	User ID que se intenta conectar
//		as_password :	Password de acceso con que se intenta conectar
//
//  DEVUELVE			:
//		  1	: 	Si hubo conexi$$HEX1$$f300$$ENDHEX$$n
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  15/DIC/09	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
string ls_database

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

IF SQLCA.of_conectarCiaEK( "dba", is_PassAdmin, as_userid) <> 1 THEN RETURN -1


IF NOT inv_seguridad.of_seguridad(as_userid, as_password) THEN
	SQLCA.of_Disconnect()
	return -1
END IF

SQLCA.of_disconnect( )
IF SQLCA.of_conectarciaek(gs_Nombre_Usuario, gs_pass, gs_num_cia) <> 1 THEN RETURN -1

//Inicializa el n$$HEX1$$fa00$$ENDHEX$$mero de sesi$$HEX1$$f300$$ENDHEX$$n
gdec0_spid = SQLCA.of_getSPID()

Return 1
end event

event pfc_open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
Integer  li_rc, li_estilomsg
String ls_debug_log, ls_estilo
n_ds lds_mensajes
n_cst_platform lnv_platform
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

SetPointer(Hourglass!)

//Inicializa la variable global del nombre de la aplicaci$$HEX1$$f300$$ENDHEX$$n
gs_NombreApp = iapp_object.DisplayName

gs_ejecutableapp = of_obtiene_exe() 

f_SetPlatform(lnv_platform,TRUE)

gs_UserNombrePC = lnv_platform.of_getComputerName()
gs_UserID = lnv_platform.of_getUserID()

f_SetPlatform(lnv_platform,FALSE)

IF RegistryGet ( gnv_app.of_GetAppKey(), "Tema", regstring!, gs_temaactual ) <> 1 THEN
	gs_temaactual = "BLUE"
	RegistrySet(of_GetAppKey(),  "Tema", RegString!, gs_temaactual)
END IF

//----------------------- Servicio Errores -----------------------------------------------------------------------
of_SetError(TRUE)

lds_mensajes = CREATE n_ds
lds_mensajes.dataobject = 'd_definedmessages2'

inv_error.of_SetPredefinedSource(lds_mensajes)

IF RegistryGet ( gnv_app.of_GetAppKey(), "DebugLog", regstring!, ls_debug_log ) <> 1 THEN
	ls_debug_log = "0"
	RegistrySet(of_GetAppKey(),  "DebugLog", regstring!, ls_debug_log)
END IF

IF RegistryGet ( gnv_app.of_GetAppKey(), "TipoMensajeErr", regstring!, ls_estilo ) <> 1 THEN
	ls_estilo = "0"
	RegistrySet(of_GetAppKey(),  "TipoMensajeErr", regstring!, ls_estilo )
END IF

IF NOT ISNULL(ls_debug_log) AND LEN(TRIM(ls_debug_log)) > 1 THEN 
	inv_error.of_SetLogFile(ls_debug_log) 
	inv_error.of_SetLogSeverity(5)
END IF

li_estilomsg = long(ls_estilo)
//1 - Mensajes de error personalizados de PFC
//0 - Estandar de windows
inv_error.of_SetStyle(li_estilomsg)

//----------------------- Servicio Errores -----------------------------------------------------------------------

//----------------------- Servicio Debug  -----------------------------------------------------------------------
//of_SetDebug(TRUE)
//inv_debug.of_SetSQLSpy(TRUE)
//inv_debug.of_Message("Opening window w_test")
//inv_debug.of_OpenLog(TRUE)
//inv_debug.inv_sqlspy.of_OpenSQLSpy(TRUE)
//inv_debug.of_SetDWProperty(TRUE)
//inv_debug.of_SetAlwaysOnTop (TRUE)
//----------------------- Servicio Debug  -----------------------------------------------------------------------

//Abre la ventana del logon del usuario
li_rc = gnv_app.of_LogonDlg( )

IF li_rc <> 1 THEN 
	This.PostEvent ("pfc_close")
	RETURN
END IF


//carga el agente que se loggeo
select empleado, nom_empleado+ ' ' +ap_paterno_empleado+ ' '+ap_materno_empleado
into :gi_agente, :gs_nom_agente
from sm_agente
where id_usuario = :gi_numope;



//Abre la ventana principal
Open(w_principal_frame)

//Open(w_selecciona_obra)

//Define si el modo de trabajo permite multiples tab
w_principal_frame.ib_multiplesTab = TRUE


end event


HA$PBExportHeader$n_cst_principal_appmanager.sru
forward
global type n_cst_principal_appmanager from n_cst_appmanager
end type
end forward

global type n_cst_principal_appmanager from n_cst_appmanager
end type
global n_cst_principal_appmanager n_cst_principal_appmanager

type prototypes
FUNCTION long IsWow64Process(long hwnd, ref  boolean Wow64Process) &
    LIBRARY "Kernel32.DLL"

FUNCTION long GetCurrentProcess ()  LIBRARY "KERNEL32.DLL"
end prototypes

type variables
//Var. para almacenar la ruta del EXE
string	is_rutaexe = ""
n_cst_seguridad inv_seguridad
n_ds ids_kontrol_ini
string is_logorep

string is_PassAdmin
end variables

forward prototypes
public function integer of_inicializa_globales ()
public function integer of_carga_odbc (ref n_ds ads_dsn)
public function string of_obtiene_directorioexe ()
public function string of_obtiene_exe ()
public function boolean of_devmode ()
public function boolean of_wow64 ()
public function integer of_carga_kontrol_ini (ref n_ds ads_kontrol_ini)
end prototypes

public function integer of_inicializa_globales ();//Var. nulas
setnull(gs_nulo)
setnull(gi_nulo)
setnull(gl_nulo)
setnull(gd_nulo)
setnull(gdt_nulo)
setnull(gdec_nulo)

of_carga_kontrol_ini(ids_kontrol_ini)

is_PassAdmin = inv_seguridad.of_getpassword( )


return 1
end function

public function integer of_carga_odbc (ref n_ds ads_dsn);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_carga_odbc
//
//  DESCRIPCION		: Carga en un datastore los origenes de datos
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  10/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string lsarr_dsnkeys[], lsarr_dsnvalues[], ls_value, ls_contenido,  lsarr_values[]
long ll_index, ll_valueindex, ll_row
integer li_rtn
string ls_dsnkeys, ls_lista_objetos

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ls_dsnkeys = "HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI"

li_rtn = RegistryValues("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI\ODBC Data Sources", lsarr_dsnvalues) 

IF li_rtn = -1 THEN RETURN -1

IF IsValid(ads_dsn) THEN DESTROY ads_dsn

ads_dsn = CREATE n_ds
ads_dsn.dataobject = 'd_ex_gr_dsn'
ls_lista_objetos = upper(ads_dsn.Describe("datawindow.objects"))

FOR ll_index = 1 TO Upperbound(lsarr_dsnvalues)
	
	ll_row = ads_dsn.InsertRow(0)
	ads_dsn.object.dsn[ll_row] = lsarr_dsnvalues[ll_index]
	
	IF RegistryValues(ls_dsnkeys + "\" + lsarr_dsnvalues[ll_index], lsarr_values) = 1 THEN
		
		FOR ll_valueindex = 1 TO Upperbound(lsarr_values)
			
			ls_value = lsarr_values[ll_valueindex]
			
			RegistryGet(ls_dsnkeys + "\" + lsarr_dsnvalues[ll_index], ls_value, RegString!, ls_contenido)
			
			IF pos(ls_lista_objetos, upper(ls_value)) > 0 THEN ads_dsn.SetItem(ll_row, ls_value, ls_contenido)

		NEXT
	ELSE
		Messagebox(gs_nombreapp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al obtener los origenes da datos", exclamation!)
	END IF
NEXT

return 1
end function

public function string of_obtiene_directorioexe ();//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_obtiene_directorioexe
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que devuelve el directorio desde el cual se
// 							est$$HEX2$$e1002000$$ENDHEX$$ejecutando el EXE
//								
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  El directorio	: 	Si no hubo errores
//		  ""					:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  6/MAY/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
application app
string ls_FullPath
string ls_Exe, ls_apppath
int li_PathLength
int li_Pos = 0

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

app = GetApplication ()

ls_FullPath = Space (255)

// For win nt
li_PathLength = GetModuleFileNameA (Handle (app), ls_FullPath, 255)

if (li_PathLength > 0) then
	
	// ls_AppPath will be something line <drive>:<full path>\<exe name>
	// You can then strip off the exe name using:
	do while (Pos (ls_FullPath, "\", li_Pos + 1) > 0)
	li_Pos = Pos (ls_FullPath, "\", li_Pos + 1)
	loop
	
	ls_AppPath = Mid (ls_FullPath, 1, li_Pos - 1)
	ls_Exe = Mid (ls_FullPath, li_Pos + 1)
end if

return ls_AppPath

end function

public function string of_obtiene_exe ();//------------------------------------------------------------------
//  MODULO/FUNCION	:	of_obtiene_exe
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que devuelve el directorio desde el cual se
// 							est$$HEX2$$e1002000$$ENDHEX$$ejecutando el EXE
//								
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  El directorio	: 	Si no hubo errores
//		  ""					:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  6/MAY/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
application app
string ls_FullPath
string ls_Exe, ls_apppath
int li_PathLength
int li_Pos = 0

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

app = GetApplication ()

ls_FullPath = Space (255)

// For win nt
li_PathLength = GetModuleFileNameA (Handle (app), ls_FullPath, 255)


return ls_FullPath

end function

public function boolean of_devmode ();//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_devmode
//
//  DESCRIPCION		: Determina si esta ejecutando la aplicacion desde un ejecutable o en desarrollo
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  TRUE	: 	Si esta ejecutando los fuentes
//		 FALSE	:	Si esta ejecutando un EXE
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  27/ENE/12	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


IF Handle(GetApplication()) = 0 THEN RETURN TRUE

RETURN FALSE
end function

public function boolean of_wow64 ();
boolean wow64 =false

IsWow64Process(GetCurrentProcess(), wow64)

RETURN wow64
end function

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

on n_cst_principal_appmanager.create
call super::create
end on

on n_cst_principal_appmanager.destroy
call super::destroy
end on

event constructor;call super::constructor;//------------------------------------------------------------------
//  MODULO/FUNCION	: constructor
//
//  DESCRIPCION		: Inicializa todas las caracter$$HEX1$$ed00$$ENDHEX$$sticas de la aplicaci$$HEX1$$f300$$ENDHEX$$n
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  28/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//-------------------------------------------------------------------
string ls_configuracion

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

gs_version	=	'1.0.0.0.0'
gs_sistema = "APP"

// Nombre de la aplicaci$$HEX1$$f300$$ENDHEX$$n
iapp_object.DisplayName="Nombre de aplicacion" 

// Funcionalidad de Microhelp
of_SetMicroHelp (true)

//Obtiene el path del EXE
is_rutaexe = of_obtiene_directorioexe()

// Registry key de la aplicaci$$HEX1$$f300$$ENDHEX$$n
of_SetAppKey ("HKEY_LOCAL_MACHINE\SOFTWARE\ENKONTROL\"+gs_sistema)

//RegistryGet ( of_GetAppKey(), "configuracion", regstring!, ls_configuracion)
//IF isnull(ls_configuracion) OR len(trim(ls_configuracion)) = 0 THEN ls_configuracion = is_rutaexe+ "\app.ini"
ls_configuracion = "C:\windows\kontrol.ini"

// Nombre del INI de la aplicaci$$HEX1$$f300$$ENDHEX$$n
of_SetAppIniFile (ls_configuracion)

// Nombre del archivo de ayuda de la aplicaci$$HEX1$$f300$$ENDHEX$$n
of_SetHelpFile ("xxxx.chm")

// Logo de la aplicaci$$HEX1$$f300$$ENDHEX$$n (nombre del archivo bmp)
of_SetLogo ("ico\logo.png")

// Mensaje de los Derechos Reservados de la Aplicaci$$HEX1$$f300$$ENDHEX$$n
of_setCopyRight("$$HEX2$$a9002000$$ENDHEX$$"+string(year(today()))+" Enkontrol. Reservados todos los derechos.")

// Versi$$HEX1$$f300$$ENDHEX$$n de la aplicaci$$HEX1$$f300$$ENDHEX$$n
if Pos ( lower(is_rutaexe), "\sybase") > 0 then
	of_SetVersion ("")
else
	of_SetVersion (string(gdt_compilacion, "ddmmyy.hh"))
end if

inv_seguridad = CREATE n_cst_seguridad


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
IF SQLCA.of_conectarCiaEK(gs_Nombre_Usuario, gs_pass, gs_num_cia) <> 1 THEN RETURN -1

//Inicializa el n$$HEX1$$fa00$$ENDHEX$$mero de sesi$$HEX1$$f300$$ENDHEX$$n
gdec0_spid = SQLCA.of_getSPID()

Return 1
end event

event pfc_open;call super::pfc_open;//------------------------------------------------------------------
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

//Abre la ventana principal
Open(gw_frame)

//Define si el modo de trabajo permite multiples tab
gw_frame.ib_multiplesTab = TRUE


end event


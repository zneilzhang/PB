HA$PBExportHeader$n_tr.sru
$PBExportComments$Extension Transaction class
forward
global type n_tr from pfc_n_tr
end type
end forward

global type n_tr from pfc_n_tr
end type
global n_tr n_tr

forward prototypes
public function datetime of_fechaservidor ()
public function integer of_conectarciaek (string as_cia)
public function integer of_getspid ()
public function integer of_ejecuta_sql (string as_sql, boolean ab_mensaje, boolean ab_terminar_trans)
public function integer of_conectar (string as_usuario, string as_password)
public function integer of_conectar ()
public function integer of_lec ()
public function integer of_conectarsqlite (string as_databasepath)
public function integer of_connectsa9 (string as_userid, string as_password, string as_database)
public function integer of_conectarciaek (string as_userid, string as_password, string as_cia)
end prototypes

public function datetime of_fechaservidor ();//------------------------------------------------------------------
//  MODULO/FUNCION	: of_fechaservidor
//
//  DESCRIPCION		: Funci$$HEX1$$f300$$ENDHEX$$n que devuelve la fecha del servidor
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  La fecha de hoy	: 	Si no hubo errores
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  26/MAY/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String		ls_SQLErrText
DateTime		ldt_hoy

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

IF of_IsConnected() THEN
	SELECT getdate()
	INTO :ldt_hoy
	FROM dummy
	USING THIS;
	
	If this.SQLCode < 0 Then
		ls_SQLErrText = this.SQLErrText
		Messagebox(gs_nombreapp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error en 'of_fechaservidor'~r" + ls_SQLErrText, StopSign!)
	End If
ELSE
	setnull(ldt_hoy)
END IF

Return	ldt_hoy

end function

public function integer of_conectarciaek (string as_cia);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_ConectarCiaEK
//
//  DESCRIPCION		: Conecta la transaccion a la compa$$HEX1$$f100$$ENDHEX$$ia especificada
//
//  DEVUELVE			:
//		>0  The number of keys retrieved
//		0  Either there are no keys that exist for the section or the section does not exist
//		-1  File error
//		-2  The INI file has not been specified or does not exist
//		-3 No se encontro el valor del DSN
//		-4 No se encontro el valor del nombre de la compa$$HEX1$$f100$$ENDHEX$$ia
//		-5 No se pudo conectar
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  18/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

RETURN of_conectarCiaEK(gs_Nombre_Usuario, gs_pass, as_cia)


end function

public function integer of_getspid ();////////////////////////////////////////////////////////////////////
//	DESCRIPCION	:
//		Funci$$HEX1$$f300$$ENDHEX$$n que obtiene el SPID de la sesi$$HEX1$$f300$$ENDHEX$$n actual
//
//	ARGUMENTOS :
//
//	DEVUELVE	:
//		-1	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//		El n$$HEX1$$fa00$$ENDHEX$$mero del SPID
//
////////////////////////////////////////////////////////////////////
//	AUTOR	:	FECHA	:		MODIFICACION:	
//	-----------------------------------------------------------------
//	LMAC		22/NOV/99		CREACION
////////////////////////////////////////////////////////////////////

decimal{0}	ldec0_SPID

IF NOT of_IsConnected() THEN RETURN -10

SELECT @@SPID 
INTO :ldec0_SPID
FROM DUMMY;

If this.SQLCode < 0 Then
	MessageBox( gs_nombreapp, "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al tratar de obtener el SPID de la sesi$$HEX1$$f300$$ENDHEX$$n ~r" + this.SqlErrtext, Exclamation!)
	Return -1
End If

Return ldec0_SPID
end function

public function integer of_ejecuta_sql (string as_sql, boolean ab_mensaje, boolean ab_terminar_trans);//------------------------------------------------------------------
//  MODULO/FUNCION	:	gf_ejecuta_sql
//
//  DESCRIPCION		:	Funci$$HEX1$$f300$$ENDHEX$$n que ejecuta el estatuto SQL que se le 
//								envia como par$$HEX1$$e100$$ENDHEX$$metro
// 
//  EVENTO/ARGUMENTOS	: 
//					as_sql		:	Sentencia SQL a ejecutar
//					ab_mensaje	:	True: muestra mensaje de error, False:No muestra el 
//										mensaje
//					atr_conexion:	Transacci$$HEX1$$f300$$ENDHEX$$n a la bd
//					ab_terminar_trans: TRUE: Hacer commit/rollback, FALSE: Dejar trans. pendiente
//
//
//  DEVUELVE		:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  31/MAR/00	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
String	ls_SQLErr

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
//Valida nulos
If IsNull(as_SQL) Or Trim(as_SQL) = "" Then Return 0

//Ejecuta la instrucci$$HEX1$$f300$$ENDHEX$$n SQL
Execute Immediate :as_SQL USING this;
ls_SQLErr = this.SQLErrText

If this.SQLCode < 0 Then
	if ab_terminar_trans then 
		Rollback using this;
	end if
	if ab_mensaje then Messagebox("Error", "Ocurri$$HEX2$$f3002000$$ENDHEX$$un error al ejecutar el estatuto SQL~r" + ls_SQLErr, Stopsign!)
	Return -1
Else
	if ab_terminar_trans then 
		Commit using this;
	end if
End If

Return 0
end function

public function integer of_conectar (string as_usuario, string as_password);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_ConectarCiaEK
//
//  DESCRIPCION		: Conecta la transaccion a la compa$$HEX1$$f100$$ENDHEX$$ia especificada
//
//  DEVUELVE			:
//		>0  The number of keys retrieved
//		0  Either there are no keys that exist for the section or the section does not exist
//		-1  File error
//		-2  The INI file has not been specified or does not exist
//		-3 No se encontro el valor del DSN
//		-4 No se encontro el valor del nombre de la compa$$HEX1$$f100$$ENDHEX$$ia
//		-5 No se pudo conectar
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  18/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_total, li_rc
string	lsarr_key[], ls_dsn, ls_nomcia, ls_enginename, ls_databasename, ls_ini_file, ls_clave, ls_puerto
string ls_sql, ls_sqlmode
n_cst_inifile  lnv_ini_handler

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ls_clave = "PARAMETROS"

ls_ini_file = gnv_app.of_GetAppINIFile()

li_total = lnv_ini_handler.of_GetKeys (ls_ini_file, ls_clave, lsarr_key )

IF li_total <= 0 THEN RETURN li_total

ls_dsn = profilestring ( ls_ini_file, ls_clave, "ODBC", '' )

//IF LEN(TRIM(ls_dsn)) = 0 THEN RETURN -3

ls_enginename = profilestring ( ls_ini_file, ls_clave, "SERVIDOR", '' )
ls_databasename = profilestring ( ls_ini_file, ls_clave, "DEFAULT", '' )
ls_puerto = profilestring ( ls_ini_file, ls_clave, "PUERTO", '' )

//Par$$HEX1$$e100$$ENDHEX$$metros de configuraci$$HEX1$$f300$$ENDHEX$$n de conexi$$HEX1$$f300$$ENDHEX$$n MySQL (Option)
//http://det.bi.ehu.es/practicasSQL/manual5/mysql-connectors.html#connection-parameters
//dbms = "ODBC"
//dbparm = "connectstring='DSN="+TRIM(ls_dsn) +";Server="+ls_enginename+ &
//			";Port=3306;Option=4112;DisableBind=1;Database="+ls_databasename
			
//http://fer911.blogspot.es/
DBMS = "ODBC"
AutoCommit = False
//DBParm = "ConnectString='DRIVER={MySQL ODBC 5.1 Driver};SERVER="+ls_enginename+";PORT="+ls_puerto+";DATABASE="+ls_databasename+";OPTION=4112;',DisableBind=1" 
DBParm = "ConnectString='DRIVER={MySQL ODBC 5.1 Driver};SERVER="+ls_enginename+";PORT="+ls_puerto+";DATABASE="+ls_databasename+";OPTION=135184;',DisableBind=1" 
//Opciones 135168
of_SetUser(as_usuario, as_password)

li_rc = of_disconnect()
li_rc = of_connect();

if li_rc <> 0 then
	messagebox(gs_nombreapp, "No se pudo realizar la conexi$$HEX1$$f300$$ENDHEX$$n al " + &
			"Servidor: " + ls_enginename + " ~r" + &
			"Puerto: "+ls_puerto + " ~r" + &
			"Base de Datos: "+ls_databasename + " ~r" + &
			"debido al siguiente error:~r(" + sqlerrtext + ")", exclamation!)
	return -1
end if

ls_sql = "SET GLOBAL sql_mode='NO_BACKSLASH_ESCAPES'; "
ls_sql = "SET lc_time_names = 'es_MX'; "

IF of_execute(ls_sql) <> 0 THEN
	Messagebox(gs_nombreapp,"No se pudo configurar la base de datos", exclamation!)
END IF

SELECT @@SESSION.sql_mode
INTO :ls_sqlmode
FROM DUMMY;

IF len(trim(ls_sqlmode)) > 0 THEN ls_sqlmode += ",NO_BACKSLASH_ESCAPES"
ls_sql = "SET SESSION sql_mode='"+ls_sqlmode+"'; "

IF of_execute(ls_sql) <> 0 THEN
	Messagebox(gs_nombreapp,"No se pudo configurar la base de datos", exclamation!)
END IF

SELECT @@SESSION.sql_mode
INTO :ls_sqlmode
FROM DUMMY;

RETURN 1
end function

public function integer of_conectar ();//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_ConectarCiaEK
//
//  DESCRIPCION		: Conecta la transaccion a la compa$$HEX1$$f100$$ENDHEX$$ia especificada
//
//  DEVUELVE			:
//		>0  The number of keys retrieved
//		0  Either there are no keys that exist for the section or the section does not exist
//		-1  File error
//		-2  The INI file has not been specified or does not exist
//		-3 No se encontro el valor del DSN
//		-4 No se encontro el valor del nombre de la compa$$HEX1$$f100$$ENDHEX$$ia
//		-5 No se pudo conectar
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  18/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

RETURN of_conectar("", "")

end function

public function integer of_lec ();integer li_rc

DBMS  ="odbc"
//DBPARM="connectstring='con="+ls_con+";DSN="+TRIM(ls_dsn) +";ENG="+ls_enginename+";DBN="+ls_databasename+",DisableBind=1,PBNewSPInvocation = 'Yes', CallEscape='No' "
//DBParm = "ConnectString='DRIVER={MySQL ODBC 5.1 Driver};SERVER="+ls_enginename+";PORT="+ls_puerto+";DATABASE="+ls_databasename+";OPTION=135184;',DisableBind=1" 
DBParm = "ConnectString='DRIVER={SQL Anywhere 11};ENG=ek_enkontrol_promotora;DBN=ek_adm90_11;',DisableBind=1" 

of_SetUser("dba", "_._ENKONTROL_._")

li_rc = of_disconnect();
li_rc = of_connect();

if li_rc <> 0 then
	return -5
end if

n_ds lds_t

lds_t = CREATE n_ds 
//lds_t.of_create("select * from am_companias", this)

li_rc = lds_t.rowcount()

RETURN 1
end function

public function integer of_conectarsqlite (string as_databasepath);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_conectarSQLite
//
//  DESCRIPCION		: Conecta la transaccion la base de datos SQLite3 Especificada
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  02/FEB/12	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_total, li_rc

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

IF NOT FileExists(as_databasepath) THEN
	Messagebox(gs_nombreapp,"No se encontr$$HEX2$$f3002000$$ENDHEX$$el archivo de base de datos~n"+as_databasePath, StopSign!)
	RETURN -1
END IF


DBMS = "ODBC"
AutoCommit = False
DBParm = "ConnectString='DRIVER={SQLite3 ODBC Driver};Database='"+as_databasepath+"'"
//100000
of_SetUser("admin","")

li_rc = of_disconnect()
li_rc = of_connect();

if li_rc <> 0 then
	messagebox(gs_nombreapp, "No se pudo realizar la conexi$$HEX1$$f300$$ENDHEX$$n a la " + &
			"Base de Datos: "+as_databasepath + " ~r" + &
			"debido al siguiente error:~r(" + sqlerrtext + ")", exclamation!)
	return -1
end if


RETURN 1
end function

public function integer of_connectsa9 (string as_userid, string as_password, string as_database);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_connectSA9
//
//  DESCRIPCION		: Conecta la transaccion 
//
//  DEVUELVE			:
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  18/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_rc
string ls_server, ls_database
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ls_database = as_database
IF isvalid(gnv_app) THEN
	ls_database = gnv_app.of_obtiene_directorioexe() + '\bd\'+as_database+'.db'
END IF
//IF NOT FileExists(ls_database)
ls_server = "srv_"+as_database

DBMS  ="odbc"
AutoCommit = False
DBParm = "ConnectString='DRIVER={Adaptive Server Anywhere 9.0};ENG="+ls_server+";DBN="+as_database+";DBF="+ls_database+"',DisableBind=1" 
of_SetUser(as_userid, as_password)

li_rc = of_disconnect()
li_rc = of_connect();

if li_rc <> 0 then
	messagebox(gs_nombreapp, "No se pudo realizar la conexi$$HEX1$$f300$$ENDHEX$$n al " + &
			"Servidor: " + ls_server + " ~r" + &
			"Base de Datos: "+as_database + " ~r" + &
			"debido al siguiente error:~r(" + sqlerrtext + ")", exclamation!)
	return -1
end if


RETURN 1

end function

public function integer of_conectarciaek (string as_userid, string as_password, string as_cia);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_ConectarCiaEK
//
//  DESCRIPCION		: Conecta la transaccion a la compa$$HEX1$$f100$$ENDHEX$$ia especificada
//
//  DEVUELVE			:
//		>0  The number of keys retrieved
//		0  Either there are no keys that exist for the section or the section does not exist
//		-1  File error
//		-2  The INI file has not been specified or does not exist
//		-3 No se encontro el valor del DSN
//		-4 No se encontro el valor del nombre de la compa$$HEX1$$f100$$ENDHEX$$ia
//		-5 No se pudo conectar
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  18/JUN/10	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer	li_total, li_rc
string	lsarr_key[], ls_dsn, ls_nomcia, ls_enginename, ls_databasename
//n_ds lds_kontrol_ini
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//lds_kontrol_ini = gnv_app.ids_kontrol_ini
//li_total = lds_kontrol_ini.Find("cia='"+as_cia+"'",1, lds_kontrol_ini.RowCount())
//
//IF li_total <= 0 THEN RETURN li_total

//ls_dsn = lds_kontrol_ini.object.dsn[li_total]

ls_dsn = profileString(  gnv_app.of_GetAppINIFile(), as_cia, "dsn", "")
IF LEN(TRIM(ls_dsn)) = 0 THEN RETURN -1

//ls_nomcia = lds_kontrol_ini.object.nom[li_total]
//ls_enginename = lds_kontrol_ini.object.eng[li_total]
//ls_databasename = lds_kontrol_ini.object.dbn[li_total]
//
//IF isnull(ls_enginename) THEN ls_enginename = ""
//IF isnull(ls_databasename) THEN ls_databasename = ""

string ls_con
ls_con = gs_sistema + STRING( gi_numope , '0000000') + '_' + TRIM(gs_Nombre_Usuario) +"'"

DBMS  ="odbc"
//DBPARM="connectstring='con="+ls_con+";DSN="+TRIM(ls_dsn) +";ENG="+ls_enginename+";DBN="+ls_databasename+",DisableBind=1,PBNewSPInvocation = 'Yes', CallEscape='No' "
DBPARM="connectstring='con="+ls_con+";DSN="+TRIM(ls_dsn) +";,DisableBind=1,PBNewSPInvocation = 'Yes', CallEscape='No' "
of_SetUser(as_userid, as_password)

li_rc = of_disconnect();
li_rc = of_connect();

if li_rc <> 0 then
	messagebox(gs_nombreapp, "No se pudo realizar la conexi$$HEX1$$f300$$ENDHEX$$n a la " + &
			"compa$$HEX2$$f100ed00$$ENDHEX$$a '" + as_cia + " - " + ls_nomcia + "' ~r" + &
			"debido al siguiente error:~r(" + sqlerrtext + ")" + &
			"~rpor tanto no se podr$$HEX1$$e100$$ENDHEX$$n definir configuraciones para esta compa$$HEX2$$f100ed00$$ENDHEX$$a", exclamation!)
	return -1
end if


RETURN 1
end function

on n_tr.create
call super::create
end on

on n_tr.destroy
call super::destroy
end on


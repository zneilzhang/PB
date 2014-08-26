HA$PBExportHeader$n_cst_seguridad.sru
forward
global type n_cst_seguridad from n_base
end type
end forward

global type n_cst_seguridad from n_base
end type
global n_cst_seguridad n_cst_seguridad

type variables

string is_key = "[@EnKontrol]"
end variables

forward prototypes
public function boolean of_seguridad (string as_userid, string as_password)
public function string of_encriptar (string as_valor)
public function string of_desencriptar (string as_valor)
public function integer of_autorizacion (long al_autorizacion_id)
public function integer of_setpassword (string as_password)
public function string of_getpassword ()
private function integer of_setlogoreporte ()
public function string of_obtiene_nombrepc ()
private function integer of_setdirectoriotemporal ()
end prototypes

public function boolean of_seguridad (string as_userid, string as_password);//------------------------------------------------------------------
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

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_password, ls_SQLErrText, ls_SMTPServidor
long ll_userid
datetime ldt_fechaHoraServidor
date ld_fecha
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
SetPointer(Hourglass!)

ll_userid = long(left(as_password,4))
as_password = mid(as_password,5)

ldt_fechaHoraServidor = SQLCA.of_fechaservidor( )
ld_fecha = date ( ldt_FechaHoraServidor )

SELECT nom, nivel, nivelcc
INTO :gs_descope, :gi_nivel, :gi_nivelcc
FROM ek010ab
WHERE num = :ll_userid
AND ( CAST ( DECRYPT(pass, :ll_userid  ) as char(100) )  = :as_password ) ;

IF SQLCA.sqlcode <> 0 THEN
	ls_SQLErrText = SQLCA.sqlerrtext
	Messagebox(gs_nombreapp, "Usuario o Contrase$$HEX1$$f100$$ENDHEX$$a no validos~n" + ls_sqlerrtext, StopSign!)
	return FALSE
END IF

IF NOT f_valida_vigencia_usuario(ld_fecha, as_Password, ll_userid) THEN
	RETURN FALSE
END IF

IF NOT (f_valida_vigencia_pass(ld_fecha, as_Password, ll_userid)) THEN
//	OpenWithParm(w_cambio_password,'')
	
//	IF gs_permiso = 'N' THEN
//		MessageBox ( gs_Titulo, 'El usuario termino su vigencia de operaciones')
//		RETURN 0
//	ELSE
//		as_Password = Message.StringParm
//	End If
	RETURN FALSE
END IF

SELECT nombre 
INTO   :gs_nombre_compania 
FROM   datos_compania 
WHERE  clave_compania = :as_userid;

// Establecer el nombre de la PC
gs_Nombre_PC = of_obtiene_nombrepc()
gs_num_cia = as_userid
gs_clv_cia = as_userid
gi_numope = ll_userid
gs_pass = as_password
gs_Nombre_Usuario = gs_descope

//Pone en capitales el nombre
gs_descope = gnv_funciones_string.of_WordCap(gs_descope)

//Pone en la var. global el login
gs_id_usuario = left(string(ll_userid) + '-' + gs_descope, 20)

gnv_app.of_SetUserID ( gs_id_usuario )

IF IsValid(gnv_app.inv_error) THEN 
//	inv_error.of_SetPredefinedSource(SQLCA)
	gnv_app.inv_error.of_SetUser(gnv_app.of_GetUserID())
END IF

//IF IsValid(gw_frame) THEN 
//	gw_frame.inv_statusbar.of_Modify("nomusr", gs_descope)
//	gw_frame.inv_statusbar.of_Modify("username", gs_id_usuario)
//END IF

// Determinar si esta en citrix o no
// Obtiene la ruta temporal de trabajo
of_SetDirectorioTemporal()
// Genera el archivo temporal del logo de reporte
of_SetLogoReporte()

// Consultar parametro del servidor
ls_SMTPServidor = gf_lee_parametro (3, 'EK')
// Establecer su uso
gnv_Correo.of_SetSMTP ( ls_SMTPServidor )

	
RETURN TRUE



end function

public function string of_encriptar (string as_valor);n_cst_crypto lnv_crypto
string ls_valor

ls_valor = lnv_crypto.of_Encrypt(as_valor,is_key,TRUE)
ls_valor= lnv_crypto.of_Encode64(blob(ls_valor))

RETURN ls_valor
end function

public function string of_desencriptar (string as_valor);n_cst_crypto lnv_crypto
blob lblob_valor
string ls_valor

lblob_valor = lnv_crypto.of_Decode64(as_valor)
ls_valor = lnv_crypto.of_Decrypt(string(lblob_valor),is_key,TRUE)

RETURN ls_valor
end function

public function integer of_autorizacion (long al_autorizacion_id);
string ls_descripcion, ls_rtn

SELECT descripcion
INTO :ls_descripcion
FROM autorizaciones
WHERE id = :al_autorizacion_id;

IF SQLCA.sqlcode <> 0 THEN
	messagebox(gs_nombreapp,"NO SE PUDO LEER LA INFORMACION DEL PROCESO DE AUTORIZACION",exclamation!)
	RETURN -1
END IF
	
OpenWithParm(w_autorizacion, string(al_autorizacion_id))
ls_rtn = Message.stringParm

IF ls_rtn = "OK" THEN RETURN 1
RETURN -1

end function

public function integer of_setpassword (string as_password);//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_SetPassword
//
//  DESCRIPCION		: Encripta y asigna la contrase$$HEX1$$f100$$ENDHEX$$a para la BD
//								en el registro de windows
//
//  EVENTO/ARGUMENTOS: 
//				string as_password : Contrase$$HEX1$$f100$$ENDHEX$$a de la BD
//
//  DEVUELVE			:
//		  1	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  06/NOV/13	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_password

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

ls_password = of_encriptar(as_password)

RegistrySet ( gnv_app.of_GetAppKey(), "Password", RegString!, ls_password )


RETURN 1

end function

public function string of_getpassword ();//------------------------------------------------------------------
//  FUNCION/EVENTO	: of_getpassword
//
//  DESCRIPCION		: Obtiene las valores de usuario y contrase$$HEX1$$f100$$ENDHEX$$a para la BD
//								que estan encriptados en el registro de windows
//
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  1	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  06/NOV/13	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string ls_password
integer li_rtn
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

li_rtn = RegistryGet ( gnv_app.of_GetAppKey(), "Password", regstring!, ls_password )

IF li_rtn <> 1 OR len(trim(ls_password)) = 0 THEN 
	of_setPassword("sql")
	RETURN "sql"
END IF

ls_password = of_desEncriptar(ls_password)

RETURN ls_password
end function

private function integer of_setlogoreporte ();///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_acceso_modulo
//
// Evento/Funcion	:	of_SetLogoReporte
//
// Objetivo 		: 	Accesar al modulo
//
// Descripcion		:	Establecer el logo de los reportes.
//
// Parametros
//		Ninguno
//
// Retorno
//		1	:	Ok
//		0	:	Error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 11/Feb/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////
BLOB		lb_Pic
INTEGER	li_FileNum
STRING	ls_NombreArchivo, ls_Regreso
///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////

//lb_Pic = gf_lee_parametro(1, 'EK')

IF NOT IsNull(lb_pic) THEN

	SELECT valor
	INTO :ls_NombreArchivo
	FROM parametros_cia
	WHERE sistema = 'EK'
	AND	id_parametro = 1;
	
	ls_regreso = gs_directorio_temporal + "ektmp_" + gs_num_cia + "_" + ls_NombreArchivo
	li_FileNum = FileOpen(ls_regreso, StreamMode!, Write!, Shared!, Replace!)
	
	IF li_FileNum = -1 THEN
		MessageBox (gs_nombreapp, "No se pudo abrir el archivo del logo, se continuar$$HEX2$$e1002000$$ENDHEX$$sin problemas con el proceso y se mostrar$$HEX2$$e1002000$$ENDHEX$$sin logo", information!)
	ELSE
		IF FileWriteEx(li_FileNum, lb_pic) = -1 THEN
			gnv_app.is_logorep = ""
			MessageBox (gs_nombreapp, "No se pudo generar el archivo del logo, se continuar$$HEX2$$e1002000$$ENDHEX$$sin problemas con el proceso y se mostrar$$HEX2$$e1002000$$ENDHEX$$sin logo", information!)
		ELSE
			gnv_app.is_logorep = ls_regreso
		END IF
		fileclose(li_FileNum)
	END IF
END IF

RETURN 1

end function

public function string of_obtiene_nombrepc ();//------------------------------------------------------------------
//  MODULO/FUNCION	:	gf_obtiene_nombrepc
//
//  DESCRIPCION		:	Obtiene el nombre dado a la PC actual
// 
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  23/MAY/01	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_nombrepc
long		ll_buffer = 50
pointer	oldpointer


//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
ls_nombrepc = space(ll_buffer)
GetComputerNameA(ls_nombrepc, ll_buffer)


Return ls_nombrepc

end function

private function integer of_setdirectoriotemporal ();///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_acceso_modulo
//
// Evento/Funcion	:	of_SetDirectorioTemporal
//
// Objetivo 		: 	Accesar al modulo
//
// Descripcion		:	Proceder a incializar variables globales
//
// Parametros
//		Ninguno
//
// Retorno
//		1	:	OK
//		0	:	Error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 11/Feb/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////
INTEGER		li_Elemento, li_Elementos
STRING		ls_ServCitrix, lars_ServCitrix[]

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////

//Determina si es un servidor Citrix (se asume que tienen ip fija por ser servers)
ls_ServCitrix = gf_lee_parametro(2, 'EK')

IF gnv_funciones_string.of_parsetoarray(ls_ServCitrix, ",", lars_ServCitrix) > 0 THEN
	li_Elementos	= UPPERBOUND(lars_ServCitrix)
	
	FOR li_Elemento = 1 TO li_Elementos
		IF POS(UPPER(lars_ServCitrix[li_Elemento]), UPPER(gs_nombre_pc)) > 0 THEN
			gs_ip_pc = gf_desglosa_string(lars_ServCitrix[li_Elemento], 2, "|")
			gb_citrix = TRUE
			EXIT
		END IF
	NEXT
	
END IF

gs_directorio_temporal = "c:\"

IF gb_citrix THEN
	gs_directorio_temporal =  "\\" + gs_ip_pc + "\ektemp\"
END IF

RETURN 1

end function

on n_cst_seguridad.create
call super::create
end on

on n_cst_seguridad.destroy
call super::destroy
end on


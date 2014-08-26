HA$PBExportHeader$n_cst_correo.sru
$PBExportComments$(JVM) Objeto autoinstanciado para ejecutar tareas relacionadas al correo electronico.
forward
global type n_cst_correo from nonvisualobject
end type
end forward

global type n_cst_correo from nonvisualobject autoinstantiate
end type

type variables
Integer ii_SMTPpuerto
STRING  is_SMTPServidor, is_SMTPuser, is_SMTPpwd, is_cc, is_bcc
end variables

forward prototypes
public function integer of_setsmtp (string as_smtpservidor)
public function integer of_enviar (string as_smtpserver, string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usahtml)
public function integer of_enviar (string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usarhtml)
public subroutine of_setconnparms (string as_smtpsvr, integer ai_smtppto, string as_smtpuser, string as_smtppwd)
public function integer of_enviar (string as_smtpserver, string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usahtml, string asarr_attach[], string as_cc, string as_bcc)
public function integer of_enviar (string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usarhtml, string asarr_attach[], string as_cc, string as_bcc)
public function integer of_aviso_soporte (string asunto, string msg)
end prototypes

public function integer of_setsmtp (string as_smtpservidor);///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_correo
//
// Evento/Funcion	:	of_SetSMTP
//
// Objetivo 		: 	Establecer el servidor SMTP Default
//
// Descripcion		:	Se configura que servidor seria el default
//
// Parametros
//		as_smtpserver			:	Nombre del servidor de correo que cuenta con 
//										servicio SMTP (ej. exchange)
//
// Retorno
//		  1	: 	Si no hubo errores
//		  0	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 25/Ene/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////

is_SMTPServidor = as_SMTPServidor

RETURN 1
end function

public function integer of_enviar (string as_smtpserver, string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usahtml);///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_correo
//
// Evento/Funcion	:	of_Enviar
//
// Objetivo 		: 	Enviar correo via smtp
//
// Descripcion		:	Se enviara la informacion proporcionada al correo. Para 
//							este caso se considera que no se proporciono el arreglo
//							de adjuntos
//
// Parametros
//		as_smtpserver			:	Nombre del servidor de correo que cuenta con 
//										servicio SMTP (ej. exchange)
//		as_de						:	Direccion de correo del remitente, el servicio 
//										SMTP puede que NO valide que la cuenta exista.
//										(puede ser una cuenta inventada ej.
//										servidor_correo@poiuytre.com)
//		as_para					:	Direcciones de correo a las cuales se les va a
//										enviar. Nota:Se deber$$HEX1$$e100$$ENDHEX$$n separar las direcciones
//										por punto y coma
//		as_asunto				:	Asunto del correo
//		as_mensaje				:	Cuerpo del texto del correo
//		ab_usahtml				:	Si el formato del correo lo manda tipo html
//
// Retorno
//		  1	: 	Si no hubo errores
//		  0	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 25/Ene/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////
STRING lsarr_vacio[]

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////


RETURN of_enviar(	as_SMTPServer, &
						as_De, &
						as_Para, &
						as_Asunto, &
						as_Mensaje, &
						ab_Usahtml, &
						lsarr_vacio, &
						is_cc, &
						is_bcc )


end function

public function integer of_enviar (string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usarhtml);///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_correo
//
// Evento/Funcion	:	of_Enviar
//
// Objetivo 		: 	Enviar correo via smtp
//
// Descripcion		:	Se enviara la informacion proporcionada al correo. Para 
//							este caso se considera que no se proporciono la informacion
//							del servidor SMTP, por lo que se tomara el que esta en la 
//							configuracion del servicio. Ademas, se considera que no
//							pase la informacion de archivos adjuntos.
//
// Parametros
//		as_de						:	Direccion de correo del remitente, el servicio 
//										SMTP puede que NO valide que la cuenta exista.
//										(puede ser una cuenta inventada ej.
//										servidor_correo@poiuytre.com)
//		as_para					:	Direcciones de correo a las cuales se les va a
//										enviar. Nota:Se deber$$HEX1$$e100$$ENDHEX$$n separar las direcciones
//										por punto y coma
//		as_asunto				:	Asunto del correo
//		as_mensaje				:	Cuerpo del texto del correo
//		ab_usahtml				:	Si el formato del correo lo manda tipo html
//
// Retorno
//		  1	: 	Si no hubo errores
//		  0	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 25/Ene/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////
STRING	lsar_attach []

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////

RETURN of_enviar(	is_SMTPServidor, & 
						as_De, &
						as_Para, &
						as_Asunto, &
						as_Mensaje, &
						ab_Usarhtml, &
						lsar_attach, &
						is_cc, &
						is_bcc)
end function

public subroutine of_setconnparms (string as_smtpsvr, integer ai_smtppto, string as_smtpuser, string as_smtppwd);///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_correo
//
// Evento/Funcion	:	of_SetConnParms
//
// Objetivo 		: 	Establecer los parametros de conexi$$HEX1$$f300$$ENDHEX$$n al servidor SMTP
//
// Descripcion		:	Se configura que servidor seria el default
//
// Parametros     : as_SMTPsvr  -> Nombre del servidor de correo que cuenta con servicio SMTP
//                  ai_SMTPpto  -> Puerto http que utiliza el servidor para enviar correo
//                  as_SMTPuser -> Cuenta que utilizar$$HEX2$$e1002000$$ENDHEX$$el servidor para enviar el correo
//                  as_SMTPpwd  -> Password de la cuenta que se utilizar$$HEX2$$e1002000$$ENDHEX$$para enciar el correo
//
// NOTA           : El servidor SMTP puede validar o no que exista la direcci$$HEX1$$f300$$ENDHEX$$n de correo que se
//                  utilizar$$HEX2$$e1002000$$ENDHEX$$como remitente, pero es conveniente proporcionar siempre estos datos
//                  ya que en alg$$HEX1$$fa00$$ENDHEX$$n momento podr$$HEX1$$ed00$$ENDHEX$$a cambiar la configuraci$$HEX1$$f300$$ENDHEX$$n del servidor.
//
// Retorno
//		  1	: 	Si no hubo errores
//		  0	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 31/Ene/11	 RAM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////
is_SMTPServidor = as_SMTPsvr
ii_SMTPpuerto   = ai_SMTPpto
is_SMTPuser     = as_SMTPuser
is_SMTPpwd      = as_SMTPpwd
end subroutine

public function integer of_enviar (string as_smtpserver, string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usahtml, string asarr_attach[], string as_cc, string as_bcc);///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_correo
//
// Evento/Funcion	:	of_Enviar
//
// Objetivo 		: 	Enviar correo via smtp
//
// Descripcion		:	Se enviara la informacion proporcionada al correo
//
// Parametros
//		as_smtpserver			:	Nombre del servidor de correo que cuenta con 
//										servicio SMTP (ej. exchange)
//		as_de						:	Direccion de correo del remitente, el servicio 
//										SMTP puede que NO valide que la cuenta exista.
//										(puede ser una cuenta inventada ej.
//										servidor_correo@poiuytre.com)
//		as_para					:	Direcciones de correo a las cuales se les va 
//										a enviar.
//										Nota: Se deber$$HEX1$$e100$$ENDHEX$$n separar las direcciones por 
//										punto y coma
//		as_asunto				:	Asunto del correo
//		as_mensaje				:	Cuerpo del texto del correo
//		ab_usahtml				:	Si el formato del correo lo manda tipo html
//		asarr_attach[]			:	Arreglo con los nombres y rutas de archivo a enviar.
//
// Retorno
//		  1	: 	Si no hubo errores
//		  0	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 25/Ene/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////

INTEGER	li_Retc
ULONG		ll_Retc
LONG		ll_Index
n_cdo_message			iMsg
n_cdo_configuration	iConf

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////

iMsg	= CREATE n_cdo_message
iConf	= CREATE n_cdo_configuration

li_Retc	= iMsg.ConnectToNewObject("CDO.Message")

IF li_Retc <> 0 then
	messagebox(gs_nombreapp, "Error en la creaci$$HEX1$$f300$$ENDHEX$$n del mensaje", Exclamation!)
	iMsg.DisconnectObject()
	
	DESTROY iMsg
	DESTROY iConf
	RETURN 0
END IF

// Configurar el acceso

iConf.setAutomationPointer(iMsg.Configuration)

iConf.uf_setsendusing(iConf.cdoSendUsingPort)
iConf.uf_setsendusername(is_SMTPuser)
iConf.uf_setsendpassword(is_SMTPpwd)
iConf.uf_setsmtpserverport(ii_SMTPpuerto)
iConf.uf_setsmtpserver(is_SMTPServidor)

FOR ll_index = 1 TO UpperBound(asarr_attach)
	iMsg.AddAttachment(asarr_attach[ll_index])
NEXT
//iConf.uf_additem("")
//iConf.uf_setsmtpaccountname("")

//iConf.uf_setsendemailaddress
li_Retc	= iConf.uf_update()

IF li_Retc <> 1 THEN
	MessageBox(gs_nombreapp, "Error en la Actualizaci$$HEX1$$f300$$ENDHEX$$n de la Configuraci$$HEX1$$f300$$ENDHEX$$n", Exclamation!)
	iMsg.DisconnectObject()
	
	DESTROY iMsg
	DESTROY iConf
	RETURN 0
END IF

// Establecer el mensaje

iMsg.From	 = as_De
iMsg.To		 = as_Para
iMsg.Subject = as_Asunto

if as_cc  <> '' then iMsg.Cc  = as_cc
if as_bcc <> '' then iMsg.Bcc = as_bcc

IF ab_usahtml THEN
	iMsg.HtmlBody	= as_Mensaje
else
	iMsg.TextBody	= as_Mensaje
end if

// Enviar el Mensaje
iMsg.Send()

// Revisar si el mensaje se envio
ll_Retc	= iMsg.uf_getExternalCode()

IF ll_Retc <> 0 THEN
	MessageBox	(gs_nombreapp, "Envio de Mensaje Fallo~r~n~r~n" + iMsg.uf_getExternalText())
	iMsg.DisconnectObject()
	
	DESTROY iMsg
	DESTROY iConf
	RETURN 0
END IF


RETURN 1
end function

public function integer of_enviar (string as_de, string as_para, string as_asunto, string as_mensaje, boolean ab_usarhtml, string asarr_attach[], string as_cc, string as_bcc);///////////////////////////////////////////////////////////////////////////////
//
// Objeto			:  n_cst_correo
//
// Evento/Funcion	:	of_Enviar
//
// Objetivo 		: 	Enviar correo via smtp
//
// Descripcion		:	Se enviara la informacion proporcionada al correo. Para 
//							este caso se considera que no se proporciono la informacion
//							del servidor SMTP, por lo que se tomara el que esta en la 
//							configuracion del servicio
//
// Parametros
//		as_de						:	Direccion de correo del remitente, el servicio 
//										SMTP puede que NO valide que la cuenta exista.
//										(puede ser una cuenta inventada ej.
//										servidor_correo@poiuytre.com)
//		as_para					:	Direcciones de correo a las cuales se les va a
//										enviar. Nota:Se deber$$HEX1$$e100$$ENDHEX$$n separar las direcciones
//										por punto y coma
//		as_asunto				:	Asunto del correo
//		as_mensaje				:	Cuerpo del texto del correo
//		ab_usahtml				:	Si el formato del correo lo manda tipo html
//		asarr_attach			:	Ruta y nombre de los archivos a adjuntar
//
// Retorno
//		  1	: 	Si no hubo errores
//		  0	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
// Fecha			Modifico		Descripcion
// ---------	-------		----------------------------------------------------
// 25/Ene/11	JVM			Creaci$$HEX1$$f300$$ENDHEX$$n
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// DECLARACION DE VARIABLES
///////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////
// Codigo de la rutina
///////////////////////////////////////////////////////////////////////////////

RETURN of_enviar(	is_SMTPServidor, & 
						as_De, &
						as_Para, &
						as_Asunto, &
						as_Mensaje, &
						ab_Usarhtml, &
						asarr_Attach, &
						as_cc, &
						as_bcc)
end function

public function integer of_aviso_soporte (string asunto, string msg);
RETURN of_enviar( "soporte@cocamar.com.mx", "luis.collomb@cocamar.com.mx", asunto,msg, FALSE)
end function

on n_cst_correo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_correo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
is_SMTPServidor = "mail.cocamar.com.mx"
ii_SMTPpuerto = 587
is_SMTPuser = "servicio@cocamar.com.mx"
is_SMTPpwd = "s3rv1c10"
end event


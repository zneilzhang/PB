HA$PBExportHeader$sca.sra
$PBExportComments$Generated Application Object
forward
global type sca from application
end type
global n_tr_sca sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global n_msg message
end forward

global variables

//Var. que instanc$$HEX1$$ed00$$ENDHEX$$a al administrador de la aplicaci$$HEX1$$f300$$ENDHEX$$n
n_cst_principal_appmanager_sca gnv_app 

//Var. que instancia el servicio de manejo de strings
n_cst_string	gnv_funciones_string

//Var. global que referenc$$HEX1$$ed00$$ENDHEX$$a a la ventana frame de la aplicaci$$HEX1$$f300$$ENDHEX$$n
w_principal_frame gw_frame

//Var. nombre de la m$$HEX1$$e100$$ENDHEX$$quina
STRING gs_UserNombrePC
STRING gs_UserID

//Var. de la Versi$$HEX1$$f300$$ENDHEX$$n del sistema (ddmmyy) 6 posiciones m$$HEX1$$e100$$ENDHEX$$ximo
Datetime gdt_compilacion = DateTime(Today(), Now())

//Var. nulas
String	gs_nulo
Integer	gi_nulo
Long		gl_nulo
Date		gd_nulo
datetime	gdt_nulo
decimal	gdec_nulo

//Var. del nombre de la aplicaci$$HEX1$$f300$$ENDHEX$$n
String	gs_NombreApp

//Var. del nombre del usuario conectado
String	gs_Nombre_Usuario, gs_id_usuario
long	gi_grupo_id, gi_id_usuario

//Var. para el n$$HEX1$$fa00$$ENDHEX$$mero de sesi$$HEX1$$f300$$ENDHEX$$n activa
decimal{0}	gdec0_spid

string gs_sistema, gs_version, gs_temaactual
dec gd_version

string gs_key

//Globales del estandar Enkontrol
string gs_descope, gs_num_cia, gs_clv_cia, gs_pass, gs_nombre_compania, gs_nom_agente
long gi_nivel, gi_nivelcc, gi_numope, gi_agente

string gs_ejecutableapp, gs_nombre_empresa 

string gs_nombre_pc, gs_ip_pc, gs_directorio_temporal
boolean gb_citrix

// Servicio de correo
n_cst_correo gnv_correo

end variables

global type sca from application
string appname = "sca"
end type
global sca sca

type prototypes

//Funci$$HEX1$$f300$$ENDHEX$$n para enviar una entrada de teclado por c$$HEX1$$f300$$ENDHEX$$digo
subroutine keybd_event(uint bVk,uint bScan,long dwFlags,long dwExtraInfo ) library 'user32.dll'

//Funci$$HEX1$$f300$$ENDHEX$$n para determinar en qu$$HEX2$$e9002000$$ENDHEX$$directorio se est$$HEX2$$e1002000$$ENDHEX$$ejecutando este EXE
Function uLong GetModuleFileNameA(Int hinstModule, Ref String lpszPath, uLong cchPath) Library "kernel32.dll" alias for "GetModuleFileNameA;Ansi"

//Funci$$HEX1$$f300$$ENDHEX$$n para determinar si se est$$HEX2$$e1002000$$ENDHEX$$conectado a la red o no
FUNCTION Integer GetSystemMetrics (Integer nIndex) LIBRARY "user32.dll"

Function Long ShellExecuteA (uLong hwnd , String lpOperation , String lpFile , String lpParameters ,String lpDirectory ,uLong nShowCmd ) Library "shell32.dll" alias for "ShellExecuteA;Ansi"

FUNCTION boolean GetComputerNameA(ref string cname,ref long nbuf) LIBRARY "Kernel32.dll" alias for "GetComputerNameA;Ansi"

FUNCTION boolean CreateDirectoryA(ref string pathname, int sa) LIBRARY "Kernel32.dll" 

function long CreateRoundRectRgn(long x1,long y1,long x2 ,long y2 ,long x3 ,long y3) library "gdi32.dll"
function long SetWindowRgn (long hwnd,long hrgn,boolean bredraw) library "user32.dll"
end prototypes
on sca.create
appname="sca"
message=create n_msg
sqlca=create n_tr_sca
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on sca.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

n_cst_uuid lnv_uuid
n_cst_crypto lnv_crypto
string ls_UUID, ls_HardWareId, ls_hostID
string ls_computerName, ls_userName, ls_key, ls_licencia

lnv_uuid = CREATE n_cst_uuid

lnv_uuid.of_getLogin(ls_computerName,ls_userName)
ls_UUID = lnv_uuid.of_GenerateUUID()
ls_HardWareId = lnv_uuid.of_getHardwareID()
ls_hostID += ls_HardWareId + "|"
ls_hostID += ls_computerName

DESTROY lnv_uuid

gs_key = ls_hostID

//Crea el objeto controlador de la aplicaci$$HEX1$$f300$$ENDHEX$$n
gnv_app = CREATE n_cst_principal_appmanager_sca

gnv_app.of_inicializa_globales()

gnv_app.Event pfc_Open(commandline)


end event

event close;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Cierra y destruye la aplicaci$$HEX1$$f300$$ENDHEX$$n
gnv_app.Event pfc_Close( )

IF IsValid(gnv_app) THEN DESTROY gnv_app

end event

event idle;
gnv_app.event pfc_idle()
end event

event systemerror;
gnv_app.event pfc_systemerror()
end event


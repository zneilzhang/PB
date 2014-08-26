HA$PBExportHeader$calendar_exampleapp.sra
$PBExportComments$Generated PFC-Based Application
forward
global type calendar_exampleapp from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global n_msg message
end forward

global variables
/*  Application Manager  */
n_cst_appmanager_calendar gnv_app 
end variables

global type calendar_exampleapp from application
string appname = "calendar_exampleapp"
end type
global calendar_exampleapp calendar_exampleapp

on calendar_exampleapp.create
appname="calendar_exampleapp"
message=create n_msg
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on calendar_exampleapp.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;gnv_app = create n_cst_appmanager_calendar

gnv_app.Event pfc_open ( commandline )
end event

event close;gnv_app.Event pfc_close ( )

Destroy gnv_app
end event

event systemerror;gnv_app.Event pfc_systemerror ( )
end event

event connectionbegin;Return gnv_app.Event pfc_connectionbegin ( userid, password, connectstring )
end event

event connectionend;gnv_app.Event pfc_connectionend (  )
end event

event idle;gnv_app.Event pfc_idle (  )
end event


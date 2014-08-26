HA$PBExportHeader$u_dw_busqueda.sru
forward
global type u_dw_busqueda from u_dw
end type
end forward

global type u_dw_busqueda from u_dw
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
event verticalscroll pbm_vscroll
end type
global u_dw_busqueda u_dw_busqueda

type variables

u_dw idw_requestor

integer ii_tipo_busqueda_grid
end variables

forward prototypes
public function integer of_setrequestor (u_dw adw_requestor)
public function integer of_settipobusqueda (integer ai_tipobusqueda)
end prototypes

event verticalscroll;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Esta rutina se usa para evitar el scroll con el mouse
return 1
end event

public function integer of_setrequestor (u_dw adw_requestor);//------------------------------------------------------------------
//  EVENTO/FUNCION	:	ue_registrar
//
//  DESCRIPCION		:	Evento para registrar el dw al cual se le va		
// 							a generar la barra de ayuda
//  EVENTO/ARGUMENTOS: 
//
//  DEVUELVE			:
//		  0	: 	Si no hubo errores
//		 -1	:	Si hubo alg$$HEX1$$fa00$$ENDHEX$$n error
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  13/JUL/04	LAC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------
//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
string	ls_sintaxis, ls_error
long		ll_total_columnas, ll_contador

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

this.SetRedraw(FALSE)

//Crea la barra de ayuda 
ls_sintaxis = adw_requestor.object.datawindow.syntax
create(ls_sintaxis, ls_error)

//Oculta el encabezado
object.dataWindow.header.height = 0

//Inserta el rengl$$HEX1$$f300$$ENDHEX$$n
insertrow(0)

powerobject lpo_parent
userobject luserobject
tab ltab
long ll_x, ll_y

lpo_parent = adw_requestor.getParent()
// Loop getting the parent of the object until it is of type window!
do while IsValid (lpo_parent) 
	if lpo_parent.TypeOf() <> window! then
		CHOOSE CASE lpo_parent.TypeOf() 
			CASE userobject!
				luserobject = lpo_parent
				ll_y += luserobject.y
				ll_x += luserobject.x
			CASE tab!
				ltab = lpo_parent
				ll_y += ltab.y
				ll_x += ltab.x
		END CHOOSE
		lpo_parent = lpo_parent.GetParent()
	else
		exit
	end if
loop

//Acomoda el objeto
x = adw_requestor.x + ll_x
y = adw_requestor.y - height + 5 + ll_y
width = adw_requestor.width

//Barre las columnas para habilitarlas
ll_total_columnas = long(object.datawindow.column.count)
modify("DataWindow.Detail.Height='90'")

for ll_contador = 1 to ll_total_columnas
	SetTabOrder ( ll_contador, 0 )			
	SetTabOrder ( ll_contador, ll_contador )
	Modify ( "#" + string(ll_contador) + ".protect='0'" )
	Modify( "#" + string(ll_contador) +".Background.Color='1090519039'")	
	Modify("#" + string(ll_contador) + ".Background.Mode='0'")
	Modify("#" + string(ll_contador) + ".Height='68'")
	Modify("#" + string(ll_contador) + ".font.face='Arial'")
	Modify("#" + string(ll_contador) + ".font.height='-8'")
	if upper(describe("#" + string(ll_contador) + ".Edit.NilIsNull")) = 'NO' then
		modify(getColumnName() + ".Edit.NilIsNull = 'yes'")
	end if
	//<0 - None, 1- Shadow, 2 - Box, 3 - Resize, 4 - Underline, 5 - 3D Lowered, 6 - 3D Raised>
	Modify("#" + string(ll_contador) + ".Border='5'")
next

//if long(adw_requestor.Describe("DataWindow.VerticalScrollMaximum")) > 0 then vscrollbar = adw_requestor.vscrollbar

setredraw(true)
setcolumn(1)
tag = '0'

idw_requestor = adw_requestor
BringToTop = TRUE

this.SetRedraw(TRUE)

return 0
end function

public function integer of_settipobusqueda (integer ai_tipobusqueda);

ii_tipo_busqueda_grid = ai_tipobusqueda

RETURN 0
end function

on u_dw_busqueda.create
call super::create
end on

on u_dw_busqueda.destroy
call super::destroy
end on

event constructor;call super::constructor;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
of_setupdateable(false)
ib_rmbmenu = false

height = 84
end event

event editchanged;call super::editchanged;//---------------------------------------
// DECLARACIONES LOCALES
//---------------------------------------
long ll_total_columnas,ll_find, ll_row
integer li_contador
string ls_nombre,ls_find,ls_type,ls_dato, ls_criterio
any lany_valor

//---------------------------------------
// C$$HEX1$$d300$$ENDHEX$$DIGO DE LA RUTINA
//---------------------------------------

//Barre los campos para armar la instrucci$$HEX1$$f300$$ENDHEX$$n
ll_total_columnas = long(idw_requestor.describe("datawindow.column.count"))
for li_contador = 1 to ll_total_columnas
                ls_nombre = idw_requestor.describe("#" + string(li_contador) + ".Name")
                if dwo.name = ls_nombre then
                               ls_dato = data
                else
                               ls_dato = string(of_GetItemAny(1, ls_nombre, primary!, false))
                end if

                if not isnull(ls_dato) and trim(ls_dato) <> '' then
                               ls_type                = idw_requestor.Describe(ls_nombre + ".Coltype")
                               ls_type = lower(left(ls_type,5))

                               choose case ls_type
                                               case       "char", "char("
                                                               ls_criterio = ls_criterio + "(UPPER(" + ls_nombre + ") LIKE '%" + upper(ls_dato) + "%') AND "

                                               case "datet", "date"
                                                               if pos(ls_dato, "00/00/0000") = 0 then
                                                                              ls_dato = left(ls_dato, 10)
                                                                              ls_criterio = ls_criterio + "(UPPER(string(" + ls_nombre + ")) LIKE '%" + upper(ls_dato) + "%') AND "
                                                               end if
                                                               
                                               case "decim", "numbe", "long", "ulong", "real", "int"    
                                                               if not isnumber(ls_dato) then 
                                                                              messagebox("Aviso", "El valor capturado no es un n$$HEX1$$fa00$$ENDHEX$$mero v$$HEX1$$e100$$ENDHEX$$lido", exclamation!)
                                                                              idw_requestor.filter()
                                                                              return
                                                               end if
                                                               ls_criterio = ls_criterio + "(UPPER(string(" + ls_nombre + ")) LIKE '%" + upper(ls_dato) + "%') AND "
                                                               
                                               case       else
                                                               ls_criterio = ls_criterio + "(UPPER(string(" + ls_nombre + ")) LIKE '%" + upper(ls_dato) + "%') AND "
                                                               
                               end choose
                end if
next

//Quitamos el And
ls_criterio = left(ls_criterio, len(ls_criterio) - 4)

IF ii_tipo_busqueda_grid = BUSQUEDA THEN
	ll_row = idw_requestor.Find(ls_criterio, 1, idw_requestor.RowCount())
	IF ll_row > 0 THEN
		idw_requestor.Selectrow(0,FALSE)
		idw_requestor.Selectrow(ll_row, TRUE)
		idw_requestor.SetRow(ll_row)
		idw_requestor.ScrollToRow(ll_row)
	END IF
ELSEIF ii_tipo_busqueda_grid = FILTRO THEN
	idw_requestor.setfilter(ls_criterio)
	idw_requestor.filter()	
	idw_requestor.selectrow(0, FALSE)		
	if idw_requestor.rowcount() > 0 then
		idw_requestor.selectrow(1, TRUE)			
	end if
END IF

end event

event rowfocuschanging;call super::rowfocuschanging;//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------
return 0
end event

event scrollhorizontal;call super::scrollhorizontal;
idw_requestor.Object.DataWindow.HorizontalScrollPosition = scrollpos
end event


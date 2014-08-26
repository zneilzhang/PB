HA$PBExportHeader$n_cst_color.sru
$PBExportComments$Extension Color service
forward
global type n_cst_color from pfc_n_cst_color
end type
end forward

global type n_cst_color from pfc_n_cst_color
end type

forward prototypes
public function ulong of_randomcolor ()
public function integer of_colorgradient (long al_rojo, long al_verde, long al_azul, integer ai_segmento, ref unsignedlong alarr_colores[])
public function integer of_gradient (unsignedlong al_color_ini, unsignedlong al_color_fin, integer ai_segmento, ref unsignedlong alarr_colores[])
public function integer of_longtorgb (long al_color, ref integer al_red, ref integer al_green, ref integer al_blue)
public function long of_invertircolor (long al_color)
public function string of_tohtml (integer al_alpha, long al_color)
end prototypes

public function ulong of_randomcolor ();//------------------------------------------------------------------
//  FUNCION/EVENTO	: gf_color_aleatorio
//
//  DESCRIPCION		: 
//							  
//
//  ARGUMENTOS			: 
//
//  DEVUELVE			:
//		  0	: 	El color aleatorio en n$$HEX1$$fa00$$ENDHEX$$merico
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  01/JUN/07	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
ulong ll_azul, ll_verde, ll_rojo, ll_color

//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//Conversion

ll_color = rgb(rand(255),rand(255),rand(255))


return ll_color




end function

public function integer of_colorgradient (long al_rojo, long al_verde, long al_azul, integer ai_segmento, ref unsignedlong alarr_colores[]);//------------------------------------------------------------------
//  FUNCION/EVENTO	: gf_color_aleatorio
//
//  DESCRIPCION		: 
//							  
//
//  ARGUMENTOS			: 
//
//  DEVUELVE			:
//		  0	: 	El color aleatorio en n$$HEX1$$fa00$$ENDHEX$$merico
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  01/JUN/07	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_cont
ulong ll_rgb
ulong llarr_colores[]
long ll_total
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------

//RGB(255,255,255)

alarr_colores[] = llarr_colores[]
ll_total = ai_segmento

ai_segmento = ai_segmento * 2

FOR li_cont = 1 TO ai_segmento
	ll_RGB = RGB( al_rojo, al_verde, al_azul )
	
	alarr_colores[li_cont] = ll_RGB
	
	// Contadores
	al_rojo -= ( 255 / ai_segmento )
	IF al_rojo < 0 THEN al_rojo = 0
	al_verde -= ( 255 / ai_segmento )
	IF al_verde < 0 THEN al_verde = 0
	al_azul -= ( 255 / ai_segmento )
	IF al_azul < 0 THEN al_azul = 0
NEXT



return upperbound(alarr_colores[])


end function

public function integer of_gradient (unsignedlong al_color_ini, unsignedlong al_color_fin, integer ai_segmento, ref unsignedlong alarr_colores[]);//------------------------------------------------------------------
//  FUNCION/EVENTO	: gf_gradiente
//
//  DESCRIPCION		: Hace un arreglo de colores entre 2 colores definidos
//							  
//
//  ARGUMENTOS			: 
//							long: Color Inicial
//							long: Color Final
//							INT:  numero de segmentos
//							ULONG: arreglo donde guardara los colores x segmento(REF)
//
//  DEVUELVE			:
//		  ulong : la dimension del arreglo
//
//  FECHA    	AUTOR    DESCRIPCION
//------------------------------------------------------------------
//  01/JUN/07	LEC	    Creaci$$HEX1$$f300$$ENDHEX$$n	
//------------------------------------------------------------------

//------------------------------------------------------------------
// DECLARACIONES LOCALES
//------------------------------------------------------------------
integer li_cont
ulong llarr_colores[]
long ll_row
dec VR, VG, VB 
integer R, G, B, R2, G2, B2
long temp 
n_cst_numerical lnc_num
//------------------------------------------------------------------
// CODIGO DE LA RUTINA
//------------------------------------------------------------------


//Desglosa los colores de los parametros en RGB
temp = lnc_num.of_bitwiseand(al_color_ini , 255)
R = lnc_num.of_bitwiseand(temp , 255)
temp = Int(al_color_ini / 256)
G = lnc_num.of_bitwiseand(temp, 255)
temp = Int(al_color_ini / 65536)
B = lnc_num.of_bitwiseand(temp, 255)
temp = lnc_num.of_bitwiseand(al_color_fin, 255)
R2 = lnc_num.of_bitwiseand(temp, 255)
temp = Int(al_color_fin / 256)
G2 = lnc_num.of_bitwiseand(temp, 255)
temp = Int(al_color_fin / 65536)
B2 = lnc_num.of_bitwiseand(temp, 255)

//Variable para calcular el incremento para cada segmento 
VR = Abs(R - R2) / ai_segmento
VG = Abs(G - G2) / ai_segmento
VB = Abs(B - B2) / ai_segmento

//Si el 2do valor es menor que el primero hace el incremento negativo
If R2 < R Then VR = -VR
If G2 < G Then VG = -VG
If B2 < B Then VB = -VB


//Genera los colores decuerdo al numero de segmentos
li_cont = 1
For ll_row = 0 To ai_segmento - 1
	R2 = R + VR * ll_row
	G2 = G + VG * ll_row
	B2 = B + VB * ll_row

	alarr_colores[li_cont] = RGB(R2, G2, B2)
	li_cont++
Next 



return upperbound(alarr_colores[])


end function

public function integer of_longtorgb (long al_color, ref integer al_red, ref integer al_green, ref integer al_blue);//myColor = 16777215 - (blue)

//Red = myColor Mod 256 - gets red component (0 = 16777215 Mod 256)
al_red = mod(al_color,256)
//RColor = myColor \ 256 - divide and return the whole number (65280 =16777215 \ 256)
long RColor
RColor = al_color / 256

//Green = RColor Mod 256 - get green component (0 = 65280 Mod 256)
al_green = mod(RColor,256)
long GColor
//GColor = RColor \ 256 - divide and return the whole number (255 =65280 \ 256)
GColor = RColor / 256
//Blue = GColor Mod 256 - gets the blue component (255 = 255 Mod 256)
al_blue = mod(GColor,256)

RETURN 1
end function

public function long of_invertircolor (long al_color);
integer r, g, b

of_longToRGB(al_color, r, g, b)

return RGB(255 - r, 255 - g, 255 - b)


end function

public function string of_tohtml (integer al_alpha, long al_color);integer ll_red, ll_green, ll_blue
n_cst_numerical lnv_numerical
string ls_htmlcolor

of_LongToRGB(al_color, ll_red, ll_green, ll_blue)

ls_htmlcolor = lnv_numerical.of_Hexadecimal(al_alpha,2)
//ls_htmlcolor += lnv_numerical.of_Hexadecimal(ll_red,2)
//ls_htmlcolor += lnv_numerical.of_Hexadecimal(ll_green,2)
//ls_htmlcolor += lnv_numerical.of_Hexadecimal(ll_blue,2)

ls_htmlcolor += lnv_numerical.of_Hexadecimal(ll_blue,2)
ls_htmlcolor += lnv_numerical.of_Hexadecimal(ll_green,2)
ls_htmlcolor += lnv_numerical.of_Hexadecimal(ll_red,2)

RETURN ls_htmlcolor 
end function

on n_cst_color.create
call super::create
end on

on n_cst_color.destroy
call super::destroy
end on


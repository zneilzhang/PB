HA$PBExportHeader$n_cst_numerical.sru
$PBExportComments$Extension Numerical service
forward
global type n_cst_numerical from pfc_n_cst_numerical
end type
end forward

global type n_cst_numerical from pfc_n_cst_numerical
end type

forward prototypes
public function string of_hexadecimal (long al_number, integer ai_digit)
end prototypes

public function string of_hexadecimal (long al_number, integer ai_digit);long ll_temp0, ll_temp1
char lc_ret

IF ai_digit > 0 THEN
	
   ll_temp0 = abs(al_number / (16 ^ (ai_digit - 1)))
   ll_temp1 = ll_temp0 * (16 ^ (ai_digit - 1))
	
   IF ll_temp0 > 9 THEN
      lc_ret = char(ll_temp0 + 55)
   ELSE
      lc_ret = char(ll_temp0 + 48)
   END IF
	
   RETURN lc_ret + of_hexadecimal(al_number - ll_temp1 , ai_digit - 1)
END IF

RETURN ""

end function

on n_cst_numerical.create
call super::create
end on

on n_cst_numerical.destroy
call super::destroy
end on


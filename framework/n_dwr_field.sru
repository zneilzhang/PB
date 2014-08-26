HA$PBExportHeader$n_dwr_field.sru
forward
global type n_dwr_field from nonvisualobject
end type
end forward

shared variables

boolean ib_system_format_cached = false
String is_system_date_format
String is_system_shortdate_format
String is_system_longdate_format
String is_system_time_format
String is_system_currency_format


end variables

global type n_dwr_field from nonvisualobject
end type
global n_dwr_field n_dwr_field

type variables
public int ii_dwo_type
public string is_dwo_name
public string is_coltype
public integer ii_colsize
public long il_xsplit_ind_from
public long il_xsplit_ind_to
public long il_ysplit_ind_from
public long il_ysplit_ind_to
public long il_base_x = 0
public long il_base_y = 0
public long il_subband_y = 0

private long il_cached_y1 = -1000000000
private string is_expr_y1 = "-"

private long il_cached_x1 = -1
private string is_expr_x1 = "-"

private long il_cached_height = -1
private string is_expr_height = "-"

private long il_cached_y2 = -1000000000
private string is_expr_y2 = "-"

private long il_cached_width = -1
private string is_expr_width = "-"

private long il_cached_x2 = -1
private string is_expr_x2 = "-"

public string is_text

//public datawindow idw_dw
public powerobject ipo_requestor
private object ipo_requestortype
private DataWindow idw_requestor
private DataStore ids_requestor
private DataWindowChild idwc_requestor
private int ii_column_display_type

public n_xls_format invo_format
public n_xls_workbook invo_writer
public n_dwr_colors invo_colors

boolean ib_color_expr = false
boolean ib_bg_color_expr = false
boolean ib_format_expr = false
boolean ib_font_face_expr = false
boolean ib_font_height_expr = false
boolean ib_font_italic_expr = false
boolean ib_font_underline_expr = false
boolean ib_font_weight_expr = false
boolean ib_alignment_expr = false

string is_text_expr = ''
string is_color_expr = ''
string is_bg_color_expr = ''
string is_format_expr = ''
string is_font_face_expr = ''
string is_font_height_expr = ''
string is_font_italic_expr = ''
string is_font_underline_expr = ''
string is_font_weight_expr = ''
string is_alignment_expr = ''


boolean ib_custom_format = false
integer ii_row_in_detail = 1
long il_dw_row_count
private boolean ib_usetrc = false

private n_dwr_service_base inv_nestedservice
private n_dwr_nested_service_parm inv_nested_service_parm
public n_dwr_service_parm inv_parm
private DataStore ids_reportdata
//private DataWindowChild idwc_child_cache
private long il_child_cache_row = -1
private DataStore ids_child_cache


//column display type
public constant int CDT_TEXT = 1
public constant int CDT_CHECKBOX = 2
public constant int CDT_DDDW = 3
public constant int CDT_DDLB = 4
public constant int CDT_CODETABLE = 5
public constant int CDT_REPORT = 6

//dwo type
public constant int DT_COLUMN = 1
public constant int DT_COMPUTE = 2
public constant int DT_TEXT = 3
public constant int DT_REPORT = 4

private boolean ib_disable_lookup_display = false
private long il_id = 0

public string is_nested_dataobject = "" 
public string is_nested_instance_id = "" 
private n_dwr_psr inv_nested_data
private string is_nested_dddw_column_ids[]
private String is_parent_band_id
private String is_nested_processing = ""

public constant string BAND_DETAIL = "1"
public constant string BAND_HEADER = "2"
public constant string BAND_FOOTER = "3"
public constant string BAND_SUMMARY = "4"
public constant string BAND_GROUPHEADER = "5"
public constant string BAND_GROUPTRAILER = "6"
public boolean ib_autosize_height = false

//public boolean ib_registered = false



end variables

forward prototypes
public function any of_getvalue (long al_row)
public function integer of_setformat ()
public function long of_get_x1 ()
public function long of_get_y1 (long al_row)
public function long of_get_y2 (long al_row)
public function long of_get_y1 ()
public function integer of_get_visible (long al_row)
public function long of_get_y2 ()
public function string of_get_item_coltype ()
public function long of_describe_expr (string as_expr, long al_row)
private function string of_unquote(string AS_STR)
public function string of_change_format (ref string as_format, string as_type)
private function integer of_get_column_display_type ()
public function n_xls_format of_get_format (long al_row)
public function integer of_set_color (n_xls_format a_format, long al_row)
public function integer of_set_bg_color (n_xls_format a_format, long al_row)
public function integer of_check_property (string as_property_name, ref boolean ab_is_expression, ref string as_expression, ref string as_value)
public function string of_descr_numformat ()
public function string of_descr_font_face ()
public function long of_descr_font_height ()
public function boolean of_descr_font_italic ()
public function integer of_descr_font_underline ()
public function boolean of_descr_font_weight ()
public function string of_descr_alignment ()
public function integer of_descr_bg_color ()
public function integer of_descr_color ()
public function integer of_eval_bg_color (n_xls_format anvo_format, long al_row)
public function integer of_eval_color (n_xls_format anvo_format, long al_row)
public function integer of_eval_font_face (n_xls_format anvo_format, long al_row)
public function integer of_eval_numformat (n_xls_format anvo_format, long al_row)
public function integer of_eval_font_height (n_xls_format anvo_format, long al_row)
public function integer of_eval_font_italic (n_xls_format anvo_format, long al_row)
public function integer of_eval_font_underline (n_xls_format anvo_format, long al_row)
public function integer of_eval_font_weight (n_xls_format anvo_format, long al_row)
public function integer of_eval_alignment (n_xls_format anvo_format, long al_row)
public function long of_get_x1 (long al_row)
public function long of_get_x2 ()
public function long of_get_x2 (readonly long al_row)
public function string of_describe (readonly string as_expr)
public function any of_getvalue_dw (long al_row)
public function any of_getvalue_ds (long al_row)
public function any of_getvalue_dwc (long al_row)
public function integer of_createnestedservice (n_dwr_nested_service_parm anvo_nested_parm, n_dwr_service_parm anvo_parm)
public function integer of_dynamic_horisontal_layout (long al_row, n_dwr_grid anvo_hgrid)
public function integer of_register_dynamic (powerobject apo_requestor)
public function integer of_init (string as_dwo_name, integer ai_dwo_type)
private function datastore of_dwc2ds (datawindowchild adwc_src, boolean ab_copydata)
public function long of_get_band_y1 ()
public function long of_get_band_y2 ()
public function string of_describe_str_expr (string as_expr, long al_row)
public function string of_get_system_currency_format ()
public function long of_describe_expr (string as_expr, long al_row, ref string as_prop_expr)
public function long of_evaluate0 (readonly string as_expr, long al_row)
public function long of_get_width (long al_row)
public function long of_get_height (long al_row)
public function string of_evaluate_str0 (readonly string as_expr, long al_row)
public function string of_describe_str_expr (string as_expr, long al_row, ref string as_prop_expr)
private function integer of_getdddwcolumnids (datawindowchild adw, ref string as_id[])
public subroutine of_setsubbandy (long ai_subband_y)
public function integer of_register (powerobject apo_requestor, n_xls_workbook anvo_writer, n_dwr_colors anvo_colors, long al_base_x, long al_base_y, long al_subband_y)
public function long of_process_nested (long al_row, long al_writer_row, n_dwr_grid anvo_hgrid, n_dwr_progress apo_progress)
end prototypes

public function any of_getvalue (long al_row);Choose Case ipo_requestortype 
	Case DataWindow!
		return of_GetValue_DW(al_row)
	Case DataStore!
		return of_GetValue_DS(al_row)
	Case DataWindowChild!
		return of_GetValue_DWC(al_row)
	Case Else
		// should not be here, see checks in of_register
End Choose   

end function

public function integer of_setformat ();integer li_ret = 1
string ls_format
integer li_color_index

invo_format = invo_writer.of_addformat()
if isNull(invo_format) then 
    li_ret = -1
else
    if Not(isValid(invo_format)) then li_ret = -1
end if
    
if li_ret = 1 then
	ls_format = of_descr_numformat()
	if ls_format = '' then ls_format = '[General]'
	ls_format = of_change_format(ls_format, is_coltype)

   invo_format.of_set_num_format(ls_format)  
	invo_format.of_set_font(of_descr_font_face())
	invo_format.of_set_size(of_descr_font_height())
   invo_format.of_set_italic(of_descr_font_italic())
   invo_format.of_set_underline(of_descr_font_underline())
   invo_format.of_set_bold(of_descr_font_weight())
   invo_format.of_set_align(of_descr_alignment())
   invo_format.of_set_align('top') 
   if is_coltype = 's' then invo_format.of_set_text_wrap(true) 
	li_color_index = of_descr_color()
	if li_color_index > 0 then invo_format.of_set_color(li_color_index)
	li_color_index = of_descr_bg_color()
   if li_color_index > 0 then invo_format.of_set_bg_color(li_color_index)
end if
	 
if li_ret = 1 then
//   ls_format = idw_dw.describe(is_dwo_name + '.format')
//   if (ls_format = '!') or (ls_format = '?') then ls_format = '[General]'
//   ls_format = of_change_format(ls_format, is_coltype)
//   invo_format.of_set_num_format(ls_format)
//   invo_format.of_set_font(idw_dw.describe(is_dwo_name + '.font.face'))
//   invo_format.of_set_size(abs(integer(idw_dw.describe(is_dwo_name + '.font.height'))))

//	string ls_italic
//	ls_italic = lower(idw_dw.describe(is_dwo_name + '.font.italic'))
//  invo_format.of_set_italic( (ls_italic = 'yes') or (ls_italic = '1'))

//	string ls_undl
//	ls_undl = lower(idw_dw.describe(is_dwo_name + '.font.underline'))
//	if (ls_undl = 'yes') or (ls_undl = '1') then invo_format.of_set_underline(1)
   
//	invo_format.of_set_bold(abs(integer(idw_dw.describe(is_dwo_name + '.font.weight'))) = 700)
//   ls_align = idw_dw.describe(is_dwo_name + '.Alignment ')
//	
//   choose case ls_align
//     case '0'
//       invo_format.of_set_align('left') 
//     case '1'
//       invo_format.of_set_align('right') 
//     case '2'
//       invo_format.of_set_align('center') 
//     case '3'
//       invo_format.of_set_align('justified') 
//   end choose
//   invo_format.of_set_align('top') 
//   if is_coltype = 's' then invo_format.of_set_text_wrap(true) 

//   long ll_color
//   integer li_color_index
//   ll_color = of_descr_color()
//   if ll_color >= 0 then
//      li_color_index = invo_colors.of_get_custom_color_index(ll_color) 
//      if li_color_index > 0 then
//          invo_format.of_set_color(li_color_index)
//      end if
//   end if
//
//   ll_color = of_descr_bg_color()
//   if ll_color >= 0 then
//      li_color_index = invo_colors.of_get_custom_color_index(ll_color) 
//      if li_color_index > 0 then
//          invo_format.of_set_bg_color(li_color_index)
//      end if
//   end if
	
	string ls_border_style
	 
	ls_border_style = of_describe(is_dwo_name + '.Border') 
	if isNumber(ls_border_style) and integer(ls_border_style) > 0 then
		invo_format.of_set_border(1)
	else
		if integer(of_describe ( 'Datawindow.Processing' )) = 1 then
			invo_format.of_set_border(7)
		end if
	end if
	ib_custom_format =  (ib_color_expr          or ib_bg_color_expr    or ib_alignment_expr or &
	                     ib_font_face_expr      or ib_font_height_expr or ib_font_italic_expr or &
								ib_font_underline_expr or ib_font_weight_expr or ib_format_expr)
end if  

return li_ret
end function

public function long of_get_x1 ();If il_cached_x1 = -1 Then 
	Return of_get_x1(1)
Else
	Return il_base_x + il_cached_x1
End If



end function

public function long of_get_y1 (long al_row);long ll_ret 

al_row = al_row + ii_row_in_detail - 1
if al_row > il_dw_row_count then 
   Return 0
end if

If is_expr_y1 = "" Then
	ll_ret = il_base_y + il_cached_y1
ElseIf is_expr_y1 = "-" Then
	il_cached_y1 = of_describe_expr(is_dwo_name + '.y', al_row, is_expr_y1) - il_subband_y
	ll_ret = il_base_y + il_cached_y1
Else 
	ll_ret = il_base_y + of_evaluate0(is_expr_y1, al_row) - il_subband_y
End If

Return ll_ret



end function

public function long of_get_y2 (long al_row);long ll_ret = 0

al_row = al_row + ii_row_in_detail - 1
if al_row > il_dw_row_count then 
   Return 0
end if

If is_expr_y2 = "" Then
	ll_ret = il_base_y + il_cached_y2
ElseIf is_expr_y2 = "-" Then
	ll_ret = of_get_y1(al_row) + of_get_height(al_row)
	il_cached_y2 = ll_ret - il_base_y
	If is_expr_y1 <> "" Or is_expr_height <> "" Then
		is_expr_y2 = "*" // this will not be used as an expression
	Else
		is_expr_y2 = ""
	End If
Else 
	ll_ret = of_get_y1(al_row) + of_get_height(al_row)
End If

Return ll_ret

end function

public function long of_get_y1 ();If il_cached_y1 = -1000000000 Then 
	Return of_get_y1(1)
Else
	Return il_base_y + il_cached_y1
End If

end function

public function integer of_get_visible (long al_row);int li_ret = 0

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
    li_ret = of_describe_expr(is_dwo_name + '.visible', al_row)
end if

return li_ret

end function

public function long of_get_y2 ();If il_cached_y2 = -1000000000 Then 
	Return of_get_y2(1)
Else
	Return il_base_y + il_cached_y2
End If

end function

public function string of_get_item_coltype ();string ls_coltype
long ll_pos, ll_pos_dec

ls_coltype = trim(lower(of_describe(is_dwo_name + '.coltype')))
ll_pos = pos(ls_coltype, '(')
if ll_pos > 0 then 
	ll_pos_dec  = pos(ls_coltype, ',', ll_pos)
	if ll_pos_dec <= 0 then ll_pos_dec = pos(ls_coltype, ')', ll_pos)
	ii_colsize = integer(mid(ls_coltype, ll_pos + 1, ll_pos_dec - ll_pos - 1))
	ls_coltype = trim(left(ls_coltype, ll_pos - 1))
end if

choose case ls_coltype
	case 'char', 'string'
		ls_coltype = 's'
	case 'decimal','int','long','ulong','number','real','integer'
		ls_coltype = 'n'
	case 'date'
		ls_coltype = 'd'
	case 'datetime', 'timestamp'
		ls_coltype = 'dt'
	case 'time'
		ls_coltype = 't'
	case else 
		ls_coltype = '-'
end choose

return ls_coltype

end function

public function long of_describe_expr (string as_expr, long al_row);string ls_val
long ll_pos
n_dwr_string lnvo_str
Choose Case ipo_requestortype //idw_requestor
	Case DataWindow!
		ls_val = idw_requestor.describe(as_expr)
	Case DataStore!
		ls_val = ids_requestor.describe(as_expr)
	Case DataWindowChild!
		ls_val = idwc_requestor.describe(as_expr)
	Case Else
		Return -1
End Choose   

ll_pos = pos(ls_val, '~t')
if ll_pos > 0 then
   ls_val = mid(ls_val, ll_pos + 1, len(ls_val) - ll_pos - 1)
   ls_val = lnvo_str.of_globalreplace(ls_val, "'", "~~~'")
	Choose Case ipo_requestortype 
		Case DataWindow!
			ls_val = idw_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataStore!
			ls_val = ids_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataWindowChild!
			ls_val = idwc_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case Else
			Return -1
	End Choose   
	if isNumber(ls_val) then return long(ls_val)
	MessageBox ( "Atenci$$HEX1$$f300$$ENDHEX$$n", "Ocurrio un error al tratar de evaluar el campo : " + &
									gf_desglosa_string (as_expr, 1, '.') + " para la " + &
									"propiedad : " + gf_desglosa_string (as_expr, 2, '.') + &
									", en el renglon : " + STRING(al_row) + &
									" del objeto : " + idw_requestor.dataobject + ".~r" + &
									"Favor de reportarlo a Sistemas.")
else
  if isNumber(ls_val) then return long(ls_val)
end if

return -1
end function

private function string of_unquote(string AS_STR);long ll_pos

if left(as_str, 1) = '"' and &
   right(as_str, 1) = '"' then
   if (pos(as_str,'~r') > 0) or (pos(as_str,'~n') > 0) then
      as_str = mid(as_str, 2, len(as_str) - 2)   
   end if
end if

ll_pos = pos(as_str, '~~"')
do while ll_pos > 0 
   as_str = replace(as_str, ll_pos, 2, '"')
   ll_pos = pos(as_str, '~~"')
loop

return as_str   
end function

public function string of_change_format (ref string as_format, string as_type);long ll_pos
n_dwr_string lnvo_str
string ls_arr[], ls_emp[]
long ll_cnt, ll_i, ll_ret

//delete expression if exist
//ll_pos = pos(lower(as_format), '~t')
//if ll_pos > 0 then
//   as_format = left(as_format, ll_pos - 1) 
//   if left(as_format, 1) = '"' then
//      as_format = right(as_format, len(as_format) - 1) 
//   end if
//end if

// acquire user regional settings
If Not ib_system_format_cached Then
	
	ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sShortDate", RegString!, is_system_shortdate_format)
	If ll_ret <> 1 Then is_system_shortdate_format = "dd.MM.yyyy"
	
	ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sLongDate", RegString!, is_system_longdate_format)
	If ll_ret <> 1 Then is_system_longdate_format = "dd MMMM yyyy"
	
	ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sTimeFormat", RegString!, is_system_time_format)
	If ll_ret <> 1 Then is_system_time_format = "HH:mm"
	
	
	
	is_system_date_format = is_system_shortdate_format

	//is_system_currency_format = '$#,##0.00'
	is_system_currency_format = of_get_system_currency_format()
	ib_system_format_cached = True
End If



//check text format with @
ll_pos = pos(as_format, '@')
if ll_pos > 0 then
   as_format = '[general]'
end if

//replace [general] to @
if is_coltype = 'd' then
	as_format = lnvo_str.of_GlobalReplace(as_format, "[general]", "[shortdate]")
elseif is_coltype = 'dt' then
	as_format = lnvo_str.of_GlobalReplace(as_format, "[general]", "[shortdate]")
elseif is_coltype = 't' then
	as_format = lnvo_str.of_GlobalReplace(as_format, "[general]", "[time]")
else
	as_format = lnvo_str.of_GlobalReplace(as_format, "[general]", "@")
end if

as_format = lnvo_str.of_GlobalReplace(as_format, "[currency]", is_system_currency_format)

as_format = lnvo_str.of_GlobalReplace(as_format, "[shortdate]", is_system_shortdate_format)
as_format = lnvo_str.of_GlobalReplace(as_format, "[longdate]", is_system_longdate_format)
as_format = lnvo_str.of_GlobalReplace(as_format, "[date]", is_system_date_format)
as_format = lnvo_str.of_GlobalReplace(as_format, "[time]", is_system_time_format)

//check multipart format
if pos(as_format, ';') > 0 then
   ll_cnt = lnvo_str.of_parsetoarray(as_format, ';', ls_arr)
   
   choose case as_type
       case 'n'
            if (ll_cnt > 3) then ll_cnt = 3
         case else
            if (ll_cnt > 1) then ll_cnt = 1
   end choose      
   for ll_i = 1 to ll_cnt
      //change single qoutes to double
      ls_emp[ll_i] = lnvo_str.of_globalreplace(ls_arr[ll_i], '~'', '"')
      //change number format to General
	  ls_emp[ll_i] = lnvo_str.of_globalreplace(ls_emp[ll_i], '@', 'General')
   next
   lnvo_str.of_arraytostring(ls_emp, ';', as_format)
end if

if ii_colsize > 255 then as_format = ''

return as_format

end function

private function integer of_get_column_display_type ();string ls_str

choose case ii_dwo_type
   case 1 // column

      ls_str = of_describe(is_dwo_name + '.CheckBox.On')
      if (ls_str <> '!') and (ls_str <> '?') and (ls_str <> '') then
         return CDT_CHECKBOX
      end if

      ls_str = of_describe(is_dwo_name + '.DDDW.Name')
      if (ls_str <> '!') and (ls_str <> '?') and (ls_str <> '') then
         return CDT_DDDW
      end if

      ls_str = of_describe(is_dwo_name + '.DDLB.Required')
      if (ls_str <> '!') and (ls_str <> '?') and (ls_str <> '') then
         return CDT_DDLB
      end if

      ls_str = of_describe(is_dwo_name + '.RadioButtons.Columns')
      if (ls_str <> '0') and (ls_str <> '!') and (ls_str <> '?') and (ls_str <> '') then
         return CDT_TEXT
      end if
    
      ls_str = of_describe(is_dwo_name + '.Edit.CodeTable')
      if (lower(ls_str) = 'yes') then
         return CDT_CODETABLE
      end if
      return CDT_TEXT
    
   case 2,3 // compute, text
     return CDT_TEXT
   case 4   // report
     return CDT_REPORT
   case else
	  return CDT_TEXT
end choose

end function

public function n_xls_format of_get_format (long al_row);integer li_ret =1
n_xls_format lnvo_temp_format

if ib_custom_format then
	
   al_row = al_row + ii_row_in_detail - 1
   if al_row <= il_dw_row_count then 
		lnvo_temp_format = invo_writer.of_addformat()
		if isNull(lnvo_temp_format) then 
			li_ret = -1
		else
			if Not(isValid(lnvo_temp_format)) then li_ret = -1
		end if
		if li_ret = 1 then
			lnvo_temp_format.of_copy(invo_format)
	
			if ib_bg_color_expr       then of_eval_bg_color(lnvo_temp_format, al_row)
			if ib_color_expr          then of_eval_color(lnvo_temp_format, al_row)
			if ib_format_expr         then of_eval_numformat(lnvo_temp_format, al_row)
			if ib_font_face_expr      then of_eval_font_face(lnvo_temp_format, al_row)
			if ib_font_underline_expr then of_eval_font_underline(lnvo_temp_format, al_row)
			if ib_font_italic_expr    then of_eval_font_italic(lnvo_temp_format, al_row)
			if ib_font_weight_expr    then of_eval_font_weight(lnvo_temp_format, al_row)
			if ib_alignment_expr      then of_eval_alignment(lnvo_temp_format, al_row)
			//dup//if ib_font_weight_expr    then of_eval_font_weight(lnvo_temp_format, al_row)
			if ib_font_height_expr    then of_eval_font_height(lnvo_temp_format, al_row)
			//dup//if ib_font_height_expr    then of_eval_font_height(lnvo_temp_format, al_row)		

   		return lnvo_temp_format
		end if
	else
		return invo_format
	end if
else
	return invo_format
end if
end function

public function integer of_set_color (n_xls_format a_format, long al_row);long ll_color
integer li_color_index

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ll_color = long(of_describe('evaluate("' + is_color_expr + '", ' + string(al_row) + ')'))
	if ll_color >= 0 then
		li_color_index = invo_colors.of_get_custom_color_index(ll_color) 
		if li_color_index > 0 then
			 a_format.of_set_color(li_color_index)
		end if
	end if
end if

return 1

end function

public function integer of_set_bg_color (n_xls_format a_format, long al_row);long ll_color
integer li_color_index

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ll_color = long(of_describe('evaluate("' + is_bg_color_expr + '", ' + string(al_row) + ')'))
	if ll_color >= 0 then
		li_color_index = invo_colors.of_get_custom_color_index(ll_color) 
		if li_color_index > 0 then
			 a_format.of_set_bg_color(li_color_index)
		end if
	end if
end if

return 1

end function

public function integer of_check_property (string as_property_name, ref boolean ab_is_expression, ref string as_expression, ref string as_value);integer li_ret
string ls_str
long ll_pos


Choose Case ipo_requestortype 
	Case DataWindow!
		ls_str = idw_requestor.describe(is_dwo_name + '.' + as_property_name)
	Case DataStore!
		ls_str = ids_requestor.describe(is_dwo_name + '.' + as_property_name)
	Case DataWindowChild!
		ls_str = idwc_requestor.describe(is_dwo_name + '.' + as_property_name)
	Case Else
		Return -1
End Choose   
if (ls_str <> '!') and (ls_str <> '?') and (ls_str <> '') then
   //check for expression
   ll_pos = pos(lower(ls_str), '~t')
   if ll_pos > 0 then
		 as_expression = right(ls_str, len(ls_str) - ll_pos) 
		 if right(as_expression, 1) = '"' then 
			 as_expression = left(as_expression, len(as_expression) - 1) 
//		 else
//			n_dwr_string s
//			as_expression = s.of_GlobalReplace(as_expression, "~~", "~~~~")
//			as_expression = s.of_GlobalReplace(as_expression, "~'", "~'~'")
//			as_expression = s.of_GlobalReplace(as_expression, "~"", "~"~"")
		 end if
		 ab_is_expression = (trim(as_expression) <> '')

      ls_str = left(ls_str, ll_pos - 1) 
      if left(ls_str, 1) = '"' then
         ls_str = right(ls_str, len(ls_str) - 1) 
      end if
   end if
	
	as_value = ls_str
	li_ret = 1
else
   li_ret = -1
end if

return li_ret
end function

public function string of_descr_numformat ();integer li_ret 
string ls_value

li_ret = of_check_property('Format', ib_format_expr, is_format_expr, ls_value)
if li_ret = 1 then
	return ls_value
else
	return ''
end if

end function

public function string of_descr_font_face ();integer li_ret 
string ls_value

li_ret = of_check_property('Font.Face', ib_font_face_expr, is_font_face_expr, ls_value)
if li_ret = 1 then
   return ls_value
else
	return 'Arial'
end if


end function

public function long of_descr_font_height ();integer li_ret 
string ls_value

li_ret = of_check_property('Font.Height', ib_font_height_expr, is_font_height_expr, ls_value)
if li_ret = 1 then
   if isNumber(ls_value) then
		return abs(integer(ls_value))
   else
      return 10
   end if
else
	return 10
end if

end function

public function boolean of_descr_font_italic ();integer li_ret 
string ls_value

li_ret = of_check_property('Font.Italic', ib_font_italic_expr, is_font_italic_expr, ls_value)
if li_ret = 1 then
	return ((lower(ls_value) = 'yes') or (ls_value = '1'))
else
	return false
end if
end function

public function integer of_descr_font_underline ();integer li_ret 
string ls_value

li_ret = of_check_property('font.underline', ib_font_underline_expr, is_font_underline_expr, ls_value)
if li_ret = 1 then
	if ((lower(ls_value) = 'yes') or (ls_value = '1')) then 
		return 1
	else
		return 0
	end if
else
	return 0
end if

end function

public function boolean of_descr_font_weight ();integer li_ret 
string ls_value

li_ret = of_check_property('font.weight', ib_font_weight_expr, is_font_weight_expr, ls_value)
if li_ret = 1 then
	if isNumber(ls_value) then
		return (abs(integer(ls_value)) = 700)
	else
		return false
	end if
else
	return false
end if

end function

public function string of_descr_alignment ();integer li_ret 
string ls_value = '-1'

li_ret = of_check_property('alignment', ib_alignment_expr, is_alignment_expr, ls_value)
if li_ret <> 1 then ls_value = '-1'
choose case ls_value
     case '0'
   		return 'left'
     case '1'
		   return 'right'
     case '2'
		   return 'center'
     case '3'
		   return 'justified'
	case else
		   if is_coltype = 'n' then
				return 'right'
			else
				return 'left'
			end if
end choose
		
	

end function

public function integer of_descr_bg_color ();integer li_ret 
string ls_str
string ls_value
long ll_color

ls_str = of_describe(is_dwo_name + '.Background.Mode')
if ls_str <> '1' then
   li_ret = of_check_property('Background.Color', ib_bg_color_expr, is_bg_color_expr, ls_value)
	if li_ret = 1 then
       if isNumber(ls_value) then
			 ll_color = invo_colors.of_get_color(long(ls_value))
			 return invo_colors.of_get_custom_color_index(ll_color) 
       else
          return -1
       end if
	else
		return -1
	end if
else
	return -1
end if



end function

public function integer of_descr_color ();integer li_ret 
string ls_value
long ll_color

li_ret = of_check_property('Color', ib_color_expr, is_color_expr, ls_value)
if li_ret = 1 then
   if isNumber(ls_value) then
		ll_color = invo_colors.of_get_color(long(ls_value))
		return invo_colors.of_get_custom_color_index(ll_color) 
   else
      return -1
   end if
else
	return -1
end if

end function

public function integer of_eval_bg_color (n_xls_format anvo_format, long al_row);integer li_color_index 
string ls_value
long ll_color

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = of_describe('evaluate("' + is_bg_color_expr + '", ' + string(al_row) + ')')
   if isNumber(ls_value) then
       ll_color = invo_colors.of_get_color(long(ls_value))
		 li_color_index = invo_colors.of_get_custom_color_index(ll_color) 
		 if li_color_index > 0 then 
			 anvo_format.of_set_bg_color(li_color_index)
			 return 1
		end if
   end if
end if

return -1

end function

public function integer of_eval_color (n_xls_format anvo_format, long al_row);integer li_color_index 
string ls_value
long ll_color

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = of_describe('evaluate("' + is_color_expr + '", ' + string(al_row) + ')')
   if isNumber(ls_value) then
       ll_color = invo_colors.of_get_color(long(ls_value))
		 li_color_index = invo_colors.of_get_custom_color_index(ll_color) 
		 if li_color_index > 0 then 
			 anvo_format.of_set_color(li_color_index)
			 return 1
		end if
   end if
end if

return -1

end function

public function integer of_eval_font_face (n_xls_format anvo_format, long al_row);string ls_value

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = trim(of_describe('evaluate("' + is_font_face_expr + '", ' + string(al_row) + ')'))
	if ls_value <> '' then
		anvo_format.of_set_font(ls_value)
		return 1
	end if
end if

return -1

end function

public function integer of_eval_numformat (n_xls_format anvo_format, long al_row);string ls_value

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = trim(of_describe('evaluate("' + is_format_expr + '", ' + string(al_row) + ')'))
 	if ls_value = '' then ls_value = '[General]'
	ls_value = of_change_format(ls_value, is_coltype)
	anvo_format.of_set_num_format(ls_value)
	return 1
end if

return -1

end function

public function integer of_eval_font_height (n_xls_format anvo_format, long al_row);string ls_value

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = of_describe('evaluate("' + is_font_height_expr + '", ' + string(al_row) + ')')
   if isNumber(ls_value) then
      anvo_format.of_set_size(abs(integer(ls_value)))
      return 1
   end if
end if

return -1

end function

public function integer of_eval_font_italic (n_xls_format anvo_format, long al_row);string ls_value

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = of_describe('evaluate("' + is_font_italic_expr + '", ' + string(al_row) + ')')
   anvo_format.of_set_italic((lower(ls_value) = 'yes') or (ls_value = '1'))
	return 1
end if

return -1


end function

public function integer of_eval_font_underline (n_xls_format anvo_format, long al_row);string ls_value

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = of_describe('evaluate("' + is_font_underline_expr + '", ' + string(al_row) + ')')
	if ((lower(ls_value) = 'yes') or (ls_value = '1')) then
		anvo_format.of_set_underline(1)
	else
		anvo_format.of_set_underline(0)
	end if
	return 1
end if

return -1


end function

public function integer of_eval_font_weight (n_xls_format anvo_format, long al_row);string ls_value

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = of_describe('evaluate("' + is_font_weight_expr + '", ' + string(al_row) + ')')
	if isNumber(ls_value) then
	   anvo_format.of_set_bold(abs(integer(ls_value)) = 700)
	else
		anvo_format.of_set_bold(false)
	end if
	
	return 1
end if

return -1


end function

public function integer of_eval_alignment (n_xls_format anvo_format, long al_row);string ls_value
string ls_align

al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	ls_value = trim(of_describe('evaluate("' + is_alignment_expr + '", ' + string(al_row) + ')'))
	choose case ls_value
		  case '0'
				ls_align = 'left'
		  case '1'
				ls_align = 'right'
		  case '2'
				ls_align = 'center'
		  case '3'
				ls_align = 'justified'
		case else
				if is_coltype = 'n' then
					ls_align = 'right'
				else
					ls_align = 'left'
				end if
	end choose
	anvo_format.of_set_align(ls_align)
	return 1
end if

return -1

end function

public function long of_get_x1 (long al_row);long ll_ret 
If is_expr_x1 = "" Then
	ll_ret = il_base_x + il_cached_x1
ElseIf is_expr_x1 = "-" Then
	il_cached_x1 = of_describe_expr(is_dwo_name + '.x', al_row, is_expr_x1)
	ll_ret = il_base_x + il_cached_x1
Else 
	ll_ret = il_base_x + of_evaluate0(is_expr_x1, al_row)
End If
Return ll_ret


end function

public function long of_get_x2 ();If il_cached_x2 = -1 Then 
	Return of_get_x2(1)
Else
	Return il_base_x + il_cached_x2
End If


end function

public function long of_get_x2 (readonly long al_row);Long ll_ret
If is_expr_x2 = "" Then
	ll_ret = il_base_x + il_cached_x2
ElseIf is_expr_x2 = "-" Then
	ll_ret = of_get_x1(al_row) + of_get_width(al_row)
	il_cached_x2 = ll_ret - il_base_x
	If is_expr_x1 <> "" Or is_expr_width <> "" Then
		is_expr_x2 = is_expr_x1 + " + " + is_expr_width
	Else
		is_expr_x2 = ""
	End If
Else 
	ll_ret = of_get_x1(al_row) + of_get_width(al_row)
End If

Return ll_ret


end function

public function string of_describe (readonly string as_expr);Choose Case ipo_requestortype 
	Case DataWindow!
		Return idw_requestor.describe(as_expr)
	Case DataStore!
		Return ids_requestor.describe(as_expr)
	Case DataWindowChild!
		Return idwc_requestor.describe(as_expr)
	Case Else
		Return "!"
End Choose   

end function

public function any of_getvalue_dw (long al_row);DataWindow lpo_requestor
// the code below is common for of_getvalue_dwc, of_getvalue_dw, of_getvalue_ds
// any changes should be replicated by copy & paste method
lpo_requestor = ipo_requestor
any la_val
string ls_val
double ldb_val
datetime ldt_val
date ld_val
time lt_val


SetNull(la_val)
al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	choose case ii_dwo_type
	case DT_COLUMN, DT_COMPUTE 
		 if ii_column_display_type = CDT_TEXT then
			choose case is_coltype
				case 's'
					integer li_id
					li_id = integer(lpo_requestor.describe(is_dwo_name+'.id'))
					if li_id > 0 then
						//la_val = string(lpo_requestor.object.data[al_row, li_id])
						// DataWindowChild has no Object property
						la_val = lpo_requestor.GetItemString(al_row, li_id) 
					else	  
						//2)la_val = string(lpo_requestor.describe("Evaluate('" + is_dwo_name + "', " + string(al_row) + ")"))
						//$$HEX21$$ef00f000e800f800eb00ee00f100fc002000e700e000ec00e500ed00e800f200fc002000ed00e0002000$$ENDHEX$$describe $$HEX8$$f200e000ea002000ea00e000ea002000$$ENDHEX$$GetItemString $$HEX38$$e200ee00e700e200f000e000f900e000eb002000f100f200ee00f000ea00f3002000f1002000ef00f000e800ec00e500ed00e500ed00e800e500ec002000f400ee00f000ec00e000f200e000$$ENDHEX$$
						//1)la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
						la_val = string(lpo_requestor.describe("Evaluate('" + is_dwo_name + "', " + string(al_row) + ")"))
					end if	
				case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
				case 'd'
					la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
				case 'dt'
					la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
				case 't'
					la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			end choose
		elseif ii_column_display_type = CDT_CHECKBOX then
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				if isNull(la_val) then la_val = ''
		elseif ii_column_display_type = CDT_DDDW then
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				
				If ib_disable_lookup_display Then
					if isNull(la_val) then 
						la_val = ''
					end if
				Else
					if not isNull(la_val) then 
						la_val = string(lpo_requestor.describe("Evaluate('LookUpDisplay(" + is_dwo_name + ")', " + string(al_row) + ")"))
					else
						la_val = ''
					end if
				End If	
		else
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				if not isNull(la_val) then 
					la_val = string(lpo_requestor.describe("Evaluate('LookUpDisplay(" + is_dwo_name + ")', " + string(al_row) + ")"))
				else
					la_val = ''
				end if
		 end if
	case DT_TEXT 
	  //-- 04.10.2004
	  //support expression in text object
		 if is_text_expr <> '' then
			 //la_val = string(of_describe_expr(is_dwo_name + '.Text', al_row))
			 // bugfix: use of_describe_str_expr
			 // of_describe_expr supports only numeric expressions
			 la_val = of_describe_str_expr(is_dwo_name + '.Text', al_row)
		 else
			 la_val = is_text
		 end if
	  //--
	case DT_REPORT 
		la_val = "{" + is_dwo_name + "}"
		
	end choose

end if

return la_val

end function

public function any of_getvalue_ds (long al_row);DataStore lpo_requestor
// the code below is common for of_getvalue_dwc, of_getvalue_dw, of_getvalue_ds
// any changes should be replicated by copy & paste method
lpo_requestor = ipo_requestor
any la_val
string ls_val
double ldb_val
datetime ldt_val
date ld_val
time lt_val


SetNull(la_val)
al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	choose case ii_dwo_type
	case DT_COLUMN, DT_COMPUTE 
		 if ii_column_display_type = CDT_TEXT then
			choose case is_coltype
				case 's'
					integer li_id
					li_id = integer(lpo_requestor.describe(is_dwo_name+'.id'))
					if li_id > 0 then
						//la_val = string(lpo_requestor.object.data[al_row, li_id])
						// DataWindowChild has no Object property
						la_val = lpo_requestor.GetItemString(al_row, li_id) 
					else	  
						//2)la_val = string(lpo_requestor.describe("Evaluate('" + is_dwo_name + "', " + string(al_row) + ")"))
						//$$HEX21$$ef00f000e800f800eb00ee00f100fc002000e700e000ec00e500ed00e800f200fc002000ed00e0002000$$ENDHEX$$describe $$HEX8$$f200e000ea002000ea00e000ea002000$$ENDHEX$$GetItemString $$HEX38$$e200ee00e700e200f000e000f900e000eb002000f100f200ee00f000ea00f3002000f1002000ef00f000e800ec00e500ed00e500ed00e800e500ec002000f400ee00f000ec00e000f200e000$$ENDHEX$$
						//1)la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
						la_val = string(lpo_requestor.describe("Evaluate('" + is_dwo_name + "', " + string(al_row) + ")"))
					end if	
				case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
				case 'd'
					la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
				case 'dt'
					la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
				case 't'
					la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			end choose
		elseif ii_column_display_type = CDT_CHECKBOX then
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				if isNull(la_val) then la_val = ''
		elseif ii_column_display_type = CDT_DDDW then
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				
				If ib_disable_lookup_display Then
					if isNull(la_val) then 
						la_val = ''
					end if
				Else
					if not isNull(la_val) then 
						la_val = string(lpo_requestor.describe("Evaluate('LookUpDisplay(" + is_dwo_name + ")', " + string(al_row) + ")"))
					else
						la_val = ''
					end if
				End If	
		else
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				if not isNull(la_val) then 
					la_val = string(lpo_requestor.describe("Evaluate('LookUpDisplay(" + is_dwo_name + ")', " + string(al_row) + ")"))
				else
					la_val = ''
				end if
		 end if
	case DT_TEXT 
	  //-- 04.10.2004
	  //support expression in text object
		 if is_text_expr <> '' then
			 //la_val = string(of_describe_expr(is_dwo_name + '.Text', al_row))
			 // bugfix: use of_describe_str_expr
			 // of_describe_expr supports only numeric expressions
			 la_val = of_describe_str_expr(is_dwo_name + '.Text', al_row)
		 else
			 la_val = is_text
		 end if
	  //--
	case DT_REPORT 
		la_val = "{" + is_dwo_name + "}"
		
	end choose

end if

return la_val

end function

public function any of_getvalue_dwc (long al_row);DataWindowChild lpo_requestor
// the code below is common for of_getvalue_dwc, of_getvalue_dw, of_getvalue_ds
// any changes should be replicated by copy & paste method
lpo_requestor = ipo_requestor
any la_val
string ls_val
double ldb_val
datetime ldt_val
date ld_val
time lt_val


SetNull(la_val)
al_row = al_row + ii_row_in_detail - 1
if al_row <= il_dw_row_count then 
	choose case ii_dwo_type
	case DT_COLUMN, DT_COMPUTE 
		 if ii_column_display_type = CDT_TEXT then
			choose case is_coltype
				case 's'
					integer li_id
					li_id = integer(lpo_requestor.describe(is_dwo_name+'.id'))
					if li_id > 0 then
						//la_val = string(lpo_requestor.object.data[al_row, li_id])
						// DataWindowChild has no Object property
						la_val = lpo_requestor.GetItemString(al_row, li_id) 
					else	  
						//2)la_val = string(lpo_requestor.describe("Evaluate('" + is_dwo_name + "', " + string(al_row) + ")"))
						//$$HEX21$$ef00f000e800f800eb00ee00f100fc002000e700e000ec00e500ed00e800f200fc002000ed00e0002000$$ENDHEX$$describe $$HEX8$$f200e000ea002000ea00e000ea002000$$ENDHEX$$GetItemString $$HEX38$$e200ee00e700e200f000e000f900e000eb002000f100f200ee00f000ea00f3002000f1002000ef00f000e800ec00e500ed00e500ed00e800e500ec002000f400ee00f000ec00e000f200e000$$ENDHEX$$
						//1)la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
						la_val = string(lpo_requestor.describe("Evaluate('" + is_dwo_name + "', " + string(al_row) + ")"))
					end if	
				case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
				case 'd'
					la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
				case 'dt'
					la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
				case 't'
					la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			end choose
		elseif ii_column_display_type = CDT_CHECKBOX then
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				if isNull(la_val) then la_val = ''
		elseif ii_column_display_type = CDT_DDDW then
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				
				If ib_disable_lookup_display Then
					if isNull(la_val) then 
						la_val = ''
					end if
				Else
					if not isNull(la_val) then 
						la_val = string(lpo_requestor.describe("Evaluate('LookUpDisplay(" + is_dwo_name + ")', " + string(al_row) + ")"))
					else
						la_val = ''
					end if
				End If	
		else
			 	choose case is_coltype
					case 's'
						la_val = lpo_requestor.GetItemString(al_row, is_dwo_name)
					case 'n'
					la_val = lpo_requestor.GetItemDecimal(al_row, is_dwo_name)
					case 'd'
						la_val = lpo_requestor.GetItemDate(al_row, is_dwo_name)
					case 'dt'
						la_val = lpo_requestor.GetItemDateTime(al_row, is_dwo_name)
					case 't'
						la_val = lpo_requestor.GetItemTime(al_row, is_dwo_name)
			 	end choose
				if not isNull(la_val) then 
					la_val = string(lpo_requestor.describe("Evaluate('LookUpDisplay(" + is_dwo_name + ")', " + string(al_row) + ")"))
				else
					la_val = ''
				end if
		 end if
	case DT_TEXT 
	  //-- 04.10.2004
	  //support expression in text object
		 if is_text_expr <> '' then
			 //la_val = string(of_describe_expr(is_dwo_name + '.Text', al_row))
			 // bugfix: use of_describe_str_expr
			 // of_describe_expr supports only numeric expressions
			 la_val = of_describe_str_expr(is_dwo_name + '.Text', al_row)
		 else
			 la_val = is_text
		 end if
	  //--
	case DT_REPORT 
		la_val = "{" + is_dwo_name + "}"
		
	end choose

end if

return la_val

end function

public function integer of_createnestedservice (n_dwr_nested_service_parm anvo_nested_parm, n_dwr_service_parm anvo_parm);int li_ret = -1
long ll_parent_rowcount
inv_nested_service_parm = anvo_nested_parm
inv_parm = anvo_parm
//is_nested_instance_id = String(inv_parm.il_nested_instance_count)
// see n_dwr_band.of_add_field

is_parent_band_id = inv_nested_service_parm.is_parent_band_id

ids_reportdata = Create DataStore
// 
String ls_dwo = ""
Choose Case ipo_requestortype 
	Case DataWindow!
		ls_dwo = idw_requestor.DataObject
		ll_parent_rowcount = idw_requestor.RowCount()
	Case DataStore!
		ls_dwo = ids_requestor.DataObject
		ll_parent_rowcount = ids_requestor.RowCount()
	Case Else
		Return -1
End Choose  
If ll_parent_rowcount = 0 Then
	// PB does not display nested DWs (even in header) if parent has no rows 
	// so we don't export them
	Return -1
End If
If ls_dwo <> "" Then
	ids_reportdata.DataObject = ls_dwo  
End If


blob lblob_1
Choose Case ipo_requestortype
Case DataWindow!, DataStore!
	Environment e
	GetEnvironment(e)
	If e.PbMajorRevision < 6 Then
		String ls_tmpfile = "dw2xls_tmp.psr"
		If ipo_requestor.Dynamic SaveAs(ls_tmpfile, PSReport!, True) <> 1 Then
			Return -1
		End If
		ids_reportdata.DataObject = ls_tmpfile
		FileDelete(ls_tmpfile)
	Else
		ipo_requestor.Dynamic GetFullState(lblob_1)
		ids_reportdata.Dynamic SetFullState(lblob_1)
	End If
	ids_reportdata.Modify("Datawindow.Processing=5")
Case Else // DWC
	 // GetFullState, GetChild, SaveAs not supported
	 Return -1
End Choose

DataWindowChild ldwc_nested
DataStore lds_nested
li_ret = ids_reportdata.GetChild(is_dwo_name, ldwc_nested)
If li_ret = 1 Then
	SetNull(lds_nested)
	is_nested_processing = ldwc_nested.Describe("Datawindow.Processing")
	If is_nested_processing = "4" Then
		// disable method1 for nested crosstab due to gpf
		inv_parm.ii_nested_extract_method = 0
	End If
	If inv_parm.ii_nested_extract_method = 1 Then
		inv_nested_data = Create n_dwr_psr
		If inv_nested_data.of_CreateFromDW(ipo_requestor) = 1 Then
			of_GetDDDWColumnIDs(ldwc_nested, is_nested_dddw_column_ids[])
			If inv_nested_data.of_Nested2DS(is_nested_instance_id, is_nested_dataobject, is_parent_band_id, 1, is_nested_dddw_column_ids[] ,lds_nested) = 1 Then
				lds_nested.GroupCalc()
			End If
		Else
			Destroy inv_nested_data
			SetNull(inv_nested_data)
			inv_parm.ii_nested_extract_method = 0
		End If
	End If
	If IsNull(lds_nested) Then
		lds_nested = of_dwc2ds(ldwc_nested, True) // should be TRUE
	End If
	il_child_cache_row = 1
	ids_child_cache = lds_nested
	anvo_nested_parm.il_nested_x = of_get_x1()
	anvo_nested_parm.il_nested_y = of_get_y1()
	inv_nestedservice = Create Using "n_dwr_service"
	li_ret = inv_nestedservice.of_create(lds_nested, invo_writer, ":not applicable:", anvo_parm, anvo_nested_parm)
End If
If li_ret = 1 Then
	li_ret = inv_nestedservice.of_Analyse_DW(0)
End If

Return li_ret
end function

public function integer of_dynamic_horisontal_layout (long al_row, n_dwr_grid anvo_hgrid);Return 1
end function

public function integer of_register_dynamic (powerobject apo_requestor);ipo_requestor = apo_requestor
ipo_requestortype = ipo_requestor.TypeOf()
Choose Case ipo_requestortype 
	Case DataWindow!
		idw_requestor = ipo_requestor
		il_dw_row_count = idw_requestor.RowCount()
	Case DataStore!
		ids_requestor = ipo_requestor
		il_dw_row_count = ids_requestor.RowCount()
	Case DataWindowChild!
		idwc_requestor = ipo_requestor
		il_dw_row_count = idwc_requestor.RowCount()
	Case Else
		Return -1
End Choose  

Return 1
end function

public function integer of_init (string as_dwo_name, integer ai_dwo_type);integer li_ret = 1

is_dwo_name = as_dwo_name


ii_dwo_type = ai_dwo_type
choose case ii_dwo_type
  case DT_COLUMN  //column
     is_coltype = of_get_item_coltype()
	  il_id = Long(of_describe(as_dwo_name + '.id'))
	  If il_id > 0 And of_describe("#" + String(il_id) + '.name') <> as_dwo_name Then
	     ib_disable_lookup_display = True
	  End If
  case DT_COMPUTE  //expression
     is_coltype = of_get_item_coltype()
  case DT_TEXT  //text
     is_coltype = 's'
     is_text = of_describe(as_dwo_name + '.text')
     is_text = of_unquote(is_text)
	  //-- 04.10.2004
	  //support expression in text object
	  if pos(is_text, '~t') > 0 then is_text_expr = is_text
	  //--
  case DT_REPORT  // report
      is_coltype = 'r'
		is_nested_dataobject = of_describe(is_dwo_name + '.DataObject')
	  
end choose

if li_ret = 1 then
	//MessageBox(as_dwo_name, idw_dw.describe(as_dwo_name + '.attributes'))
	//MessageBox(as_dwo_name, idw_dw.describe(as_dwo_name + '.row_in_detail'))
	//ii_row_in_detail = integer(idw_dw.describe(as_dwo_name + '.row_in_detail'))
	//if (ii_row_in_detail < 1) or isNull(ii_row_in_detail) then ii_row_in_detail = 1
	
	Choose Case ipo_requestortype 
		Case DataWindow!
			il_dw_row_count = idw_requestor.RowCount()
		Case DataStore!
			il_dw_row_count = ids_requestor.RowCount()
		Case DataWindowChild!
			il_dw_row_count = idwc_requestor.RowCount()
		Case Else
			Return -1
	End Choose  

   ib_autosize_height = of_describe(as_dwo_name + ".height.autosize") = "yes"
	ii_column_display_type = of_get_column_display_type()
   li_ret = of_setformat()
end if


return li_ret
end function

private function datastore of_dwc2ds (datawindowchild adwc_src, boolean ab_copydata);DataStore lds_res
lds_res = Create DataStore

//TODO: check for processing=4 and cache the result
adwc_src.Modify('DataWindow.Crosstab.StaticMode=Yes') 
// Don't set to TRUE, experimental mode
Boolean lb_copy_using_psr = False //False, True
If Not lb_copy_using_psr Then
	lds_res.Create(adwc_src.Describe("Datawindow.Syntax"))
	If ab_copydata Then
		adwc_src.RowsCopy(1, adwc_src.RowCount(), Primary!, lds_res, 1, Primary!)
		lds_res.GroupCalc()
	End If
Else
	If ab_copydata Then
		String ls_tmpfile = "dw2xls_tmp.psr"
		FileDelete(ls_tmpfile)
		If adwc_src.SaveAs(ls_tmpfile, PSReport!, True) <> 1 Then
			lds_res.Create(adwc_src.Describe("Datawindow.Syntax"))
			adwc_src.RowsCopy(1, adwc_src.RowCount(), Primary!, lds_res, 1, Primary!)
			lds_res.GroupCalc()
		Else
			lds_res.DataObject = ls_tmpfile
			FileDelete(ls_tmpfile)
		End If
	Else
		lds_res.Create(adwc_src.Describe("Datawindow.Syntax"))
	End If
End If
Return lds_res
end function

public function long of_get_band_y1 ();If il_cached_y1 = -1000000000 Then 
	Return of_get_y1(1) - il_base_y
Else
	Return il_cached_y1
End If

end function

public function long of_get_band_y2 ();If il_cached_y2 = -1000000000 Then 
	Return of_get_y2(1) - il_base_y
Else
	Return il_cached_y2
End If

end function

public function string of_describe_str_expr (string as_expr, long al_row);string ls_val
long ll_pos
//n_dwr_string lnvo_str
Choose Case ipo_requestortype //idw_requestor
	Case DataWindow!
		ls_val = idw_requestor.describe(as_expr)
	Case DataStore!
		ls_val = ids_requestor.describe(as_expr)
	Case DataWindowChild!
		ls_val = idwc_requestor.describe(as_expr)
	Case Else
		Return ""
End Choose   

ll_pos = pos(ls_val, '~t')
if ll_pos > 0 then
   ls_val = mid(ls_val, ll_pos + 1, len(ls_val) - ll_pos - 1)
	//
   //ls_val = lnvo_str.of_globalreplace(ls_val, '~~', '~~~~')
   //ls_val = lnvo_str.of_globalreplace(ls_val, '"', '~~~"')
   //ls_val = lnvo_str.of_globalreplace(ls_val, "'", "~~~'")
	Choose Case ipo_requestortype 
		Case DataWindow!
			ls_val = idw_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataStore!
			ls_val = ids_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataWindowChild!
			ls_val = idwc_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case Else
			Return ""
	End Choose   
	return ls_val
else
  return ls_val
end if

end function

public function string of_get_system_currency_format ();long ll_ret, ll_MonGrouping
String ls_sCurrency, ls_sMonDecimalSep /*"."*/, ls_sMonThousandSep /*","*/ 
String ls_sMonGrouping /*"3;0"*/ 
String ls_numFormat, ls_iCurrency, ls_iNegCurr
String ls_positive, ls_negative
n_dwr_string s


ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sCurrency", RegString!, ls_sCurrency)
If ll_ret <> 1 Then ls_sCurrency = "$"
ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "iCurrency", RegString!, ls_iCurrency)
If ll_ret <> 1 Then ls_iCurrency = "0"
ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "iNegCurr", RegString!, ls_iNegCurr)
If ll_ret <> 1 Then ls_iNegCurr = "0"
ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sMonDecimalSep", RegString!, ls_sMonDecimalSep)
If ll_ret <> 1 Then ls_sMonDecimalSep = "."
ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sMonThousandSep", RegString!, ls_sMonThousandSep)
If ll_ret <> 1 Then ls_sMonThousandSep = ","
ll_ret = RegistryGet("HKEY_CURRENT_USER\Control Panel\International", "sMonGrouping", RegString!, ls_sMonGrouping)
If ll_ret <> 1 Then ls_sMonGrouping = "3;0"




/*
0 $2 
1 2$ 
2 $ 2 
3 2 $ 
*/
Choose Case ls_iCurrency
	Case "0"; ls_positive = "$n"
	Case "1"; ls_positive = "n$"
	Case "2"; ls_positive = "$ n"
	Case "3"; ls_positive = "n $"
	Case Else 
		ls_positive = "$n"
End Choose
/*
0 ($1.1) ($100.00) 
1 -$1.1 -$100.00 
2 $-1.1 $-100.00 
3 $1.1- $100.00- 
4 (1.1$) (100.00$) 
5 -1.1$ -100.00$ 
6 1.1-$ 100.00-$ 
7 1.1$- 100.00$- 
8 -1.1 $ -100.00 $ (space before $) 
9 -$ 1.1 -$ 100.00 (space after $) 
10 1.1 $- 100.00 $- (space before $) 
11 $ 1.1- $ 100.00- (space after $) 
12 $ -1.1 $ -100.00 (space after $) 
13 1.1- $ 100.00- $ (space before $) 
14 ($ 1.1) ($ 100.00) (space after $) 
15 (1.1 $) (100.00 $) (space before $) 
*/
Choose Case ls_iNegCurr
	Case "0" ; 	ls_negative = "($n)"
	Case "1" ; 	ls_negative = "-$n"
	Case "2" ;  ls_negative = "$-n"
	Case "3" ;	ls_negative = "$n-"
	Case "4" ;	ls_negative = "(n$)"
	Case "5" ;	ls_negative = "-n$"
	Case "6" ;	ls_negative = "n-$"
	Case "7" ;	ls_negative = "n$-"
	Case "8" ;	ls_negative = "-n $"
	Case "9" ;	ls_negative = "-$ n"
	Case "10";	ls_negative = "n $-"
	Case "11";	ls_negative = "$ n-"
	Case "12";	ls_negative = "$ -n"
	Case "13";	ls_negative = "n- $"
	Case "14";	ls_negative = "($ n)"
	Case "15";	ls_negative = "(n $)"
	Case Else 
		ls_negative = "-$n"
End Choose

// using only the first number from sMonGrouping
// TODO: full parse
ll_ret = Pos(ls_sMonGrouping, ";")
If ll_ret > 0 Then ls_sMonGrouping = Left(ls_sMonGrouping, ll_ret - 1)
ll_MonGrouping = Long(ls_sMonGrouping)  
If ll_MonGrouping <> 0 Then
	ls_numFormat = "#" + ls_sMonThousandSep + &
		Fill("#", ll_MonGrouping - 1) + "0.00"
Else
	ls_numFormat = "#0.00"
End If
ls_numFormat = s.of_GlobalReplace(ls_positive + ";" + ls_negative, "n", ls_numFormat)
ls_numFormat = s.of_GlobalReplace(ls_numFormat, "$", ls_sCurrency)

Return ls_numFormat
end function

public function long of_describe_expr (string as_expr, long al_row, ref string as_prop_expr);string ls_val
long ll_pos
n_dwr_string lnvo_str
Choose Case ipo_requestortype //idw_requestor
	Case DataWindow!
		ls_val = idw_requestor.describe(as_expr)
	Case DataStore!
		ls_val = ids_requestor.describe(as_expr)
	Case DataWindowChild!
		ls_val = idwc_requestor.describe(as_expr)
	Case Else
		Return -1
End Choose   

ll_pos = pos(ls_val, '~t')
if ll_pos > 0 then
	ls_val = mid(ls_val, ll_pos + 1, len(ls_val) - ll_pos - 1)
   ls_val = lnvo_str.of_globalreplace(ls_val, "'", "~~~'")
	as_prop_expr = ls_val
   
	Choose Case ipo_requestortype 
		Case DataWindow!
			ls_val = idw_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataStore!
			ls_val = ids_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataWindowChild!
			ls_val = idwc_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case Else
			Return -1
	End Choose   
	if isNumber(ls_val) then return long(ls_val)
else
  as_prop_expr = ""
  if isNumber(ls_val) then return long(ls_val)
end if

return -1
end function

public function long of_evaluate0 (readonly string as_expr, long al_row);/**
 as_expr must be already escaped expression (" -> ~", ~ => ~~ )
*/

String ls_val
Choose Case ipo_requestortype 
	Case DataWindow!
		ls_val = idw_requestor.describe('evaluate("' + as_expr + '", ' + string(al_row) + ')')
	Case DataStore!
		ls_val = ids_requestor.describe('evaluate("' + as_expr + '", ' + string(al_row) + ')')
	Case DataWindowChild!
		ls_val = idwc_requestor.describe('evaluate("' + as_expr + '", ' + string(al_row) + ')')
	Case Else
		Return -1
End Choose   

If IsNumber(ls_val) Then 
	Return long(ls_val)
Else
	Return -1
End If



end function

public function long of_get_width (long al_row);long ll_ret 
If is_expr_width = "" Then
	ll_ret = il_cached_width
ElseIf is_expr_width = "-" Then
	il_cached_width = of_describe_expr(is_dwo_name + '.width', al_row, is_expr_width)
	ll_ret = il_cached_width
Else 
	ll_ret = of_evaluate0(is_expr_width, al_row)
End If

Return ll_ret


end function

public function long of_get_height (long al_row);long ll_ret 
If is_expr_height = "" Then
	ll_ret = il_cached_height
ElseIf is_expr_height = "-" Then
	il_cached_height = of_describe_expr(is_dwo_name + '.height', al_row, is_expr_height)
	ll_ret = il_cached_height
Else 
	ll_ret = of_evaluate0(is_expr_height, al_row)
End If

Return ll_ret


end function

public function string of_evaluate_str0 (readonly string as_expr, long al_row);/**
 as_expr must be already escaped expression (" -> ~", ~ => ~~ )
*/

String ls_val
Choose Case ipo_requestortype 
	Case DataWindow!
		ls_val = idw_requestor.describe('evaluate("' + as_expr + '", ' + string(al_row) + ')')
	Case DataStore!
		ls_val = ids_requestor.describe('evaluate("' + as_expr + '", ' + string(al_row) + ')')
	Case DataWindowChild!
		ls_val = idwc_requestor.describe('evaluate("' + as_expr + '", ' + string(al_row) + ')')
	Case Else
		Return ""
End Choose   

Return ls_val



end function

public function string of_describe_str_expr (string as_expr, long al_row, ref string as_prop_expr);string ls_val
long ll_pos
n_dwr_string lnvo_str
Choose Case ipo_requestortype //idw_requestor
	Case DataWindow!
		ls_val = idw_requestor.describe(as_expr)
	Case DataStore!
		ls_val = ids_requestor.describe(as_expr)
	Case DataWindowChild!
		ls_val = idwc_requestor.describe(as_expr)
	Case Else
		Return ""
End Choose   

ll_pos = pos(ls_val, '~t')
if ll_pos > 0 then
	ls_val = mid(ls_val, ll_pos + 1, len(ls_val) - ll_pos - 1)
   ls_val = lnvo_str.of_globalreplace(ls_val, "'", "~~~'")
	as_prop_expr = ls_val
   
	Choose Case ipo_requestortype 
		Case DataWindow!
			ls_val = idw_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataStore!
			ls_val = ids_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case DataWindowChild!
			ls_val = idwc_requestor.describe('evaluate("' + ls_val + '", ' + string(al_row) + ')')
		Case Else
			Return ""
	End Choose   
	Return ls_val
else
	as_prop_expr = ""
	Return ls_val
end if


end function

private function integer of_getdddwcolumnids (datawindowchild adw, ref string as_id[]);String ls_empty[], ls_objects, ls_object[], ls_str, ls_id
n_dwr_string s
Long ll_objectcount, ll_i
as_id[] = ls_empty[]

ls_objects = adw.Describe('DataWindow.Objects')
ll_objectcount = s.of_parsetoarray ( ls_objects, '~t', ls_object )
For ll_i = 1 To ll_objectcount
	ls_id = adw.Describe ( ls_object[ll_i] + '.id' )
	If Long(ls_id) > 0 Then
   	ls_str = adw.Describe(ls_object[ll_i] + '.DDDW.Name')
      If (ls_str <> '!') And (ls_str <> '?') And (ls_str <> '') Then
         as_id[UpperBound(as_id[]) + 1] = ls_id
      End If
	End If
Next

Return 1
end function

public subroutine of_setsubbandy (long ai_subband_y);il_subband_y = ai_subband_y
//reset cache
il_cached_y1 = -1000000000
is_expr_y1 = "-"

il_cached_x1 = -1
is_expr_x1 = "-"

end subroutine

public function integer of_register (powerobject apo_requestor, n_xls_workbook anvo_writer, n_dwr_colors anvo_colors, long al_base_x, long al_base_y, long al_subband_y);il_base_x = al_base_x
il_base_y = al_base_y
il_subband_y = al_subband_y
ipo_requestor = apo_requestor
ipo_requestortype = ipo_requestor.TypeOf()
Choose Case ipo_requestortype 
	Case DataWindow!
		idw_requestor = ipo_requestor
	Case DataStore!
		ids_requestor = ipo_requestor
	Case DataWindowChild!
		idwc_requestor = ipo_requestor
	Case Else
		Return -1
End Choose   

invo_writer = anvo_writer
invo_colors = anvo_colors
return 1
end function

public function long of_process_nested (long al_row, long al_writer_row, n_dwr_grid anvo_hgrid, n_dwr_progress apo_progress);
// returns written rows count 

long ll_rown = 0, li_ret = 1
If ib_usetrc Then
	// some trick code for PB :-)
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 1
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	ll_rown = 0
	
End If

DataWindowChild ldwc_nested
If il_child_cache_row <> al_row Then
	SetNull(ids_child_cache)
	il_child_cache_row = -1 // prepare for failure	
	If inv_parm.ii_nested_extract_method = 1 Then
		inv_nested_data.of_Nested2DS(is_nested_instance_id, is_nested_dataobject, is_parent_band_id, al_row, is_nested_dddw_column_ids[], ids_child_cache)
	End If	
	If IsNull(ids_child_cache) Then
		inv_parm.ii_nested_extract_method = 0
		If al_row > 1 Then
			ids_reportdata.RowsMove(al_row, al_row,  Primary!, ids_reportdata, 1, Primary!)
		End IF
		li_ret = ids_reportdata.GetChild(is_dwo_name, ldwc_nested)
		If li_ret <> 1 Then
			Return 0
		End IF
		ids_child_cache = of_dwc2ds(ldwc_nested, True)
	Else
		ids_child_cache.GroupCalc()
	End If
	il_child_cache_row = al_row
End If


inv_nested_service_parm.il_writer_row = al_writer_row
inv_nested_service_parm.il_parent_row = al_row
inv_nested_service_parm.ipo_dynamic_requestor = ids_child_cache
inv_nested_service_parm.invo_dynamic_hgrid = anvo_hgrid

inv_nested_service_parm.ipo_progress = apo_progress
//inv_nested_service_parm.il_change_progress_each = al_change_progress_each
//inv_nested_service_parm.il_cur_change_progress = al_cur_change_progress

li_ret = inv_nestedservice.of_process_work()
If li_ret = 1 Then
	ll_rown = inv_nested_service_parm.il_writer_row - al_writer_row
	//al_cur_change_progress = inv_nested_service_parm.il_cur_change_progress
else
End IF
Return ll_rown

end function

on n_dwr_field.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_dwr_field.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


compile_file(X) :- main(cfg, X).
compile :- start(cfg).
start(X) :- main(X, "input1.txt").
main(X, Y) :- phrase_from_file(X, Y), accepted.
main(_, _) :- write("Ga ada yng cocok.."), error.
cfg --> s.
accepted :- nl,ansi_format([bold, fg(green)], "Accepted!", []), nl, !, abort.
error :- nl,ansi_format([bold, fg(red)], "Syntax Error!", []), nl, !, abort.
s --> statement.
eps --> [].
datatype --> number ; string ; dict ; list ; set ; tuple ; none.
none --> char_None.
element --> expr ; (expr , separator , any_element).
any_element --> eps ; (any_blanks , element , any_blanks).
dict_element_single --> expr , colon , expr.
dict_element --> dict_element_single ; (dict_element_single , separator , any_dict_element).
any_dict_element --> eps ; (any_blanks , dict_element , any_blanks).
set --> open_curly_bracket , any_element , close_curly_bracket.
list --> open_square_bracket , any_element , close_square_bracket.
tuple --> open_bracket , any_element , close_bracket.
dict --> open_curly_bracket , any_dict_element , close_curly_bracket.
number --> boolean ; non_complex_number ; complex_number ; scientific.
digit --> char_0 ; char_1 ; char_2 ; char_3 ; char_4 ; char_5 ; char_6 ; char_7 ; char_8 ; char_9.
int_rec --> digit , int.
int --> digit ; int_rec.
any_int --> eps ; int.
boolean --> char_True ; char_False.
float --> any_int , char_46 , int.
float --> int , char_46 , any_int.
non_complex_number --> float ; int.
any_op_num_plus_min --> eps ; op_num_plus_min.
power_symbol --> char_e ; char_E.
scientific --> non_complex_number , power_symbol , any_op_num_plus_min , int.
complex_infix --> any_blanks , op_num_plus_min , any_blanks.
non_complex_number_with_op --> non_complex_number , complex_infix.
any_non_complex_number_with_op --> eps ; non_complex_number_with_op.
complex_part --> non_complex_number , char_j.
complex_number --> any_non_complex_number_with_op , complex_part.
op_num_plus_min --> char_43 ; char_45.
op_num_single --> op_num_plus_min ; char_42 ; char_37 ; char_47.
op_num --> op_num_single ; char_4242 ; char_4747.
op_compare_single --> char_60 ; char_62.
op_compare --> op_compare_single ; char_6161 ; char_3361 ; char_6261 ; char_6061.
op_assignment_single --> char_61.
op_assignment --> op_assignment_single ; char_4361 ; char_4561 ; char_4261 ; char_4761 ; char_474761 ; char_3761 ; char_424261 ; char_606061 ; char_626261.
op_bitwise_single --> char_38 ; char_124 ; char_94 ; char_126.
op_bitwise --> op_bitwise_single ; char_6060 ; char_6262.
op_logical --> char_and ; char_or ; char_not.
op_membership --> char_in ; char_not96in.
op_identity --> char_is ; char_is96not.
op_infix --> op_num ; op_compare ; op_bitwise ; op_logical ; (blank , op_new , blank).
op_new --> op_membership ; op_identity.
op_prefix --> op_num_plus_min ; char_126.
op_single --> op_bitwise_single ; op_assignment_single ; op_compare_single ; op_num_single.
op --> op_num ; op_compare ; op_assignment ; op_bitwise ; op_logical ; op_membership ; op_identity.
lowercase --> char_a ; char_b ; char_c ; char_d ; char_e ; char_f ; char_g ; char_h ; char_i ; char_j ; char_k ; char_l ; char_m ; char_n ; char_o ; char_p ; char_q ; char_r ; char_s ; char_t ; char_u ; char_v ; char_w ; char_x ; char_y ; char_z.
uppercase --> char_A ; char_B ; char_C ; char_D ; char_E ; char_F ; char_G ; char_H ; char_I ; char_J ; char_K ; char_L ; char_M ; char_N ; char_O ; char_P ; char_Q ; char_R ; char_S ; char_T ; char_U ; char_V ; char_W ; char_X ; char_Y ; char_Z.
letter --> lowercase ; uppercase.
symbol_without_underscore_and_blank --> char_33 ; char_34 ; char_35 ; char_36 ; char_37 ; char_38 ; char_39 ; char_40 ; char_41 ; char_42 ; char_43 ; char_44 ; char_45 ; char_46 ; char_47 ; char_58 ; char_59 ; char_60 ; char_61 ; char_62 ; char_63 ; char_64 ; char_91 ; char_92 ; char_93 ; char_94 ; char_96 ; char_123 ; char_124 ; char_125 ; char_126.
symbol_without_underscore --> symbol_without_underscore_and_blank ; char_32.
symbol_without_single_quote --> char_32 ; char_33 ; char_34 ; char_35 ; char_36 ; char_37 ; char_38 ; char_40 ; char_41 ; char_42 ; char_43 ; char_44 ; char_45 ; char_46 ; char_47 ; char_58 ; char_59 ; char_60 ; char_61 ; char_62 ; char_63 ; char_64 ; char_91 ; char_92 ; char_93 ; char_94 ; char_95 ; char_96 ; char_123 ; char_124 ; char_125 ; char_126 ; escaped_single_quote ; underscore ; tab.
symbol_without_double_quote --> char_32 ; char_33 ; char_35 ; char_36 ; char_37 ; char_38 ; char_39 ; char_40 ; char_41 ; char_42 ; char_43 ; char_44 ; char_45 ; char_46 ; char_47 ; char_58 ; char_59 ; char_60 ; char_61 ; char_62 ; char_63 ; char_64 ; char_91 ; char_92 ; char_93 ; char_94 ; char_95 ; char_96 ; char_123 ; char_124 ; char_125 ; char_126 ; escaped_double_quote ; underscore ; tab.
enter --> char_10.
single_quote --> char_39.
double_quote --> char_34.
escaped_single_quote --> char_92 , single_quote.
escaped_double_quote --> char_92 , double_quote.
alphanumeric --> (letter , any_alphanumeric) ; (digit , any_alphanumeric).
any_alphanumeric --> eps ; alphanumeric.
alphanumeric_underscore --> alphanumeric_underscore_new , any_alphanumeric_underscore.
alphanumeric_underscore_new --> alphanumeric ; underscore.
any_alphanumeric_underscore --> eps ; alphanumeric_underscore.
symbol --> symbol_without_underscore ; underscore.
string_body_without_single_quote --> eps ; string_body_without_single_quote_01 ; string_body_without_single_quote_02 ; string_body_without_single_quote_03.
string_body_without_single_quote_01 --> letter , string_body_without_single_quote.
string_body_without_single_quote_02 --> digit , string_body_without_single_quote.
string_body_without_single_quote_03 --> symbol_without_single_quote , string_body_without_single_quote.
string_body_without_double_quote --> eps ; string_body_without_double_quote_01 ; string_body_without_double_quote_02 ; string_body_without_double_quote_03.
string_body_without_double_quote_01 --> letter , string_body_without_double_quote.
string_body_without_double_quote_02 --> digit , string_body_without_double_quote.
string_body_without_double_quote_03 --> symbol_without_double_quote , string_body_without_double_quote.
string_multi_body_without_double_quote --> symbol_without_double_quote ; digit ; letter ; enter.
string_body_multi_body_without_double_quote --> eps ; string_body_multi_body_without_double_quote_01 ; string_body_multi_body_without_double_quote_02 ; string_body_multi_body_without_double_quote_03.
string_body_multi_body_without_double_quote_01 --> string_multi_body_without_double_quote , string_body_multi_body_without_double_quote.
string_body_multi_body_without_double_quote_02 --> double_quote , string_multi_body_without_double_quote , string_body_multi_body_without_double_quote.
string_body_multi_body_without_double_quote_03 --> double_quote , double_quote , string_multi_body_without_double_quote , string_body_multi_body_without_double_quote.
string_multi_body_without_single_quote --> symbol_without_single_quote ; digit ; letter ; enter.
string_body_multi_body_without_single_quote --> eps ; string_body_multi_body_without_single_quote_01 ; string_body_multi_body_without_single_quote_02 ; string_body_multi_body_without_single_quote_03.
string_body_multi_body_without_single_quote_01 --> string_multi_body_without_single_quote , string_body_multi_body_without_single_quote.
string_body_multi_body_without_single_quote_02 --> single_quote , string_multi_body_without_single_quote , string_body_multi_body_without_single_quote.
string_body_multi_body_without_single_quote_03 --> single_quote , single_quote , string_multi_body_without_single_quote , string_body_multi_body_without_single_quote.
string --> string_01 ; string_02 ; string_03 ; string_04.
string_01 --> single_quote , string_body_without_single_quote , single_quote.
string_02 --> double_quote , string_body_without_double_quote , double_quote.
string_03 --> double_quote , double_quote , double_quote , string_body_multi_body_without_double_quote , double_quote , double_quote , double_quote.
string_04 --> single_quote , single_quote , single_quote , string_body_multi_body_without_single_quote , single_quote , single_quote , single_quote.
blank --> char_32.
tab --> char_tab.
tab_rec --> tab , blanks.
blank_rec --> blank , blanks.
blanks_tab --> tab ; tab_rec.
blanks_blank --> blank ; blank_rec.
blanks --> blanks_tab ; blanks_blank.
any_blanks --> eps ; blanks.
tab_only_rec --> tab , tabs.
tabs --> tab ; tab_only_rec.
any_tabs --> eps ; tabs.
underscore --> char_95.
underscores_rec --> underscore , underscores.
underscores --> underscore ; underscores_rec.
any_underscore --> eps ; underscores.
newline_only --> any_comment , enter.
newline --> any_blanks , newline_only , maybe_empty_line.
empty_line --> any_blanks , any_comment , newline.
maybe_empty_line --> any_tabs ; empty_line.
colon --> any_blanks , char_58 , any_blanks.
open_bracket --> char_40 , any_blanks.
close_bracket --> any_blanks , char_41.
open_square_bracket --> char_91 , any_blanks.
close_square_bracket --> any_blanks , char_93.
open_curly_bracket --> char_123 , any_blanks.
close_curly_bracket --> any_blanks , char_125.
comma --> char_44.
dot --> char_46.
separator --> any_blanks , comma , any_blanks.
keywords --> char_False ; char_class ; char_finally ; char_is ; char_return ; char_None ; char_continue ; char_for ; char_lambda ; char_try ; char_True ; char_def ; char_from ; char_nonlocal ; char_while ; char_and ; char_del ; char_global ; char_not ; char_with ; char_as ; char_elif ; char_if ; char_or ; char_yield ; char_assert ; char_else ; char_import ; char_pass ; char_break ; char_except ; char_in ; char_raise.
block --> colon , block_statement.
statement_rec --> statement_single , statement.
statement --> statement_single ; statement_rec.
indented_statement --> newline , statement.
inline_statement --> any_blanks , statement_elmt.
block_statement --> inline_statement ; indented_statement.
compound_stmt --> if ; while ; for ; with ; funcdef ; classdef.
simple_stmt --> import ; return ; pass ; break ; continue ; assign ; expr.
statement_elmt --> (simple_stmt , newline) ; compound_stmt.
statement_single --> empty_line ; statement_single_01.
statement_single_01 --> any_tabs , statement_elmt.
classdef --> char_class , blanks , variable_name , any_blanks , any_args , block.
if_only --> char_if , blanks , expr , block.
elif_only --> char_el , if_only.
else --> char_else , block.
maybe_else --> eps ; else.
elif --> elif_only , any_elif.
any_elif --> eps ; elif.
if --> if_only , any_elif , maybe_else.
pass --> char_pass.
while --> char_while , blanks , expr , block , maybe_else.
for --> char_for , blanks , variable , blanks , in.
in --> char_in , blanks , expr , block , maybe_else.
break --> char_break.
continue --> char_continue.
with_item --> expr , any_blanks , char_as , any_blanks , expr.
with_items --> with_item ; with_items_01.
with_items_01 --> with_item , separator , with_items.
with --> char_with , any_blanks , with_items , block.
args_element --> variable ; expr ; assign_without_op.
args_ins --> args_element ; args_ins_01.
args_ins_01 --> args_element , separator , args_ins.
any_args_ins --> eps ; args_ins.
args --> open_bracket , any_args_ins , close_bracket.
any_args --> eps ; args.
comment_elmt --> letter ; digit ; symbol ; tab.
comment_body --> comment_elmt ; comment_body_01.
comment_body_01 --> comment_elmt , comment_body.
any_comment_body --> eps ; comment_body.
comment --> char_35 , any_comment_body , eps.
any_comment --> eps ; comment.
expr_elmt --> variable ; function ; datatype.
expr_body --> expr_prefix , expr_body_02.
expr_body_01 --> expr_elmt , expr_op_infix , expr_body.
expr_body_02 --> expr_elmt ; expr_body_01.
prefix_multi --> op_prefix , any_blanks , expr_prefix.
expr_prefix --> eps ; prefix_multi.
expr_op_infix --> any_blanks , op_infix , any_blanks.
maybe_expr_after --> eps ; maybe_expr_after_01.
maybe_expr_after_01 --> expr_op_infix , expr_body.
maybe_expr_before --> eps ; maybe_expr_before_01.
maybe_expr_before_01 --> expr_body , expr_op_infix.
expr --> maybe_expr_before , expr_01 , expr_02 , expr_body , maybe_expr_after.
expr_01 --> eps ; (char_not , blank).
expr_02 --> prefix_multi ; any_blanks.
exprs_without_comma --> expr ; (expr , separator , exprs_without_comma).
exprs --> exprs_without_comma ; (exprs_without_comma , separator).
assign_with_op --> variable_names , any_blanks , op_assignment , any_blanks , exprs.
assign_without_op --> variable_names , any_blanks , op_assignment_single , any_blanks , assign_without_op_01.
assign_without_op_01 --> exprs ; assign_without_op.
assign --> assign_without_op ; assign_with_op.
function --> variable_name , any_blanks , args.
maybe_return_var --> eps ; (any_blanks , char_45 , char_62 , any_blanks , expr).
funcdef_elmt --> function , maybe_return_var.
funcdef_body --> blanks , funcdef_elmt.
funcdef --> char_def , funcdef_body , block.
return_body --> any_blanks , return_body_01.
return_body_01 --> eps ; expr.
return --> char_return , return_body.
from_expr_body --> any_blanks , expr.
from_expr --> char_from , from_expr_body.
maybe_from_expr --> eps ; from_expr.
raise_elmt --> expr , any_blanks , maybe_from_expr.
any_raise_elmt --> eps ; raise_elmt.
raise_body --> any_blanks , any_raise_elmt.
raise --> char_raise , raise_body.
import_only_body --> blanks , variables.
import_only --> char_import , import_only_body.
import_all_body --> blanks , char_42.
import_all --> char_import , import_all_body.
as --> char_as , import_only_body.
import_alias_body --> blanks , as.
import_alias --> import_only , import_alias_body.
import_with_from_elmt --> import_all ; import_without_from.
import_with_from_body --> blanks , import_with_from_elmt.
import_with_from_body_full --> import_only_body , import_with_from_body.
import_with_from --> char_from , import_with_from_body_full.
import_without_from --> import_alias ; import_only.
import --> import_without_from ; import_with_from.
parameter_element --> variable.
parameter_default --> assign_without_op.
parameter_only --> parameter_element ; (parameter_element , separator , parameter_only).
maybe_parameter_only --> eps ; parameter_only.
parameter_only_default --> parameter_default ; (parameter_default , separator , parameter_default).
parameter_args --> char_42 , variable.
parameter_kwargs --> char_4242 , variable.
param --> open_bracket , maybe_parameter_only , param_01 , param_02 , param_03 , close_bracket.
param_01 --> eps ; parameter_only_default ; (separator , parameter_only_default).
param_02 --> eps ; parameter_args ; (separator , parameter_args).
param_03 --> eps ; parameter_kwargs ; (separator , parameter_kwargs).
end_of_variable_char --> any_blanks , end_of_variable_char_01.
end_of_variable_char_01 --> op ; symbol_without_underscore_and_blank.
access_array_single --> open_square_bracket , expr , close_square_bracket.
access_array --> access_array_single ; access_array_01.
access_array_01 --> access_array_single , any_blanks , access_array.
any_access_array --> eps ; access_array.
hint --> colon , expr.
any_hint --> eps ; hint.
first_char_var --> underscore ; letter.
other_char_var --> letter ; digit ; underscore ; (letter , other_char_var) ; (digit , other_char_var) ; (underscore , other_char_var).
any_other_char_var --> eps ; other_char_var.
variable_name --> first_char_var , any_other_char_var.
variable_single --> variable_name.
variable_names_without_comma_rec --> variable_name , separator , variable_names_without_comma.
variable_names_without_comma --> variable_name ; variable_names_without_comma_rec.
variable_names --> variable_names_without_comma , maybe_comma.
maybe_comma --> eps ; separator.
variable_only_no_bracket --> variable_single ; (variable_single , dot , variable).
variable_only --> variable_only_no_bracket ; (open_bracket , variable_only_no_bracket , close_bracket).
variable_elmt --> variable_only.
variable_body_no_bracket --> expr_prefix , variable_body_no_bracket_01.
variable_body_no_bracket_01 --> variable_elmt ; (variable_elmt , expr_op_infix , variable_body).
variable_body --> variable_body_no_bracket ; (open_bracket , variable_body_no_bracket , close_bracket).
variable_prefix --> variable_prefix_01 , variable_prefix_02.
variable_prefix_01 --> eps ; (char_not , blank).
variable_prefix_02 --> prefix_multi ; any_blanks.
variable --> variable_prefix , variable_body , any_blanks , any_args , any_access_array.
variables_rec --> variable , separator , variables_without_comma.
variables_without_comma --> variable ; variables_rec.
variables --> variables_without_comma , maybe_comma.
char_False --> char_F , char_alse.
char_alse --> char_a , char_lse.
char_lse --> char_l , char_se.
char_se --> char_s , char_e.
char_class --> char_c , char_lass.
char_lass --> char_l , char_ass.
char_ass --> char_a , char_ss.
char_ss --> char_s , char_s.
char_finally --> char_f , char_inally.
char_inally --> char_i , char_nally.
char_nally --> char_n , char_ally.
char_ally --> char_a , char_lly.
char_lly --> char_l , char_ly.
char_ly --> char_l , char_y.
char_is --> char_i , char_s.
char_return --> char_r , char_eturn.
char_eturn --> char_e , char_turn.
char_turn --> char_t , char_urn.
char_urn --> char_u , char_rn.
char_rn --> char_r , char_n.
char_None --> char_N , char_one.
char_one --> char_o , char_ne.
char_ne --> char_n , char_e.
char_continue --> char_c , char_ontinue.
char_ontinue --> char_o , char_ntinue.
char_ntinue --> char_n , char_tinue.
char_tinue --> char_t , char_inue.
char_inue --> char_i , char_nue.
char_nue --> char_n , char_ue.
char_ue --> char_u , char_e.
char_for --> char_f , char_or.
char_or --> char_o , char_r.
char_lambda --> char_l , char_ambda.
char_ambda --> char_a , char_mbda.
char_mbda --> char_m , char_bda.
char_bda --> char_b , char_da.
char_da --> char_d , char_a.
char_try --> char_t , char_ry.
char_ry --> char_r , char_y.
char_True --> char_T , char_rue.
char_rue --> char_r , char_ue.
char_def --> char_d , char_ef.
char_ef --> char_e , char_f.
char_from --> char_f , char_rom.
char_rom --> char_r , char_om.
char_om --> char_o , char_m.
char_nonlocal --> char_n , char_onlocal.
char_onlocal --> char_o , char_nlocal.
char_nlocal --> char_n , char_local.
char_local --> char_l , char_ocal.
char_ocal --> char_o , char_cal.
char_cal --> char_c , char_al.
char_al --> char_a , char_l.
char_while --> char_w , char_hile.
char_hile --> char_h , char_ile.
char_ile --> char_i , char_le.
char_le --> char_l , char_e.
char_and --> char_a , char_nd.
char_nd --> char_n , char_d.
char_del --> char_d , char_el.
char_el --> char_e , char_l.
char_global --> char_g , char_lobal.
char_lobal --> char_l , char_obal.
char_obal --> char_o , char_bal.
char_bal --> char_b , char_al.
char_not --> char_n , char_ot.
char_ot --> char_o , char_t.
char_with --> char_w , char_ith.
char_ith --> char_i , char_th.
char_th --> char_t , char_h.
char_as --> char_a , char_s.
char_elif --> char_e , char_lif.
char_lif --> char_l , char_if.
char_if --> char_i , char_f.
char_yield --> char_y , char_ield.
char_ield --> char_i , char_eld.
char_eld --> char_e , char_ld.
char_ld --> char_l , char_d.
char_assert --> char_a , char_ssert.
char_ssert --> char_s , char_sert.
char_sert --> char_s , char_ert.
char_ert --> char_e , char_rt.
char_rt --> char_r , char_t.
char_else --> char_e , char_lse.
char_import --> char_i , char_mport.
char_mport --> char_m , char_port.
char_port --> char_p , char_ort.
char_ort --> char_o , char_rt.
char_pass --> char_p , char_ass.
char_break --> char_b , char_reak.
char_reak --> char_r , char_eak.
char_eak --> char_e , char_ak.
char_ak --> char_a , char_k.
char_except --> char_e , char_xcept.
char_xcept --> char_x , char_cept.
char_cept --> char_c , char_ept.
char_ept --> char_e , char_pt.
char_pt --> char_p , char_t.
char_in --> char_i , char_n.
char_raise --> char_r , char_aise.
char_aise --> char_a , char_ise.
char_ise --> char_i , char_se.
char_not96in --> char_n , char_ot96in.
char_ot96in --> char_o , char_t96in.
char_t96in --> char_t , char_96in.
char_96in --> char_96 , char_in.
char_is96not --> char_i , char_s96not.
char_s96not --> char_s , char_96not.
char_96not --> char_96 , char_not.
char_6060 --> char_60 , char_60.
char_4361 --> char_43 , char_61.
char_4561 --> char_45 , char_61.
char_4261 --> char_42 , char_61.
char_474761 --> char_47 , char_4761.
char_4761 --> char_47 , char_61.
char_3761 --> char_37 , char_61.
char_424261 --> char_42 , char_4261.
char_606061 --> char_60 , char_6061.
char_626261 --> char_62 , char_6261.
char_6161 --> char_61 , char_61.
char_3361 --> char_33 , char_61.
char_6261 --> char_62 , char_61.
char_6061 --> char_60 , char_61.
char_4242 --> char_42 , char_42.
char_4747 --> char_47 , char_47.
char_6262 --> char_62 , char_62.
char_32 --> " ".
char_33 --> "!".
char_34 --> "\"".
char_35 --> "#".
char_36 --> "$".
char_37 --> "%".
char_38 --> "&".
char_39 --> "\'".
char_40 --> "(".
char_41 --> ")".
char_42 --> "*".
char_43 --> "+".
char_44 --> ",".
char_45 --> "-".
char_46 --> ".".
char_47 --> "/".
char_0 --> "0".
char_1 --> "1".
char_2 --> "2".
char_3 --> "3".
char_4 --> "4".
char_5 --> "5".
char_6 --> "6".
char_7 --> "7".
char_8 --> "8".
char_9 --> "9".
char_10 --> "\n".
char_58 --> ":".
char_59 --> ";".
char_60 --> "<".
char_61 --> "=".
char_62 --> ">".
char_63 --> "?".
char_64 --> "@".
char_A --> "A".
char_B --> "B".
char_C --> "C".
char_D --> "D".
char_E --> "E".
char_F --> "F".
char_G --> "G".
char_H --> "H".
char_I --> "I".
char_J --> "J".
char_K --> "K".
char_L --> "L".
char_M --> "M".
char_N --> "N".
char_O --> "O".
char_P --> "P".
char_Q --> "Q".
char_R --> "R".
char_S --> "S".
char_T --> "T".
char_U --> "U".
char_V --> "V".
char_W --> "W".
char_X --> "X".
char_Y --> "Y".
char_Z --> "Z".
char_91 --> "[".
char_92 --> "\\".
char_93 --> "]".
char_94 --> "^".
char_95 --> "_".
char_96 --> "`".
char_a --> "a".
char_b --> "b".
char_c --> "c".
char_d --> "d".
char_e --> "e".
char_f --> "f".
char_g --> "g".
char_h --> "h".
char_i --> "i".
char_j --> "j".
char_k --> "k".
char_l --> "l".
char_m --> "m".
char_n --> "n".
char_o --> "o".
char_p --> "p".
char_q --> "q".
char_r --> "r".
char_s --> "s".
char_t --> "t".
char_u --> "u".
char_v --> "v".
char_w --> "w".
char_x --> "x".
char_y --> "y".
char_z --> "z".
char_123 --> "{".
char_124 --> ";".
char_125 --> "}".
char_126 --> "~".
char_tab --> "\t".

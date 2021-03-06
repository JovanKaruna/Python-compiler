/*
	Parameter order :
	1. Normal
	2. Default
	3. Args
	4. Keyword Arguments
*/

parameter_element -->
	variable.
parameter_default -->
	assign_without_op.
parameter_only -->
	parameter_element;(parameter_element,separator,parameter_only).
maybe_parameter_only -->
	eps;parameter_only.
parameter_only_default -->
	parameter_default;(parameter_default,separator,parameter_default).
parameter_args -->
	char_42,variable. 
parameter_kwargs -->
	char_4242,variable.

param -->
	open_bracket,
		maybe_parameter_only,
		(eps ; parameter_only_default ; (separator,parameter_only_default)),
		(eps ; parameter_args ; (separator, parameter_args)),
		(eps ; parameter_kwargs ; (separator, parameter_kwargs)),
	close_bracket.
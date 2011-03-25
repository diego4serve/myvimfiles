if exists("loaded_css_syntax_checker")
    finish
endif
let loaded_css_syntax_checker = 1

function! SyntaxCheckers_css_GetLocList()
	let makeprg = "validate_css\ $*\ %"
	let errorformat = '\%f:%t:%l:%m.'
	return SyntasticMake({'makeprg':makeprg, 'errorformat': errorformat})
endfunction

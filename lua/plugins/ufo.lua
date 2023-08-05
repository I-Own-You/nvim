local ftMap = {
  ocaml = ''
}
return {
  provider_selector = function(bufnr, filetype)
    return ftMap[filetype]
  end
}

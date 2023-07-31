local ftMap = {
  python = ''
}
return {
  provider_selector = function(bufnr, filetype)
    return ftMap[filetype]
  end
}

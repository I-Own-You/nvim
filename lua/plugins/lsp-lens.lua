return {
  enable = true,
  include_declaration = false,      -- Reference include declaration
  sections = {                      -- Enable / Disable specific request
    definition = true,
    references = true,
    implements = true,
  },
  ignore_filetype = {
    "prisma",
  },
}

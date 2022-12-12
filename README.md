# lvim
<!-- vim-markdown-toc Marked -->

* [title1](#title1)
* [title2](#title2)
    * [generate current all setting](#generate-current-all-setting)

<!-- vim-markdown-toc -->
  lunarvim config

# title1

# title2

---[[ lsp installed list ]]
---[[  black ]]
---[[  buf ]]
---[[  css-lsp ]]
---[[  dockerfile-language-server ]]
---[[  eslint_d ]]
---[[  fixjson ]]
---[[  flake8 ]]
---[[  gofumpt ]]
---[[  goimports ]]
---[[  golangci-lint ]]
---[[  golines ]]
---[[  gopls ]]
---[[  html-lsp ]]
---[[  isort ]]
---[[  json-lsp ]]
---[[  lua-language-server ]]
---[[  markdownlint ]]
---[[  prettier ]]
---[[  pyright ]]
---[[  shellcheck ]]
---[[  sql-formatter ]]
---[[  tailwindcss-language-server ]]
---[[  taplo ]]
---[[  typescript-language-server ]]
---[[  vim-language-server ]]
---[[  vue-language-server ]]
---[[  yaml-language-server ]]
---[[  yamlfmt ]]

## generate current all setting
lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}

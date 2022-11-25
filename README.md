# lvim
<!-- vim-markdown-toc Marked -->

* [title1](#title1)
* [title2](#title2)
    * [generate current all setting](#generate-current-all-setting)

<!-- vim-markdown-toc -->
  lunarvim config

# title1

# title2

LSP:
* markdownlint
* black
* buf
* eslint_d
* fixjson
* flake8
* goimports
* goimports-reviser
* golangci-lint
* golines
* gopls
* isort
* json-lsp
* lua-language-server
* prettier
* pyright
* shellcheck
* tailwindcss-language-server
* typescript-language-server
* vue-language-server
* yamlfmt


## generate current all setting
lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}

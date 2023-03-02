
<!-- vim-markdown-toc Marked -->

* [lvim settings](#lvim-settings)
* [init cmd](#init-cmd)
    * [generate current all setting](#generate-current-all-setting)
    * [show full filename](#show-full-filename)

<!-- vim-markdown-toc -->

# lvim settings

 **never put package.json and package-lock.json in dir HOME**

# init cmd
```shell
:Copilot auth
:CmpTabnineHub
```

## generate current all setting

```shell
lvim --headless +'lua require("lvim.utils").generate_settings()' +qa && sort -o lv-settings.lua{,}
```
## show full filename

edit "~/.local/share/lunarvim/lvim/lua/lvim/core/lualine/styles.lua"

options => style.lvim

```shell
lualine_c = {
  components.diff,
  components.python_env,
  { "filename", path = 2 },
}

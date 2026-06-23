**Automating blockquote leaders maintains writing flow by removing manual formatting tasks.**

The `r` flag in `formatoptions` continues the current comment leader (`>`) after a carriage return. Since Neovim identifies Markdown blockquotes as comment leaders, this enables seamless multi-line quoting.

```vim
:set fo+=r
```

---

#wiki #nvim #automation-typing #action
> [Practice in scratch.md; tag \#internalized once mastered.]

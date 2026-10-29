---
name: markitdown
description:
  Read web pages on the internet, or convert files (PDF, DOCX, PPTX, XLSX, HTML, EPUB)
  to Markdown. (Prefer web__run over this if available)
---

# MarkItDown

## Read websites

Pass a quoted URL to fetch and convert a webpage or downloadable file. Output goes to
stdout unless `-o` is specified:

```bash
markitdown 'https://example.com/article'
markitdown 'https://example.com/report.pdf' -o 'report.md'
```

This does not execute JavaScript or crawl sites. JavaScript-only or login-protected
pages may yield incomplete content.

## Convert files

```bash
markitdown 'input.docx' -o 'output.md'
```

For stdin, provide an extension hint with `-x`:

```bash
markitdown -x .pdf < 'input.pdf' > 'output.md'
```

Other supported formats use the same syntax; adjust the extension hint accordingly.

For all options, run `markitdown --help`.

If markitdown fails to read the contents of a web page, you may use the chrome-mcp skill
to open the web page in my browser and read it.

---
name: markitdown
description:
  Read web pages on the internet, or convert files (PDF, DOCX, PPTX, XLSX, HTML, EPUB)
  to Markdown.
---

# MarkItDown

Use `/home/aspizu/.local/bin/markitdown` explicitly; it may not be on `PATH`.

## Read websites

Pass a quoted URL to fetch and convert a webpage or downloadable file. Output goes to
stdout unless `-o` is specified:

```bash
/home/aspizu/.local/bin/markitdown 'https://example.com/article'
/home/aspizu/.local/bin/markitdown 'https://example.com/report.pdf' -o 'report.md'
```

This does not execute JavaScript or crawl sites. JavaScript-only or login-protected
pages may yield incomplete content.

## Convert files

```bash
/home/aspizu/.local/bin/markitdown 'input.docx' -o 'output.md'
```

For stdin, provide an extension hint with `-x`:

```bash
/home/aspizu/.local/bin/markitdown -x .pdf < 'input.pdf' > 'output.md'
```

Other supported formats use the same syntax; adjust the extension hint accordingly.

For all options, run `/home/aspizu/.local/bin/markitdown --help`.

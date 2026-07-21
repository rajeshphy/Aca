# Academic Records

This Jekyll site publishes files stored under:

```text
RECORDS/<section>/<subsection>/<file>
```

## Adding a record

1. Copy the file into the appropriate subsection under `RECORDS`.
2. Commit and push the new file normally.

There is no generated filename list to update. Jekyll reads `site.static_files`
during the build, and `index.md` uses it to create the section, subsection, and
file links automatically. Adding, renaming, or deleting a direct child file is
therefore reflected on the next site build.

Files below a deeper directory level are intentionally not listed.

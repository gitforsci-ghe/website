# Restructure website layout (issue #2)

## Context

Part of a session working through all open issues for the 15 July 2026
workshop rework. The user asked to run through all issues on the ghe
repos and implement everything today on feature branches into dev, with
dev-to-main PRs left open for verification.

## Prompt (paraphrased)

Restructure the website layout away from the RDM-template numbering:
rename `0-1-pre-work/` and `1-1-website/`, done first today before any
learner-facing URLs ship in the pre-work email.

## Outcome

- `0-1-pre-work/` renamed to `pre-work/` (step files keep their
  two-digit sequence, which is meaningful ordering).
- `1-1-website/` renamed to `workshop/`; deck renamed
  `1-1-website.qmd` to `slides.qmd`, PDF to `slides.pdf`.
- All references updated: `_quarto.yml` sidebar, `index.qmd` step
  links, `workshop/index.qmd` slide links and iframe, deck PDF link
  (also corrected the org from gitforsci-cis to gitforsci-ghe),
  schedule CSV page links.
- Full re-render of docs/.

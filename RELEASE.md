# Release checklist: per-iteration DOI for gitforsci-ghe

This repository is the frozen snapshot of the `gitforsci-ghe` (Summer 2026)
cohort. Releasing it to Zenodo mints a per-iteration DOI, so this exact run
of the course is independently citable, separate from the canonical course
DOI (which is minted from `gitforsci/website`).

Do this once the site is final and the cohort is complete.

- [x] Confirm the canonical `CITATION.cff` is synced down from `gitforsci/website` (it is, but re-copy if the canonical file has changed since).
- [x] Confirm a `LICENSE` is present (CC-BY-4.0 for content, MIT for code).
- [x] Sign in to Zenodo (<https://zenodo.org>) with the GitHub account.
- [x] Enable the Zenodo integration for this repository (`gitforsci-ghe/website`).
- [x] Create a GitHub release of this repository. Zenodo archives the release and mints a DOI.
- [x] Add the minted per-iteration DOI into this repository's `CITATION.cff` (fill `doi`, `version`, `date-released`), alongside a reference to the canonical course DOI once that exists.
- [x] Display the DOI badge on the site if desired.

Completed 2026-07-30 with release v0.1.0. Per-iteration concept DOI:
10.5281/zenodo.21704115. Canonical course concept DOI, referenced in
`CITATION.cff`: 10.5281/zenodo.21703566.

The canonical course DOI stays the same across iterations; this one points
at the frozen `gitforsci-ghe` snapshot. See the "Keep it open and citable"
chapter in the instructor handbook (`gitforsci/website`) for the full flow.

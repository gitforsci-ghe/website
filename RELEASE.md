# Release checklist: per-iteration DOI for gitforsci-ghe

This repository is the frozen snapshot of the `gitforsci-ghe` (Summer 2026)
cohort. Releasing it to Zenodo mints a per-iteration DOI, so this exact run
of the course is independently citable, separate from the canonical course
DOI (which is minted from `gitforsci/website`).

Do this once the site is final and the cohort is complete.

- [ ] Confirm the canonical `CITATION.cff` is synced down from `gitforsci/website` (it is, but re-copy if the canonical file has changed since).
- [ ] Confirm a `LICENSE` is present (CC-BY-4.0 for content, MIT for code).
- [ ] Sign in to Zenodo (<https://zenodo.org>) with the GitHub account.
- [ ] Enable the Zenodo integration for this repository (`gitforsci-ghe/website`).
- [ ] Create a GitHub release of this repository. Zenodo archives the release and mints a DOI.
- [ ] Add the minted per-iteration DOI into this repository's `CITATION.cff` (fill `doi`, `version`, `date-released`), alongside a reference to the canonical course DOI once that exists.
- [ ] Display the DOI badge on the site if desired.

The canonical course DOI stays the same across iterations; this one points
at the frozen `gitforsci-ghe` snapshot. See the "Keep it open and citable"
chapter in the instructor handbook (`gitforsci/website`) for the full flow.

# Pre-work: manuscript package installation (issue #22)

## Context

Same session: implement all rework issues today. This one ships before
the pre-work email so learners see it in time; it moves package
installation out of block B5 (premortem R1 mitigation).

## Prompt (paraphrased)

Add a package install step to the setup-test pre-work page with a
concrete one-line verification, covering what the man-washinvestments
manuscript needs.

## Outcome

- New Step 6 on pre-work/07-first-repo.qmd: install devtools, ggplot2,
  ggthemes, countrycode, dplyr, rmarkdown from CRAN plus
  openwashdata/washinvestments from GitHub (taken from the manuscript
  repo's setup chunk), with a single verification line that prints
  "All workshop packages installed".
- The final open-an-issue step (renumbered to 7) now asks learners to
  confirm the install in their comment, so the tracker can count it.
- Also corrected the leftover gitforsci-cis org references on the page
  to gitforsci-ghe, unified the setup repo name to 01-setup-USERNAME,
  and fixed a typo.

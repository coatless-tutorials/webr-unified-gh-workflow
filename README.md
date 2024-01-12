
# webr-github-action-wasm-binaries

<!-- badges: start -->

[![R-CMD-check](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/R-CMD-check.yaml)
[![webr-build-binary](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/deploy-cran-repo.yml/badge.svg)](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/deploy-cran-repo.yml)
<!-- badges: end -->

Example GitHub Action workflow to generate developmental webR/R WASM
Package binaries

# Overview

Interested in having your R package automatically be built for
[webR](https://docs.r-wasm.org/webr/latest/) through a [GitHub
Action](https://github.com/features/actions)? If so, this is the
repository for you! Here’s a summary of what you can find in the
repository:

- [`.github/workflows/deploy-cran-repo.yml`](.github/workflows/deploy-cran-repo.yml):
  Modified version of [`r-wasm/actions`’
  deploy-cran-repo.yml](https://github.com/r-wasm/actions/blob/d21bf7da50e539df543bbee973087ec585deaba6/examples/deploy-cran-repo.yml)
- [`DESCRIPTION`](DESCRIPTION): Standard description information for an
  R package
- [`R/in-webr.R`](R/in-webr.R): Check to see if we’re inside of webR or
  not.

You can view the pushed webR package binary parts by looking at the
[`gh-pages`](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/tree/gh-pages)
branch of the repository. Specifically, we can see binary package data
[`bin/emscripten/contrib/4.3`](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/tree/gh-pages/bin/emscripten/contrib/4.3)
and the package information in
[`src/contrib`](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/tree/gh-pages/src/contrib).
You can read more about package repositories that are CRAN-like in the
[R Administration: 6.6 Setting up a package
repository](https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Setting-up-a-package-repository).

## Setup

You can re-create the necessary parts to automatically compile R WASM
package binaries and make them available on GitHub Pages with:

``` r
if(!requireNamespace("usethis", quietly = TRUE)) {install.packages("usethis")}


# Ensure GitHub Pages is setup
usethis::use_github_pages()

# Obtain the modified version of the rwasm repo setup
usethis::use_github_action(
  "https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/blob/main/.github/workflows/deploy-cran-repo.yml"
)
```

Viola! Binaries will automatically be built on each new commit and
published on the repository’s website served by GitHub Pages.

## Accessing Binaries

Inside of a webR session, you can access the built binaries by using the
repository’s GitHub Pages URL, e.g.

    https://gh-username.github.io/repo-name

This can be set either using `options()` or specifying the location in
each `webr::install()` call.

The easiest is probably to define the location webR should search for in
`options()`.

``` r
# Run once at the start of the session
options(
  repos = c("https://gh-username.github.io/repo-name", 
            "https://repo.r-wasm.org/")
)

# Call
webr::install("pkgname")
```

Otherwise, you can specify it each time:

``` r
webr::install("pkgname", "https://gh-username.github.io/repo-name")
```

## Verify

Go to the [webR REPL Editor](https://webr.r-wasm.org/v0.2.2/) (pinned to
v0.2.2) and run the following:

``` r
# Check if package `{demorwasmbinary}` is installed
"demorwasmbinary" %in% installed.packages()[,"Package"]
# Install the binary from a repository
webr::install(
  "demorwasmbinary", 
  repos = "https://tutorials.thecoatlessprofessor.com/webr-github-action-wasm-binaries/"
)
# Check to see if the function works
demorwasmbinary::in_webr()
# View help documentation
?demorwasmbinary::in_webr
```

You should receive:

![Screenshot of the webR REPL editor showing how to download from
repository outside of repo.r-wasm.org an R package
binary](man/figures/demo-of-package-working-in-webr-repl.png)

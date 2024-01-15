
# Unified GH Action for webR/R WASM Package Binaries and {pkgdown} Deployment

<!-- badges: start -->

[![R-CMD-check](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/R-CMD-check.yaml)
[![webr-build-binary](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/deploy-cran-repo.yml/badge.svg)](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/actions/workflows/deploy-cran-repo.yml)
<!-- badges: end -->

Example GitHub Action workflow combining creation of developmental
webR/R WASM Package binaries and `{pkgdown}` websites.

This repository is part of a series of repositories exploring the topic.

- [Org-focused webR/WASM Package Repository without a `{pkgdown}`
  website
  (Preferred)](https://github.com/coatless-tutorials/webr-org-gh-action)
- **[Unified GitHub Action Deployment using artifacts of R WASM Package
  binaries and {pkgdown}
  website](https://github.com/coatless-tutorials/webr-unified-gh-workflow)
  \[This repository\]**
- [Separate GitHub Action Deployment onto `gh-pages` branch of R WASM
  Package binaries and {pkgdown}
  website](https://github.com/coatless-tutorials/webr-github-action-wasm-binaries)

# Overview

Interested in having your R package automatically be built for
[webR](https://docs.r-wasm.org/webr/latest/) through a [GitHub
Action](https://github.com/features/actions) alongside of a pkgdown
website? If so, this is the repository for you! Here’s a summary of what
you can find in the repository:

- [`.github/workflows/webr-pkgdown-build-and-deploy.yml`](.github/workflows/webr-pkgdown-build-and-deploy.yml):
  Modified version of [`r-wasm/actions`’
  deploy-cran-repo.yml](https://github.com/r-wasm/actions/blob/d21bf7da50e539df543bbee973087ec585deaba6/examples/deploy-cran-repo.yml)
- [`DESCRIPTION`](DESCRIPTION): Standard description information for an
  R package
- [`R/in-webr.R`](R/in-webr.R): Check to see if we’re inside of webR or
  not.

## Deployment

This approach moves away from tracking website deployments in a
`gh-pages` to generating artifacts with GitHub Actions and, then,
deploying them onto GitHub Pages. As a result, the size of the
repository should not grow large with the addition of a webR/R WASM
Package binary. Though, this means that changes associated with new
`{pkgdown}` deployments are no longer tracked in the `gh-pages` branch.

## Setup

You can re-create the necessary parts to automatically compile R WASM
package binaries and make them available on GitHub Pages with:

``` r
if(!requireNamespace("usethis", quietly = TRUE)) {install.packages("usethis")}


# Ensure GitHub Pages is setup
usethis::use_github_pages()

# Obtain the modified version of the rwasm repo setup
usethis::use_github_action(
  "https://github.com/coatless-tutorials/webr-unified-gh-workflow/blob/main/.github/workflows/webr-pkgdown-build-and-deploy.yml"
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

<div>

> **Important**
>
> Please make sure the repository’s [GitHub Pages website is available
> over
> `HTTPS`](https://docs.github.com/en/pages/getting-started-with-github-pages/securing-your-github-pages-site-with-https#enforcing-https-for-your-github-pages-site)
> not `HTTP` (notice the lack of an `s`). You can verify this option was
> selected by:
>
> 1.  Going to the repository’s **Settings** page
> 2.  Selecting **Pages** under **Code and automation**
> 3.  Checking the **Enforce HTTPS** button.
>
> Otherwise, you will receive the error message of:
>
>     Warning: unable to access index for repository http://gh-username.github.io/repo-name/bin/emscripten/contrib/4.3

</div>

## Verify

Go to the [webR REPL Editor](https://webr.r-wasm.org/v0.2.2/) (pinned to
v0.2.2) and run the following:

``` r
# Check if package `{demorwasmbinary}` is installed
"demorwasmbinary" %in% installed.packages()[,"Package"]
# Install the binary from a repository
webr::install(
  "demorwasmbinary", 
  repos = "https://tutorials.thecoatlessprofessor.com/webr-unified-gh-workflow/"
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

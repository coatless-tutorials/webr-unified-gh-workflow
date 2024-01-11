# webr-github-action-wasm-binaries

Example GitHub Actions workflow with an R package that generates developmental webR binaries

## Steps

1. Deployed

```r
usethis::use_github_action(
  url = "https://raw.githubusercontent.com/r-wasm/actions/v1/examples/deploy-cran-repo.yml"
)
```

2. Modify to include `packages: .` to trigger `pak` to treat the local environment as the package

3. Enable GH pages

```r
usethis::use_github_pages()
```

Avoids:

```
Error: Creating Pages deployment failed
Error: HttpError: Not Found
    at /home/runner/work/_actions/actions/deploy-pages/v2/node_modules/@octokit/request/dist-node/index.js:86:1
    at processTicksAndRejections (node:internal/process/task_queues:96:5)
    at createPagesDeployment (/home/runner/work/_actions/actions/deploy-pages/v2/src/internal/api-client.js:126:1)
    at Deployment.create (/home/runner/work/_actions/actions/deploy-pages/v2/src/internal/deployment.js:80:1)
    at main (/home/runner/work/_actions/actions/deploy-pages/v2/src/index.js:30:1)
Error: Error: Failed to create deployment (status: 404) with build version 0e5457c152727daecc085994d0dd749653c6ab17. Ensure GitHub Pages has been enabled: https://github.com/coatless-tutorials/webr-github-action-wasm-binaries/settings/pages
```
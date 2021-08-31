# Link Snitch: scan your site for broken links so you can fix them 🔗

A lightweight GitHub Action that runs [hydra-link-checker](https://github.com/victoriadrake/hydra-link-checker) on the URL you provide, which crawls your site and scans for broken links using multithreaded Python (standard library).

It's up to you to use Link Snitch responsibly!

## Contributing

This project simply Action-ifies (that's a word now, right?) the Hydra program. To submit issues or contributions to the link-checking functionality, go to [hydra-link-checker](https://github.com/victoriadrake/hydra-link-checker).

## Use this in your workflow

You can use this action in a workflow file to run Link Snitch on your choice of trigger, for instance, on a `push` event to the `master` branch:

```yml
  push:
    branches:
      - master
```

Or on a weekly schedule, say, 04:05 on Monday:

```yml
on:
  schedule:
    - cron: '5 4 * * 1'
```

Here's a full example of a workflow file. See below for `env` instructions.

```yml
name: Link Snitch

on:
  push:
    branches:
      - master

env:
  URL: https://example.com
  FILENAME: report.yaml
  CONFIG: config.json

jobs:
  build:

    runs-on: ubuntu-latest

    steps:
      - name: Check out master
        uses: actions/checkout@master
        with:
          fetch-depth: 1
      - name: Report broken links
        uses: victoriadrake/link-snitch@master
```

### Setting the `env` variables

This action requires a single environment variable, `URL`. Set this to the fully qualified address of your site, including schema (the `https://` part).

Optional variables include:

- `FILENAME`: See [view results](#view-results) below. Omit if you want results printed to `stdout` otherwise the action will appear to fail without errors.
- `CONFIG`: Your Hydra configuration fle. See [Configuration for Hydra](https://github.com/victoriadrake/hydra-link-checker#configuration).

### Workflow customization

See full instructions for [Configuring and managing workflows](https://help.github.com/en/actions/configuring-and-managing-workflows).

For help editing the YAML file, see [Workflow syntax for GitHub Actions](https://help.github.com/en/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions).

## View results

By default, the report is YAML formatted and output to `stdout` in your Action run. If you wish to save this to a file that you can download, set `FILENAME` to a file name of your choosing, then use `actions/upload-artifact` in your workflow. See [Uploading build and test artifacts](https://docs.github.com/en/actions/configuring-and-managing-workflows/persisting-workflow-data-using-artifacts#uploading-build-and-test-artifacts) for more.

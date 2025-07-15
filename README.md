# irulescan-action

[![Functional Tests](https://github.com/simonkowallik/irulescan-action/actions/workflows/functional_tests.yaml/badge.svg)](https://github.com/simonkowallik/irulescan-action/actions/workflows/functional_tests.yaml)

This action uses [irulescan](https://github.com/simonkowallik/irulescan) to scan iRules within your repository for security issues during execution of a GitHub Actions Workflow.

This action scans all iRules in the repository and returns the result of findings in JSON format. __The workflow step will not fail__ by default, hence the execution of the workflow job succeeds even when security issues are found. The goal is to provide the findings to let you choose what to do with them.

`irulescan-action` will scan files with `.tcl`, `.irul`, and `.irule` extensions by default. You can customize the file extensions using the `file_extensions` input parameter.

## Usage

In the simplest form the below workflow scans iRules in the whole repository. Please take a look at the provided examples for more details.

```yaml
jobs:
  irulescan-action:
    runs-on: ubuntu-latest
    name: "Workflow"
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Run irulescan-action
        uses: simonkowallik/irulescan-action@v3
```

Some behavior can be modified, see *inputs* below.

### `inputs`

All inputs are *optional*.

- **`scandir`**: Use `scandir` to scan a custom subdirectory within the repository.

- **`expected_results_file`**: Specify a relative path (based on the GITHUB_WORKSPACE / your repo) to a JSON file with expected results. If the actual result of irulescan does not match the expected result, a diff will be returned and __the job step will fail__.

- **`file_extensions`**: Comma-separated list of file extensions to scan (default: `.tcl,.irul,.irule`). This allows you to customize which file types are scanned for iRules.

- **`cmd`**: Specify a custom command to execute within the container.

### `outputs`

- **`result`**: `result` will be populated with the output results. It can be accessed using `${{ steps.<iruescan-action-step-id>.outputs.result }}`.

## Examples

The [`example/`](example/) folder contains example iRules and a [JSON file](examples/expected_results.json) with expected results.

[`.github/workflows`](.github/workflows) contains several example workflows, click on the icons below to inspect the workflow:
  
  [![Demo: Successful](https://img.shields.io/github/actions/workflow/status/simonkowallik/irulescan-action/example_success.yaml?style=for-the-badge&label=Demo%3A%20Successful)](.github/workflows/example_success.yaml)
  
  [![Demo: Failing workflow step](https://img.shields.io/github/actions/workflow/status/simonkowallik/irulescan-action/example_failure.yaml?style=for-the-badge&label=Demo%3A%20Failing%20workflow%20step)](.github/workflows/example_failure.yaml)
  
  [![Demo: Custom CMD](https://img.shields.io/github/actions/workflow/status/simonkowallik/irulescan-action/example_custom_cmd.yaml?style=for-the-badge&label=Demo%3A%20Custom%20CMD)](.github/workflows/example_custom_cmd.yaml)
  
  [![Demo: Custom File Extensions](https://img.shields.io/github/actions/workflow/status/simonkowallik/irulescan-action/example_custom_extensions.yaml?style=for-the-badge&label=Demo%3A%20Custom%20File%20Extensions)](.github/workflows/example_custom_extensions.yaml)
  
  [![Demo: Advanced Usage](https://img.shields.io/github/actions/workflow/status/simonkowallik/irulescan-action/example_advanced.yaml?style=for-the-badge&label=Demo%3A%20Advanced%20Usage)](.github/workflows/example_advanced.yaml)

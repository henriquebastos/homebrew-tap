# Homebrew Tap — Agent Guide

Homebrew formulae for henriquebastos projects.

## How Homebrew Python Formulae Work

Homebrew installs Python packages in isolated virtualenvs. The key constraint:
**Homebrew uses `pip install` with `--no-binary :all:` by default**, which means
every dependency must build from source. This breaks packages with Rust/C build
backends (hatchling needs maturin, uv_build needs maturin).

### What doesn't work

```ruby
# DON'T — virtualenv_install_with_resources fails without resource blocks
include Language::Python::Virtualenv
def install
  virtualenv_install_with_resources
end

# DON'T — resource blocks with sdists that use hatchling/uv_build backends
resource "argcomplete" do
  url "https://files.pythonhosted.org/.../argcomplete-3.6.3.tar.gz"
  sha256 "..."
end
```

### What works (our pattern)

Create a venv and pip install from PyPI. This uses wheels when available,
bypassing the source build problem:

```ruby
class MyFormula < Formula
  desc "Description"
  homepage "https://github.com/henriquebastos/my-package"
  url "https://github.com/henriquebastos/my-package/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "abc123..."  # REQUIRED — use: curl -sL <url> | shasum -a 256
  license "MIT"

  depends_on "python@3.14"

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "my-package==#{version}"
    bin.install_symlink Dir[libexec/"bin/my-command"]
  end

  test do
    assert_match "usage", shell_output("#{bin}/my-command --help")
  end
end
```

Key points:
- `url` points to the GitHub release tarball (for Homebrew's download/cache)
- `sha256` is **required** — `:no_check` doesn't work
- `pip install` from PyPI gets wheels automatically
- `bin.install_symlink` links the venv binary to Homebrew's bin
- The PyPI package name may differ from the formula name (e.g. `magic-beans` vs `beans`)

### Getting the sha256

```bash
# For GitHub release tarball:
curl -sL https://github.com/USER/REPO/archive/refs/tags/vX.Y.Z.tar.gz | shasum -a 256
```

## Auto-Update via Release Workflows

Each project's release workflow updates the formula automatically using
`mislav/bump-homebrew-formula-action`. This requires:

1. A `HOMEBREW_TAP_TOKEN` secret in the project repo
2. The token needs **Contents: Read and write** permission on this repo (fine-grained PAT)
3. The release workflow has a `homebrew` job that runs after `publish`

When the auto-updater runs, it only updates `url` and `sha256`. If the formula
install logic changes, update it manually here.

## Python Version Constraints

- `jira-genie` — pure Python, works on 3.11+. Formula uses `python@3.14`.
- `beans` — depends on pydantic-core (compiled). Pin to `python@3.13` until
  pydantic-core wheels are stable on 3.14.

Check compatibility before bumping Python versions.

## Testing

The CI workflow (`.github/workflows/test.yml`) runs `brew install` + `brew test`
for each formula on macOS. Uses `fail-fast: false` so one formula's failure
doesn't cancel the others.

## Common Issues

### "No checksum was provided"
The formula is missing `sha256`. Get it with `curl -sL <url> | shasum -a 256`.

### "Failed to build 'hatchling' / 'uv_build'"
The formula is using `virtualenv_install_with_resources` with source tarballs.
Switch to the pip install pattern above.

### "Failed changing dylib ID"
A compiled dependency (e.g. pydantic-core) has issues on the target Python version.
Pin to a lower Python version until wheels are fixed.

### "The operation was canceled"
Another formula in the matrix failed and `fail-fast` was true. Set `fail-fast: false`.

# lysosome-dev/homebrew-tap

```bash
brew install lysosome-dev/tap/lysosome
```

Installs the [lysosome CLI](https://github.com/lysosome-dev/cli) with its man pages and bash/zsh/fish completions.

## The desktop app (beta)

```bash
brew install --cask lysosome-dev/tap/lysosome-app
```

Installs the lysosome app for Mac and the CLI with it. [`Casks/lysosome-app.rb`](Casks/lysosome-app.rb) is hand-written. It downloads from `lysosome.dev/download/mac` (Apple silicon) or `/download/mac-intel`, which always serve the latest release. The app updates itself (and `brew upgrade --greedy` picks up new builds), so the cask tracks `:latest` and never needs a per-release change. Until a build is published those URLs lead to the waitlist, and the install fails cleanly.

## How the formula is updated

`Formula/lysosome.rb` is generated, not hand-edited. [`update-formula.yml`](.github/workflows/update-formula.yml) runs every 30 minutes (and on demand), reads the checksums from the latest [lysosome-dev/cli release](https://github.com/lysosome-dev/cli/releases/latest), installs and `brew test`s the new formula, and commits it with this repo's own `GITHUB_TOKEN`. No token for this repo lives in the CLI repo.

Publish a release right away instead of waiting for the schedule:

```bash
gh workflow run -R lysosome-dev/homebrew-tap update-formula.yml            # latest release
gh workflow run -R lysosome-dev/homebrew-tap update-formula.yml -f tag=v0.2.0
```

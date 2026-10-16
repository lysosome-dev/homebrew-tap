# lysosome-dev/homebrew-tap

```bash
brew install lysosome-dev/tap/lysosome
```

Installs the [lysosome CLI](https://github.com/lysosome-dev/cli) with its man pages and bash/zsh/fish completions.

## The desktop app (beta)

```bash
brew install --cask lysosome-dev/tap/lysosome-app
```

Installs the free beta of the lysosome app for Mac (Apple silicon or Intel, macOS 11+) and the CLI with it. `brew uninstall --zap --cask lysosome-app` also removes its settings and caches.

The app updates itself, so the cask sets `auto_updates true`: a plain `brew upgrade` leaves it alone, while `brew upgrade --greedy` moves it to the newest build.

## How the formula and cask are updated

`Formula/lysosome.rb` is generated, not hand-edited. [`update-formula.yml`](.github/workflows/update-formula.yml) runs every 30 minutes (and on demand), reads the checksums from the latest [lysosome-dev/cli release](https://github.com/lysosome-dev/cli/releases/latest), installs and `brew test`s the new formula, and commits it with this repo's own `GITHUB_TOKEN`. No token for this repo lives in the CLI repo.

`Casks/lysosome-app.rb` is generated too. [`update-cask.yml`](.github/workflows/update-cask.yml) checks every 30 minutes for a newer build on [lysosome.dev](https://lysosome.dev/app/downloads.json). When one is out, it downloads and hashes both DMGs ([`render-cask.sh`](.github/scripts/render-cask.sh)), runs `brew style`, `brew audit` and `brew install --cask` on macOS, and commits the bump. `brew livecheck --cask lysosome-dev/tap/lysosome-app` checks the same manifest.

Publish right away instead of waiting for the schedule:

```bash
gh workflow run -R lysosome-dev/homebrew-tap update-formula.yml            # latest CLI release
gh workflow run -R lysosome-dev/homebrew-tap update-formula.yml -f tag=v0.2.0
gh workflow run -R lysosome-dev/homebrew-tap update-cask.yml               # promoted app build
gh workflow run -R lysosome-dev/homebrew-tap update-cask.yml -f version=0.2.0
```

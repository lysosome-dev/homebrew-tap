# The lysosome desktop app. Hand-written (unlike Formula/lysosome.rb).
# The URLs always redirect to the latest promoted build, and the app updates
# itself (brew upgrade --greedy picks up new builds), so the cask tracks :latest
# and needs no change per release.
cask "lysosome-app" do
  arch arm: "mac", intel: "mac-intel"

  version :latest
  sha256 :no_check

  url "https://lysosome.dev/download/#{arch}"
  name "lysosome"
  desc "Find and safely reclaim disk space left behind by dev tools and coding agents"
  homepage "https://lysosome.dev/"

  depends_on formula: "lysosome-dev/tap/lysosome"
  depends_on :macos

  app "lysosome.app"

  zap trash: [
    "~/Library/Application Support/dev.lysosome.app",
    "~/Library/Caches/dev.lysosome.app",
    "~/Library/Preferences/dev.lysosome.app.plist",
    "~/Library/Saved Application State/dev.lysosome.app.savedState",
    "~/Library/WebKit/dev.lysosome.app",
  ]
end

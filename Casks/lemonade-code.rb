cask "lemonade-code" do
  arch arm: "arm64", intel: "x64"

  version "0.0.7"
  sha256 arm:   "a8f22259d32aacb54c218c81ba4ee639d7b485655d6d6cca75d773aa0ed6e3d2",
         intel: "6d5df9e1a9ab26c7709250f9a6a715e76181c09fbbfa19532d26b9783e1dfc91"

  url "https://github.com/williankl/l-code/releases/download/v#{version}/Lemonade-Code-#{version}-macos-#{arch}.dmg"
  name "Lemonade Code"
  desc "Terminal IDE for reviewing work"
  homepage "https://github.com/williankl/l-code"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on :macos

  app "Lemonade Code.app"

  # Not notarized, so Gatekeeper would block the quarantined app. Cleared in staging, because
  # macOS can stop an install step from changing the app once it is installed.
  preflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{staged_path}}/Lemonade Code.app"],
        must_succeed: false
  end

  zap trash: "~/Library/Application Support/Lemonade Code"

  caveats <<~EOS
    Lemonade Code isn't notarized by Apple. This cask removes macOS's quarantine flag from the
    app so it opens without a Gatekeeper prompt.
  EOS
end

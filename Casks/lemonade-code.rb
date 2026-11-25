cask "lemonade-code" do
  arch arm: "arm64", intel: "x64"

  version "0.0.6"
  sha256 arm:   "e037b71290654526e03b49533435d5c6fffc5578e70af1f94deb0ab6fa9ef904",
         intel: "8a86bec8c5ec6052e62d7bdf911ce3441c4bb2635dd818e140859a1373094e49"

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

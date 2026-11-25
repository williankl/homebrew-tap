cask "lemonade-code" do
  arch arm: "arm64", intel: "x64"

  version "0.0.5"
  sha256 arm:   "c5ae77fd0753428d5175902ce02b8b4fb5d961d8e424011d70cbe1c694bbed16",
         intel: "d39ce11fbf599849cd0fc0817cd242243c7d88dbf3061e82c8360a7a1942f510"

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

  # Not notarized, so Gatekeeper would block the quarantined app.
  postflight_steps do
    run "/usr/bin/xattr",
        args:         ["-dr", "com.apple.quarantine", "{{appdir}}/Lemonade Code.app"],
        must_succeed: false
  end

  zap trash: "~/Library/Application Support/Lemonade Code"

  caveats <<~EOS
    Lemonade Code isn't notarized by Apple. This cask removes macOS's quarantine flag from the
    app so it opens without a Gatekeeper prompt.
  EOS
end

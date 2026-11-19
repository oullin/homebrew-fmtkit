class Fmtkit < Formula
  desc "Formats and checks Go, TypeScript, JavaScript, Vue, HTML, and Markdown repositories."
  homepage "https://github.com/oullin/fmtkit"
  version "2.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.7.0/fmtkit-aarch64-apple-darwin.tar.xz"
      sha256 "f409a662a0b83d010e1a6d7f954888116a3b5361b4c982c0da1d4f8198bb9469"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.7.0/fmtkit-x86_64-apple-darwin.tar.xz"
      sha256 "f858918d2d894597e16f65547dac0cdf45c611b356cf506497d2a1611d13d5db"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.7.0/fmtkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2625955e1b9b0e4b9990a17d3bf9526d05b6df86d66f97e5772da8549ddb0ec9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.7.0/fmtkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ee6e8878411beead882c5b1e0218c097aeb28e4e82262d2dc48e4e6671c3d500"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "fmtkit"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "fmtkit"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "fmtkit"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "fmtkit"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

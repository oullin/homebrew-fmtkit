class Fmtkit < Formula
  desc "Formats and checks Go, TypeScript, JavaScript, Vue, HTML, and Markdown repositories."
  homepage "https://github.com/oullin/fmtkit"
  version "2.1.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.1.1/fmtkit-aarch64-apple-darwin.tar.xz"
      sha256 "736bc507084b762d89251fc119e7e6ebd47c2da7ef5d31365739d6e6734145b0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.1.1/fmtkit-x86_64-apple-darwin.tar.xz"
      sha256 "03b5400a82a98cf83de4ded68c79ba06f4d9cff06746e7f81e62c1b5b5588cf3"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.1.1/fmtkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1b73cb86bbd9fed6b63ec6c87c81634d3391d10599201aa260e880f488d1f15d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.1.1/fmtkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7616506ee25320550e4c465efd2d7a476efed8546f8e4d846da0fabe87dd9ae9"
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

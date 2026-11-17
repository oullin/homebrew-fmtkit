class Fmtkit < Formula
  desc "Formats and checks Go, TypeScript, JavaScript, Vue, HTML, and Markdown repositories."
  homepage "https://github.com/oullin/fmtkit"
  version "2.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.5.0/fmtkit-aarch64-apple-darwin.tar.xz"
      sha256 "2e0714a321840fde10a1e872a1365fffe8a4c35a3529bbefaa4c23c9b6a2883d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.5.0/fmtkit-x86_64-apple-darwin.tar.xz"
      sha256 "6a2f2b31e4d7031ed9530ab871980e7f001672c90c8e87f5784f131f2254a4a6"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.5.0/fmtkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "afb232acb2b675965d24366e64e53bd83949bb517cf18354c6865622d3bbf672"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.5.0/fmtkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3d317eed92e8d8d6b3680953306fb5d87caa80e702a6dbba7b6650721134c4ff"
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

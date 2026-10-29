class Fmtkit < Formula
  desc "Formats and checks Go, TypeScript, JavaScript, Vue, HTML, and Markdown repositories."
  homepage "https://github.com/oullin/fmtkit"
  version "2.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.2.0/fmtkit-aarch64-apple-darwin.tar.xz"
      sha256 "dff8b9e2eeddc630293d4c40a65fa6ede76ea68dc1727f1cdba7d42b0976aa14"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.2.0/fmtkit-x86_64-apple-darwin.tar.xz"
      sha256 "be2a3d431bacfd9192bb8b78588448f290f44bb1660ca994afcb1d3c11f3fa7c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.2.0/fmtkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0cdb7fc0f1797b1afec2fad2edfbec4897a55677e7504d1a7ebcd1e016e19369"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.2.0/fmtkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8566fd803606c6cb5d3bccfa37693fe0715ba5d916273b205d3cac94e5c1ea13"
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

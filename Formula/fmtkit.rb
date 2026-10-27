class Fmtkit < Formula
  desc "Formats and checks Go, TypeScript, JavaScript, Vue, HTML, and Markdown repositories."
  homepage "https://github.com/oullin/fmtkit"
  version "2.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.0.0/fmtkit-aarch64-apple-darwin.tar.xz"
      sha256 "9c140cb65e11c838ae1d3b5d18442cd16ce0cf0fca42e6847b459ead76e93637"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.0.0/fmtkit-x86_64-apple-darwin.tar.xz"
      sha256 "f57725c6aeef384fe4fdbfcf8652b08092256ce082f930d5af4fe6b0ef176626"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/oullin/fmtkit/releases/download/v2.0.0/fmtkit-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "adff419c743cc3803a8e6bf0a0b4d147e6d890312a4ed268554c4b542d297e5b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/oullin/fmtkit/releases/download/v2.0.0/fmtkit-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "857a962545770005e6cf23e649cc2bb02faddc30c9ee899daec26d065a272576"
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

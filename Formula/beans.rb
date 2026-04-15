class Beans < Formula
  desc "Graph-based issue tracker for AI agent coordination"
  homepage "https://github.com/henriquebastos/beans"
  url "https://github.com/henriquebastos/beans/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "070a754252bc6dc6191bf3cc0a64e4adbb49f9fcbad2f29fc6d8472afcbe92b0"
  license "MIT"

  depends_on "python@3.13"
  depends_on "rust" => :build

  def install
    python3 = Formula["python@3.13"].opt_bin/"python3.13"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "--no-binary", "pydantic-core", "magic-beans==#{version}"
    bin.install_symlink Dir[libexec/"bin/beans"]
  end

  test do
    assert_match "Usage", shell_output("#{bin}/beans --help")
  end
end

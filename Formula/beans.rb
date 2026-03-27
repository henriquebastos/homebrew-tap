class Beans < Formula
  desc "Graph-based issue tracker for AI agent coordination"
  homepage "https://github.com/henriquebastos/beans"
  url "https://github.com/henriquebastos/beans/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "b96908da6fb2047d85ff767f06196e77cb5cbea0b010db5c56ea1abdfc5d6898"
  license "MIT"

  depends_on "python@3.14"

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "magic-beans==#{version}"
    bin.install_symlink Dir[libexec/"bin/beans"]
  end

  test do
    assert_match "Usage", shell_output("#{bin}/beans --help")
  end
end

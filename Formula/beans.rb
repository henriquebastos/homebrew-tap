class Beans < Formula
  desc "Graph-based issue tracker for AI agent coordination"
  homepage "https://github.com/henriquebastos/beans"
  url "https://github.com/henriquebastos/beans/archive/refs/tags/v0.5.1.tar.gz"
  sha256 "da02af3c834f56f002e1295d7bab65f1eaf8f38135cb3a1dc356e6944aaec0d0"
  license "MIT"

  depends_on "python@3.14"
  depends_on "rust" => :build

  def install
    python3 = Formula["python@3.14"].opt_bin/"python3.14"
    system python3, "-m", "venv", libexec
    system libexec/"bin/pip", "install", "--no-cache-dir", "--no-binary", "pydantic-core", "magic-beans==#{version}"
    bin.install_symlink Dir[libexec/"bin/beans"]
  end

  test do
    assert_match "Usage", shell_output("#{bin}/beans --help")
  end
end

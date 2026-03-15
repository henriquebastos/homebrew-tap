class Beans < Formula
  include Language::Python::Virtualenv

  desc "Graph-based issue tracker for AI agent coordination"
  homepage "https://github.com/henriquebastos/beans"
  url "https://files.pythonhosted.org/packages/71/28/e4f2311acdc97606e440c91bd567e0c2ba075c9b0803aee2171ca31d8a3c/magic_beans-0.1.0.tar.gz"
  sha256 "36b3874ca7c72c49eb7f7fc7a223d6df81dbf186998a65a8372b5e5a707f5c4e"
  license "MIT"

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage", shell_output("#{bin}/beans --help")
  end
end

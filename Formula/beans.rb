class Beans < Formula
  include Language::Python::Virtualenv

  desc "Graph-based issue tracker for AI agent coordination"
  homepage "https://github.com/henriquebastos/beans"
  url "https://github.com/henriquebastos/beans/archive/refs/tags/v0.4.1.tar.gz"
  license "MIT"

  depends_on "python@3.14"

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Usage", shell_output("#{bin}/beans --help")
  end
end

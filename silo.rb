# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class Silo < Formula
  desc ""
  homepage ""
  url "https://wci.llnl.gov/content/assets/docs/simulation/computer-codes/silo/silo-4.10.2/silo-4.10.2.tar.gz"
  version "4.10.2"
  sha256 "3af87e5f0608a69849c00eb7c73b11f8422fa36903dd14610584506e7f68e638"

  # depends_on "cmake" => :build
  depends_on "hdf5"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./configure", "--enable-optimization",
                          "--disable-fortran",
                          "--with-zlib",
                          "--enable-install-lite-headers",
                          "--enable-shared",
                          "--enable-browser=no",
                          "--enable-silex=no",
                          "--with-hdf5=#{Formula["hdf5"].opt_prefix}"
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test silo`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end

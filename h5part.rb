# Documentation: https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/homebrew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class H5part < Formula
  desc "H5Part: a Portable High Performance Parallel Data Interface to HDF5"
  homepage "http://vis.lbl.gov/Research/H5Part/"
  url "https://codeforge.lbl.gov/frs/download.php/file/387/H5Part-1.6.6.tar.gz"
  version "1.6.6"
  sha256 "10347e7535d1afbb08d51be5feb0ae008f73caf889df08e3f7dde717a99c7571"

  # depends_on "cmake" => :build
  depends_on "hdf5"

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel

    # Remove unrecognized options if warned by configure
    system "./configure", "--with-hdf5=#{Formula["hdf5"].opt_prefix}",
                          "--enable-shared",
                          "--prefix=#{prefix}"
    # system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test H5Part`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

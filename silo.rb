class Silo < Formula
  desc "LLNL mesh and field Silo I/O library. Allows creating databases for VisIt."
  homepage "https://wci.llnl.gov/simulation/computer-codes/silo"
  url "https://wci.llnl.gov/sites/wci/files/2021-01/silo-4.10.2-bsd.tgz"
  sha256 "4b901dfc1eb4656e83419a6fde15a2f6c6a31df84edfad7f1dc296e01b20140e"
  revision 4

  option "with-static", "Build as static instead of dynamic library"
  option "without-lite-headers", "Do not install PDB lite headers"

  depends_on "gcc" # for gfortran
  depends_on "readline"
  depends_on "hdf5" => :recommended

  def install
    args = ["--prefix=#{prefix}"]
    args << "--enable-optimization"
    args << "--with-zlib"
    #args << "--enable-install-lite-headers" if build.with? "lite-headers"
    #args << "--enable-shared" if build.without? "static"
    args << "--with-hdf5=#{Formula["hdf5"].opt_prefix}" if build.with? "hdf5"

    ENV.append "CFLAGS", "-DH5_USE_110_API_DEFAULT"
    ENV.append "LDFLAGS", "-L#{Formula["readline"].opt_lib} -lreadline"
    system "./configure", *args
    system "make", "install"
    if build.with? "hdf5"
      rm lib/"libsiloh5.settings"
    else
      rm lib/"libsilo.settings"
    end
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
        #include <silo.h>

        int main(void)
        {
            DBfile *silodb;
            silodb = DBCreate("test.silo", DB_CLOBBER, DB_LOCAL, NULL, DB_PDB);
            if (!silodb)
                return 1;

            DBClose(silodb);
            return 0;
        }
        EOS
    test_args = ["test.c", "-I#{opt_include}", "-L#{opt_lib}", "-o", "test"]
    if build.with? "hdf5"
      test_args << "-lsiloh5"
      test_args << "-L#{Formula["hdf5"].opt_lib}"
      test_args << "-lhdf5"
    else
      test_args << "-lsilo"
    end
    test_args << "-lm"
    system ENV.cc, *test_args
    system "./test"
  end
end

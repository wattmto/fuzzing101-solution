{ pkgs
, stdenv
, fetchzip
}:

stdenv.mkDerivation rec {
  pname = "exercise-1-xpdf";
  version = "3.02";

  src = fetchzip {
    url = "https://dl.xpdfreader.com/old/xpdf-${version}.tar.gz";
    hash = "sha256-+CO+dS+WloYr2bDv8H4VWrtx9irszqVPk2orDVfk09s=";
  };

  makeFlags = [
    "CC=${pkgs.aflplusplus}/bin/afl-clang-fast"
    "CXX=${pkgs.aflplusplus}/bin/afl-clang-fast++"
  ];

  nativeBuildInputs = with pkgs; [ aflplusplus ];

  buildInputs = with pkgs; [
    zlib
    libpng
  ];
}

{ pkgs
, lib
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "exercise-2-libexif";
  version = "0.6.14";

  src = fetchFromGitHub {
    owner = pname;
    repo = pname;
    rev = "${pname}-${builtins.replaceStrings ["."] ["_"] version}-release";
    sha256 = "sha256-Eqgnm31s8iPJdhTpk5HM89HSZTXTK+e7YZ/CCdbeJX4=";
  };

  preConfigure = ''
    export LLVM_CONFIG="llvm-config-11"
  '';

  configureFlags = [
    "--enable-lto"
    "--disable-shared"
    "--disable-inline-asm"
  ];

  makeFlags = [
    "CC=${pkgs.aflplusplus}/bin/afl-clang-lto"
    "CXX=${pkgs.aflplusplus}/bin/afl-clang-lto++"
    "RANLIB=llvm-ranlib"
    "AR=llvm-ar"
    "AS=llvm-as"
    "LD=afl-ld-lto"
  ];

  nativeBuildInputs = with pkgs; [
    aflplusplus
    autoreconfHook
    gettext
  ];
}

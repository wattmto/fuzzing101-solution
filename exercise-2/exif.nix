{ lib
, pkgs
, stdenv
, fetchFromGitHub
}:

stdenv.mkDerivation rec {
  pname = "exercise-2-exif";
  version = "0.6.15";

  src = fetchFromGitHub {
    owner = "libexif";
    repo = pname;
    rev = "${pname}-${builtins.replaceStrings ["."] ["_"] version}-release";
    sha256 = "1xlb1gdwxm3rmw7vlrynhvjp9dkwmvw23mxisdbdmma7ah2nda3i";
  };

  preConfigure = ''
    export LLVM_CONFIG="llvm-config-11"
  '';

  makeFlags = [
    "CC=${pkgs.aflplusplus}/bin/afl-clang-lto"
    "CXX=${pkgs.aflplusplus}/bin/afl-clang-lto++"
    "RANLIB=llvm-ranlib"
    "AR=llvm-ar"
    "AS=llvm-as"
  ];

  nativeBuildInputs = with pkgs; [
    aflplusplus
    autoreconfHook
    pkg-config
  ];
  buildInputs = with pkgs; [ (callPackage ./libexif.nix { }) popt libintl ];
}

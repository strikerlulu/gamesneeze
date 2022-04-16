let pkgs = import <nixpkgs> { };
in with pkgs;
pkgs.mkShell {
  nativeBuildInputs = [ cmake pkg-config ];

 # shellHook = ''
 #    export CMAKE_C_COMPILER=${pkgs.gcc}/bin/gcc
 #    export CMAKE_CXX_COMPILER=${pkgs.gcc}/bin/g++
 #  '';

  buildInputs = [
    SDL2
  ];

}

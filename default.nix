with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "game-mode";#not to collide with original gamemode
  pname = "gamesneeze";
  # src = ./.;
  src = pkgs.fetchFromGitHub {
    repo = "gamesneeze";
    owner = "strikerlulu";
    rev = "4f2e281bb95998a2516ad99e89ffb868be202111";
    sha256 = "sha256-X4FPMS5afTu24zvVgOaADYxJbTPH4li1Rf7XYRwNBI0=";
  };
  nativeBuildInputs = with pkgs; [ cmake gcc ];
  buildInputs = with pkgs; [ SDL2 ];
  patches = [ ./gamesneeze.patch ];
  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 ../toolbox.sh $out/bin/
    sed -i "s#REPLACE_WITH_LIBPATH#$out/lib#g" $out/bin/toolbox.sh
    mkdir $out/lib
    libname=$(sed -n 's/libname="\(.*\)".*/\1/p' $src/toolbox.sh)
    cp libgamesneeze.so $out/lib/$libname
  '';

  meta = {
    description =
      "An open source training utility for Counter-Strike: Global Offensive on Linux";
    homepage = "https://github.com/strikerlulu/gamesneeze";
    license = lib.licenses.mit;
    # maintainers = [ lib.maintainers.strikerlulu ];
    platforms = lib.platforms.linux;
  };
}

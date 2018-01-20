{pkgs ? import /etc/nixos/nixpkgs-master {} }:

with pkgs;
{
  it = stdenv.mkDerivation {
    name = "binarin-hass";
    buildInputs = [
      (python36.withPackages (ps: with ps; [
        keyring
        virtualenv
      ]))
    ];
    shellHook = ''
      export SOURCE_DATE_EPOCH=315532800 # fix ZIP warnings from python (per https://github.com/NixOS/nixpkgs/issues/20716)
      [ -d ./.homeassistant-venv ] || virtualenv --system-site-packages ./.homeassistant-venv
      source ./.homeassistant-venv/bin/activate
    '';
  };
}

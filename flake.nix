{
  description = "JumpCloud Password Manager";

  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      jumpcloud-pw = with pkgs;
        appimageTools.wrapType2 {
          name = "jumpcloud-pw";
          src = fetchurl {
            url =
              "https://cdn.pwm.jumpcloud.com/DA/release/JumpCloud-Password-Manager-latest.AppImage";
            hash = "sha256-/N94SH3PamM65537iIWn7XhjcZI2luFVLCqmKtpRG8Y=";
          };
          extraPkgs = pkgs: with pkgs; [ libsecret ];

          meta = with lib; {
            description = "JumpCloud Password Manager";
            homepage = "https://jumpcloud.com/platform/password-manager";
            license = licenses.unfree;
            maintainers = [{
              name = "Charles Ellis";
              email = "hamled@hamled.dev";
              github = "Hamled";
              githubId = 66355;
            }];
            platforms = [ "x86_64-linux" ];
          };
        };
    in {
      packages.${system}.default = jumpcloud-pw;
      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.default}/bin/jumpcloud-pw";
      };
      overlays.default = (prev: final: { inherit jumpcloud-pw; });

      devShells.${system}.default =
        pkgs.mkShell { inputsFor = [ self.packages.${system}.default ]; };
    };
}

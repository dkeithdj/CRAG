{
  description = "Python environment using micromamba";

  inputs = {
    utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      utils,
      ...
    }:
    utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        python-env = pkgs.buildFHSEnv {
          name = "python-env";
          targetPkgs =
            _: with pkgs; [
              micromamba
              just
            ];
          profile = ''
            export MAMBA_ROOT_PREFIX=./.mamba

            eval "$(micromamba shell hook --shell=posix)"

            if [ ! -d $MAMBA_ROOT_PREFIX ]; then
              micromamba create -f env.yml
            fi
            micromamba activate python-env
          '';
        };
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            python-env
          ];

        };
      }
    );
}

{ pkgs, ... }: {

  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python311
  ];

  # Sets environment variables in the workspace
  env = {
    QRCODER_GCS_BUCKET = "qrcode-test";
    PORT = "80";
  };

  # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
  idx.extensions = [
      "ms-python.python"
      "vscodevim.vim"
  ];

  idx.workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onStart = {
        install =
          "python -m venv .venv  && source .venv/bin/activate  &&  pip install -r requirements.txt";
      };
      # To run something each time the environment is rebuilt, use the `onStart` hook
  };

  # Enable previews and customize configuration
  idx.previews = {
    enable = true;
    previews = [
      {
        command = [ "./devserver.sh" ];
        env = { PORT = "$PORT"; };
        manager = "web";
        id = "web";
      }
    ];
  };
}

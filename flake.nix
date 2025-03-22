{
  description = "Python 2.7 environment with Django and other packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
            permittedInsecurePackages = [
              "python-2.7.18.8"
              "python-2.7.18.8-env"
            ];
          };
        };

        pythonOverrides = self: super: {
        };

        python27WithPackages = pkgs.python27.override { packageOverrides = pythonOverrides; };

        myPython27Env = python27WithPackages.withPackages (ps: with ps; [
          # boto
          # argparse
          # bpython
          # certifi
          # django-braces
          # django-filter
          # django-model-utils
          # django-timedeltafield
          # djangorestframework
          # docutils
          # easy-thumbnails
          # ecdsa
          # logutils
          # paramiko
          # psycopg2
          # pycrypto
          # python-memcached
          # python-dateutil
          # requests
          # six
          # xlrd
          # sqlparse
          # xlwt
          # django-tenancy
          # django-hosts
          # django-compressor
          # django-safedelete
          # wkhtmltopdf
          # django-storages
          # django-appconf
          # jinja2
          # markdown
          # markupsafe
          # pillow
          # pygments
          # south
          # xlsxwriter
        ]);

      in {
        devShells.default = pkgs.mkShell {
          buildInputs = [
            myPython27Env
            pkgs.aircrack-ng
            pkgs.wirelesstools
            pkgs.tshark
            pkgs.reaverwps-t6x
            pkgs.bully
            pkgs.wireshark-cli
            pkgs.cowpatty
            pkgs.hashcat
            pkgs.hcxtools
            pkgs.hcxdumptool
            pkgs.which
            pkgs.pixiewps
            pkgs.john
            pkgs.iw
            pkgs.macchanger
            # pkgs.git
          ];

          shellHook = ''
            echo "Python 2.7 development environment activated!"
            echo "Python version: $(python --version)"
            echo "Installed packages:"
            pip list

            export PYTHONPATH="${myPython27Env}/${myPython27Env.sitePackages}:$PYTHONPATH"
          '';
        };
      }
    );
}
{
  allowUnfree = true;
  packageOverrides = super: let self = super.pkgs; in
  {
    haskellPackages = super.haskellPackages.override {
      overrides = self: super:
        let call = p: args: self.callPackage (
                            ../workspace/haskell + "/${p}/project.nix") args;
        in
        rec {
          error-list = call "error-list" { inherit text-render; };
          text-render = call "text-render" {};
          simple-nix = call "simple-nix" { inherit error-list text-render; };
          nixfromnpm = call "nixfromnpm" {
            inherit error-list text-render hnix;
          };
          hnix = call "hnix" {};
          context-stack = call "context-stack" {};
          fedallah = call "fedallah" {
            inherit context-stack easyjson oneormore rowling error-list;
          };
          easyjson = call "easyjson" {};
          oneormore = call "oneormore" {};
          rowling = call "rowling" {inherit error-list text-render;};
      };
    };
  };
}

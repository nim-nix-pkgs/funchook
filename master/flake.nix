{
  description = ''funchook wrapper'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-funchook-master.flake = false;
  inputs.src-funchook-master.owner = "ba0f3";
  inputs.src-funchook-master.ref   = "master";
  inputs.src-funchook-master.repo  = "funchook.nim";
  inputs.src-funchook-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-funchook-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-funchook-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}
{ pkgs, lib, ... }:

{
  home.packages = [
    pkgs.solaar
  ];

  home.file.".config/solaar".text = lib.mkForce ''
    %YAML 1.3
    ---
    - Test: [thumb_wheel_down, 15]
    - KeyPress:
      - [Control_L, Shift_L, Tab]
      - click
    ...
    ---
    - Test: [thumb_wheel_up, 15]
    - KeyPress:
      - [Control_L, Tab]
      - click
    ...
  '';
}

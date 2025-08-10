{ pkgs, lib, ... }:

{
  environment.systemPackages = [
    pkgs.solaar
  ];

  system.activationScripts.createSolaarConfig.text = ''
    mkdir -p /home/marc/.config/solaar
    echo "%YAML 1.3
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
    ..." > /home/marc/.config/solaar/rules.yml
  '';
}

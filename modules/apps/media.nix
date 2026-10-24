{
  flake.modules.nixos.media =
    { lib, pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        swayimg # image viewer
        mpv # video and audio player
      ];

      # Open images in swayimg and video/audio in mpv
      xdg.mime.defaultApplications =
        lib.genAttrs [
          "image/png"
          "image/jpeg"
          "image/gif"
          "image/webp"
          "image/avif"
          "image/heic"
          "image/bmp"
          "image/tiff"
          "image/svg+xml"
        ] (_: "swayimg.desktop")
        // lib.genAttrs [
          "video/mp4"
          "video/x-matroska"
          "video/webm"
          "video/quicktime"
          "video/x-msvideo"
          "video/mpeg"
          "audio/mpeg"
          "audio/flac"
          "audio/ogg"
          "audio/wav"
          "audio/mp4"
          "audio/opus"
        ] (_: "mpv.desktop");
    };
}

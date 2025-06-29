{ ... }: {
  programs.mpv.scriptOpts = {
    uosc = {
      timeline_size = 25;
      timeline_persistency = "paused,audio";
      top_bar = "never";
      refine = "text_width";
    };
    thumbfast = {
      spawn_first = true;
      network = true;
      hwdec = false;
    };
  };
}

{
...  
}: {
  
  programs.foot.enable = true;
  programs.foot.settings =  {
  main = {
    title="Terminal";
    pad = "15x0";
    font = "JetBrainsMono Nerd Font Mono:size=14";
    
  };
    url = {
      launch = "xdg-open $\{url\}";
      osc8-underline="url-mode";
      protocols="http, https, ftp, ftps, file, gemini, gopher";
      uri-characters=''abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-_.,~:;/?#@!$&%*+="'()[]'';
    };
    colors = {
      background="0D1117";
      foreground="f8f8f2";

      regular0="21222c";
      regular1="ff5555";
      regular2="50fa7b";
      regular3="f1fa8c";
      regular4="bd93f9";
      regular5="ff79c6";
      regular6="8be9fd";
      regular7="f8f8f2";


      bright0="6272a4";
      bright1="ff6e6e";
      bright2="69ff94";
      bright3="ffffa5";
      bright4="d6acff";
      bright5="ff92df";
      bright6="a4ffff";
      bright7="ffffff"   ; 
    };
  };
}

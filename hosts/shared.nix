{eriniteLib, ...}: let
  inherit (eriniteLib.themeSpecialisations) mkWallpapers;
in {
  theme = {
    default = "kurogame-olive";
    wallpapers = mkWallpapers {
      "kurogame-olive.png" = {
        url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/6y9pm8iicrjyhd354y-17739965643372.png";
        hash = "sha256-wdC7ZU7KChFkyQW0B5twnpq4i1nFIovfyNEklSY973I=";
      };
      "kurogame-blue-dark.png" = {
        url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/ogvbi74cjtbp460lif-17739965468193.png";
        hash = "sha256-Hl/vRLR2V0F3JRrYl0JYjxWN9KVWkFpzaWFojOXHmJQ=";
      };
      "kurogame-grey-blue.png" = {
        url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/p4w55y5r9nube7xy4d-177399637338912.png";
        hash = "sha256-ZuGDUi+W9DOFNdBw8XWFD53YVvXrA7Ybo/ndyjDugBI=";
      };
    };
  };
}

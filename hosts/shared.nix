{pkgs, ...}: {
  theme = {
    default = "kurogame-olive";
    wallpapers = {
      kurogame-olive = {
        image = pkgs.fetchurl {
          name = "kurogame-olive.png";
          url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/6y9pm8iicrjyhd354y-17739965643372.png";
          hash = "sha256-wdC7ZU7KChFkyQW0B5twnpq4i1nFIovfyNEklSY973I=";
        };
      };
      kurogame-blue-dark = {
        image = pkgs.fetchurl {
          name = "kurogame-blue.png";
          url = "https://media-cdn-zspms.kurogame.com/pnswebsite/website2.0/images/1773936000000/ogvbi74cjtbp460lif-17739965468193.png";
          hash = "sha256-Hl/vRLR2V0F3JRrYl0JYjxWN9KVWkFpzaWFojOXHmJQ=";
        };
      };
    };
  };
}

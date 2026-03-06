{ ... }: {
  plugins.snacks.settings.dashboard = {
	  sections = [
	    { section = "header"; }
	    { icon = ""; title = ""; section = "keys"; indent = 2; padding = 1; }
    ];
	  preset = {
	    keys = [
	  	  { icon = "󰈞 "; key = "f"; desc = "Find files"; action = ":lua Snacks.picker.smart()"; }
	  	  { icon = " "; key = "h"; desc = "Find history"; action = "lua Snacks.picker.recent()"; }
	  	  { icon = " "; key = "e"; desc = "New file"; action = ":enew"; }
	  	  { icon = " "; key = "o"; desc = "Recent files"; action = ":lua Snacks.picker.recent()"; }
	  	  { icon = " "; key = "q"; desc = "Quit"; action = ":qa"; }
      ];
	    header = ''
         ██████████            ███                      
         ▒▒███▒▒▒▒▒█           ▒▒▒                       
          ▒███  █ ▒  ████████  ████  ████████    ██████  
          ▒██████   ▒▒███▒▒███▒▒███ ▒▒███▒▒███  ▒▒▒▒▒███ 
          ▒███▒▒█    ▒███ ▒▒▒  ▒███  ▒███ ▒███   ███████ 
          ▒███ ▒   █ ▒███      ▒███  ▒███ ▒███  ███▒▒███ 
          ██████████ █████     █████ ████ █████▒▒████████
         ▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒     ▒▒▒▒▒ ▒▒▒▒ ▒▒▒▒▒  ▒▒▒▒▒▒▒▒ 
        '';
	  };
  };
}

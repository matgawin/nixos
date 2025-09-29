{
  services.glance = {
    enable = true;
    settings = {
      server = {
        port = 30198;
      };
      theme = {
        background-color = "229 19 23";
        contrast-multiplier = 1.2;
        primary-color = "222 74 74";
        positive-color = "96 44 68";
        negative-color = "359 68 71";
      };
      pages = [
        {
          name = "Home";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "calendar";
                  "first-day-of-week" = "monday";
                }
                {
                  "type" = "rss";
                  "limit" = 10;
                  "collapse-after" = 3;
                  "cache" = "12h";
                  "feeds" = [
                    {
                      "url" = "https://selfh.st/rss/";
                      "title" = "selfh.st";
                      "limit" = 4;
                    }
                    {
                      "url" = "https://ciechanow.ski/atom.xml";
                    }
                    {
                      "url" = "https://www.joshwcomeau.com/rss.xml";
                      "title" = "Josh Comeau";
                    }
                    {
                      "url" = "https://samwho.dev/rss.xml";
                    }
                    {
                      "url" = "https://ishadeed.com/feed.xml";
                      "title" = "Ahmad Shadeed";
                    }
                  ];
                }
                {
                  type = "twitch-channels";
                  channels = [
                    "theprimeagen"
                    "j_blow"
                    "piratesoftware"
                    "cohhcarnage"
                    "christitustech"
                    "EJ_SA"
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "group";
                  widgets = [
                    {
                      "type" = "hacker-news";
                    }
                    {
                      "type" = "lobsters";
                    }
                  ];
                }
                {
                  type = "videos";
                  channels = [
                    "UCXuqSBlHAE6Xw-yeJA0Tunw"
                    "UCR-DXc1voovS8nhAvccRZhg"
                    "UCsBjURrPoezykLs9EqgamOA"
                    "UCBJycsmduvYEL83R_U4JriQ"
                    "UCHnyfMqiRRG1u-2MsSQLbXA"
                  ];
                }
                {
                  type = "group";
                  widgets = [
                    {
                      "type" = "reddit";
                      "subreddit" = "technology";
                      "show-thumbnails" = true;
                    }
                    {
                      "type" = "reddit";
                      "subreddit" = "selfhosted";
                      "show-thumbnails" = true;
                    }
                  ];
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  "type" = "weather";
                  "location" = "Gdańsk, Poland";
                  "units" = "metric";
                  "hour-format" = "24h";
                }
                {
                  "type" = "markets";
                  "markets" = [
                    {
                      "symbol" = "SPY";
                      "name" = "S&P 500";
                    }
                    {
                      "symbol" = "BTC-USD";
                      "name" = "Bitcoin";
                    }
                    {
                      "symbol" = "NVDA";
                      "name" = "NVIDIA";
                    }
                    {
                      "symbol" = "AAPL";
                      "name" = "Apple";
                    }
                    {
                      "symbol" = "MSFT";
                      "name" = "Microsoft";
                    }
                  ];
                }
                {
                  "type" = "releases";
                  "cache" = "1d";
                  "repositories" = [
                    "glanceapp/glance"
                    "go-gitea/gitea"
                    "immich-app/immich"
                    "syncthing/syncthing"
                  ];
                }
              ];
            }
          ];
        }
      ];
    };
  };
}

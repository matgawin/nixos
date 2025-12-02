{...}: {
  programs.noctalia-shell = {
    enable = true;
    settings = {
      settingsVersion = 58;

      appLauncher = {
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        density = "compact";
        enableClipPreview = false;
        enableClipboardChips = true;
        enableClipboardHistory = false;
        enableSessionSearch = true;
        enableSettingsSearch = true;
        enableWindowsSearch = true;
        iconMode = "tabler";
        ignoreMouseInput = false;
        overviewLayer = true;
        pinnedApps = [];
        position = "center";
        showCategories = false;
        showIconBackground = false;
        sortByMostUsed = true;
        terminalCommand = "NO_TMUX=1 alacritty --class QuickShell";
        viewMode = "list";
      };

      audio = {
        mprisBlacklist = [];
        preferredPlayer = "spotify";
        spectrumFrameRate = 30;
        visualizerType = "linear";
        volumeFeedback = false;
        volumeFeedbackSoundFile = "";
        volumeOverdrive = true;
        volumeStep = 5;
      };

      bar = {
        autoHideDelay = 500;
        autoShowDelay = 150;
        backgroundOpacity = 1;
        barType = "simple";
        capsuleColorKey = "none";
        capsuleOpacity = 1;
        contentPadding = 2;
        density = "compact";
        displayMode = "always_visible";
        enableExclusionZoneInset = true;
        floating = false;
        fontScale = 1;
        frameRadius = 12;
        frameThickness = 8;
        hideOnOverview = false;
        marginHorizontal = 5;
        marginVertical = 5;
        middleClickAction = "none";
        middleClickCommand = "";
        middleClickFollowMouse = false;
        monitors = [];
        mouseWheelAction = "none";
        mouseWheelWrap = true;
        outerCorners = true;
        position = "top";
        reverseScroll = false;
        rightClickAction = "controlCenter";
        rightClickCommand = "";
        rightClickFollowMouse = true;
        screenOverrides = [];
        showCapsule = true;
        showOutline = false;
        useSeparateOpacity = false;
        widgetSpacing = 6;
        widgets = {
          center = [
            {
              clockColor = "none";
              customFont = "";
              formatHorizontal = "HH:mm yyyy-MM-dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
            }
          ];
          left = [
            {
              characterCount = 2;
              colorizeIcons = false;
              emptyColor = "secondary";
              enableScrollWheel = true;
              focusedColor = "primary";
              followFocusedScreen = false;
              fontWeight = "bold";
              groupedBorderOpacity = 1;
              hideUnoccupied = true;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              occupiedColor = "secondary";
              pillSize = 0.6;
              showApplications = true;
              showApplicationsHover = false;
              showBadge = true;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
            {
              colorizeIcons = false;
              hideMode = "hidden";
              id = "ActiveWindow";
              maxWidth = 145;
              scrollingMode = "hover";
              showIcon = true;
              textColor = "none";
              useFixedWidth = false;
            }
          ];
          right = [
            {
              compactMode = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 145;
              panelShowAlbumArt = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = false;
              showProgressRing = true;
              showVisualizer = true;
              textColor = "none";
              useFixedWidth = false;
              visualizerType = "linear";
            }
            {
              blacklist = [];
              chevronColor = "none";
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [
                "Telegram Desktop"
                "Bluetooth Enabled"
                "Easy Effects"
                "spotify-client"
                "proton-vpn-app"
              ];
            }
            {
              displayMode = "onhover";
              iconColor = "none";
              id = "Bluetooth";
              textColor = "none";
            }
            {
              hideWhenZero = true;
              hideWhenZeroUnread = false;
              iconColor = "none";
              id = "NotificationHistory";
              showUnreadBadge = true;
              unreadBadgeColor = "primary";
            }
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "settings";
              id = "ControlCenter";
              useDistroLogo = false;
            }
            {
              displayMode = "alwaysShow";
              iconColor = "none";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
              textColor = "none";
            }
            {
              compactMode = true;
              diskPath = "/";
              iconColor = "none";
              id = "SystemMonitor";
              showCpuCores = false;
              showCpuFreq = false;
              showCpuTemp = false;
              showCpuUsage = true;
              showDiskAvailable = false;
              showDiskUsage = false;
              showDiskUsageAsPercent = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showMemoryAsPercent = true;
              showMemoryUsage = true;
              showNetworkStats = true;
              showSwapUsage = false;
              textColor = "none";
              useMonospaceFont = true;
              usePadding = false;
            }
          ];
        };
      };

      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };

      colorSchemes = {
        darkMode = true;
        generationMethod = "tonal-spot";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        monitorForColors = "";
        predefinedScheme = "Tokyo Night";
        schedulingMode = "off";
        useWallpaperColors = false;
      };

      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = true;
            id = "shortcuts-card";
          }
          {
            enabled = true;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "weather-card";
          }
          {
            enabled = false;
            id = "media-sysmon-card";
          }
        ];
        diskPath = "/";
        position = "close_to_bar_button";
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "WallpaperSelector";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }
          ];
        };
      };

      dock = {
        enabled = false;
      };

      general = {
        allowPanelsOnScreenWithoutBar = true;
        allowPasswordWithFprintd = false;
        animationDisabled = false;
        animationSpeed = 2;
        autoStartAuth = false;
        avatarImage = "/home/matt/.face";
        boxRadiusRatio = 1;
        clockFormat = "hh\\nmm";
        clockStyle = "custom";
        compactLockScreen = true;
        dimmerOpacity = 0;
        enableBlurBehind = true;
        enableLockScreenCountdown = true;
        enableLockScreenMediaControls = false;
        enableShadows = true;
        forceBlackScreenCorners = false;
        iRadiusRatio = 1;
        language = "en";
        lockOnSuspend = true;
        lockScreenAnimations = false;
        lockScreenBlur = 0;
        lockScreenCountdownDuration = 10000;
        lockScreenMonitors = [];
        lockScreenTint = 0;
        passwordChars = false;
        radiusRatio = 1;
        reverseScroll = false;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "bottom_right";
        shadowOffsetX = 2;
        shadowOffsetY = 3;
        showChangelogOnStartup = true;
        showHibernateOnLockScreen = false;
        showScreenCorners = false;
        showSessionButtonsOnLockScreen = true;
        telemetryEnabled = false;
        keybinds = {
          keyUp = [
            "Up"
            "Ctrl+P"
          ];
          keyDown = [
            "Down"
            "Ctrl+N"
          ];
          keyLeft = [
            "Left"
          ];
          keyRight = [
            "Right"
          ];
          keyEnter = [
            "Return"
            "Enter"
          ];
          keyEscape = [
            "Esc"
          ];
          keyRemove = [
            "Del"
          ];
        };
      };

      hooks = {
        enabled = false;
      };

      idle = {
        enabled = false;
      };

      location = {
        analogClockInCalendar = false;
        firstDayOfWeek = 1;
        hideWeatherCityName = false;
        hideWeatherTimezone = false;
        name = "Gdańsk, Poland";
        showCalendarEvents = true;
        showCalendarWeather = true;
        showWeekNumberInCalendar = true;
        use12hourFormat = false;
        useFahrenheit = false;
        weatherEnabled = true;
        weatherShowEffects = true;
      };

      network = {
        wifiEnabled = false;
      };

      nightLight = {
        autoSchedule = false;
        dayTemp = "2800";
        enabled = true;
        forced = true;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "2300";
      };

      noctaliaPerformance = {
        disableDesktopWidgets = true;
        disableWallpaper = true;
      };

      notifications = {
        backgroundOpacity = 1;
        clearDismissed = true;
        criticalUrgencyDuration = 8;
        density = "compact";
        enableBatteryToast = true;
        enableKeyboardLayoutToast = true;
        enableMarkdown = false;
        enableMediaToast = false;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 2;
        monitors = [];
        normalUrgencyDuration = 5;
        overlayLayer = true;
        respectExpireTimeout = false;
        saveToHistory = {
          critical = true;
          low = true;
          normal = true;
        };
        sounds = {
          criticalSoundFile = "";
          enabled = false;
          excludedApps = "discord,firefox,chrome,chromium,edge";
          lowSoundFile = "";
          normalSoundFile = "";
          separateSounds = false;
          volume = 0.5;
        };
      };

      osd = {
        autoHideMs = 2000;
        backgroundOpacity = 1;
        enabled = true;
        enabledTypes = [0 1 2];
        location = "bottom";
        monitors = [];
        overlayLayer = true;
      };

      plugins = {
        autoUpdate = false;
      };

      sessionMenu = {
        countdownDuration = 10000;
        enableCountdown = true;
        largeButtonsLayout = "single-row";
        largeButtonsStyle = true;
        position = "center";
        powerOptions = [
          {
            action = "lock";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            command = "";
            countdownEnabled = true;
            enabled = false;
            keybind = "";
          }
          {
            action = "reboot";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "3";
          }
          {
            action = "logout";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "4";
          }
          {
            action = "shutdown";
            command = "";
            countdownEnabled = true;
            enabled = true;
            keybind = "5";
          }
          {
            action = "userspaceReboot";
            command = "";
            countdownEnabled = true;
            enabled = false;
            keybind = "";
          }
          {
            action = "rebootToUefi";
            command = "";
            countdownEnabled = true;
            enabled = false;
            keybind = "";
          }
        ];
        showHeader = true;
        showKeybinds = true;
      };

      templates = {
        activeTemplates = [];
        enableUserTheming = false;
      };

      ui = {
        boxBorderEnabled = false;
        fontDefault = "MesloLGM Nerd Font";
        fontDefaultScale = 0.9;
        fontFixed = "MesloLGM Nerd Font Mono";
        fontFixedScale = 0.9;
        panelBackgroundOpacity = 1;
        panelsAttachedToBar = true;
        scrollbarAlwaysVisible = true;
        settingsPanelMode = "attached";
        settingsPanelSideBarCardStyle = false;
        tooltipsEnabled = true;
        translucentWidgets = false;
      };

      wallpaper = {
        automationEnabled = false;
        directory = "/home/matt/.wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        favorites = [];
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        monitorDirectories = [];
        overviewBlur = 0.4;
        overviewEnabled = true;
        overviewTint = 0.6;
        panelPosition = "follow_bar";
        randomIntervalSec = 300;
        setWallpaperOnAllMonitors = true;
        showHiddenFiles = false;
        skipStartupTransition = false;
        solidColor = "#1a1a2e";
        sortOrder = "name";
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = "random";
        useSolidColor = false;
        useWallhaven = false;
        viewMode = "single";
      };
    };
  };
}

pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string userConfigPath: Quickshell.shellDir + "/config/user_config.json"

    // ---- dashboard open/close ----
    property bool dashboardActive: false
    property int active_panel: 0
    property bool lockscreenActive: false

    property var dashboardActiveTabs: ({
            wallpaper: true,
            system: true,
            music: true
        })

    readonly property var allTabs: [
        {
            key: "apps",
            icon: "\ue5c3",
            label: "Apps",
            alwaysOn: true
        },
        {
            key: "wallpaper",
            icon: "\ue3f4",
            label: "Wallpaper"
        },
        {
            key: "system",
            icon: "\ue30a",
            label: "System"
        },
        {
            key: "music",
            icon: "\ue405",
            label: "Music"
        }
    ]
    readonly property var visibleTabs: allTabs.filter(t => t.alwaysOn || dashboardActiveTabs[t.key])

    onVisibleTabsChanged: {
        if (active_panel >= visibleTabs.length) {
            active_panel = 0;
        }
    }

    function set_panel(index) {
        active_panel = index;
    }
    function dashboardToggle() {
        if (dashboardActive) {
            dashboardClose();
        } else {
            dashboardOpen();
        }
    }
    function dashboardOpen() {
        dashboardActive = true;
    }
    function dashboardClose() {
        dashboardActive = false;
        active_panel = 0;
    }
    function toggleLock() {
        lockscreenActive = !lockscreenActive;
        if (lockscreenActive) {
            dashboardClose();
        }
    }

    function setTabActive(tabKey, enabled) {
        const updated = Object.assign({}, dashboardActiveTabs);
        updated[tabKey] = enabled;
        dashboardActiveTabs = updated;
        saveActiveTabs();
    }

    function saveActiveTabs() {
        let fullConfig = {};
        try {
            fullConfig = JSON.parse(activeTabsFile.text());
        } catch (e) {
            // file missing/invalid, start fresh
        }
        fullConfig.activated_tabs = root.dashboardActiveTabs;
        activeTabsFile.setText(JSON.stringify(fullConfig, null, 2));
    }

    // ---- settings window open/close ----
    property bool settingsOpen: false

    function toggleSettings() {
        settingsOpen = !settingsOpen;
    }
    function openSettings() {
        settingsOpen = true;
    }
    function closeSettings() {
        settingsOpen = false;
    }

    FileView {
        id: activeTabsFile
        path: root.userConfigPath
        watchChanges: true
        onFileChanged: reload()
        onLoaded: {
            try {
                const data = JSON.parse(text());
                if (data.activated_tabs) {
                    root.dashboardActiveTabs = data.activated_tabs;
                }
            } catch (e) {
                console.warn("States.qml: cannot parse user_config.json, using defaults");
            }
        }
        onLoadFailed: error => {
            console.warn("States.qml: user_config.json not found (" + error + "), using defaults");
        }
    }
}

pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    readonly property string userConfigPath: Quickshell.shellDir + "/config/user_config.json"

    // ---- dashboard open/close ----
    property bool dashboardOpen: false
    property int active_panel: 0

    property var dashboardActive: ({
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
    readonly property var visibleTabs: allTabs.filter(t => t.alwaysOn || dashboardActive[t.key])

    onVisibleTabsChanged: {
        if (active_panel >= visibleTabs.length) {
            active_panel = 0;
        }
    }

    function set_panel(index) {
        active_panel = index;
    }
    function toggle() {
        dashboardOpen = !dashboardOpen;
    }
    function open() {
        dashboardOpen = true;
    }
    function close() {
        dashboardOpen = false;
    }

    function setTabActive(tabKey, enabled) {
        const updated = Object.assign({}, dashboardActive);
        updated[tabKey] = enabled;
        dashboardActive = updated;
        saveActiveTabs();
    }

    function saveActiveTabs() {
        let fullConfig = {};
        try {
            fullConfig = JSON.parse(activeTabsFile.text());
        } catch (e) {
            // file missing/invalid, start fresh
        }
        fullConfig.activated_tabs = root.dashboardActive;
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
                    root.dashboardActive = data.activated_tabs;
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

import QtQuick
import Quickshell.Io
import qs.Common
import qs.Services
import qs.Modules.Plugins

PluginComponent {
    id: root

    property string systemdEscapePath: pluginData.systemdEscapePath || "systemd-escape"
    property string systemctlPath: pluginData.systemctlPath || "systemctl"
    property string dmsPath: pluginData.dmsPath || "dms"
    property int restartDelayMs: pluginData.restartDelayMs || 500
    property string escapedUnit: ""
    property string errorOutput: ""

    Connections {
        target: SessionData

        function onWallpaperPathChanged() {
            root.switchThemeForWallpaper(SessionData.wallpaperPath)
        }
    }

    function switchThemeForWallpaper(wallpaperPath) {
        if (!wallpaperPath || wallpaperPath.startsWith("#") || escapeProcess.running || switchProcess.running || restartTimer.running)
            return;

        const choice = themeNameFromPath(wallpaperPath);
        if (!choice)
            return;

        escapedUnit = "";
        errorOutput = "";
        escapeProcess.command = [systemdEscapePath, "--template=erinite-theme-switch@.service", choice];
        escapeProcess.running = true;
    }

    function themeNameFromPath(path) {
        let fileName = path;
        if (fileName.startsWith("file://"))
            fileName = fileName.substring(7);
        fileName = fileName.split("/").pop();
        return fileName.replace(/\.[^.]*$/, "");
    }

    Process {
        id: escapeProcess
        running: false

        stdout: StdioCollector {
            onStreamFinished: root.escapedUnit = text.trim()
        }

        stderr: StdioCollector {
            onStreamFinished: root.errorOutput = text.trim()
        }

        onExited: exitCode => {
            if (exitCode !== 0 || !root.escapedUnit) {
                ToastService.showError("Theme switch failed", root.errorOutput || "systemd-escape exited with code: " + exitCode);
                return;
            }

            switchProcess.command = [root.systemctlPath, "start", root.escapedUnit];
            switchProcess.running = true;
        }
    }

    Process {
        id: switchProcess
        running: false

        stderr: StdioCollector {
            onStreamFinished: root.errorOutput = text.trim()
        }

        onExited: exitCode => {
            if (exitCode !== 0) {
                ToastService.showError("Theme switch failed", root.errorOutput || "systemctl exited with code: " + exitCode);
                return;
            }

            restartTimer.restart();
        }
    }

    Timer {
        id: restartTimer
        interval: root.restartDelayMs
        repeat: false
        onTriggered: {
            restartProcess.command = [root.dmsPath, "restart"];
            restartProcess.running = true;
        }
    }

    Process {
        id: restartProcess
        running: false

        stderr: StdioCollector {
            onStreamFinished: root.errorOutput = text.trim()
        }

        onExited: exitCode => {
            if (exitCode !== 0)
                ToastService.showError("DMS restart failed", root.errorOutput || "dms exited with code: " + exitCode);
        }
    }
}

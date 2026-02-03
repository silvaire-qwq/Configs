pragma ComponentBehavior: Bound
import qs.modules.common
import qs.modules.common.widgets
import qs.modules.common.models
import qs.services
import qs
import qs.modules.common.functions
import qs.modules.background.widgets
import qs.modules.mediaControls

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Io
import Quickshell.Services.Mpris

AbstractBackgroundWidget {
    id: root

    configEntryName: "mediaControls"

    readonly property real widgetWidth: Appearance.sizes.mediaControlsWidth
    readonly property real widgetHeight: Appearance.sizes.mediaControlsHeight
    property real popupRounding: Appearance.rounding.screenRounding - Appearance.sizes.hyprlandGapsOut + 1

    // Use MprisController.displayPlayers - centralized filtering
    readonly property var meaningfulPlayers: MprisController.displayPlayers

    implicitWidth: widgetWidth
    implicitHeight: playerColumnLayout.implicitHeight

    readonly property bool visualizerActive: (Config.options?.background?.widgets?.mediaControls?.enable ?? false)
        && (root.meaningfulPlayers?.length ?? 0) > 0

    CavaProcess {
        id: cavaProcess
        active: root.visualizerActive
    }

    property list<real> visualizerPoints: cavaProcess.points

    readonly property point widgetScreenPos: root.mapToItem(null, 0, 0)

    ColumnLayout {
        id: playerColumnLayout
        anchors.fill: parent
        spacing: -Appearance.sizes.elevationMargin

        Repeater {
            model: ScriptModel {
                values: root.meaningfulPlayers
            }
            delegate: PlayerControl {
                required property MprisPlayer modelData
                player: modelData
                visualizerPoints: root.visualizerPoints
                implicitWidth: root.widgetWidth
                implicitHeight: root.widgetHeight
                radius: root.popupRounding
                screenX: root.widgetScreenPos.x
                screenY: root.widgetScreenPos.y
            }
        }

        Item {
            Layout.fillWidth: true
            visible: root.meaningfulPlayers.length === 0
            implicitWidth: placeholderBackground.implicitWidth + Appearance.sizes.elevationMargin
            implicitHeight: placeholderBackground.implicitHeight + Appearance.sizes.elevationMargin

            StyledRectangularShadow {
                target: placeholderBackground
                visible: !Appearance.inirEverywhere && !Appearance.auroraEverywhere
            }

            Rectangle {
                id: placeholderBackground
                anchors.centerIn: parent
                color: Appearance.inirEverywhere ? Appearance.inir.colLayer1
                     : Appearance.auroraEverywhere ? Appearance.aurora.colPopupSurface
                     : Appearance.colors.colLayer0
                radius: Appearance.inirEverywhere ? Appearance.inir.roundingNormal : root.popupRounding
                border.width: Appearance.inirEverywhere || Appearance.auroraEverywhere ? 1 : 0
                border.color: Appearance.inirEverywhere ? Appearance.inir.colBorder
                            : Appearance.auroraEverywhere ? Appearance.aurora.colPopupBorder
                            : "transparent"
                property real padding: 20
                implicitWidth: placeholderLayout.implicitWidth + padding * 2
                implicitHeight: placeholderLayout.implicitHeight + padding * 2

                ColumnLayout {
                    id: placeholderLayout
                    anchors.centerIn: parent

                    StyledText {
                        text: Translation.tr("No active player")
                        font.pixelSize: Appearance.font.pixelSize.large
                        color: Appearance.inirEverywhere ? Appearance.inir.colText
                            : Appearance.auroraEverywhere ? Appearance.colors.colOnLayer0
                            : Appearance.colors.colOnLayer0
                    }
                    StyledText {
                        color: Appearance.inirEverywhere ? Appearance.inir.colTextSecondary
                            : Appearance.auroraEverywhere ? Appearance.aurora.colTextSecondary
                            : Appearance.colors.colSubtext
                        text: Translation.tr("Make sure your player has MPRIS support\nor try turning off duplicate player filtering")
                        font.pixelSize: Appearance.font.pixelSize.small
                    }
                }
            }
        }
    }
}

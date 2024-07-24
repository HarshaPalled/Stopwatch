// import QtQuick 2.15
// import QtQuick.Controls 2.15

// Rectangle {
//     id: menu
//     width: parent.width
//     height: parent.height
//     color: "cyan"

//     // Column {
//     //     anchors.centerIn: parent

//     //     CheckBox {
//     //         text: qsTr("Dark Theme")
//     //         checked: root.themeColor === "#373636"
//     //         onCheckedChanged: {
//     //             if (checked) {
//     //                 root.themeColor = "#373636"
//     //             }
//     //         }
//     //     }

//     //     CheckBox {
//     //         text: qsTr("Light Theme")
//     //         checked: root.themeColor === "#f0f0f0"
//     //         onCheckedChanged: {
//     //             if (checked) {
//     //                 root.themeColor = "#f0f0f0"
//     //             }
//     //         }
//     //     }
//     // }
// }
import QtQuick
import QtQuick.Controls

ApplicationWindow {
    id: window
    width: 200
    height: 228
    visible: true

    Drawer {
        id: drawer
        width: 0.66 * window.width
        height: window.height
    }

    Label {
        id: content

        text: "Aa"
        font.pixelSize: 96
        anchors.fill: parent
        verticalAlignment: Label.AlignVCenter
        horizontalAlignment: Label.AlignHCenter

        transform: Translate {
            x: drawer.position * content.width * 0.33
        }
    }
}

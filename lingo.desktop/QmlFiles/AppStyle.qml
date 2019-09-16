import QtQml 2.12

QtObject {
	readonly property string background: "#0e1621"
	readonly property string foreground: "#f5f5f5"

	readonly property QtObject mainFeedStyle : QtObject {
		readonly property string background : "#0e1621"
		readonly property string feedBackground: "#182533"
		readonly property string feedHighlighted : "#2c3847"
        readonly property int itemsHPadding: 16
        readonly property int itemsVPadding: 16
        readonly property int insetVDiff: 16
        readonly property int insetHDiff: 16
		readonly property int imageSpacing: 16
		readonly property int titleSpacing: 16
		readonly property int titleFontPixelSize: 17
		readonly property int timeFontPixelSize: 12
		readonly property int summaryFontPixelSize: 14
	}

	readonly property QtObject projectPageStyle : QtObject {
		readonly property string background : "#0e1621"
		readonly property string feedBackground: "#182533"
		readonly property string tint: "#96070b11"
		readonly property int itemsHPadding: 30
		readonly property int itemsVPadding: 20
		readonly property int insetVDiff: 10
		readonly property int insetHDiff: 5
		readonly property int titleFontPixelSize: 27
		readonly property int timeFontPixelSize: 12
		readonly property int summaryFontPixelSize: 15
	}

	readonly property QtObject headerStyle : QtObject {
        readonly property int height: 36
        readonly property int toolButtonHeight: 36
        readonly property int toolButtonWidth: 36
        readonly property int fontPixelSize: 14
        readonly property string background: "#17212b"
		readonly property string foreground: "#6c7883"
		readonly property string foregroundTabs : "#e9e8e8"
	}
	
	readonly property QtObject menuStyle : QtObject {
		readonly property int width: 200
		readonly property int itemHeight: 48
		readonly property string background: "#17212b"
		readonly property string tint: "#070b11"
		readonly property string accent : "#232e3c"
		readonly property string foreground: "#e9e8e8"
		readonly property string foregroundAccent: "#e9e9e9"

		readonly property string separatorBackground: "#242F3D"
		readonly property int separatorHeight: 8
	}
	
	readonly property QtObject titleBarStyle : QtObject {
		readonly property int height: 28
		readonly property int buttonHeight: 28
		readonly property int buttonWidth: 32
		readonly property string background: "#242F3D"
		readonly property string foreground: "#6c7883"
		readonly property string backgroundHovered : "#2c3847"
		readonly property string foregroundHovered : "#e0e0e0"
		readonly property string closeButtonHovered : "#e92539"
	}

	readonly property QtObject statusBarStyle: QtObject {
		readonly property int height: 28
		readonly property string background: "#242F3D"
		readonly property string foreground: "#6c7883"
	}
}

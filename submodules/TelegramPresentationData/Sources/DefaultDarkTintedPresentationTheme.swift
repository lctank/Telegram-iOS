import Foundation
import UIKit
import TelegramUIPreferences

private func makeDarkPresentationTheme(accentColor: UIColor, bubbleColors: (UIColor, UIColor?)?, preview: Bool) -> PresentationTheme {
    let destructiveColor: UIColor = UIColor(rgb: 0xff6767)
    let constructiveColor: UIColor = UIColor(rgb: 0x08a723)
    let secretColor: UIColor = UIColor(rgb: 0x89df9e)
    
    var accentColor = accentColor
    let hsb = accentColor.hsb
    accentColor = UIColor(hue: hsb.0, saturation: hsb.1, brightness: max(hsb.2, 0.18), alpha: 1.0)
    
    let secondaryBadgeTextColor: UIColor
    let lightness = accentColor.lightness
    if lightness > 0.7 {
        secondaryBadgeTextColor = .black
    } else {
        secondaryBadgeTextColor = .white
    }
    
    let mainBackgroundColor = accentColor.withMultiplied(hue: 1.024, saturation: 0.585, brightness: 0.25)
    let mainSelectionColor = accentColor.withMultiplied(hue: 1.03, saturation: 0.585, brightness: 0.12)
    let additionalBackgroundColor = accentColor.withMultiplied(hue: 1.024, saturation: 0.573, brightness: 0.18)

    let mainSeparatorColor = accentColor.withMultiplied(hue: 1.033, saturation: 0.426, brightness: 0.34)
    let mainForegroundColor = accentColor.withMultiplied(hue: 0.99, saturation: 0.256, brightness: 0.62)
    
    let mainSecondaryColor = accentColor.withMultiplied(hue: 1.019, saturation: 0.109, brightness: 0.59)
    let mainSecondaryTextColor = accentColor.withMultiplied(hue: 0.956, saturation: 0.17, brightness: 1.0)
    
    let mainFreeTextColor = accentColor.withMultiplied(hue: 1.019, saturation: 0.097, brightness: 0.56)
    
    let outgoingBubbleFillColor: UIColor
    let outgoingBubbleFillGradientColor: UIColor
    let outgoingBubbleHighlightedFillColor: UIColor
    let outgoingScamColor: UIColor
    let outgoingPrimaryTextColor: UIColor
    let outgoingSecondaryTextColor: UIColor
    let outgoingLinkTextColor: UIColor
    let outgoingCheckColor: UIColor
    
    if let bubbleColors = bubbleColors {
        outgoingBubbleFillColor = bubbleColors.0
        outgoingBubbleFillGradientColor = bubbleColors.1 ?? bubbleColors.0
    } else {
        outgoingBubbleFillGradientColor = accentColor.withMultiplied(hue: 1.019, saturation: 0.731, brightness: 0.59)
        outgoingBubbleFillColor = outgoingBubbleFillGradientColor.withMultiplied(hue: 0.966, saturation: 0.61, brightness: 0.98)
    }
    
    let outgoingBubbleLightnessColor = outgoingBubbleFillColor.mixedWith(outgoingBubbleFillGradientColor, alpha: 0.5)
    if outgoingBubbleLightnessColor.lightness > 0.7 {
        outgoingScamColor = UIColor(rgb: 0x000000)
        outgoingPrimaryTextColor = UIColor(rgb: 0x000000)
        outgoingSecondaryTextColor = UIColor(rgb: 0x000000, alpha: 0.5)
        outgoingLinkTextColor = UIColor(rgb: 0x000000)
        outgoingCheckColor = UIColor(rgb: 0x000000, alpha: 0.5)
    } else {
        outgoingScamColor = UIColor(rgb: 0xffffff)
        outgoingPrimaryTextColor = UIColor(rgb: 0xffffff)
        outgoingSecondaryTextColor = UIColor(rgb: 0xffffff, alpha: 0.5)
        outgoingLinkTextColor = UIColor(rgb: 0xffffff)
        outgoingCheckColor = UIColor(rgb: 0xffffff, alpha: 0.5)
    }
        
    let highlightedIncomingBubbleColor = accentColor.withMultiplied(hue: 1.03, saturation: 0.463, brightness: 0.29)
    let highlightedOutgoingBubbleColor = accentColor.withMultiplied(hue: 1.019, saturation: 0.609, brightness: 0.63)
    
    let mainInputColor = accentColor.withMultiplied(hue: 1.029, saturation: 0.609, brightness: 0.19)
    let inputBackgroundColor = accentColor.withMultiplied(hue: 1.02, saturation: 0.609, brightness: 0.15)
    
    let rootTabBar = PresentationThemeRootTabBar(
        backgroundColor: mainBackgroundColor,
        separatorColor: mainSeparatorColor,
        iconColor: mainForegroundColor,
        selectedIconColor: accentColor,
        textColor: mainForegroundColor,
        selectedTextColor: accentColor,
        badgeBackgroundColor: UIColor(rgb: 0xef5b5b),
        badgeStrokeColor: UIColor(rgb: 0xef5b5b),
        badgeTextColor: UIColor(rgb: 0xffffff)
    )

    let rootNavigationBar = PresentationThemeRootNavigationBar(
        buttonColor: accentColor,
        disabledButtonColor: accentColor.withMultiplied(hue: 1.033, saturation: 0.219, brightness: 0.44),
        primaryTextColor: .white,
        secondaryTextColor: mainSecondaryColor,
        controlColor: mainSecondaryColor,
        accentTextColor: accentColor,
        backgroundColor: mainBackgroundColor,
        separatorColor: mainSeparatorColor,
        badgeBackgroundColor: UIColor(rgb: 0xef5b5b),
        badgeStrokeColor: UIColor(rgb: 0xef5b5b),
        badgeTextColor: UIColor(rgb: 0xffffff),
        segmentedBackgroundColor: mainInputColor,
        segmentedForegroundColor: mainBackgroundColor,
        segmentedTextColor: UIColor(rgb: 0xffffff),
        segmentedDividerColor: mainSecondaryTextColor.withAlphaComponent(0.5)
    )

    let navigationSearchBar = PresentationThemeNavigationSearchBar(
        backgroundColor: mainBackgroundColor,
        accentColor: accentColor,
        inputFillColor: mainInputColor,
        inputTextColor: UIColor(rgb: 0xffffff),
        inputPlaceholderTextColor: mainSecondaryColor,
        inputIconColor: mainSecondaryColor,
        inputClearButtonColor: mainSecondaryColor,
        separatorColor: additionalBackgroundColor
    )

    let intro = PresentationThemeIntro(
        statusBarStyle: .white,
        primaryTextColor: .white,
        accentTextColor: accentColor,
        disabledTextColor: accentColor.withMultiplied(hue: 1.033, saturation: 0.219, brightness: 0.44),
        startButtonColor: accentColor,
        dotColor: mainSecondaryColor
    )

    let passcode = PresentationThemePasscode(
        backgroundColors: PresentationThemeGradientColors(topColor: accentColor.withMultiplied(hue: 1.049, saturation: 0.573, brightness: 0.47), bottomColor: additionalBackgroundColor),
        buttonColor: mainBackgroundColor
    )

    let rootController = PresentationThemeRootController(
        statusBarStyle: .white,
        tabBar: rootTabBar,
        navigationBar: rootNavigationBar,
        navigationSearchBar: navigationSearchBar,
        keyboardColor: .dark
    )

    let switchColors = PresentationThemeSwitch(
        frameColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        handleColor: UIColor(rgb: 0x121212),
        contentColor: accentColor,
        positiveColor: constructiveColor,
        negativeColor: destructiveColor
    )

    let list = PresentationThemeList(
        blocksBackgroundColor: additionalBackgroundColor,
        plainBackgroundColor: additionalBackgroundColor,
        itemPrimaryTextColor: UIColor(rgb: 0xffffff),
        itemSecondaryTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        itemDisabledTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        itemAccentColor: accentColor,
        itemHighlightedColor: UIColor(rgb: 0x28b772),
        itemDestructiveColor: destructiveColor,
        itemPlaceholderTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        itemBlocksBackgroundColor: mainBackgroundColor,
        itemHighlightedBackgroundColor: mainSelectionColor,
        itemBlocksSeparatorColor: mainSeparatorColor,
        itemPlainSeparatorColor: mainSeparatorColor,
        disclosureArrowColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        sectionHeaderTextColor: mainFreeTextColor,
        freeTextColor: mainFreeTextColor,
        freeTextErrorColor: destructiveColor,
        freeTextSuccessColor: UIColor(rgb: 0x30cf30),
        freeMonoIconColor: mainFreeTextColor,
        itemSwitchColors: switchColors,
        itemDisclosureActions: PresentationThemeItemDisclosureActions(
            neutral1: PresentationThemeFillForeground(fillColor: accentColor, foregroundColor: .white),
            neutral2: PresentationThemeFillForeground(fillColor: UIColor(rgb: 0xcd7800), foregroundColor: .white),
            destructive: PresentationThemeFillForeground(fillColor: UIColor(rgb: 0xc70c0c), foregroundColor: .white),
            constructive: PresentationThemeFillForeground(fillColor: constructiveColor, foregroundColor: .white),
            accent: PresentationThemeFillForeground(fillColor: accentColor, foregroundColor: .white),
            warning: PresentationThemeFillForeground(fillColor: UIColor(rgb: 0xcd7800), foregroundColor: .white),
            inactive: PresentationThemeFillForeground(fillColor: accentColor.withMultiplied(hue: 1.029, saturation: 0.609, brightness: 0.3), foregroundColor: .white)
        ),
        itemCheckColors: PresentationThemeFillStrokeForeground(
            fillColor: accentColor,
            strokeColor: mainSecondaryTextColor.withAlphaComponent(0.5),
            foregroundColor: secondaryBadgeTextColor
        ),
        controlSecondaryColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        freeInputField: PresentationInputFieldTheme(
            backgroundColor: mainSecondaryTextColor.withAlphaComponent(0.5),
            strokeColor: mainSecondaryTextColor.withAlphaComponent(0.5),
            placeholderColor: UIColor(rgb: 0x4d4d4d),
            primaryColor: .white,
            controlColor: UIColor(rgb: 0x4d4d4d)
        ),
        freePlainInputField: PresentationInputFieldTheme(
            backgroundColor: mainSecondaryTextColor.withAlphaComponent(0.5),
            strokeColor: mainSecondaryTextColor.withAlphaComponent(0.5),
            placeholderColor: UIColor(rgb: 0x4d4d4d),
            primaryColor: .white,
            controlColor: UIColor(rgb: 0x4d4d4d)
        ),
        mediaPlaceholderColor: accentColor.withMultiplied(hue: 1.019, saturation: 0.585, brightness: 0.23),
        scrollIndicatorColor: UIColor(white: 1.0, alpha: 0.3),
        pageIndicatorInactiveColor: mainSecondaryTextColor.withAlphaComponent(0.4),
        inputClearButtonColor: mainSecondaryColor,
        itemBarChart: PresentationThemeItemBarChart(color1: accentColor, color2: mainSecondaryTextColor.withAlphaComponent(0.5), color3: accentColor.withMultiplied(hue: 1.038, saturation: 0.329, brightness: 0.33))
    )
    
    let chatList = PresentationThemeChatList(
        backgroundColor: additionalBackgroundColor,
        itemSeparatorColor: mainSeparatorColor,
        itemBackgroundColor: additionalBackgroundColor,
        pinnedItemBackgroundColor: mainBackgroundColor,
        itemHighlightedBackgroundColor: mainSelectionColor,
        itemSelectedBackgroundColor: mainSelectionColor,
        titleColor: UIColor(rgb: 0xffffff),
        secretTitleColor: secretColor,
        dateTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        authorNameColor: UIColor(rgb: 0xffffff),
        messageTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        messageHighlightedTextColor: UIColor(rgb: 0xffffff),
        messageDraftTextColor: UIColor(rgb: 0xdd4b39),
        checkmarkColor: accentColor,
        pendingIndicatorColor: mainSecondaryTextColor.withAlphaComponent(0.4),
        failedFillColor: destructiveColor,
        failedForegroundColor: .white,
        muteIconColor: mainSecondaryTextColor.withAlphaComponent(0.4),
        unreadBadgeActiveBackgroundColor: accentColor,
        unreadBadgeActiveTextColor: secondaryBadgeTextColor,
        unreadBadgeInactiveBackgroundColor: mainSecondaryTextColor.withAlphaComponent(0.4),
        unreadBadgeInactiveTextColor: additionalBackgroundColor,
        pinnedBadgeColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        pinnedSearchBarColor: mainInputColor,
        regularSearchBarColor: accentColor.withMultiplied(hue: 1.029, saturation: 0.609, brightness: 0.12),
        sectionHeaderFillColor: mainBackgroundColor,
        sectionHeaderTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        verifiedIconFillColor: accentColor,
        verifiedIconForegroundColor: .white,
        secretIconColor: secretColor,
        pinnedArchiveAvatarColor: PresentationThemeArchiveAvatarColors(backgroundColors: PresentationThemeGradientColors(topColor: UIColor(rgb: 0x72d5fd), bottomColor: UIColor(rgb: 0x2a9ef1)), foregroundColor: .white),
        unpinnedArchiveAvatarColor: PresentationThemeArchiveAvatarColors(backgroundColors: PresentationThemeGradientColors(topColor: accentColor.withMultiplied(hue: 0.985, saturation: 0.268, brightness: 0.47), bottomColor: accentColor.withMultiplied(hue: 0.98, saturation: 0.268, brightness: 0.39)), foregroundColor: additionalBackgroundColor),
        onlineDotColor: UIColor(rgb: 0x4cc91f)
    )
    
    let buttonStrokeColor = accentColor.withMultiplied(hue: 1.014, saturation: 0.56, brightness: 0.64).withAlphaComponent(0.15)
    
    let message = PresentationThemeChatMessage(
        incoming: PresentationThemePartedColors(bubble: PresentationThemeBubbleColor(withWallpaper: PresentationThemeBubbleColorComponents(fill: mainBackgroundColor, highlightedFill: highlightedIncomingBubbleColor, stroke: mainBackgroundColor), withoutWallpaper: PresentationThemeBubbleColorComponents(fill: mainBackgroundColor, highlightedFill: highlightedIncomingBubbleColor, stroke: mainBackgroundColor)), primaryTextColor: .white, secondaryTextColor: mainSecondaryTextColor.withAlphaComponent(0.5), linkTextColor: accentColor, linkHighlightColor: accentColor.withAlphaComponent(0.5), scamColor: destructiveColor, textHighlightColor: UIColor(rgb: 0xf5c038), accentTextColor: accentColor, accentControlColor: accentColor, mediaActiveControlColor: accentColor, mediaInactiveControlColor: accentColor.withAlphaComponent(0.5), mediaControlInnerBackgroundColor: mainBackgroundColor, pendingActivityColor: mainSecondaryTextColor.withAlphaComponent(0.5), fileTitleColor: accentColor, fileDescriptionColor: mainSecondaryTextColor.withAlphaComponent(0.5), fileDurationColor: mainSecondaryTextColor.withAlphaComponent(0.5), mediaPlaceholderColor: accentColor.withMultiplied(hue: 1.019, saturation: 0.585, brightness: 0.23), polls: PresentationThemeChatBubblePolls(radioButton: accentColor.withMultiplied(hue: 0.995, saturation: 0.317, brightness: 0.51), radioProgress: accentColor, highlight: accentColor.withAlphaComponent(0.12), separator: mainSeparatorColor, bar: accentColor), actionButtonsFillColor: PresentationThemeVariableColor(withWallpaper: additionalBackgroundColor.withAlphaComponent(0.5), withoutWallpaper: additionalBackgroundColor.withAlphaComponent(0.5)), actionButtonsStrokeColor: PresentationThemeVariableColor(color: buttonStrokeColor), actionButtonsTextColor: PresentationThemeVariableColor(color: .white), textSelectionColor: accentColor.withAlphaComponent(0.2), textSelectionKnobColor: accentColor),
        outgoing: PresentationThemePartedColors(bubble: PresentationThemeBubbleColor(withWallpaper: PresentationThemeBubbleColorComponents(fill: outgoingBubbleFillColor, gradientFill: outgoingBubbleFillGradientColor, highlightedFill: highlightedOutgoingBubbleColor, stroke: outgoingBubbleFillColor), withoutWallpaper: PresentationThemeBubbleColorComponents(fill: outgoingBubbleFillColor, gradientFill: outgoingBubbleFillGradientColor, highlightedFill: highlightedOutgoingBubbleColor, stroke: outgoingBubbleFillColor)), primaryTextColor: outgoingPrimaryTextColor, secondaryTextColor: outgoingSecondaryTextColor, linkTextColor: outgoingLinkTextColor, linkHighlightColor: UIColor.white.withAlphaComponent(0.5), scamColor: outgoingScamColor, textHighlightColor: UIColor(rgb: 0xf5c038), accentTextColor: outgoingPrimaryTextColor, accentControlColor: outgoingPrimaryTextColor, mediaActiveControlColor: outgoingPrimaryTextColor, mediaInactiveControlColor: outgoingSecondaryTextColor, mediaControlInnerBackgroundColor: outgoingBubbleFillColor, pendingActivityColor: outgoingSecondaryTextColor, fileTitleColor: outgoingPrimaryTextColor, fileDescriptionColor: outgoingSecondaryTextColor, fileDurationColor: outgoingSecondaryTextColor, mediaPlaceholderColor: accentColor.withMultiplied(hue: 1.019, saturation: 0.804, brightness: 0.51), polls: PresentationThemeChatBubblePolls(radioButton: outgoingPrimaryTextColor, radioProgress: accentColor.withMultiplied(hue: 0.99, saturation: 0.56, brightness: 1.0), highlight: accentColor.withMultiplied(hue: 0.99, saturation: 0.56, brightness: 1.0).withAlphaComponent(0.12), separator: mainSeparatorColor, bar: outgoingPrimaryTextColor), actionButtonsFillColor: PresentationThemeVariableColor(withWallpaper: additionalBackgroundColor.withAlphaComponent(0.5), withoutWallpaper: additionalBackgroundColor.withAlphaComponent(0.5)), actionButtonsStrokeColor: PresentationThemeVariableColor(color: buttonStrokeColor), actionButtonsTextColor: PresentationThemeVariableColor(color: .white), textSelectionColor: UIColor.white.withAlphaComponent(0.2), textSelectionKnobColor: UIColor.white),
        freeform: PresentationThemeBubbleColor(withWallpaper: PresentationThemeBubbleColorComponents(fill: mainBackgroundColor, highlightedFill: highlightedIncomingBubbleColor, stroke: mainBackgroundColor), withoutWallpaper: PresentationThemeBubbleColorComponents(fill: mainBackgroundColor, highlightedFill: highlightedIncomingBubbleColor, stroke: mainBackgroundColor)),
        infoPrimaryTextColor: UIColor(rgb: 0xffffff),
        infoLinkTextColor: accentColor,
        outgoingCheckColor: outgoingCheckColor,
        mediaDateAndStatusFillColor: UIColor(white: 0.0, alpha: 0.5),
        mediaDateAndStatusTextColor: UIColor(rgb: 0xffffff),
        shareButtonFillColor: PresentationThemeVariableColor(color: additionalBackgroundColor.withAlphaComponent(0.5)),
        shareButtonStrokeColor: PresentationThemeVariableColor(color: buttonStrokeColor),
        shareButtonForegroundColor: PresentationThemeVariableColor(color: UIColor(rgb: 0xb2b2b2)),
        mediaOverlayControlColors: PresentationThemeFillForeground(fillColor: UIColor(rgb: 0x000000, alpha: 0.6), foregroundColor: .white),
        selectionControlColors: PresentationThemeFillStrokeForeground(fillColor: accentColor, strokeColor: .white, foregroundColor: .white),
        deliveryFailedColors: PresentationThemeFillForeground(fillColor: destructiveColor, foregroundColor: .white),
        mediaHighlightOverlayColor: UIColor(white: 1.0, alpha: 0.6)
    )
    
    let serviceMessage = PresentationThemeServiceMessage(
        components: PresentationThemeServiceMessageColor(withDefaultWallpaper: PresentationThemeServiceMessageColorComponents(fill: additionalBackgroundColor, primaryText: .white, linkHighlight: UIColor(rgb: 0xffffff, alpha: 0.12), scam: destructiveColor, dateFillStatic: additionalBackgroundColor.withAlphaComponent(0.6), dateFillFloating: additionalBackgroundColor.withAlphaComponent(0.2)), withCustomWallpaper: PresentationThemeServiceMessageColorComponents(fill: additionalBackgroundColor, primaryText: .white, linkHighlight: UIColor(rgb: 0xffffff, alpha: 0.12), scam: destructiveColor, dateFillStatic: additionalBackgroundColor.withAlphaComponent(0.6), dateFillFloating: additionalBackgroundColor.withAlphaComponent(0.2))),
        unreadBarFillColor: mainBackgroundColor,
        unreadBarStrokeColor: mainBackgroundColor,
        unreadBarTextColor: .white,
        dateTextColor: PresentationThemeVariableColor(color: .white)
    )

    let inputPanelMediaRecordingControl = PresentationThemeChatInputPanelMediaRecordingControl(
        buttonColor: accentColor,
        micLevelColor: accentColor.withAlphaComponent(0.2),
        activeIconColor: .white
    )
    
    let inputPanel = PresentationThemeChatInputPanel(
        panelBackgroundColor: mainBackgroundColor,
        panelSeparatorColor: mainSeparatorColor,
        panelControlAccentColor: accentColor,
        panelControlColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        panelControlDisabledColor: UIColor(rgb: 0x90979F, alpha: 0.5),
        panelControlDestructiveColor: destructiveColor,
        inputBackgroundColor: inputBackgroundColor,
        inputStrokeColor: accentColor.withMultiplied(hue: 1.038, saturation: 0.463, brightness: 0.26),
        inputPlaceholderColor: mainSecondaryTextColor.withAlphaComponent(0.4),
        inputTextColor: UIColor(rgb: 0xffffff),
        inputControlColor: mainSecondaryTextColor.withAlphaComponent(0.4),
        actionControlFillColor: accentColor,
        actionControlForegroundColor: .white,
        primaryTextColor: UIColor(rgb: 0xffffff),
        secondaryTextColor: UIColor(rgb: 0xffffff, alpha: 0.5),
        mediaRecordingDotColor: accentColor,
        mediaRecordingControl: inputPanelMediaRecordingControl
    )

    let inputMediaPanel = PresentationThemeInputMediaPanel(
        panelSeparatorColor: mainBackgroundColor,
        panelIconColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        panelHighlightedIconBackgroundColor: inputBackgroundColor,
        stickersBackgroundColor: additionalBackgroundColor,
        stickersSectionTextColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        stickersSearchBackgroundColor: accentColor.withMultiplied(hue: 1.009, saturation: 0.621, brightness: 0.15),
        stickersSearchPlaceholderColor: accentColor.withMultiplied(hue: 0.99, saturation: 0.243, brightness: 0.59),
        stickersSearchPrimaryColor: .white,
        stickersSearchControlColor: accentColor.withMultiplied(hue: 0.99, saturation: 0.243, brightness: 0.59),
        gifsBackgroundColor: additionalBackgroundColor
    )

    let inputButtonPanel = PresentationThemeInputButtonPanel(
        panelSeparatorColor: mainBackgroundColor,
        panelBackgroundColor: accentColor.withMultiplied(hue: 1.048, saturation: 0.378, brightness: 0.13),
        buttonFillColor: accentColor.withMultiplied(hue: 1.0, saturation: 0.085, brightness: 0.38),
        buttonStrokeColor: accentColor.withMultiplied(hue: 1.019, saturation: 0.39, brightness: 0.07),
        buttonHighlightedFillColor: accentColor.withMultiplied(hue: 1.0, saturation: 0.085, brightness: 0.38).withAlphaComponent(0.7),
        buttonHighlightedStrokeColor: accentColor.withMultiplied(hue: 1.019, saturation: 0.39, brightness: 0.07),
        buttonTextColor: UIColor(rgb: 0xffffff)
    )

    let historyNavigation = PresentationThemeChatHistoryNavigation(
        fillColor: mainBackgroundColor,
        strokeColor: mainSeparatorColor,
        foregroundColor: mainSecondaryTextColor.withAlphaComponent(0.5),
        badgeBackgroundColor: accentColor,
        badgeStrokeColor: accentColor,
        badgeTextColor: .white
    )

    let chat = PresentationThemeChat(
        defaultWallpaper: .color(Int32(bitPattern: accentColor.withMultiplied(hue: 1.024, saturation: 0.573, brightness: 0.18).rgb)),
        message: message,
        serviceMessage: serviceMessage,
        inputPanel: inputPanel,
        inputMediaPanel: inputMediaPanel,
        inputButtonPanel: inputButtonPanel,
        historyNavigation: historyNavigation
    )

    let actionSheet = PresentationThemeActionSheet(
        dimColor: UIColor(white: 0.0, alpha: 0.5),
        backgroundType: .dark,
        opaqueItemBackgroundColor: mainBackgroundColor,
        itemBackgroundColor: mainBackgroundColor.withAlphaComponent(0.8),
        opaqueItemHighlightedBackgroundColor: mainSelectionColor,
        itemHighlightedBackgroundColor: mainSelectionColor.withAlphaComponent(0.2),
        opaqueItemSeparatorColor: additionalBackgroundColor,
        standardActionTextColor: accentColor,
        destructiveActionTextColor: destructiveColor,
        disabledActionTextColor: UIColor(white: 1.0, alpha: 0.5),
        primaryTextColor: .white,
        secondaryTextColor: UIColor(white: 1.0, alpha: 0.5),
        controlAccentColor: accentColor,
        inputBackgroundColor: mainInputColor,
        inputHollowBackgroundColor: mainInputColor,
        inputBorderColor: mainInputColor,
        inputPlaceholderColor: mainSecondaryColor,
        inputTextColor: .white,
        inputClearButtonColor: mainSecondaryColor,
        checkContentColor: secondaryBadgeTextColor
    )
    
    let contextMenu = PresentationThemeContextMenu(
        dimColor: UIColor(rgb: 0x000000, alpha: 0.6),
        backgroundColor: rootNavigationBar.backgroundColor.withAlphaComponent(0.78),
        itemSeparatorColor: UIColor(rgb: 0xFFFFFF, alpha: 0.15),
        sectionSeparatorColor: UIColor(rgb: 0x000000, alpha: 0.2),
        itemBackgroundColor: UIColor(rgb: 0x000000, alpha: 0.0),
        itemHighlightedBackgroundColor: UIColor(rgb: 0xFFFFFF, alpha: 0.15),
        primaryColor: UIColor(rgb: 0xffffff, alpha: 1.0),
        secondaryColor: UIColor(rgb: 0xffffff, alpha: 0.8),
        destructiveColor: destructiveColor
    )

    let inAppNotification = PresentationThemeInAppNotification(
        fillColor: mainBackgroundColor,
        primaryTextColor: .white,
        expandedNotification: PresentationThemeExpandedNotification(
            backgroundType: .dark,
            navigationBar: PresentationThemeExpandedNotificationNavigationBar(
                backgroundColor: mainBackgroundColor,
                primaryTextColor: UIColor(rgb: 0xffffff),
                controlColor: accentColor,
                separatorColor: mainSeparatorColor
            )
        )
    )

    return PresentationTheme(
        name: .builtin(.nightAccent),
        referenceTheme: .nightAccent,
        overallDarkAppearance: true,
        intro: intro,
        passcode: passcode,
        rootController: rootController,
        list: list,
        chatList: chatList,
        chat: chat,
        actionSheet: actionSheet,
        contextMenu: contextMenu,
        inAppNotification: inAppNotification,
        preview: preview
    )
}

public let defaultDarkAccentColor = UIColor(rgb: 0x2ea6ff)
public let defaultDarkAccentPresentationTheme = makeDarkAccentPresentationTheme(accentColor: UIColor(rgb: 0x2ea6ff), bubbleColors: nil, preview: false)

public func makeDarkAccentPresentationTheme(accentColor: UIColor?, bubbleColors: (UIColor, UIColor?)?, preview: Bool) -> PresentationTheme {
    var accentColor = accentColor ?? defaultDarkAccentColor
    if accentColor == PresentationThemeBaseColor.blue.color {
        accentColor = defaultDarkAccentColor
    }
    return makeDarkPresentationTheme(accentColor: accentColor, bubbleColors: bubbleColors, preview: preview)
}

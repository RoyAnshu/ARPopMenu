# ARPopMenu


A Popup menu, you can customize it according to your use.

# Requirements

1.iOS 9.0+
2.Swift 4.2+
3.Xcode 9.0+

# Installation

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate ARPopMenu into your Xcode project using CocoaPods, specify it in your Podfile:

pod 'ARPopMenu'


# Getting Started

1. Swift
import ARPopMenu

(ARPopUpMenu.shared() as! ARPopUpMenu).show(withOption: ["Test 1","Test 2"], origin: sender.frame.origin, images: nil, backgroundColor: UIColor.green, textColor: UIColor.black, imageColor: nil, isMultiLineTitle: false, isHaveSeparator: true) { (index) in
    // TODO: Any Action
 }

2. Objective c

#import "ARPopMenu.h"

[[ARPopMenu shared] showMenuWithOption:@[@"Test 1", @"Test 2"] origin:sender.frame.origin, images:nil backgroundColor:[UIColor whiteColor] textColor:[UIColor darkGrayColor] imageColor:nil isMultiLineTitle:NO isHaveSeparator:YES WithComptionBlock:^(NSInteger selectedIndex) {
    // TODO: Any Action
 }];

# License

This project is licensed under the MIT License - see the LICENSE file for details

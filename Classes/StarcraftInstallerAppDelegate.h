//
//  StarcraftInstallerAppDelegate.h
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StarcraftInstallerViewController;

@interface StarcraftInstallerAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    StarcraftInstallerViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet StarcraftInstallerViewController *viewController;

@end


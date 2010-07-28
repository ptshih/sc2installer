//
//  StarcraftInstallerViewController.h
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCFinishedViewController;

@interface StarcraftInstallerViewController : UIViewController {
	IBOutlet UIImageView *installerScreen;
	IBOutlet UIImageView *percentBar;
	NSUInteger currentPage;
	NSUInteger percentCounter;
	
	SCFinishedViewController *finishedViewController;
	
	NSTimer *installTimer;
	NSTimer *storyTimer;
}

@property (nonatomic, retain) SCFinishedViewController *finishedViewController;

@property (retain) NSTimer *storyTimer;
@property (retain) NSTimer *installTimer;

- (void)resetState;
- (void)fireStoryTimer;
- (void)finishInstall;
- (IBAction)okCancel;
- (IBAction)back;
- (IBAction)pageLeft;
- (IBAction)pageRight;

@end


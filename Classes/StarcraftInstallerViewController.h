//
//  StarcraftInstallerViewController.h
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@class SCFinishedViewController;

@interface StarcraftInstallerViewController : UIViewController <AVAudioPlayerDelegate> {
	IBOutlet UIImageView *installerScreen;
	IBOutlet UIImageView *percentBar;
	IBOutlet UIImageView *dataBar;
	IBOutlet UIImageView *boxTop;
	IBOutlet UIImageView *boxBottom;
	IBOutlet UIView *installView;
	IBOutlet UITextField *installLocation;
	NSUInteger currentPage;
	NSUInteger percentCounter;
	NSUInteger dataCounter;
	
	SCFinishedViewController *finishedViewController;
	
	NSTimer *installTimer;
	NSTimer *storyTimer;
	NSTimer *dataTimer;
	
	AVAudioPlayer *audioPlayer;
}

@property (nonatomic, retain) SCFinishedViewController *finishedViewController;

@property (retain) NSTimer *storyTimer;
@property (retain) NSTimer *installTimer;
@property (retain) NSTimer *dataTimer;

- (void)splitBox;
- (void)resetState;
- (void)fireStoryTimer;
- (void)finishInstall;
- (IBAction)resignKeyboard;
- (IBAction)okCancel;
- (IBAction)change;
- (IBAction)back;
- (IBAction)pageLeft;
- (IBAction)pageRight;
- (IBAction)beginInstall;

@end


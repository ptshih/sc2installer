//
//  SCFinishedViewController.h
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SCFinishedViewController : UIViewController {
	IBOutlet UIImageView *finishedScreen;
	IBOutlet UIImageView *scvImageView;
	IBOutlet UIView *scvView;
	IBOutlet UIView *endView;
	IBOutlet UILabel *queueLabel;
	IBOutlet UILabel *timeLabel;
	IBOutlet UIButton *finishedButton;
	
	NSInteger queueCounter;
	NSInteger timeCounter;
	
	NSTimer *queueTimer;
}

- (IBAction)finishInstall;
- (IBAction)exit;
- (IBAction)credits;
- (IBAction)sp;
- (IBAction)mp;
- (IBAction)rickRoll;

@end

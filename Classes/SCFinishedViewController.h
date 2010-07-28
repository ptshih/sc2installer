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
	IBOutlet UILabel *queueLabel;
	IBOutlet UILabel *timeLabel;
	
	NSInteger queueCounter;
	NSInteger timeCounter;
	
	NSTimer *queueTimer;
}

- (IBAction)finishInstall;

@end

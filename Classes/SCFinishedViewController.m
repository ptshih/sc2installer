    //
//  SCFinishedViewController.m
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SCFinishedViewController.h"
#import "FlurryAPI.h"

@implementation SCFinishedViewController

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		queueCounter = 1337;
		timeCounter = 13;
    }
    return self;
}

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

- (IBAction)finishInstall {
//	finishedScreen.image = [UIImage imageNamed:@"scv.png"];
	finishedScreen.hidden = YES;
	scvView.hidden = NO;
	
	queueTimer = [NSTimer timerWithTimeInterval:0.05 target:self selector:@selector(queueTick) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:queueTimer forMode:NSDefaultRunLoopMode];
}

- (void)queueTick {
	if(queueCounter == 1) {
		[queueTimer invalidate];
		scvImageView.image = [UIImage imageNamed:@"facepalm.png"];
    [FlurryAPI logEvent:@"facepalm"];
	}
	
	queueCounter--;
	if(queueCounter % 100 == 0) timeCounter--;
	queueLabel.text = [NSString stringWithFormat:@"Position in queue: %d",queueCounter];
	if(timeCounter == 0) {
		timeLabel.text = @"Less than one minute...";
	} else if (timeCounter < 0) {
		timeLabel.text = @"Did you really think you could play StarCraft II on your iPad?";
	} else {
		timeLabel.text = [NSString stringWithFormat:@"Estimated time: %d minutes",timeCounter];
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

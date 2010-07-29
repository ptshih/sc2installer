    //
//  SCFinishedViewController.m
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SCFinishedViewController.h"
#import "FlurryAPI.h"
#import "MovieViewController.h"

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

- (void)animateSC {
	UIImage *sc1 = [UIImage imageNamed:@"sc1.jpg"];
	UIImage *sc2 = [UIImage imageNamed:@"sc2.jpg"];
	UIImage *sc3 = [UIImage imageNamed:@"sc3.jpg"];
	UIImage *sc4 = [UIImage imageNamed:@"sc4.jpg"];
	
	endView.hidden = NO;
	[scvView removeFromSuperview];
	finishedScreen.hidden = NO;
	finishedScreen.contentMode = UIViewContentModeScaleToFill;
	finishedScreen.animationImages = [[[NSArray alloc] initWithObjects:sc1, sc2, sc3, sc4, sc3, sc2, nil] autorelease];
	finishedScreen.animationDuration = 1.25;
	[finishedScreen startAnimating];	
}

- (IBAction)finishInstall {
//	finishedScreen.image = [UIImage imageNamed:@"scv.png"];
	finishedScreen.hidden = YES;
	scvView.hidden = NO;
	endView.hidden = YES;
	finishedButton.hidden = YES;
	
	queueTimer = [NSTimer timerWithTimeInterval:kQueueTimerInterval target:self selector:@selector(queueTick) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:queueTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)exit {
	[FlurryAPI logEvent:@"exit"];
	finishedButton.hidden = NO;
	finishedScreen.hidden = NO;
	scvView.hidden = YES;
	endView.hidden = YES;
	[finishedScreen stopAnimating];
	[self dismissModalViewControllerAnimated:NO];
}
- (IBAction)credits {
	[FlurryAPI logEvent:@"credits"];
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Credits" message:@"We hope you had as much fun using this app as we did making it! Now go and play StarCraft II! Follow us on twitter @orzware for the lulz" delegate:nil cancelButtonTitle:@"Thank You!" otherButtonTitles:nil] autorelease];
	[alertView show];
}
- (IBAction)sp {
	[FlurryAPI logEvent:@"singlePlayer"];
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Epic Fail" message:@"Did you really think you could play StarCraft on your iPad?" delegate:nil cancelButtonTitle:@"Fine, I'll go play FarmVille" otherButtonTitles:nil] autorelease];
	[alertView show];
}
- (IBAction)mp {
	[FlurryAPI logEvent:@"multiPlayer"];
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Epic Fail" message:@"Did you really think you could play StarCraft on your iPad?" delegate:nil cancelButtonTitle:@"Fine, I'll go play FarmVille" otherButtonTitles:nil] autorelease];
	[alertView show];
}

- (IBAction)campaign {
	[FlurryAPI logEvent:@"dota"];
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"DotA" message:@"Vi sitter här i venten och spelar lite DotA." delegate:nil cancelButtonTitle:@"I hear you man" otherButtonTitles:nil] autorelease];
	[alertView show];
}

- (IBAction)rickRoll {
	MovieViewController *mvc = [[MovieViewController alloc] initWithNibName:@"MovieViewController" bundle:nil];
	[self presentModalViewController:mvc animated:YES];
	[mvc release];	
}

- (void)queueTick {
	if(queueCounter == 1) {
		[queueTimer invalidate];
		[self animateSC];
		[FlurryAPI logEvent:@"finishedQueue"];
	} else {
		queueCounter--;
		if(queueCounter % 100 == 0) timeCounter--;
		queueLabel.text = [NSString stringWithFormat:@"Position in queue: %d",queueCounter];
		if(timeCounter == 0) {
			timeLabel.text = @"Less than a minute...";
		} else {
			timeLabel.text = [NSString stringWithFormat:@"Estimated time: %d minutes",timeCounter];
		}
	}
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
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

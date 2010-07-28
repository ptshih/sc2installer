//
//  StarcraftInstallerViewController.m
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "StarcraftInstallerViewController.h"
#import "SCFinishedViewController.h"

@implementation StarcraftInstallerViewController

@synthesize finishedViewController;
@synthesize storyTimer;
@synthesize installTimer;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		currentPage = 0;
		percentCounter = 0;
    }
    return self;
}

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.finishedViewController = [[[SCFinishedViewController alloc] initWithNibName:@"SCFinishedViewController" bundle:nil] autorelease];
}

- (void)resetState {
	currentPage = 0;
	percentCounter = 0;
	if([storyTimer isValid]) [storyTimer invalidate];
	[installTimer invalidate];
}

- (void)percentageTick {
	if(percentCounter == 98) { // finished installation
		[self resetState];
		[self finishInstall];
	} else {
		NSLog(@"tick: %d",percentCounter);
		percentCounter++;
//		percentBar.image = [UIImage imageNamed:[NSString stringWithFormat:@"p-%d.png",percentCounter]];
	}
}

- (void)cancelInstall {
	[self resetState];
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",currentPage]];
}

- (void)startInstall {
	self.installTimer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(percentageTick) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:installTimer forMode:NSDefaultRunLoopMode];
	
	[self fireStoryTimer];
	
	currentPage = 1;
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",currentPage]];
}

- (void)finishInstall {
	[self.view addSubview:finishedViewController.view];
}

- (void)fireStoryTimer {
	if([storyTimer isValid]) [storyTimer invalidate];
	self.storyTimer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(pageRight) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:storyTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)okCancel {
	if(currentPage == 0) { // begin install
		[self startInstall];
	} else { // cancel install
		[self cancelInstall];
	}
}

- (IBAction)back {
	
}

- (IBAction)pageLeft {
	if(currentPage == 1) return; // stop at first story page
	[self fireStoryTimer];
	currentPage--;
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",currentPage]];
}

- (IBAction)pageRight {
	if(currentPage == 22) return; // stop at last story page
	[self fireStoryTimer];
	
	currentPage++;
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",currentPage]];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[finishedViewController release];
	if(installTimer) [installTimer release];
	if(storyTimer) [storyTimer release];
    [super dealloc];
}

@end

//
//  StarcraftInstallerViewController.m
//  StarcraftInstaller
//
//  Created by Peter Shih on 7/27/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "StarcraftInstallerViewController.h"
#import "SCFinishedViewController.h"
#import "FlurryAPI.h"

@implementation StarcraftInstallerViewController

@synthesize finishedViewController;
@synthesize storyTimer;
@synthesize installTimer;
@synthesize dataTimer;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
		currentPage = 0;
		percentCounter = 0;
		dataCounter = 0;
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
	percentBar.hidden = YES;
	dataBar.hidden = YES;

	// Slide the boxes apart
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5]; // animation duration in seconds
//	boxTop.center = CGPointMake(512, -187);
//	boxBottom.center = CGPointMake(512, 935);
	boxTop.center = CGPointMake(512, 354);
	boxBottom.center = CGPointMake(512, 394);
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(boxSplitEnded:finished:context:)];
	[UIView commitAnimations];
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"liftoff" ofType:@"m4a"];  
	AVAudioPlayer* theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];  
	theAudio.delegate = self;  
	[theAudio play];
}

- (void)boxSplitEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	// Slide the boxes apart
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0]; // animation duration in seconds
	boxTop.center = CGPointMake(512, -374);
	boxBottom.center = CGPointMake(512, 1122);
	[UIView commitAnimations];
} 

- (void)resetState {
	currentPage = 0;
	percentCounter = 0;
	dataCounter = 0;
	dataBar.hidden = YES;
	percentBar.hidden = YES;
	installLocation.hidden = NO;
	if([storyTimer isValid]) [storyTimer invalidate];
	[installTimer invalidate];
	[dataTimer invalidate];
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"s%d.jpg",currentPage]];
	percentBar.image = [UIImage imageNamed:@"1.png"];
}

- (void)percentageTick {
	if(percentCounter == 99) { // finished installation
		[self resetState];
		[self finishInstall];
	} else {
		NSLog(@"tick: %d",percentCounter);
		percentCounter++;
		percentBar.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",percentCounter]];
	}
}

- (void)dataTick {
	dataCounter++;
	dataBar.image = [UIImage imageNamed:[NSString stringWithFormat:@"dataticker%03d.jpg",dataCounter]];
}

- (void)cancelInstall {
  [FlurryAPI logEvent:@"cancelInstall"];
	[self resetState];
}

- (void)startInstall {
  [FlurryAPI logEvent:@"startInstall"];
	self.installTimer = [NSTimer timerWithTimeInterval:kInstallTimerInterval target:self selector:@selector(percentageTick) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:installTimer forMode:NSDefaultRunLoopMode];
	self.dataTimer = [NSTimer timerWithTimeInterval:kDataTimerInterval target:self selector:@selector(dataTick) userInfo:nil repeats:YES];
	[[NSRunLoop currentRunLoop] addTimer:dataTimer forMode:NSDefaultRunLoopMode];
	
	[self fireStoryTimer];
	
	currentPage = 1;
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"s%d.jpg",currentPage]];
	percentBar.hidden = NO;
	dataBar.hidden = NO;
	installLocation.hidden = YES;
}

- (void)finishInstall {
	[FlurryAPI logEvent:@"finishInstall"];
	SCFinishedViewController *fvc = [[SCFinishedViewController alloc] initWithNibName:@"SCFinishedViewController" bundle:nil];
	[self presentModalViewController:fvc animated:NO];
	[fvc release];
//	[self.view addSubview:finishedViewController.view];
	percentBar.hidden = YES;
	dataBar.hidden = YES;
}

- (void)fireStoryTimer {
	if([storyTimer isValid]) [storyTimer invalidate];
	self.storyTimer = [NSTimer timerWithTimeInterval:kStoryTimerInterval target:self selector:@selector(pageRight) userInfo:nil repeats:NO];
	[[NSRunLoop currentRunLoop] addTimer:storyTimer forMode:NSDefaultRunLoopMode];
}

- (IBAction)okCancel {
	if(currentPage == 0) { // begin install
		[self startInstall];
	} else { // cancel install
		[self cancelInstall];
	}
}

- (IBAction)change {
	[installLocation becomeFirstResponder];
}

- (IBAction)back {
  [FlurryAPI logEvent:@"farmville"];
	UIAlertView *alertView = [[[UIAlertView alloc] initWithTitle:@"Epic Fail" message:@"StarCraft too hard? Would you like to play FarmVille instead?" delegate:nil cancelButtonTitle:@"OMG I LOVE FARMVILLE" otherButtonTitles:nil] autorelease];
	[alertView show];
}

- (IBAction)resignKeyboard {
	[installLocation resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

- (IBAction)pageLeft {
	if(currentPage == 1) return; // stop at first story page
	[self fireStoryTimer];
	currentPage--;
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"s%d.jpg",currentPage]];
  [FlurryAPI logEvent:@"pageLeft"];
}

- (IBAction)pageRight {
	if(currentPage == 22) return; // stop at last story page
	[self fireStoryTimer];
	
	currentPage++;
	installerScreen.image = [UIImage imageNamed:[NSString stringWithFormat:@"s%d.jpg",currentPage]];
  [FlurryAPI logEvent:@"pageRight"];
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
	if(dataTimer) [dataTimer release];
    [super dealloc];
}

@end

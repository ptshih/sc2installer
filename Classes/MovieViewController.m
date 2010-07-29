    //
//  MovieViewController.m
//  SC2Installer
//
//  Created by Peter Shih on 7/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MovieViewController.h"

@implementation MovieViewController

@synthesize playerViewController;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];

  self.playerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[self movieURL]];
  
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playerReady:) name:MPMoviePlayerLoadStateDidChangeNotification object:[playerViewController moviePlayer]];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:[playerViewController moviePlayer]];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:MPMoviePlayerDidExitFullscreenNotification object:[playerViewController moviePlayer]];
  
  playerViewController.view.frame = self.view.bounds;
  
  [self.view addSubview:playerViewController.view];


}

- (NSURL *)movieURL {

  NSBundle *bundle = [NSBundle mainBundle];
  NSString *moviePath = [bundle pathForResource:@"rickroll" ofType:@"mov"];
  if(moviePath) {
    return [NSURL fileURLWithPath:moviePath];
  } else {
    return nil;
  }
}

- (void)playerReady:(NSNotification *)notification {
	MPMoviePlayerController *player = [notification object];
	if(player.loadState == 3) {
		[player play];
	}
}

- (void)playbackFinished:(NSNotification *)notification {
  MPMoviePlayerController *player = [notification object];
  [player stop];
  [player autorelease];
  [self dismissModalViewControllerAnimated:YES]; 
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
	[playerViewController release];
    [super dealloc];
}


@end

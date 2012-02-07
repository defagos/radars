//
//  ContainerViewController.m
//  ios5-root-container-bug
//
//  Created by Samuel Défago on 07.02.12.
//  Copyright (c) 2012 Samuel Défago. All rights reserved.
//

#import "ContainerViewController.h"

@implementation ContainerViewController

#pragma mark Object creation and destruction

- (void)dealloc
{
    self.bottomViewController = nil;
    self.topViewController = nil;

    [super dealloc];
}

#pragma mark Accessors and mutators

@synthesize bottomViewController = m_bottomViewController;

@synthesize topViewController = m_topViewController;

#pragma mark View lifecycle

- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers
{
    // Disable automatic viewWillAppear: and viewDidAppear: forwarding when child view controller's views
    // are added using addSubview:
    return NO;
}

- (void)loadView
{
    CGRect applicationFrame = [[UIScreen mainScreen] applicationFrame];
    self.view = [[[UIView alloc] initWithFrame:applicationFrame] autorelease];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Display the two child view controllers by adding them as subviews
    [self.view addSubview:self.bottomViewController.view];
    [self.view addSubview:self.topViewController.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Adjust frames (not final in viewDidLoad)
    self.bottomViewController.view.frame = self.view.bounds;
    self.topViewController.view.frame = self.view.bounds;
    
    // Forward viewWillAppear: event to the top view controller only
    [self.topViewController viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // Forward viewDidAppear: event to the top view controller only
    [self.topViewController viewDidAppear:animated];
}

@end

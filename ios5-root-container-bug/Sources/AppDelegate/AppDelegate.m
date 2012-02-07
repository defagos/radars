//
//  AppDelegate.m
//  ios5-root-container-bug
//
//  Created by Samuel Défago on 07.02.12.
//  Copyright (c) 2012 Samuel Défago. All rights reserved.
//

#import "AppDelegate.h"

#import "ContainerViewController.h"
#import "ViewController.h"

@implementation AppDelegate

#pragma mark Object creation and destruction

- (void)dealloc
{
    self.window = nil;
    
    [super dealloc];
}

#pragma mark Accessors and mutators

@synthesize window = m_window;

#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    
    // Create and display the container
    ContainerViewController *containerViewController = [[[ContainerViewController alloc] init] autorelease];
    containerViewController.bottomViewController = [[[ViewController alloc] initWithName:@"Bottom"] autorelease];
    containerViewController.topViewController = [[[ViewController alloc] initWithName:@"Top"] autorelease];
    self.window.rootViewController = containerViewController;
    
    return YES;
}

@end

//
//  AppDelegate.m
//  DVRInfoPanel
//
//  Created by Samuel Défago on 18.05.20.
//  Copyright © 2020 SRG SSR. All rights reserved.
//

#import "AppDelegate.h"

#import <AVKit/AVKit.h>

@interface AppDelegate () <AVPlayerViewControllerDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary<UIApplicationLaunchOptionsKey,id> *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window makeKeyAndVisible];
    
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    playerViewController.delegate = self;
    
    // If playing a DVR livestream, the info panel incorrectly periodically resets the scroll position (probably with each
    // player item time loaded time range update). This should not be the case, as it conflicts with user interactions.
    // There is no such problem if playing an on-demand stream.
    NSURL *URL = [NSURL URLWithString:@"https://mcdn.daserste.de/daserste/int/master.m3u8"];
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:URL];
    playerItem.navigationMarkerGroups = [self navigationMarkerGroups];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    playerViewController.player = player;
    [player play];
    
    self.window.rootViewController = playerViewController;
    return YES;
}

- (NSArray<AVNavigationMarkersGroup *> *)navigationMarkerGroups
{
    NSMutableArray<AVTimedMetadataGroup *> *navigationMarkers = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < 10; ++i) {
        AVMutableMetadataItem *titleItem = [[AVMutableMetadataItem alloc] init];
        titleItem.identifier = AVMetadataCommonIdentifierTitle;
        titleItem.value = [NSString stringWithFormat:@"Sequence %@", @(i + 1)];
        titleItem.extendedLanguageTag = @"und";
        
        CMTimeRange timeRange = CMTimeRangeMake(CMTimeMakeWithSeconds(10 * i, NSEC_PER_SEC), CMTimeMakeWithSeconds(10., NSEC_PER_SEC));
        AVTimedMetadataGroup *navigationMarker = [[AVTimedMetadataGroup alloc] initWithItems:@[ titleItem.copy ] timeRange:timeRange];
        [navigationMarkers addObject:navigationMarker];
    }
    
    AVNavigationMarkersGroup *navigationMarkerGroup = [[AVNavigationMarkersGroup alloc] initWithTitle:nil timedNavigationMarkers:navigationMarkers.copy];
    return @[ navigationMarkerGroup ];
}

@end

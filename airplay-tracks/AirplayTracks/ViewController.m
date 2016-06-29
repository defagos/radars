//
//  ViewController.m
//  AirplayTracks
//
//  Created by Samuel Défago on 29/06/16.
//  Copyright © 2016 Samuel Défago. All rights reserved.
//

#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation ViewController

- (IBAction)playVideo:(id)sender
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    NSURL *URL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    playerViewController.player = [AVPlayer playerWithURL:URL];
    [self presentViewController:playerViewController animated:YES completion:^{
        [playerViewController.player play];
    }];
    
    __weak __typeof(playerViewController) weakPlayerViewController = playerViewController;
    
    // Periodically display the tracks during playback. Consider the following use cases:
    // 1) Airplay is enabled after playback has started. In this case, tracks are available
    // 2) Airplay was enabled before playback starts. In this case, the tracks array is empty
    [playerViewController.player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1., 1.) queue:NULL usingBlock:^(CMTime time) {
        NSLog(@"Tracks: %@", weakPlayerViewController.player.currentItem.tracks);
    }];
}

@end

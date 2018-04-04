
#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation ViewController

- (IBAction)playOnDemand:(id)sender
{
    NSURL *URL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    [self playURL:URL];
}

- (IBAction)playLivestream:(id)sender
{
    NSURL *URL = [NSURL URLWithString:@"http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8?dw=0"];
    [self playURL:URL];
}

- (IBAction)playDVRLivestream:(id)sender
{
    NSURL *URL = [NSURL URLWithString:@"http://tagesschau-lh.akamaihd.net/i/tagesschau_1@119231/master.m3u8"];
    [self playURL:URL];
}

- (void)playURL:(NSURL *)URL
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    playerViewController.player = player;
    
    __weak __typeof(player) weakPlayer = player;
    [player addPeriodicTimeObserverForInterval:CMTimeMakeWithSeconds(1., NSEC_PER_SEC) queue:NULL usingBlock:^(CMTime time) {
        AVPlayerItem *playerItem = weakPlayer.currentItem;
        NSLog(@"Seekable: %@; loaded: %@)", playerItem.seekableTimeRanges.firstObject, playerItem.loadedTimeRanges.firstObject);
    }];
    
    [self presentViewController:playerViewController animated:YES completion:^{
        [player play];
    }];
}

@end


#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

static void *s_kvoContext = &s_kvoContext;

@implementation ViewController

- (IBAction)playVideo:(id)sender
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    NSURL *URL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    playerViewController.player = [AVPlayer playerWithURL:URL];
    
    // Not clean, but only for demo purposes. The player will crash on close, but I wanted to keep this code simple
    [playerViewController.player addObserver:self forKeyPath:@"rate" options:0 context:s_kvoContext];
    
    [self presentViewController:playerViewController animated:YES completion:^{
        [playerViewController.player play];
    }];
}

- (IBAction)playVideoSeveralRateChanges:(id)sender
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    NSURL *URL = [NSURL URLWithString:@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8"];
    playerViewController.player = [AVPlayer playerWithURL:URL];
    
    // Not clean, but only for demo purposes. The player will crash on close, but I wanted to keep this code simple
    [playerViewController.player addObserver:self forKeyPath:@"rate" options:0 context:s_kvoContext];
    
    [self presentViewController:playerViewController animated:YES completion:^{
        [playerViewController.player play];
        [playerViewController.player pause];
        [playerViewController.player play];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if (context == s_kvoContext && [keyPath isEqualToString:@"rate"]) {
        NSLog(@"Rate changed to %@", @([object rate]));
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end

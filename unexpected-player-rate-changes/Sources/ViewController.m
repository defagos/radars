
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
}

@end

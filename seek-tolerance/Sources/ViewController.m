
#import "ViewController.h"

#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@implementation ViewController

- (IBAction)playPreciselyAtTime
{
    // According to the documentation (https://developer.apple.com/documentation/avfoundation/avplayer/1387741-seektotime?language=objc), using
    // kCMTimeZero for both tolerances provides for exact seeking. This is actually the case, as this example confirms.
    [self playAtTime:CMTimeMakeWithSeconds(219., NSEC_PER_SEC) withToleranceBefore:kCMTimeZero toleranceAfter:kCMTimeZero];
}

- (IBAction)playAtTimeWithToleranceBefore
{
    // According to the documentation (https://developer.apple.com/documentation/avfoundation/avplayer/1387741-seektotime?language=objc), using
    // a tolerance of "1 second before" should let the player optimize seeking by choosing a position in [218; 219]. This example shows that this
    // does not work as documented, though, since playback starts at 210, outside this range.
    [self playAtTime:CMTimeMakeWithSeconds(219., NSEC_PER_SEC) withToleranceBefore:CMTimeMakeWithSeconds(1., NSEC_PER_SEC) toleranceAfter:kCMTimeZero];
}

- (IBAction)playAtTimeWithToleranceAfter
{
    // According to the documentation (https://developer.apple.com/documentation/avfoundation/avplayer/1387741-seektotime?language=objc), using
    // a tolerance of "1 second after" should let the player optimize seeking by choosing a position in [215; 216]. This example shows that this
    // does not work as documented, though, since playback starts at 210, outside this range.
    [self playAtTime:CMTimeMakeWithSeconds(215., NSEC_PER_SEC) withToleranceBefore:kCMTimeZero toleranceAfter:CMTimeMakeWithSeconds(1., NSEC_PER_SEC)];
}

- (void)playAtTime:(CMTime)time withToleranceBefore:(CMTime)toleranceBefore toleranceAfter:(CMTime)toleranceAfter
{
    AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
    NSURL *URL = [NSURL URLWithString:@"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
    AVPlayer *player = [AVPlayer playerWithURL:URL];
    playerViewController.player = player;
    [self presentViewController:playerViewController animated:YES completion:^{
        [player seekToTime:time toleranceBefore:toleranceBefore toleranceAfter:toleranceAfter completionHandler:^(BOOL finished) {
            [player play];
        }];
    }];
}

@end

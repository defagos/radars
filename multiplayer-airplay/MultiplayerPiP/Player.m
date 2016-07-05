//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "Player.h"

#import "PlayerViewController.h"

static void *s_kvoContext = &s_kvoContext;

@interface Player ()

@property (nonatomic) AVPlayer *player;

@end

@implementation Player

#pragma mark Class methods

+ (void)initialize
{
    if (self != [Player class]) {
        return;
    }
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
}

+ (Player *)sharedPlayer
{
    static Player *s_player = nil;
    static dispatch_once_t s_onceToken;
    dispatch_once(&s_onceToken, ^{
        s_player = [[Player alloc] init];
        s_player.allowsExternalPlayback = YES;
    });
    return s_player;
}

#pragma mark Getters and setters

@synthesize view = _view;
@synthesize allowsExternalPlayback = _allowsExternalPlayback;
@synthesize muted = _muted;

- (PlayerView *)view
{
    if (! _view) {
        _view = [[PlayerView alloc] init];
    }
    return _view;
}

- (void)setPlayer:(AVPlayer *)player
{
    _player = player;
    self.view.playerLayer.player = player;
}

- (BOOL)allowsExternalPlayback
{
    return _allowsExternalPlayback;
}

- (void)setMuted:(BOOL)muted
{
    _muted = muted;
    self.view.playerLayer.player.muted = muted;
}

- (BOOL)isMuted
{
    return _muted;
}

#pragma mark Playback control

- (void)playURL:(NSURL *)URL
{
    NSParameterAssert(URL);
    
    self.player = [AVPlayer playerWithURL:URL];
    self.player.allowsExternalPlayback = self.allowsExternalPlayback;
    self.player.muted = self.muted;
}

@end

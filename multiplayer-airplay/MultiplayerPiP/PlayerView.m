//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "PlayerView.h"

#import "Player.h"

@implementation PlayerView

+ (Class)layerClass
{
	return [AVPlayerLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(play:)];
        [self addGestureRecognizer:tapGestureRecognizer];
    }
    return self;
}

- (AVPlayerLayer *)playerLayer
{
	return (AVPlayerLayer *)self.layer;
}

- (void)play:(id)sender
{
    [self.playerLayer.player play];
}

@end

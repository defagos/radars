//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "PlayerView.h"

#import <AVKit/AVKit.h>
#import <Foundation/Foundation.h>

@interface Player : NSObject

- (void)playURL:(NSURL *)URL;

@property (nonatomic) BOOL allowsExternalPlayback;
@property (nonatomic, getter=isMuted) BOOL muted;

@property (nonatomic, readonly) PlayerView *view;

@end

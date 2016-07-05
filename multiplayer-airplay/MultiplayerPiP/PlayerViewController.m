//
//  Copyright (c) Samuel Défago. All rights reserved.
//
//  License information is available from the LICENSE file.
//

#import "PlayerViewController.h"

#import "Player.h"

@interface PlayerViewController ()

@property (nonatomic, strong) Player *smallPlayer1;
@property (nonatomic, strong) Player *smallPlayer2;

@property (nonatomic, weak) IBOutlet UIView *smallPlayer1View;
@property (nonatomic, weak) IBOutlet UIView *smallPlayer2View;

@end

@implementation PlayerViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.smallPlayer1 = [[Player alloc] init];
        self.smallPlayer1.allowsExternalPlayback = YES;
        self.smallPlayer1.muted = NO;
        
        self.smallPlayer2 = [[Player alloc] init];
        self.smallPlayer2.allowsExternalPlayback = NO;
        self.smallPlayer2.muted = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [PlayerViewController addPlayer:self.smallPlayer1 toView:self.smallPlayer1View];
    [PlayerViewController addPlayer:self.smallPlayer2 toView:self.smallPlayer2View];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Close", nil)
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(close:)];
}

+ (void)addPlayer:(Player *)player toView:(UIView *)view
{
    if (player.view.superview) {
        return;
    }
    
    player.view.translatesAutoresizingMaskIntoConstraints = YES;
    player.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    player.view.frame = view.bounds;
    [view addSubview:player.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([self.navigationController isMovingToParentViewController] || [self.navigationController isBeingPresented]) {
        NSURL *smallURL1 = [NSURL URLWithString:@"https://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
        [self.smallPlayer1 playURL:smallURL1];
        
        NSURL *smallURL2 = [NSURL URLWithString:@"http://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_640x360.m4v"];
        [self.smallPlayer2 playURL:smallURL2];
    }
}

- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

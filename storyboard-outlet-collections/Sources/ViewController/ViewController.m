//
//  ViewController.m
//  storyboard-outlet-collections
//
//  Created by Samuel Défago on 8/28/12.
//  Copyright (c) 2012 Hortis. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UILabel *firstLabel = [self.labels objectAtIndex:0];
    NSLog(@"First label in the IBOutletCollection: %@", firstLabel.text);
    
    UILabel *secondLabel = [self.labels objectAtIndex:1];
    NSLog(@"Second label in the IBOutletCollection: %@", secondLabel.text);
}

@end

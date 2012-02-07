//
//  ViewController.m
//  ios5-root-container-bug
//
//  Created by Samuel Défago on 07.02.12.
//  Copyright (c) 2012 Samuel Défago. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, retain) NSString *name;

@end

@implementation ViewController

#pragma mark Object creation and destruction

- (id)initWithName:(NSString *)name
{
    if ((self = [super init])) {
        self.name = name;
    }
    return self;
}

- (void)dealloc
{
    self.name = nil;
    self.nameLabel = nil;
    
    [super dealloc];
}

#pragma mark Accessors and mutators

@synthesize name = m_name;

@synthesize nameLabel = m_nameLabel;

#pragma mark View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameLabel.text = self.name;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"View will appear for %@; call stack: %@", self.name, [NSThread callStackSymbols]);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    NSLog(@"View did appear for %@; call stack: %@", self.name, [NSThread callStackSymbols]);
}

@end

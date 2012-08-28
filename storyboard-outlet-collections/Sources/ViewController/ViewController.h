//
//  ViewController.h
//  storyboard-outlet-collections
//
//  Created by Samuel Défago on 8/28/12.
//  Copyright (c) 2012 Hortis. All rights reserved.
//

@interface ViewController : UIViewController

@property (nonatomic, strong) IBOutletCollection(UILabel) NSArray *labels;

@end

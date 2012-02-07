//
//  ViewController.h
//  ios5-root-container-bug
//
//  Created by Samuel Défago on 07.02.12.
//  Copyright (c) 2012 Samuel Défago. All rights reserved.
//

/**
 * Test view controller. Has a name which is displayed on its view and used when logging view lifecycle events
 */
@interface ViewController : UIViewController {
@private
    NSString *m_name;
    UILabel *m_nameLabel;
}

- (id)initWithName:(NSString *)name;

@property (nonatomic, retain) IBOutlet UILabel *nameLabel;

@end


#import "PrototypeCell.h"

@implementation PrototypeCell

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    
    // Display constraints. An identifier beginning with "debug_" has been set in the storyboard for those constraints
    // which might not be installed depending on the size class. To keep log entries minimal, those are the only ones we log below
    NSLog(@"Constraints for prototype table cell:");
    for (NSLayoutConstraint *layoutConstraint in self.contentView.constraints) {
        if (! [layoutConstraint.identifier hasPrefix:@"debug_"]) {
            continue;
        }
        
        NSLog(@"  > identifier: %@, active: %@", layoutConstraint.identifier, layoutConstraint.active ? @"YES" : @"NO");
    }
}

@end

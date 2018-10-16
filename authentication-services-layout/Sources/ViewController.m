
#import "ViewController.h"

#import <AuthenticationServices/AuthenticationServices.h>

@interface ViewController ()

@property (nonatomic) ASWebAuthenticationSession *authenticationSession;

@end

@implementation ViewController

- (IBAction)authenticate:(id)sender
{
    NSURL *URL = [NSURL URLWithString:@"https://appleid.apple.com"];
    self.authenticationSession = [[ASWebAuthenticationSession alloc] initWithURL:URL callbackURLScheme:@"callback" completionHandler:^(NSURL * _Nullable callbackURL, NSError * _Nullable error) {
        // ...
    }];
    [self.authenticationSession start];
}

@end

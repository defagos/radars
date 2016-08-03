
#import "TableViewController.h"

#import "XibCell.h"

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"XibCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"XibCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return [tableView dequeueReusableCellWithIdentifier:@"PrototypeCell"];
    }
    else {
        return [tableView dequeueReusableCellWithIdentifier:@"XibCell"];
    }
}

@end

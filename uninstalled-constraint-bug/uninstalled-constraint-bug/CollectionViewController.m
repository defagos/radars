
#import "CollectionViewController.h"

#import "XibCollectionCell.h"

@implementation CollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *nib = [UINib nibWithNibName:@"XibCollectionCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"XibCollectionCell"];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [collectionView dequeueReusableCellWithReuseIdentifier:@"XibCollectionCell" forIndexPath:indexPath];
}

@end

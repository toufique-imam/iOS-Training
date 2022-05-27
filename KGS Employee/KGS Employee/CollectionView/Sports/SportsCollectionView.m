//
//  SportsCollectionView.m
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

#import "SportsCollectionView.h"

@interface SportsCollectionView ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout
>
@end

@implementation SportsCollectionView
-(void)awakeFromNib {
    [super awakeFromNib];
    self.cellId = @"SportsCollectionViewCell";
    self.descriptionData = [NSArray arrayWithObjects:@"KGS Sports Tournament",@"Fifa_20_logo",@"Table_tennis_logo","DART Tournament", nil];
    self.imageData = [NSArray arrayWithObjects:@"KGS_Sports_logo",@"FIFA 20 Tournament",@"Table Tennis Tournament","Dart_logo", nil];
    self.itemPerRow = 2;
    self.sectionInsets = UIEdgeInsetsMake(26, 26, 26, 26);
    UINib *nibCell = [UINib nibWithNibName:self.cellId bundle:nil];
    [self registerNib:nibCell forCellWithReuseIdentifier:self.cellId];
}
-(void) initialize {
    self.delegate = self;
    self.dataSource = self;
//    self.reloadData();
}



- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SportsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellId forIndexPath:indexPath];
    
    [cell loadCellnamed:self.cellId title:self.cellId];

    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageData.count;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.sectionInsets->left;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.sectionInsets->bottom;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return *(self.sectionInsets);
}

@end


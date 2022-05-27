//
//  SportsCollectionViewCell.m
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

#import "SportsCollectionViewCell.h"

@implementation SportsCollectionViewCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)loadCellnamed:(NSString*)imageName title:(NSString*)title{
    self.imageView.image = [UIImage imageNamed:imageName];
    self.labelSports.text = title;
}

@end

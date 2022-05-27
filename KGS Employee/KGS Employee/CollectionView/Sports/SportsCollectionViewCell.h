//
//  SportsCollectionViewCell.h
//  KGS Employee
//
//  Created by Nuhash on 5/26/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SportsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *labelSports;


- (void)loadCellnamed:(NSString*)imageName title:(NSString*)title;
@end

NS_ASSUME_NONNULL_END

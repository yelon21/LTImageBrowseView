//
//  LTBrowseImageCell.h
//  Pods
//
//  Created by yelon on 16/8/4.
//
//

#import <UIKit/UIKit.h>

@interface LTBrowseImageCell : UICollectionViewCell

@property (strong, nonatomic,readonly) UIImageView *lt_imageView;

@property(nonatomic) CGFloat minimumZoomScale;
@property(nonatomic) CGFloat maximumZoomScale;
@property(nonatomic) BOOL zoomAble;
@end

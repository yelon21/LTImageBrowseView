//
//  LTImageBrowseView.h
//  Pods
//
//  Created by yelon on 16/8/4.
//
//

#import <UIKit/UIKit.h>

#import "LTBrowseImageCell.h"

@class LTImageBrowseView;

@protocol LTImageBrowseViewDelegate <NSObject>

- (NSInteger)lt_ImageBrowseViewNumberOfItems;
- (void)lt_ImageBrowseView:(LTImageBrowseView *)imageBrowseView
                    ltCell:(LTBrowseImageCell *)cell
                   atIndex:(NSInteger)index;
@optional
- (void)lt_ImageBrowseView:(LTImageBrowseView *)imageBrowseView
          didScrollToIndex:(NSInteger)index;
@end

@interface LTImageBrowseView : UIView

@property(nonatomic,assign) id<LTImageBrowseViewDelegate>ltDelegate;
@property(nonatomic,assign,readonly) NSUInteger numberOfItems;
@property(nonatomic,assign,readonly) NSUInteger currentIndex;
@property(nonatomic,assign) NSUInteger defaultIndex;
- (void)lt_reloadData;
@end

//
//  LYViewController.m
//  LTImageBrowseView
//
//  Created by yelon21 on 08/04/2016.
//  Copyright (c) 2016 yelon21. All rights reserved.
//

#import "LYViewController.h"
#import <LTImageBrowseView/LTImageBrowseView.h>
#import "UIImageView+WebCache.h"

@interface LYViewController ()<LTImageBrowseViewDelegate>{

    NSArray *listArray;
}

@end

@implementation LYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    listArray = @[@"http://www.pptbz.com/pptpic/UploadFiles_6909/201110/20111014111307895.jpg",
                  @"http://scimg.jb51.net/allimg/160618/77-16061Q44U6444.jpg",
                  @"http://img10.3lian.com/c1/newpic/10/08/04.jpg",
                  @"http://www.pptbz.com/pptpic/UploadFiles_6909/201110/20111014111307895.jpg",
                  @"http://scimg.jb51.net/allimg/160618/77-16061Q44U6444.jpg",
                  @"http://img10.3lian.com/c1/newpic/10/08/04.jpg"];
    
    UIView *superV = self.view;
    
    LTImageBrowseView *ltImageBrowseView = [[LTImageBrowseView alloc]initWithFrame:self.view.bounds];
    ltImageBrowseView.ltDelegate = self;
    [superV addSubview:ltImageBrowseView];
    
    ltImageBrowseView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:ltImageBrowseView
                                                       attribute:NSLayoutAttributeTop
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeTop
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:ltImageBrowseView
                                                       attribute:NSLayoutAttributeLeft
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeLeft
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:ltImageBrowseView
                                                       attribute:NSLayoutAttributeBottom
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeBottom
                                                      multiplier:1.0
                                                        constant:0.0]];
    
    [superV addConstraint:[NSLayoutConstraint constraintWithItem:ltImageBrowseView
                                                       attribute:NSLayoutAttributeRight
                                                       relatedBy:NSLayoutRelationEqual
                                                          toItem:superV
                                                       attribute:NSLayoutAttributeRight
                                                      multiplier:1.0
                                                        constant:0.0]];
}

- (NSInteger)lt_ImageBrowseViewNumberOfItems{

    return [listArray count];
}

- (void)lt_ImageBrowseView:(LTImageBrowseView *)imageBrowseView
                    ltCell:(LTBrowseImageCell *)cell
                   atIndex:(NSInteger)index{

    NSLog(@"index=%@",@(index));
    
    cell.maximumZoomScale = 10.0;
    cell.zoomAble = index%2==0;
    cell.contentView.backgroundColor = [UIColor colorWithRed:(arc4random()%100)/100.0
                                                       green:(arc4random()%100)/100.0
                                                        blue:(arc4random()%100)/100.0
                                                       alpha:1.0];
    NSString *urlStr = listArray[index];
    NSURL *url = [NSURL URLWithString:urlStr];
    [cell.lt_imageView sd_setImageWithURL:url
                         placeholderImage:nil];
}

- (void)lt_ImageBrowseView:(LTImageBrowseView *)imageBrowseView
          didScrollToIndex:(NSInteger)index{

    NSLog(@"title = %@/%@",@(index+1),@([listArray count]));
}
@end

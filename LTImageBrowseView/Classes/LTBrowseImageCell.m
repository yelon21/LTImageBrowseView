//
//  LTBrowseImageCell.m
//  Pods
//
//  Created by yelon on 16/8/4.
//
//

#import "LTBrowseImageCell.h"

@interface LTBrowseImageCell ()<UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic,readwrite) UIImageView *lt_imageView;
@end

@implementation LTBrowseImageCell
@synthesize minimumZoomScale = _minimumZoomScale;
@synthesize maximumZoomScale = _maximumZoomScale;

- (void)prepareForReuse{
    
    self.scrollView.zoomScale = 1.0;
    self.minimumZoomScale = self.minimumZoomScale;
    self.maximumZoomScale = self.maximumZoomScale;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

-(void)awakeFromNib{
    
    [self setup];
}

- (void)setup {

    UIView *superView = self.contentView;
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = self.minimumZoomScale;
    self.scrollView.maximumZoomScale = self.maximumZoomScale;
    
    [superView addSubview:self.scrollView];
    
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    
    {
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superView addConstraint:[NSLayoutConstraint constraintWithItem:self.scrollView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superView
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
    }
    
    self.lt_imageView = [[UIImageView alloc]init];
    
    UIView *superV = self.scrollView;
    [superV addSubview:self.lt_imageView];
    self.lt_imageView.translatesAutoresizingMaskIntoConstraints = NO;

    {
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.lt_imageView
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superV
                                                              attribute:NSLayoutAttributeTop
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.lt_imageView
                                                              attribute:NSLayoutAttributeLeft
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superV
                                                              attribute:NSLayoutAttributeLeft
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.lt_imageView
                                                              attribute:NSLayoutAttributeBottom
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superV
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.lt_imageView
                                                              attribute:NSLayoutAttributeRight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:superV
                                                              attribute:NSLayoutAttributeRight
                                                             multiplier:1.0
                                                               constant:0.0]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.lt_imageView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:superV
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1.0
                                                            constant:0.0]];
        
        [superV addConstraint:[NSLayoutConstraint constraintWithItem:self.lt_imageView
                                                           attribute:NSLayoutAttributeWidth
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:superV
                                                           attribute:NSLayoutAttributeWidth
                                                          multiplier:1.0
                                                            constant:0.0]];
    }
}

-(void)setMinimumZoomScale:(CGFloat)minimumZoomScale{

    _minimumZoomScale = minimumZoomScale;
    self.scrollView.minimumZoomScale = _minimumZoomScale;
}

-(CGFloat)minimumZoomScale{

    if (_minimumZoomScale == 0.0) {
        _minimumZoomScale = 1.0;
    }
    return _minimumZoomScale;
}

-(void)setMaximumZoomScale:(CGFloat)maximumZoomScale{

    _maximumZoomScale = maximumZoomScale;
    self.scrollView.maximumZoomScale = _maximumZoomScale;
}

-(CGFloat)maximumZoomScale{

    if (_maximumZoomScale == 0.0) {
        
        _maximumZoomScale = 3.0;
    }
    return _maximumZoomScale;
}

#pragma mark UIScrollViewDelegate

- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    if (self.zoomAble) {
        
        return self.lt_imageView;
    }
    return nil;
}
//- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view{}
//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{}

//- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{}
//- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{}

@end

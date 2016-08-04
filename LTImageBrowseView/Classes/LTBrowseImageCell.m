//
//  LTBrowseImageCell.m
//  Pods
//
//  Created by yelon on 16/8/4.
//
//

#import "LTBrowseImageCell.h"

@interface LTBrowseImageCell ()<UIScrollViewDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation LTBrowseImageCell
@synthesize minimumZoomScale = _minimumZoomScale;
@synthesize maximumZoomScale = _maximumZoomScale;

-(void)prepareForReuse{

    self.scrollView.zoomScale = 1.0;
    self.minimumZoomScale = 1.0;
    self.maximumZoomScale = 1.0;
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

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.scrollView.minimumZoomScale = self.minimumZoomScale;
    self.scrollView.maximumZoomScale = self.maximumZoomScale;
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

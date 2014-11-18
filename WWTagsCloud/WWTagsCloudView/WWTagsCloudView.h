//
//  WWScrollTagsCloud.h
//  ScrollTagsCloud
//
//  Created by 张正超 on 14-7-24.
//  Copyright (c) 2014年 张正超. All rights reserved.
//

@protocol WWTagsCloudViewDelegate <NSObject>
@optional
-(void)tagClickAtIndex:(NSInteger)tagIndex;
@end

#import <UIKit/UIKit.h>
@interface WWTagsCloudView : UIView
@property (strong, nonatomic) id<WWTagsCloudViewDelegate> delegate;
-(id)initWithFrame:(CGRect)frame andTags:(NSArray*)tags andTagColors:(NSArray*)tagColors andFonts:(NSArray*)fonts andParallaxRate:(CGFloat)parallaxRate andNumOfLine:(NSInteger)lineNum;
-(void)reloadAllTags;
@end

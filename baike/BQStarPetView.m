//
//  BQStarPetView.m
//  boqiimall
//
//  Created by 张正超 on 14/11/18.
//  Copyright (c) 2014年 Boqii.com. All rights reserved.
//

#import "BQStarPetView.h"
#import "UIImage+ImageUtil.h"

#define color(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define color_grayGreenBack  color(247,246,236)
#define color_view  color(157,195,41)
#define color_text  color(91,91,91)

@interface BQStarPetView ()
{
    NSDictionary *viewDict;
    UIImageView*_avatarImageView;
}

@end

@implementation BQStarPetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _avatarImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _avatarImageView.translatesAutoresizingMaskIntoConstraints=NO;
//        _avatarImageView.backgroundColor = [UIColor redColor];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
//        _nameLabel.backgroundColor = [UIColor greenColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = color_text;
        _nameLabel.font = defFont12;
        _nameLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [self addSubview:_avatarImageView];
        [self addSubview:_nameLabel];
        
        viewDict = NSDictionaryOfVariableBindings(_avatarImageView,_nameLabel);
        
    }
    return self;
}


- (void)layoutSubviews{

    NSString *vhl2 = @"H:|[_nameLabel]|";
    NSString *vhl3 = @"V:|[_avatarImageView]-[_nameLabel]|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vhl2 options:0 metrics:nil views:viewDict]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vhl3 options:0 metrics:nil views:viewDict]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_nameLabel attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_avatarImageView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_avatarImageView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_avatarImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.7 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_nameLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0.2 constant:0]];
    
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
    _avatarImageView.image = [_image roundedCornerImage:230 borderSize:1];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_delegate && [_delegate respondsToSelector:_selector]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [_delegate performSelector:_selector withObject:_paramsObject];
#pragma clang diagnostic pop
   
    }
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

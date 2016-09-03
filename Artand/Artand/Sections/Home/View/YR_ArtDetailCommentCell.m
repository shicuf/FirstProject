//
//  YR_ArtDetailCommentCell.m
//  Artand
//
//  Created by Dendi on 9/3/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_ArtDetailCommentCell.h"

@interface YR_ArtDetailCommentCell () <UITextViewDelegate>

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation YR_ArtDetailCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    
    self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 8, self.bounds.size.width - 10, 17)];
    self.placeholderLabel.text = @"我也来说两句...";
    self.placeholderLabel.enabled = NO;
    self.placeholderLabel.font = [UIFont systemFontOfSize:14];
    self.placeholderLabel.backgroundColor = [UIColor clearColor];
    self.placeholderLabel.textColor = [UIColor lightGrayColor];
    [self.commentTextView addSubview:self.placeholderLabel];
    
    self.commentTextView.delegate = self;
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (self.commentTextView.text.length == 0) {
        self.placeholderLabel.text = @"我也来说两句...";
    } else {
        self.placeholderLabel.text = @"";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

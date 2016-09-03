//
//  YR_BaseTableViewCell.m
//  Artand
//
//  Created by Dendi on 8/27/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_BaseTableViewCell.h"

@implementation YR_BaseTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
        
        
    }
    return self;
}

- (void)setup {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor whiteColor];
}

@end

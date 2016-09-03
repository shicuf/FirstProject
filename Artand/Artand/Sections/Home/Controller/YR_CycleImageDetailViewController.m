//
//  YR_CycleImageDetailViewController.m
//  Artand
//
//  Created by Dendi on 9/1/16.
//  Copyright © 2016 kaleidoscope. All rights reserved.
//

#import "YR_CycleImageDetailViewController.h"

@interface YR_CycleImageDetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@end

@implementation YR_CycleImageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text = self.titleStr;
    [self.detailWebView loadRequest:[NSURLRequest requestWithURL:self.detailUrl]];
}

- (IBAction)popAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end

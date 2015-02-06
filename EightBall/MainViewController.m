//
//  MainViewController.m
//  EightBall
//
//  Created by Екатерина Колесникова on 06.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "MainViewController.h"
#import "SettingsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"8-ball";
    self.answerLabel.text = @"Shake me!";

    self.answerView.layer.cornerRadius = 100;
    self.answerView.clipsToBounds = YES;

    [self.answerBkgImageView setFrame:CGRectMake(260, 340, 0, 0)];
    [self.answerBkgImageView setAlpha:0];

    [self.view setUserInteractionEnabled:NO];
    [self.answerLabel setAlpha:0];

    [UIView animateWithDuration:2
                     animations:^{
                         [self.answerBkgImageView setFrame:CGRectMake(140, 340, 120, 120)];
                         [self.answerBkgImageView setAlpha:1];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:2
                                          animations:^{
                                              [self.answerLabel setAlpha:1];
                                          }
                                          completion:^(BOOL finished){
                                              [self.view setUserInteractionEnabled:YES];
                                          }];
                     }];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clickSettingsButton:(id)sender {
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController" bundle:nil];
    [self.navigationController pushViewController:settingsViewController animated:YES];
}

@end

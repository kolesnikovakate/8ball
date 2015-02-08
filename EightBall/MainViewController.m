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

@implementation MainViewController {
    CGRect answerViewFrame_;
    CGRect answerViewFrameDisappeared_;
    BOOL isFirstLaunch_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"8-ball";
    isFirstLaunch_ = YES;

}

- (BOOL)canBecomeFirstResponder {
    return YES;
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //CGRect frame = self.view.frame;
    answerViewFrame_ = self.answerBkgImageView.frame;
    CGPoint center = self.answerBkgImageView.center;
    answerViewFrameDisappeared_ = CGRectMake(center.x, center.y, 0, 0);
    [self updateViewConstraints];
}

- (void)updateViewConstraints
{
    if (self.view.superview != nil && [[self.view.superview constraints] count] == 0) {
        [self.answerLabelYConstraint setConstant:answerViewFrame_.origin.y + 15.f];
    }
    [super updateViewConstraints];
}

- (void)motionBegan:(UIEventSubtype)motion
          withEvent:(UIEvent *)event {

    // Play a sound whenever a shake motion starts
    if (motion != UIEventSubtypeMotionShake) return;
    [self answerReappearWithText:@"YES"];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    // Play a sound whenever a shake motion ends
    if (motion != UIEventSubtypeMotionShake) return;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    if (isFirstLaunch_) {
        [self.answerBkgImageView setFrame:answerViewFrameDisappeared_];
        self.answerLabel.hidden = NO;
        self.answerBkgImageView.hidden = NO;
        isFirstLaunch_ = NO;
    }
    [self firstAnswerAppearWithText:@"Shake me!"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

- (void)firstAnswerAppearWithText:(NSString *)text
{
    [self.answerLabel setAlpha:0];
    [UIView animateWithDuration:2
                     animations:^{
                         self.answerLabel.text = text;
                         [self.answerBkgImageView setFrame:answerViewFrame_];
                         [self.answerLabel setAlpha:1];
                     }
                     completion:^(BOOL finished){
                         [self.view setUserInteractionEnabled:YES];
                     }];
}

- (void)answerReappearWithText:(NSString *)text
{
    //self.answerLabel.text = @"";
    [UIView animateWithDuration:1
                     animations:^{
                         [self.answerBkgImageView setFrame:answerViewFrameDisappeared_];
                         [self.answerLabel setAlpha:0];
                         [self.view setUserInteractionEnabled:NO];
                     }
                     completion:^(BOOL finished){
                         self.answerLabel.text = text;
                         [UIView animateWithDuration:1
                                          animations:^{
                                              [self.answerBkgImageView setFrame:answerViewFrame_];
                                              [self.answerLabel setAlpha:1];
                                          }
                                          completion:^(BOOL finished){
                                              [self.view setUserInteractionEnabled:YES];
                                          }];
                     }];
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

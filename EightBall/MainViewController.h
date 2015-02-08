//
//  MainViewController.h
//  EightBall
//
//  Created by Екатерина Колесникова on 06.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;
@property (strong, nonatomic) IBOutlet UIImageView *answerBkgImageView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *answerLabelYConstraint;

- (IBAction)clickSettingsButton:(id)sender;

@end

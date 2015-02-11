//
//  SettingsViewController.m
//  EightBall
//
//  Created by Екатерина Колесникова on 06.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Settings";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [self.soundSwitsh setOn:[[userDefaults objectForKey:@"isSoundOn"] boolValue] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeValueSoundSwitch:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:self.soundSwitsh.isOn] forKey:@"isSoundOn"];
    [userDefaults synchronize];
}

@end

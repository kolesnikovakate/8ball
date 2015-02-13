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
    self.title = @"Настройки";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[SettingsCell class] forCellReuseIdentifier:@"SettingsCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsCell" bundle:nil] forCellReuseIdentifier:@"SettingsCell"];

    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 2) {
        return 1;
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"SettingsCell";
        cell = (SettingsCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                    forIndexPath:indexPath];

        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [[(SettingsCell *)cell soundSwitsh] setOn:[[userDefaults objectForKey:@"isSoundOn"] boolValue] animated:YES];
    } else if (indexPath.section == 1) {
        static NSString *cellIdentifier = @"CellAnswer";
        UITableViewCell *cellAnswer = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (nil == cellAnswer) {
            cellAnswer = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cellAnswer.textLabel.text = @"Привет";
        cell = cellAnswer;
        
    } else {
        static NSString *cellIdentifier = @"CellAddAnswer";
        UITableViewCell *cellAddAnswer = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (nil == cellAddAnswer) {
            cellAddAnswer = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }

        [cellAddAnswer setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
        cellAddAnswer.textLabel.text = @"Добавить свой ответ";
        cell = cellAddAnswer;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 53.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 40.0f;
    }
    return 5.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Ответы";
    }
    return nil;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        NSLog(@"Добавление ответа.");
    }
}

#pragma mark - SettingsCell delegate

- (void)changeValueSoundSwitchInCell:(SettingsCell *)cell
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:cell.soundSwitsh.isOn] forKey:@"isSoundOn"];
    [userDefaults synchronize];
}

@end

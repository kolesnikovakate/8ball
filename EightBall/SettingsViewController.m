//
//  SettingsViewController.m
//  EightBall
//
//  Created by Екатерина Колесникова on 06.02.15.
//  Copyright (c) 2015 KKate. All rights reserved.
//

#import "SettingsViewController.h"
#import "Answer.h"
#import "AddAnswerViewController.h"

@interface SettingsViewController () < NSFetchedResultsControllerDelegate >

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultControllerAnswers;

@end

@implementation SettingsViewController {
    UIBarButtonItem *rightBarButtonItemEdit_;
    UIBarButtonItem *rightBarButtonItemDone_;
}

@synthesize fetchedResultControllerAnswers = _fetchedResultControllerAnswers;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Настройки";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fetchedResultControllerAnswers = [NSFetchedResultsController fetchedResultControllerAnswers];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[SettingsCell class] forCellReuseIdentifier:@"SettingsCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SettingsCell" bundle:nil] forCellReuseIdentifier:@"SettingsCell"];

    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 1;
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView.allowsSelectionDuringEditing = YES;

    rightBarButtonItemEdit_ =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                       target:self
                                                                                       action:@selector(setTableViewEditStyle:)];
    rightBarButtonItemDone_ =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(resetTableViewEditStyle:)];

    self.navigationItem.rightBarButtonItem = rightBarButtonItemEdit_;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.fetchedResultControllerAnswers = nil;
}

- (void)setTableViewEditStyle:(id)sender
{
    [self.tableView setEditing:YES animated:YES];
    self.navigationItem.rightBarButtonItem = rightBarButtonItemDone_;
}

- (void)resetTableViewEditStyle:(id)sender
{
    [self.tableView setEditing:NO animated:YES];
    self.navigationItem.rightBarButtonItem = rightBarButtonItemEdit_;
}

#pragma mark - Property

- (void)setFetchedResultControllerAnswers:(NSFetchedResultsController *)fetchedResultControllerAnswers
{
    _fetchedResultControllerAnswers.delegate = nil;
    _fetchedResultControllerAnswers = fetchedResultControllerAnswers;
    _fetchedResultControllerAnswers.delegate = self;
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
        id sectionInfo = [[self.fetchedResultControllerAnswers sections] objectAtIndex:0];
        return [sectionInfo numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        static NSString *cellIdentifier = @"SettingsCell";
        cell = (SettingsCell *)[self.tableView dequeueReusableCellWithIdentifier:cellIdentifier
                                                                    forIndexPath:indexPath];

        [(SettingsCell *)cell setDelegate:self];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [[(SettingsCell *)cell soundSwitsh] setOn:[[userDefaults objectForKey:@"isSoundOn"] boolValue] animated:YES];
    } else if (indexPath.section == 1) {
        static NSString *cellIdentifier = @"CellAnswer";
        UITableViewCell *cellAnswer = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

        if (nil == cellAnswer) {
            cellAnswer = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        Answer *answer = [self.fetchedResultControllerAnswers objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];

        cellAnswer.textLabel.text = answer.text;
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
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Ответы";
    }
    return nil;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return YES;
    }
    return NO;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [tableView setEditing:NO animated:YES];
    if (indexPath.section == 2 || indexPath.section == 1) {
        AddAnswerViewController *destVC = [[AddAnswerViewController alloc] init];
        if (indexPath.section == 1 ) {
            destVC.answer = [self.fetchedResultControllerAnswers objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        }
        [self.navigationController pushViewController:destVC animated:YES];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Answer *answer = [self.fetchedResultControllerAnswers objectAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row inSection:0]];
        [answer removeAnswer];
    }
}

#pragma mark - SettingsCell delegate

- (void)changeValueSoundSwitchInCell:(SettingsCell *)cell
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithBool:cell.soundSwitsh.isOn] forKey:@"isSoundOn"];
    [userDefaults synchronize];
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;

    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView reloadData];
            NSLog(@"didChangeObject - ChangeInsert");
            break;

        case NSFetchedResultsChangeDelete: {
            [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:1]] withRowAnimation:UITableViewRowAnimationLeft];
            NSLog(@"didChangeObject - ChangeDelete");
            break;
        }
        case NSFetchedResultsChangeUpdate: {
            [tableView reloadData];
            NSLog(@"didChangeObject - ChangeUpdate");
            break;
        }
        case NSFetchedResultsChangeMove:
            NSLog(@"didChangeObject - ChangeMove");
            break;
    }
}

@end

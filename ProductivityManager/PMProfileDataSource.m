//
//  PMProfileDataSource.m
//  ProductivityManager
//
//  Created by Orion on 3/15/13.
//  Copyright (c) 2013 Orion. All rights reserved.
//

#import "PMProfileDataSource.h"
#import "PMAppDelegate.h"

@implementation PMProfileDataSource

#pragma mark - Delegate Methods

- (void)tableViewSelectionDidChange:(NSNotification *)notification
{
    PMAppDelegate *delegate = [NSApplication sharedApplication].delegate;
    
    NSTableView *table = [notification object];
    
    NSIndexSet *selectedIndicies = [table selectedRowIndexes];
    [delegate.removeProfileButton setEnabled:(selectedIndicies.count > 0)];
}

- (void)controlTextDidEndEditing:(NSNotification *)obj
{
    PMAppDelegate *delegate = [NSApplication sharedApplication].delegate;
    NSTableView *table = [obj object];
    NSMutableArray *profiles = [[PMUtils profiles] mutableCopy];
    
    [delegate populateProfileSelector];
    [[PMProfileManager sharedProfileManager] updateProfile:[profiles objectAtIndex:table.selectedRow] to:[table.selectedCell stringValue]];
    [profiles setObject:[table.selectedCell stringValue] atIndexedSubscript:table.selectedRow];
    [PMUtils setProfiles:[profiles copy]];
    [[NSUserDefaults standardUserDefaults] setObject:[table.selectedCell stringValue] forKey:@"profile"];
    [table reloadData];
}

#pragma mark - DataSourceMethods

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    if (![PMUtils profiles])
        return 0;
    
    return [[PMUtils profiles] count];
}

- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    if (![PMUtils profiles])
        return nil;
    
    return [[PMUtils profiles] objectAtIndex:row];
}


@end

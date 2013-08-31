//
//  MasterViewController.m
//  ListaContatos
//
//  Created by Raffael Patrício de Souza on 24/08/13.
//  Copyright (c) 2013 raffaelps. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "AddressBook/AddressBook.h"

@interface MasterViewController () {
    NSArray *_objects;
}
@end

@implementation MasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    return self;
}

- (void)dealloc
{
    [_detailViewController release];
    [_objects release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self carregarContatos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)carregarContatos
{
    NSError *error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, (CFErrorRef *)error);
    ABAddressBookRef copiaAddresBook = ABAddressBookCopyDefaultSource(addressBook);
    _objects = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, copiaAddresBook, kABPersonSortByLastName);
    
    [self.tableView reloadData];
    
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _objects.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)[_objects objectAtIndex:indexPath.row],kABPersonFirstNameProperty);
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
    }
 
    self.detailViewController.detailItem = (__bridge ABRecordRef)[_objects objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

@end

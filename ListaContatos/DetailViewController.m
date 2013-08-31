//
//  DetailViewController.m
//  ListaContatos
//
//  Created by Raffael Patrício de Souza on 24/08/13.
//  Copyright (c) 2013 raffaelps. All rights reserved.
//

#import "DetailViewController.h"
#import "AddressBook/AddressBook.h"

@interface DetailViewController ()
- (void)configureView;
@end

@implementation DetailViewController

- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionLabel release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        NSString *nome = (__bridge NSString*)ABRecordCopyValue(self.detailItem,kABPersonFirstNameProperty);
        NSString *sobrenome = (__bridge NSString*)ABRecordCopyValue(self.detailItem,kABPersonLastNameProperty);
        
        ABMultiValueRef emailMultiValue = ABRecordCopyValue(self.detailItem, kABPersonEmailProperty);
        NSArray *emailAddresses = [(NSArray *)ABMultiValueCopyArrayOfAllValues(emailMultiValue) autorelease];
        
        NSString *email = [[NSString alloc]init];
        
        if (emailAddresses.count > 0)
        {
            email = [emailAddresses objectAtIndex:0];
        }
        
        NSString *texto = [NSString stringWithFormat:@"%@ %@ \n %@",nome,sobrenome,email];
        
        self.detailDescriptionLabel.text = texto;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
@end

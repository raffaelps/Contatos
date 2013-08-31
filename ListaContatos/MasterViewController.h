//
//  MasterViewController.h
//  ListaContatos
//
//  Created by Raffael Patrício de Souza on 24/08/13.
//  Copyright (c) 2013 raffaelps. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end

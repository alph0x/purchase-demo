//
//  TableViewController.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentMethodTableViewCell.h"
#import "BankTableViewCell.h"
#import "InstallmentTableViewCell.h"
#import "Sale.h"

typedef enum {
    tableViewModePaymentMethods = 0,
    tableViewModeCardIssuers = 1,
    tableViewModeInstallments = 2
} tableViewMode;

@interface TableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) Sale *sale;
@property tableViewMode mode;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

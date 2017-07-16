//
//  TableViewController.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "TableViewController.h"
#import "APIController.h"

@interface TableViewController () {
    NSMutableArray *dataSource;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PaymentMethodTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"PaymentMethodTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BankTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"BankTableViewCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"InstallmentTableViewCell"
                                               bundle:nil]
         forCellReuseIdentifier:@"InstallmentTableViewCell"];
    dataSource = [NSMutableArray new];
    self.tableView.tableFooterView = [UIView new];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    switch (self.mode) {
        case tableViewModePaymentMethods:
        {
            self.title = @"Métodos de Pago";
            [APIController getPaymentMethodsWithCompletionHandler:^(Response *response) {
                
                [response.json enumerateObjectsUsingBlock:^(NSDictionary *d, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [dataSource addObject:[PaymentMethod instanceWithDictionary:d]];
                }];
                
                [self.tableView reloadData];
            }];
        }
            break;
            
        case tableViewModeCardIssuers:
        {
            self.title = @"Emisor de la Tarjeta";
            [APIController getCardIssuersForPaymentMethod:self.sale.paymentMethod withCompletionHandler:^(Response *response) {
                
                [response.json enumerateObjectsUsingBlock:^(NSDictionary *d, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [dataSource addObject:[Bank instanceWithDictionary:d]];
                }];
                
                [self.tableView reloadData];
            }];
        }
            break;
            
    case tableViewModeInstallments:
        {
            [APIController getInstallmentsForCardIssuer:self.sale.bank withPaymentMethod:self.sale.paymentMethod andAmount:self.sale.amount withCompletionHandler:^(Response *response) {
             
             
             [[[response.json firstObject] objectForKey:@"payer_costs"] enumerateObjectsUsingBlock:^(NSDictionary *d, NSUInteger idx, BOOL * _Nonnull stop) {
                 
                 [dataSource addObject:[Installment instanceFromDictionary:d]];
             }];
             
             [self.tableView reloadData];
         }];
        }
            break;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    switch (self.mode) {
        case tableViewModePaymentMethods:
        {
            height = 70;
        }
            break;
            
        case tableViewModeCardIssuers:
        {
            height = 55;
        }
            break;
            
        case tableViewModeInstallments:
        {
            height = 55;
        }
            break;
    }
    return height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id cell;
    switch (self.mode) {
        case tableViewModePaymentMethods:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentMethodTableViewCell"];
        }
            break;
            
        case tableViewModeCardIssuers:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"BankTableViewCell"];
        }
            break;
            
        case tableViewModeInstallments:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"InstallmentTableViewCell"];
        }
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    id source = [dataSource objectAtIndex:indexPath.row];
    switch (self.mode) {
        case tableViewModePaymentMethods:
        {
            [(PaymentMethodTableViewCell *) cell prepareForPaymentMethod:source];
        }
            break;
            
        case tableViewModeCardIssuers:
        {
            [(BankTableViewCell *) cell prepareForBank:source];
        }
            break;
            
        case tableViewModeInstallments:
        {
            [(InstallmentTableViewCell *) cell prepareForInstallment:source];
        }
            break;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (self.mode) {
        case tableViewModePaymentMethods:
        {
            TableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
            tableViewController.mode = tableViewModeCardIssuers;
            self.sale.paymentMethod = [dataSource objectAtIndex:indexPath.row];
            tableViewController.sale = self.sale;
            [self.navigationController pushViewController:tableViewController
                                                 animated:YES];
        }
            break;
            
        case tableViewModeCardIssuers:
        {
            TableViewController *tableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewController"];
            tableViewController.mode = tableViewModeInstallments;
            self.sale.bank = [dataSource objectAtIndex:indexPath.row];
            tableViewController.sale = self.sale;
            [self.navigationController pushViewController:tableViewController
                                                 animated:YES];
        }
            break;
            
        case tableViewModeInstallments:
        {
            Installment *installment = [dataSource objectAtIndex:indexPath.row];
            NSString *message = [NSString stringWithFormat:@"El Pago fue realizado correctamente utilizando los siguientes datos: \n Método de Pago: %@\n Banco: %@\n Monto: %@\n Modalidad de pago: %@\n", self.sale.paymentMethod.name, self.sale.bank.name, [self.sale.amount getFormattedAmount], installment.recommendedMessage];
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Pago realizado con Exito!" message:message preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *acceptButton = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault handler:nil];
            [alertController addAction:acceptButton];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
            [self presentViewController:alertController
                               animated:YES
                             completion:nil];
        }
            break;
    }
}

@end

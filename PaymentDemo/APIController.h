//
//  APIController.h
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "PaymentMethod.h"
#import "Bank.h"
#import "Amount.h"

#define HTTP_GET_METHOD @"GET"

#define X_WWW_FORM_URLENCODED_CONTENT_TYPE @"application/x-www-form-urlencoded"
#define JSON_CONTENT_TYPE @"application/json"
#define FORM_DATA_CONTENT_TYPE @"multipart/form-data"
#define CONTENT_TYPE_HEADER_NAME @"Content-Type"

@interface HTTPRequestConfigurator : NSObject

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *HTTPMethod;
@property (nonatomic, retain) NSString *sessionToken;
@property (nonatomic, retain) NSDictionary *paramenters;
@property (nonatomic, copy) void (^formData)(id<AFMultipartFormData> formData);
@property (nonatomic, retain) NSData *HTTPBody;
@property (nonatomic, retain) NSDictionary *headers;
@property (nonatomic, retain) AFHTTPResponseSerializer *serializer;

+(HTTPRequestConfigurator *) configuratorWithURL:(NSString *)url;

+(HTTPRequestConfigurator *) configuratorWithMethod:(NSString *) method
                                                URL:(NSString *) url
                                        contentType:(NSString *) contentType;

-(void) setValue:(id) value
       forHeader:(NSString *) headerName;

-(void) setContent:(NSData *) content
   withContentType:(NSString *) contentType;

-(void) setContentType:(NSString *) contentType;

-(void) setJsonContent:(NSData *) jsonData;

@end

typedef void (^HTTPRequestConfiguratorBlock)(HTTPRequestConfigurator *configurator);

@interface Response : NSObject

@property (nonatomic, strong) NSURLRequest *request;
@property (nonatomic, strong) HTTPRequestConfigurator *configurator;
@property (nonatomic, strong) id json;
@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSString *errorTitle;
@property (nonatomic, strong) NSString *contentType;
@property BOOL fail;

@end

typedef void (^ResponseBlock)(Response *response);

@interface APIController : NSObject

+ (void) requestWithConfigurator: (HTTPRequestConfigurator *) configurator
           withCompletionHandler:(void (^)(Response *response)) requestBlock;

+ (void)    handleURLRequest: (NSURLRequest *) request
       withCompletionHandler:(void (^)(Response *response)) requestBlock;

+ (void) getPaymentMethodsWithCompletionHandler:(void (^)(Response *response)) requestBlock;

+ (void) getCardIssuersForPaymentMethod:(PaymentMethod *) paymentMethod
                  withCompletionHandler:(void (^)(Response *response)) requestBlock;


+ (void) getInstallmentsForCardIssuer:(Bank *) bank
                    withPaymentMethod:(PaymentMethod *) paymentMethod
                            andAmount:(Amount *) amount
                withCompletionHandler:(void (^)(Response *response)) requestBlock;
@end

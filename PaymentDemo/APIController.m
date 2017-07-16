//
//  APIController.m
//  PaymentDemo
//
//  Created by Alfredo Perez on 7/15/17.
//  Copyright © 2017 Alfredo Perez. All rights reserved.
//

#import "APIController.h"

#define MAIN_URL @"https://api.mercadopago.com/v1/"

#define KEY @"444a9ef5-8a6b-429f-abdf-587639155d88"

#define KEY_PARAM [NSString stringWithFormat:@"public_key=%@", KEY]
#define PAYMENT_METHOD_PARAM NSString stringWithFormat:@"&payment_method_id=%@"
#define CARD_ISSUER_PARAM NSString stringWithFormat:@"&issuer.id=%@"
#define AMOUNT_PARAM NSString stringWithFormat:@"&amount=%.02f"

#define GET_PAYMENT_METHODS NSString stringWithFormat:@"payment_methods?%@"
#define GET_CARD_ISSUERS NSString stringWithFormat:@"payment_methods/card_issuers?%@%@"
#define GET_INSTALLMENTS NSString stringWithFormat:@"payment_methods/installments?%@%@%@%@"

@implementation HTTPRequestConfigurator

+ (HTTPRequestConfigurator *)configuratorWithURL:(NSString *)url {
    HTTPRequestConfigurator *configurator = [HTTPRequestConfigurator new];
    configurator.url = [NSString stringWithFormat:@"%@%@", MAIN_URL, url];
    return configurator;
}

+ (HTTPRequestConfigurator *)configuratorWithMethod:(NSString *)method
                                                URL:(NSString *)url
                                        contentType:(NSString *)contentType {
    
    HTTPRequestConfigurator *configurator = [HTTPRequestConfigurator configuratorWithURL:url];
    configurator.HTTPMethod = method;
    [configurator setContentType:contentType];
    
    return configurator;
    
}

-(instancetype)init {
    if (self = [super init]) {
        self.serializer = [AFJSONResponseSerializer serializer];
    }
    
    return self;
}

- (void)setValue:(id)value
       forHeader:(NSString *)headerName {
    if (self.headers == nil) {
        self.headers = [NSMutableDictionary new];
    }
    
    [self.headers setValue:value
                    forKey:headerName];
}

-(void) setContent: (NSData *) content
   withContentType: (NSString *) contentType {
    
    NSParameterAssert(content);
    NSParameterAssert(contentType);
    
    self.HTTPBody = content;
    
    [self setValue: contentType
         forHeader: CONTENT_TYPE_HEADER_NAME];
}

-(void) setJsonContent: (NSData *) jsonData {
    
    [self setContent: jsonData
     withContentType: [NSString stringWithFormat:@"%@", FORM_DATA_CONTENT_TYPE]];
}

-(void) setContentType: (NSString *) contentType {
    [self setValue: contentType
         forHeader: CONTENT_TYPE_HEADER_NAME];
}

@end

@implementation Response

-(NSString *) description {
    return [NSString stringWithFormat:@"Response: %@", self.json];
}

@end

@implementation APIController

+ (NSMutableURLRequest *) requestWithConfiguration:(HTTPRequestConfigurator *)configurator {
    NSMutableURLRequest *request = nil;
    
    NSParameterAssert(configurator.url);
    NSParameterAssert(configurator.HTTPMethod);
    
    if (configurator.formData) {
        request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:configurator.HTTPMethod
                                                                             URLString:configurator.url
                                                                            parameters:configurator.paramenters
                                                             constructingBodyWithBlock:configurator.formData
                                                                                 error:nil];
    }else {
        request = [[AFHTTPRequestSerializer serializer] requestWithMethod:configurator.HTTPMethod
                                                                URLString:configurator.url
                                                               parameters:configurator.paramenters
                                                                    error:nil];
    }
    
    for (NSString *key in [configurator.headers allKeys]) {
        id value = [configurator.headers objectForKey:key];
        [request setValue:[NSString stringWithFormat:@"%@", value]
       forHTTPHeaderField:key];
    }
    
    if (configurator.HTTPBody) {
        [request setHTTPBody:configurator.HTTPBody];
        
        
        
    }
    
    return request;
}

+ (void) requestWithConfigurator:(HTTPRequestConfigurator *)configurator
           withCompletionHandler:(void (^)(Response *response)) requestBlock  {
    
    NSMutableURLRequest *request = [APIController requestWithConfiguration:configurator];
    
    [APIController handleURLRequest:request
           withCompletionHandler:requestBlock];
}

+ (void)                get:(NSString *)url
      withCompletionHandler:(void (^)(Response *response)) requestBlock {
    HTTPRequestConfigurator *configurator = [HTTPRequestConfigurator configuratorWithURL:url];
    
    configurator.HTTPMethod = HTTP_GET_METHOD;
    
    [APIController requestWithConfigurator:configurator
                  withCompletionHandler:requestBlock];
    
}

+ (void) handleURLRequest:(NSURLRequest *)request
    withCompletionHandler:(void (^)(Response *response)) requestBlock {
    Response *resp = [[Response alloc] init];
    resp.request = request;
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                completionHandler:^(NSURLResponse * _Nonnull response,
                                                                    id  _Nullable responseObject,
                                                                    NSError * _Nullable error) {

                                                    if (error) {
                                                        resp.fail = YES;
                                                        resp.error = error;
                                                        
                                                    } else {
                                                        
                                                        resp.json = responseObject;
                                                    }
                                                    
                                                    requestBlock(resp);
                                                }];
    [dataTask resume];
}

+ (void)getPaymentMethodsWithCompletionHandler:(void (^)(Response *))requestBlock {
    
                    [self get:[GET_PAYMENT_METHODS, KEY_PARAM]
        withCompletionHandler:requestBlock];
    
}

+ (void)getCardIssuersForPaymentMethod:(PaymentMethod *)paymentMethod
                 withCompletionHandler:(void (^)(Response *))requestBlock {
    
                    [self get:[GET_CARD_ISSUERS, KEY_PARAM, [PAYMENT_METHOD_PARAM, paymentMethod.identifier]]
        withCompletionHandler:requestBlock];
}

+ (void)getInstallmentsForCardIssuer:(Bank *)bank
                   withPaymentMethod:(PaymentMethod *)paymentMethod
                           andAmount:(Amount *) amount
               withCompletionHandler:(void (^)(Response *))requestBlock {
    
                    [self get:[GET_INSTALLMENTS, KEY_PARAM,
                       [PAYMENT_METHOD_PARAM, paymentMethod.identifier],
                       [AMOUNT_PARAM, amount.raw.doubleValue],
                       [CARD_ISSUER_PARAM, bank.identifier]]
        withCompletionHandler:requestBlock];
}

@end

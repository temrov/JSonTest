//
//  FCJSonRequest.m
//  JSonTest
//
//  Created by user01 on 14.09.16.
//  Copyright © 2016 user01. All rights reserved.
//

#import "FCJSonRequest.h"
#import "FCImage.h"

NSString* FEATURED_ITEMS_PATH = @"/ifunny/v1/feeds/featured";
NSString* POPULAR_ITEMS_PATH = @"/ifunny/v1/feeds/popular";


@implementation FCJSonRequest
-(void)configure {
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://web-api.ifunny.mobi"];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    RKMapping* pictureMapping = [FCImageMapping get];
    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptorFeatured =
    [RKResponseDescriptor responseDescriptorWithMapping:pictureMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:FEATURED_ITEMS_PATH
                                                keyPath:@"content.items"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptorFeatured];
    RKResponseDescriptor *responseDescriptorPopular =
    [RKResponseDescriptor responseDescriptorWithMapping:pictureMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:POPULAR_ITEMS_PATH
                                                keyPath:@"content.items"
                                            statusCodes:[NSIndexSet indexSetWithIndex:200]];
    [objectManager addResponseDescriptor:responseDescriptorPopular];
    
}
-(void)loadItemsAtPath : (NSString*)path
              OnSuccess: (void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))successHandler
              OnFailure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failureHanlder
{
    [[RKObjectManager sharedManager] getObjectsAtPath:path
                                           parameters:nil
                                              success:successHandler
                                              failure:failureHanlder];
}
@end

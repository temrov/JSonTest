//
//  FCJSonRequest.h
//  JSonTest
//
//  Created by user01 on 14.09.16.
//  Copyright © 2016 user01. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>


@interface FCJSonRequest : NSObject

-(void)configure;
-(void)loadItemsAtPath : (NSString*)path
              OnSuccess: (void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))successHandler
              OnFailure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failureHanlder;

@end

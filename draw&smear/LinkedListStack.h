//
//  LinkedListStack.h
//  draw&smear
//
//  Created by 程翔 on 2018/2/27.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FINAL_NODE_OFFSET -1
#define INVALID_NODE_CONTENT INT_MIN

typedef struct PointNode
{
    long nextNodeOffset;
    
    int point;
    
} PointNode;

@interface LinkedListStack : NSObject
{
    NSMutableData *nodeCache;
    
    long freeNodeOffset;
    long topNodeOffset;
    int cacheSizeIncrements;
    
    int multiplier;
}

- (id)initWithCapacity:(int)capacity incrementSize:(int)increment andMultiplier:(int)mul;
- (id)initWithCapacity:(int)capacity;

- (void)pushFrontX:(int)x andY:(int)y;
- (int)popFront:(int *)x andY:(int *)y;

@end

//
//  LinkedListStack.m
//  draw&smear
//
//  Created by 程翔 on 2018/2/27.
//  Copyright © 2018年 程翔. All rights reserved.
//

#import "LinkedListStack.h"

@implementation LinkedListStack

#pragma mark - Initialisation

- (instancetype)init
{
    return [self initWithCapacity:500];
}

-(id)initWithCapacity:(int)capacity
{
    return [self initWithCapacity:capacity incrementSize:500 andMultiplier:1000];
}

-(id)initWithCapacity:(int)capacity incrementSize:(int)increment andMultiplier:(int)mul
{
    self = [super init];
    
    if (self) {
        cacheSizeIncrements = increment;
        
        int bytesRequired = capacity * sizeof(PointNode);
        
        nodeCache = [[NSMutableData alloc] initWithLength:bytesRequired];
        
        [self initialiseNodesAtOffset:0 count:capacity];
        
        freeNodeOffset = 0;
        topNodeOffset = FINAL_NODE_OFFSET;
        
        multiplier = mul;
    }
    return self;
}

#pragma mark - Stack methods
- (void)initialiseNodesAtOffset:(long)offset count:(int)count
{
    PointNode *node = (PointNode *)nodeCache.mutableBytes + offset;
    
    for (int i=0; i<count - 1; i++)
    {
        node->point = 0;
        node->nextNodeOffset = offset + i + 1;
        node++;
    }
    
    node->point = 0;
    
    // Set the next node offset to make sure we don't continue
    node->nextNodeOffset = FINAL_NODE_OFFSET;
}

- (PointNode *)getNextFreeNode
{
    if(freeNodeOffset < 0)
    {
        // Need to extend the size of the nodeCache
        unsigned long currentSize = nodeCache.length / sizeof(PointNode);
        [nodeCache increaseLengthBy:cacheSizeIncrements * sizeof(PointNode)];
        
        // Set these new nodes to be the free ones
        [self initialiseNodesAtOffset:currentSize count:cacheSizeIncrements];
        freeNodeOffset = currentSize;
    }
    
    PointNode *node = (PointNode*)nodeCache.mutableBytes + freeNodeOffset;
    freeNodeOffset = node->nextNodeOffset;
    
    return node;
}

- (void)pushFrontX:(int)x andY:(int)y;
{
    int p = multiplier * x + y;
    
    PointNode *node = [self getNextFreeNode];
    
    node->point = p;
    node->nextNodeOffset = topNodeOffset;
    
    topNodeOffset = [self offsetOfNode:node];
}

- (int)popFront:(int *)x andY:(int *)y;
{
    if(topNodeOffset == FINAL_NODE_OFFSET)
    {
        return INVALID_NODE_CONTENT;
    }
    
    PointNode *node = [self nodeAtOffset:topNodeOffset];
    
    long thisNodeOffset = topNodeOffset;
    
    // Remove this node from the queue
    topNodeOffset = node->nextNodeOffset;
    int value = node->point;
    
    // Reset it and add it to the free node cache
    node->point = 0;
    node->nextNodeOffset = freeNodeOffset;
    
    freeNodeOffset = thisNodeOffset;
    
    *x = value / multiplier;
    *y = value % multiplier;
    
    return value;
}

#pragma mark - utility functions
- (long)offsetOfNode:(PointNode *)node
{
    return node - (PointNode *)nodeCache.mutableBytes;
}

- (PointNode *)nodeAtOffset:(long)offset
{
    return (PointNode *)nodeCache.mutableBytes + offset;
}


@end

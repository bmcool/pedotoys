//
//  DataSource.h
//  calendar
//
//  Created by Chi-Cheng Lin on 11/12/14.
//  Copyright (c) 2011年 COEVO Technology. All rights reserved.
//

#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"
#import "NSDate+Calendar.h"

@interface COEVODatabase : NSObject

+(void)openDB;
+(void)closeDB;
+(FMDatabase *)DB;
+ (void) migrateToSchemaFromVersion:(NSInteger)fromVersion toVersion:(NSInteger)toVersion;


+ (void) insertWithTable:(NSString *)table dict:(NSDictionary *)dict;

+ (NSArray *) selectWithTable:(NSString *)table;
+ (NSArray *) selectWithTable:(NSString *)table where:(NSString *)where;
+ (NSArray *) selectWithTable:(NSString *)table where:(NSString *)where orderBy:(NSString *)order orderType:(NSString *)orderType;

+ (NSArray *) selectWithTable:(NSString *)table orderBy:(NSString *)order orderType:(NSString *)orderType;
+ (FMResultSet *) selectPWithTable:(NSString *)table orderBy:(NSString *)column orderType:(NSString *)orderType;

+ (NSString *) getValueWithtTable:(NSString *)table filterColumn:(NSString *)filterColumn filterValue:(NSString *)filterValue targetColumn:(NSString *)targetColumn;
+ (NSString *) getValueWithtTable:(NSString *)table ID:(NSString *)ID column:(NSString *)column;

+ (NSDictionary *) getValuesWithTable:(NSString *)table column:(NSString *)column value:(NSString *)value;
+ (NSDictionary *) getValuesWithTable:(NSString *)table ID:(NSString *)ID;

+ (void) updateWithTable:(NSString *)table dict:(NSDictionary *)dict where:(NSString *)where;
+ (void) updateWithTable:(NSString *)table dict:(NSDictionary *)dict ID:(NSString *)ID;

+ (void) deleteWithTable:(NSString *)table ID:(NSString *)ID;
+ (void) deleteWithTable:(NSString *)table where:(NSString *)where;

+ (void) setValueWithTable:(NSString *)table ID:(NSString *)ID column:(NSString *)column value:(id)value;

+ (NSString *) getLastIDWithTable:(NSString *)table;

+ (void) beginTransaction;
+ (void) rollback;
+ (void) commit;

@end

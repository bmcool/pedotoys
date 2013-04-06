//
//  DataSource.m
//  calendar
//
//  Created by Chi-Cheng Lin on 11/12/14.
//  Copyright (c) 2011年 COEVO Technology. All rights reserved.
//

#import "COEVODatabase.h"

@interface COEVODatabase()

+ (NSArray *) resultToArray;

@end

@implementation COEVODatabase

static FMDatabase *db = nil;
static FMResultSet *rs = nil;

/* 
 不同專案需更改的地方
 */

int toVersion = 1;
NSString *dbname = @"BWCalendar.db";

// todo 測試時間邊界值
+ (void) migrateToSchemaFromVersion:(NSInteger)fromVersion toVersion:(NSInteger)toVersion { 
    [db beginTransaction];
    while (fromVersion < toVersion) {
        switch (fromVersion + 1) {
            case 1:
                // 062212 add images int,
                // 070812 add audios int,
                [db executeUpdate:@"\
                 create table notes (\
                 id integer primary key autoincrement,\
                 description text,\
                 images int,\
                 audios int,\
                 date timestamp,\
                 updated_at timestamp default (strftime('%s', 'now')),\
                 created_at timestamp default (strftime('%s', 'now'))\
                 )"];
                
                // alert_time -1:none, 0:immediate, >1:n minutes
                // recurrence 0:none 1:daily, 2:weekly, 3:monthly for day, 4:monthly for week and weekday, 5:yearly
                // end_type 0:forever, 1:end_count, 2:end_date
                // weekday 1~7, ex: 1,3,5
                [db executeUpdate:@"\
                 create table tasks (\
                 id integer primary key autoincrement,\
                 summary text,\
                 description text,\
                 location text,\
                 start_time timestamp,\
                 due_time timestamp,\
                 all_day_event integer default 0,\
                 alert_time integer default -1,\
                 recurrence integer default 0,\
                 frequency integer default 1,\
                 start_on timestamp,\
                 end_type integer default 0,\
                 end_on timestamp,\
                 end_count integer,\
                 weekday text,\
                 updated_at timestamp default (strftime('%s', 'now')),\
                 created_at timestamp default (strftime('%s', 'now'))\
                 )"];
                
                // type 0:deleted, 1:completed
                [db executeUpdate:@"\
                 create table task_trash (\
                 id integer primary key autoincrement,\
                 task_id integer,\
                 type integer,\
                 date timestamp,\
                 updated_at timestamp default (strftime('%s', 'now')),\
                 created_at timestamp default (strftime('%s', 'now'))\
                 )"];
                
                [db executeUpdate:@"\
                 create table task_cache (\
                 id integer primary key autoincrement,\
                 task_id integer,\
                 completed integer default 0,\
                 date timestamp,\
                 updated_at timestamp default (strftime('%s', 'now')),\
                 created_at timestamp default (strftime('%s', 'now'))\
                 )"];
                
                [db executeUpdate:@"\
                 create table task_modify (\
                 id integer primary key,\
                 date timestamp,\
                 summary text,\
                 description text,\
                 location text,\
                 start_time timestamp,\
                 due_time timestamp,\
                 all_day_event integer default 0,\
                 alert_time integer default -1,\
                 recurrence integer default 0,\
                 frequency integer default 1,\
                 start_on timestamp,\
                 end_type integer default 0,\
                 end_on timestamp,\
                 end_count integer,\
                 weekday text,\
                 updated_at timestamp default (strftime('%s', 'now')),\
                 created_at timestamp default (strftime('%s', 'now'))\
                 )"];
                break;
            case 2:
                
                
                break;
        }
        
        fromVersion++;
        [db executeUpdate:@"insert into version_control (version) values (?)", [NSNumber numberWithInt:fromVersion]];
    }
    if ([db hadError]) {
        [db rollback];
    } else {
        [db commit];
    }
}


+ (void)openDB
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *dbPath = [documentDirectory stringByAppendingPathComponent:dbname];
    
    db = [FMDatabase databaseWithPath:dbPath];
    NSLog(@"dbPath = %@", dbPath);
    if (![db open]) {
        NSLog(@"Could not open db.");
    } else {
        if (![db tableExists:@"version_control"]) {
            NSLog(@"Is new db");
            [db executeUpdate:@"\
            create table version_control (\
            id integer primary key autoincrement,\
            version integer,\
            created_at Timestamp default (strftime('%s', 'now'))\
            )"];
            [db executeUpdate:@"insert into version_control (version) values (0)"];
        }
        
        rs = [db executeQuery:@"select * from version_control order by id desc"];
        [rs next];
        int fromVersion = [rs intForColumn:@"version"];
        
        [COEVODatabase migrateToSchemaFromVersion:fromVersion toVersion:toVersion];
    }
}

+ (void)closeDB
{
    [db close];
}

+ (FMDatabase *)DB
{
    return db;
}

#pragma mark -
#pragma mark - self methods

+ (NSArray *) resultToArray
{
    NSMutableArray *result = [NSMutableArray new];
    while ([rs next]) {
        [result addObject:[rs resultDict]];
    }
    return result;
}

#pragma mark -
#pragma mark - SQL methods

#pragma mark - general

+ (void) insertWithTable:(NSString *)table dict:(NSDictionary *)dict
{    
    NSMutableArray *columns = [NSMutableArray new];
    NSMutableArray *values = [NSMutableArray new];
    for (NSString *column in dict) {
        NSString *value = [dict objectForKey:column];
        // todo maybe other special char need to escape
        value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        [columns addObject:column];
        [values addObject:[NSString stringWithFormat:@"'%@'", value]];
    }
    NSString *sql = [NSString stringWithFormat:@"insert into %@ (%@) values (%@)", table, [columns componentsJoinedByString:@","], [values componentsJoinedByString:@","]];
    [db executeUpdate:sql];
}

+ (NSArray *) selectWithTable:(NSString *)table
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@", table];
    rs = [[COEVODatabase DB] executeQuery:sql];
    return [self resultToArray];
}

+ (NSArray *) selectWithTable:(NSString *)table where:(NSString *)where
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@", table, where];
    rs = [[COEVODatabase DB] executeQuery:sql];
    return [self resultToArray];
}

+ (NSArray *) selectWithTable:(NSString *)table where:(NSString *)where orderBy:(NSString *)column orderType:(NSString *)orderType
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ ORDER BY %@ %@", table, where, column, orderType];
    rs = [[COEVODatabase DB] executeQuery:sql];
    return [self resultToArray];
}

+ (NSArray *) selectWithTable:(NSString *)table orderBy:(NSString *)column orderType:(NSString *)orderType
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ ORDER BY %@ %@", table, column, orderType];
    rs = [[COEVODatabase DB] executeQuery:sql];
    return [self resultToArray];
}

+ (FMResultSet *) selectPWithTable:(NSString *)table orderBy:(NSString *)column orderType:(NSString *)orderType
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ ORDER BY %@ %@", table, column, orderType];
    rs = [[COEVODatabase DB] executeQuery:sql];
    return rs;
}

+ (NSString *) getValueWithtTable:(NSString *)table filterColumn:(NSString *)filterColumn filterValue:(NSString *)filterValue targetColumn:(NSString *)targetColumn
{
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@ where %@ = '%@'", targetColumn, table, filterColumn, filterValue];
    rs = [[COEVODatabase DB] executeQuery:sql];
    [rs next];
    return [rs stringForColumnIndex:0];
}

+ (NSString *) getValueWithtTable:(NSString *)table ID:(NSString *)ID column:(NSString *)column
{
    return [self getValueWithtTable:table filterColumn:@"id" filterValue:ID targetColumn:column];
}

+ (NSDictionary *) getValuesWithTable:(NSString *)table column:(NSString *)column value:(NSString *)value
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'", table, column, value];
    rs = [[COEVODatabase DB] executeQuery:sql];
    [rs next];
    return [rs resultDict];
}

+ (NSDictionary *) getValuesWithTable:(NSString *)table ID:(NSString *)ID
{
    return [self getValuesWithTable:table column:@"id" value:ID];
}

+ (void) updateWithTable:(NSString *)table dict:(NSDictionary *)dict where:(NSString *)where
{
    NSMutableArray *contents = [NSMutableArray new];
    for (NSString *column in dict) {
        NSString *value = [dict objectForKey:column];
        // todo maybe other special char need to escape
        value = [value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
        [contents addObject:[NSString stringWithFormat:@"%@ = '%@'", column, value]];
    }
    NSString *set = [contents componentsJoinedByString:@","];
    NSString *sql = [NSString stringWithFormat:@"update %@ set %@, updated_at = (strftime('%.f', 'now')) where %@", table, set, [[NSDate date] timeIntervalSince1970], where];
    [db executeUpdate:sql];
}

+ (void) updateWithTable:(NSString *)table dict:(NSDictionary *)dict ID:(NSString *)ID
{
    [self updateWithTable:table dict:dict where:[NSString stringWithFormat:@"id = '%@'", ID]];
}

+ (void) deleteWithTable:(NSString *)table ID:(NSString *)ID
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where id = '%@'", table, ID];
    [db executeUpdate:sql];
}

+ (void) deleteWithTable:(NSString *)table where:(NSString *)where
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@", table, where];
    [db executeUpdate:sql];
}

+ (void) setValueWithTable:(NSString *)table ID:(NSString *)ID column:(NSString *)column value:(id)value
{
    [self updateWithTable:table dict:[NSDictionary dictionaryWithObjectsAndKeys:value, column, nil] ID:ID];
}

+ (NSString *) getLastIDWithTable:(NSString *)table
{
    NSString *sql = [NSString stringWithFormat:@"select * from %@ order by id desc", table];
    rs = [db executeQuery:sql];
    [rs next];
    return [rs stringForColumn:@"id"];
}

+ (void) beginTransaction
{
    [db beginTransaction];
}

+ (void) rollback
{
    [db rollback];
}

+ (void) commit
{
    [db commit];
}

@end

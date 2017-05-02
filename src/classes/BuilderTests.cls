@IsTest
class BuilderTests
{
    class FieldSetMemberProxy { String fieldPath; }
    
    static testmethod void testCountQuery()
    {
        Test.startTest();
            Integer count = new Builder(Organization.sObjectType).count();
        Test.stopTest();
        
        system.assertEquals(1, count, 'Only one organization should be visible');
    }
    static testmethod void testGetRecord()
    {
        Test.startTest();
            User runningUser = (User)new Builder(User.sObjectType)
                .selectX(User.Username).whereX(
                    new Filter(User.Id).equals(UserInfo.getUserId())
                ).getRecord();
        Test.stopTest();
        
        system.assertEquals(UserInfo.getUserName(), runningUser.Username,
            'The running user should be queried');
    }
    static testmethod void testGetRecords()
    {
        Test.startTest();
            List<Profile> assignedProfiles = new Builder(Profile.sObjectType)
                .whereX(new Filter('Id').isIn(new Builder(User.sObjectType).selectX('ProfileId')))
                .getRecords();
        Test.stopTest();
        
        Set<Id> assignedProfileIds = new Map<Id, Profile>(assignedProfiles).keySet();
        system.assert(assignedProfileIds.contains(UserInfo.getProfileId()),
            'All assigned profiles should be returned');
    }
    
    static testMethod void testSelect_SObjectField()
    {
        List<SObjectField> fields = new List<SObjectField> { User.Name };
        
        Test.startTest();
            List<SObject> records = new Builder(User.sObjectType)
                .selectX(fields).getRecords();
        Test.stopTest();
        
        SObjectException unexpectedException;
        for (SObjectField field : fields)
        {
            try { records[0].get(field); }
            catch (SObjectException s) { unexpectedException = s; }
        }
        system.assertEquals(null, unexpectedException,
            'Each selected field should be queried for');
    }
    static testMethod void testSelect_String()
    {
        List<String> fields = new List<String> { 'Name' };
        
        Test.startTest();
            List<SObject> records = new Builder(User.sObjectType)
                .selectX(fields).getRecords();
        Test.stopTest();
        
        SObjectException unexpectedException;
        for (String field : fields)
        {
            try { records[0].get(field); }
            catch (SObjectException s) { unexpectedException = s; }
        }
        system.assertEquals(null, unexpectedException,
            'Each selected field should be queried for');
    }
    static testMethod void testSelect_FieldExpression()
    {
        List<FieldExpression> fields = new List<FieldExpression> { new FieldExpression('Name') };
        
        Test.startTest();
            List<SObject> records = new Builder(User.sObjectType)
                .selectX(fields).getRecords();
        Test.stopTest();
        
        SObjectException unexpectedException;
        for (FieldExpression field : fields)
        {
            try { records[0].get(field.toString()); }
            catch (SObjectException s) { unexpectedException = s; }
        }
        system.assertEquals(null, unexpectedException,
            'Each selected field should be queried for');
    }
    static testMethod void testSelect_FieldSetMember()
    {
        FieldSetMemberProxy proxy = new FieldSetMemberProxy();
        proxy.fieldPath = 'Name';
        List<FieldSetMemberProxy> proxies = new List<FieldSetMemberProxy> { proxy };
        List<FieldSetMember> fields = (List<FieldSetMember>)JSON.deserialize(
            JSON.serialize(proxies), List<FieldSetMember>.class
        );
        
        Test.startTest();
            List<SObject> records = new Builder(User.sObjectType)
                .selectX(fields).getRecords();
        Test.stopTest();
        
        SObjectException unexpectedException;
        for (FieldSetMember field : fields)
        {
            try { records[0].get(field.getFieldPath()); }
            catch (SObjectException s) { unexpectedException = s; }
        }
        system.assertEquals(null, unexpectedException,
            'Each selected field should be queried for');
    }
    static testmethod void testSelect_FieldSet()
    {
        FieldSet undefined;
        
        NullPointerException expectedException;
        Test.startTest();
            try
            {
                new Builder(User.sObjectType).selectX(undefined);
            }
            catch (NullPointerException n)
            {
                expectedException = n;
            }
        Test.stopTest();
        
        system.assertNotEquals(null, expectedException,
            'Each selected field should be queried for');
    }
    
    static testmethod void testUsingScope()
    {
        Test.startTest();
            List<LoginHistory> records = new Builder(LoginHistory.sObjectType)
                .selectX(LoginHistory.UserId).usingScope(FilterScope.MINE)
                .getRecords();
        Test.stopTest();
        
        system.assertNotEquals(null, records,
            'There should be a collection');
        system.assert(!records.isEmpty(),
            'There should be at least one login for the running user');
        for (LoginHistory record : records)
        {
            system.assertEquals(UserInfo.getUserId(), record.UserId,
                'The running user should own only their own login history');
        }
    }
    
    static testmethod void testWhere()
    {
        Test.startTest();
            List<User> records = new Builder(User.sObjectType)
                .whereX(new Filter('Id').equals(UserInfo.getUserId()))
                .andX(new Filter('CreatedDate').isLessThanOrEqualTo(DateLiteral.today()))
                .orX(new Filter('CreatedDate').isGreaterThan(DateLiteral.today()))
                .getRecords();
        Test.stopTest();
        
        system.assertEquals(1, records.size(),
            'No records can be created in the future');
    }
    
    static testmethod void testWithUserId()
    {
        Test.startTest();
            String soql = new Builder(User.sObjectType)
                .withUserId(UserInfo.getUserId()).toString();
        Test.stopTest();
        
        system.assertNotEquals(null, soql,
            'A clause should be generated');
        system.assert(soql.endsWith(' WITH UserId=\'' + UserInfo.getUserId() + '\''),
            'The correct WITH clause should be generated - ' + soql);
    }
    static testmethod void testWithDataCategory()
    {
        String categoryGroup = 'Group__c',
            category1 = 'Category1__c',
            category2 = 'Category2__c';
        
        Test.startTest();
            String soql = new Builder(User.sObjectType)
                .withDataCategory(new DataCategory(categoryGroup).above(category1))
                .andX(new DataCategory(categoryGroup).below(category2)).toString();
        Test.stopTest();
        
        String above = String.valueOf(DataCategory.Selector.ABOVE),
            below = String.valueOf(DataCategory.Selector.BELOW);
        String expectedClause = ' WITH DATA CATEGORY ' +
            categoryGroup + ' ' + above + ' ' + category1 + ' AND ' +
            categoryGroup + ' ' + below + ' ' + category2;
        system.debug(expectedClause);
        system.debug(soql);
        system.assert(soql.endsWith(expectedClause),
            'The clause should be properly generated - ' + soql);
    }
    
    static testmethod void testGroupBy()
    {
        Test.startTest();
            List<AggregateResult> loginsToday = new Builder(LoginHistory.sObjectType)
                .selectX(new FieldExpression('UserId').alias('Id'))
                .whereX(new Filter(LoginHistory.LoginTime).equals(Dateliteral.today()))
                .groupBy(LoginHistory.UserId).getRecords();
        Test.stopTest();
        
        system.assertNotEquals(null, loginsToday,
            'A collection should be returned');
        Map<Id, SObject> userIdsLoggedInToday = new Map<Id, SObject>(loginsToday);
        system.assert(userIdsLoggedInToday.containsKey(UserInfo.getUserId()),
            'The running user must have logged in today');
    }
    static testmethod void testHaving()
    {
        Test.startTest();
            List<AggregateResult> loginsToday = new Builder(LoginHistory.sObjectType)
                .selectX(new FieldExpression('UserId').alias('Id'))
                .whereX(new Filter(LoginHistory.LoginTime).equals(Dateliteral.today()))
                .groupBy(LoginHistory.UserId)
                .havingX(new Filter('UserId').equals(UserInfo.getUserId()))
                .andX(new Filter(FieldExpression.count('LoginTime')).isGreaterThan(0))
                .getRecords();
        Test.stopTest();
        
        system.assertNotEquals(null, loginsToday,
            'A collection should be returned');
        Map<Id, SObject> userIdsLoggedInToday = new Map<Id, SObject>(loginsToday);
        system.assert(userIdsLoggedInToday.containsKey(UserInfo.getUserId()),
            'The running user must have logged in today');
    }
    static testmethod void testHaving_Or()
    {
        Test.startTest();
            List<AggregateResult> loginsToday = new Builder(LoginHistory.sObjectType)
                .selectX(new FieldExpression('UserId').alias('Id'))
                .whereX(new Filter(LoginHistory.LoginTime).equals(Dateliteral.today()))
                .groupBy(LoginHistory.UserId).havingX(new Filter('UserId').equals(null))
                .orX(new Filter('UserId').equals(UserInfo.getUserId())).getRecords();
        Test.stopTest();
        
        system.assertNotEquals(null, loginsToday,
            'A collection should be returned');
        Map<Id, SObject> userIdsLoggedInToday = new Map<Id, SObject>(loginsToday);
        system.assert(userIdsLoggedInToday.containsKey(UserInfo.getUserId()),
            'The running user must have logged in today');
    }
    
    static testmethod void testGroupByRollup()
    {
        SObjectField field = User.ProfileId;
        String name = String.valueOf(field);
        
        Test.startTest();
            List<AggregateResult> aggregates = new Builder(User.sObjectType)
                .selectX(new FieldExpression(name).alias('Id'))
                .groupByRollup(field).getRecords();
        Test.stopTest();
        
        Map<Id, SObject> results = new Map<Id, SObject>();
        for (AggregateResult aggregate : aggregates)
            results.put(aggregate.Id, aggregate);
        // null Id would throw the following exception:
        // System.ListException: Row with null Id at index: 4
        
        system.assert(results.containsKey(UserInfo.getProfileId()),
            'Each profile should be rolled up');
    }
    
    static testmethod void testGroupByCube()
    {
        SObjectField field = User.ProfileId;
        String name = String.valueOf(field);
        
        Test.startTest();
            List<AggregateResult> aggregates = new Builder(User.sObjectType)
                .selectX(new FieldExpression(name).alias('Id'))
                .groupByCube(field)
                .getRecords();
        Test.stopTest();
        
        Map<Id, SObject> results = new Map<Id, SObject>();
        for (AggregateResult aggregate : aggregates)
            results.put(aggregate.Id, aggregate);
        // null Id would throw the following exception:
        // System.ListException: Row with null Id at index: 0
        system.assert(results.containsKey(UserInfo.getProfileId()),
            'Each profile should be rolled up');
    }
    
    static testmethod void testOrderBy()
    {
        Test.startTest();
            List<Profile> profiles = new Builder(Profile.sObjectType)
                .orderBy(Profile.Id).getRecords();
        Test.stopTest();
        
        Id pointer = profiles[0].Id;
        for (Integer i = 1; i < profiles.size(); i++)
        {
            system.assert(pointer < profiles[i].Id,
                'The records should be ordered properly');
            pointer = profiles[i].Id;
        }
    }
    
    static testmethod void testLimit()
    {
        Test.startTest();
            List<Profile> profiles = new Builder(Profile.sObjectType)
                .orderBy('Id').limitX(1).getRecords();
        Test.stopTest();
        
        system.assertEquals(1, profiles.size(),
            'The record limit should be respected');
    }
    static testmethod void testOffset()
    {
        List<Profile> orderedProfiles = [SELECT Id FROM Profile ORDER BY Id LIMIT 2];
        
        Test.startTest();
            List<Profile> profiles = new Builder(Profile.sObjectType)
                .orderBy('Id').limitX(1).offset(1).getRecords();
        Test.stopTest();
        
        system.assertEquals(orderedProfiles[1].Id, profiles[0].Id,
            'The record offset should be respected');
    }
    
    static testmethod void testForView()
    {
        Test.startTest();
            String soql = new Builder(User.sObjectType).forView().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, soql,
            'A query should be generated');
        system.assert(soql.endsWith(' FOR VIEW'),
            'The query must include the specified clause');
    }
    static testmethod void testForReference()
    {
        Test.startTest();
            String soql = new Builder(User.sObjectType).forReference().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, soql,
            'A query should be generated');
        system.assert(soql.endsWith(' FOR REFERENCE'),
            'The query must include the specified clause');
    }
    static testmethod void testForUpdate()
    {
        Test.startTest();
            String soql = new Builder(User.sObjectType).forUpdate().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, soql,
            'A query should be generated');
        system.assert(soql.endsWith(' FOR UPDATE'),
            'The query must include the specified clause');
    }
    
    static testmethod void testUpdateClauses()
    {
        Test.startTest();
            String soql = new Builder(User.sObjectType)
                .updateTracking().updateViewStat().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, soql, 'A query should be generated');
        system.assert(soql.endsWith('UPDATE TRACKING,VIEWSTAT'),
            'Both update clauses should be included');
    }
    
    static testmethod void testQueryChildren()
    {
        Test.startTest();
            Profile runningUserProfile = (Profile)new Builder(Profile.sObjectType)
                .whereX(new Filter(Profile.Id).equals(UserInfo.getProfileId()))
                .queryChildren('Users').getRecord();
        Test.stopTest();
        
        system.assertNotEquals(null, runningUserProfile.Users,
            'There should be users assigned to this Profile');
        Set<Id> userIds = new Map<Id, User>(runningUserProfile.Users).keySet();
        system.assert(userIds.contains(UserInfo.getUserId()),
            'The running user should be assigned to this Profile');
    }
}
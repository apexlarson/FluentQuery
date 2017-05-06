@IsTest
class DescribeCacheTests
{
    static testmethod void testGetChildRelationship()
    {
        final SObjectType type = PermissionSet.sObjectType;
        
        Test.startTest();
            ChildRelationship fieldPerms = DescribeCache.getChildRelationship(type, 'FieldPerms');
            ChildRelationship objectPerms = DescribeCache.getChildRelationship(type, 'ObjectPerms');
            ChildRelationship assignments = DescribeCache.getChildRelationship(type, 'Assignments');
        Test.stopTest();
        
        system.assertNotEquals(null, fieldPerms, 'The relationship should be found');
        system.assertEquals(SObjectType.FieldPermissions.getSObjectType(), fieldPerms.getChildSObject(),
            'The correct relationship should be found');
        
        system.assertNotEquals(null, objectPerms, 'The relationship should be found');
        system.assertEquals(SObjectType.ObjectPermissions.getSObjectType(), objectPerms.getChildSObject(),
            'The correct relationship should be found');
        
        system.assertNotEquals(null, assignments, 'The relationship should be found');
        system.assertEquals(PermissionSetAssignment.sObjectType, assignments.getChildSObject(),
            'The correct relationship should be found');
    }
    
    static testMethod void testGetField()
    {
        Test.startTest();
        	SObjectField field = DescribeCache.getField(User.sObjectType, 'Name');
        Test.stopTest();
        
        system.assertEquals(User.Name, field, 'The correct field should be retrieved');
    }
    static testMethod void testGetField_DNE()
    {
        Test.startTest();
        	SObjectField field = DescribeCache.getField(User.sObjectType, 'Bogus');
        Test.stopTest();
        
        system.assertEquals(null, field,
            'Field names which do not exist should result in a null return value');
    }
    static testMethod void testGetField_CrossObject()
    {
        Test.startTest();
        	SObjectField field = DescribeCache.getField(User.sObjectType, 'Profile.Name');
        Test.stopTest();
        
        system.assertEquals(Profile.Name, field, 'The correct field should be retrieved');
    }
    static testMethod void testGetField_CrossObject_DNE()
    {
        Test.startTest();
        	SObjectField field = DescribeCache.getField(User.sObjectType, 'Bogus.Name');
        Test.stopTest();
        
        system.assertEquals(null, field,
            'Relationship names which do not exist should result in a null return value');
    }
}
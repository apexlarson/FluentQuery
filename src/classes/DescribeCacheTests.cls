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
}
@IsTest
class PermissionsMockTests
{
    static final SObjectType SOBJECT_TYPE = Account.sObjectType;
    static final SObjectField FIELD = Account.Name;
    static final Boolean IS_ACCESSIBLE = FIELD.getDescribe().isAccessible();
    
    static testmethod void testWhitelist_Positive()
    {
        String fieldPath = String.valueOf(FIELD);
        FieldExpression expression = new FieldExpression(fieldPath);
        FieldOrder ordering = new FieldOrder(FIELD);
        Filter filter = new Filter(FIELD).equals(null);
        
        Test.startTest();
            PermissionsMock.whitelist(fieldPath);
            PermissionsMock.whitelist(SOBJECT_TYPE);
            Permissions.setMock(new PermissionsMock());
            
            Boolean isObjectAccessible = Permissions.isAccessible(SOBJECT_TYPE);
            Boolean isFieldPathAccessible = Permissions.isAccessible(SOBJECT_TYPE, fieldPath);
            Boolean isFieldExpressionAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
            Boolean isFieldOrderAccessible = Permissions.isAccessible(SOBJECT_TYPE, ordering);
            Boolean isFilterAccessible = Permissions.isAccessible(SOBJECT_TYPE, filter);
        Test.stopTest();
        
        system.assertequals(true, isObjectAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFilterAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFieldExpressionAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFieldOrderAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFilterAccessible, 'The proper mock should be set');
    }
    static testmethod void testWhitelist_Negaitive()
    {
        String fieldPath = String.valueOf(FIELD);
        FieldExpression expression = new FieldExpression(fieldPath);
        FieldOrder ordering = new FieldOrder(FIELD);
        Filter filter = new Filter(FIELD).equals(null);
        
        Test.startTest();
            Permissions.setMock(new PermissionsMock());
            
            Boolean isObjectAccessible = Permissions.isAccessible(SOBJECT_TYPE);
            Boolean isFieldPathAccessible = Permissions.isAccessible(SOBJECT_TYPE, fieldPath);
            Boolean isFieldExpressionAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
            Boolean isFieldOrderAccessible = Permissions.isAccessible(SOBJECT_TYPE, ordering);
            Boolean isFilterAccessible = Permissions.isAccessible(SOBJECT_TYPE, filter);
        Test.stopTest();
        
        system.assertequals(false, isObjectAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFilterAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFieldExpressionAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFieldOrderAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFilterAccessible, 'The proper mock should be set');
    }
    
    static testmethod void testAll()
    {
        String fieldPath = String.valueOf(FIELD);
        FieldExpression expression = new FieldExpression(fieldPath);
        FieldOrder ordering = new FieldOrder(FIELD);
        Filter filter = new Filter(FIELD).equals(null);
        
        Test.startTest();
            Permissions.setMock(new PermissionsMock.All());
            
            Boolean isObjectAccessible = Permissions.isAccessible(SOBJECT_TYPE);
            Boolean isFieldPathAccessible = Permissions.isAccessible(SOBJECT_TYPE, fieldPath);
            Boolean isFieldExpressionAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
            Boolean isFieldOrderAccessible = Permissions.isAccessible(SOBJECT_TYPE, ordering);
            Boolean isFilterAccessible = Permissions.isAccessible(SOBJECT_TYPE, filter);
        Test.stopTest();
        
        system.assertequals(true, isObjectAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFilterAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFieldExpressionAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFieldOrderAccessible, 'The proper mock should be set');
        system.assertEquals(true, isFilterAccessible, 'The proper mock should be set');
    }
    static testmethod void testNone()
    {
        String fieldPath = String.valueOf(FIELD);
        FieldExpression expression = new FieldExpression(fieldPath);
        FieldOrder ordering = new FieldOrder(FIELD);
        Filter filter = new Filter(FIELD).equals(null);
        
        Test.startTest();
            PermissionsMock.whitelist(fieldPath);
            PermissionsMock.whitelist(SOBJECT_TYPE);
            Permissions.setMock(new PermissionsMock.None());
            
            Boolean isObjectAccessible = Permissions.isAccessible(SOBJECT_TYPE);
            Boolean isFieldPathAccessible = Permissions.isAccessible(SOBJECT_TYPE, fieldPath);
            Boolean isFieldExpressionAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
            Boolean isFieldOrderAccessible = Permissions.isAccessible(SOBJECT_TYPE, ordering);
            Boolean isFilterAccessible = Permissions.isAccessible(SOBJECT_TYPE, filter);
        Test.stopTest();
        
        system.assertequals(false, isObjectAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFilterAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFieldExpressionAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFieldOrderAccessible, 'The proper mock should be set');
        system.assertEquals(false, isFilterAccessible, 'The proper mock should be set');
    }
}
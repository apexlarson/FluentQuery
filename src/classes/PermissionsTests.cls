@IsTest
class PermissionsTests
{
    static final SObjectType SOBJECT_TYPE = Account.sObjectType;
    static final SObjectField FIELD = Account.JigsawCompanyId;
    static final String FIELD_PATH = String.valueOf(FIELD);
    
    static final Boolean IS_OBJECT_ACCESSIBLE = SOBJECT_TYPE.getDescribe().isAccessible();
    static final Boolean IS_FIELD_ACCESSIBLE = FIELD.getDescribe().isAccessible();
    
    static testmethod void testIsAccessible_SObjectType()
    {
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE);
        Test.stopTest();
        
        system.assertEquals(IS_OBJECT_ACCESSIBLE, isAccessible,
            'Object permissions should be correctly retrieved');
    }
    
    static testmethod void testIsAccessible_FieldPath()
    {
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, FIELD_PATH);
        Test.stopTest();
        
        system.assertEquals(IS_FIELD_ACCESSIBLE, isAccessible,
            'Field permissions should be correctly retrieved');
    }
    
    static testmethod void testIsAccessible_FieldExpression_Null()
    {
        FieldExpression expression;
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(false, isAccessible,
            'A FieldExpression which is null should not be accessible');
    }
    static testmethod void testIsAccessible_FieldExpression_Count()
    {
        FieldExpression expression = FieldExpression.count();
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(true, isAccessible,
            'The count() expression should always be accessible');
    }
    static testmethod void testIsAccessible_FieldExpression_FieldPath()
    {
        FieldExpression expression = new FieldExpression(FIELD_PATH);
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(IS_FIELD_ACCESSIBLE, isAccessible,
            'Field permissions should be correctly retrieved');
    }
    static testmethod void testIsAccessible_FieldExpression()
    {
        FieldExpression expression = FieldExpression.max(FIELD);
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(IS_FIELD_ACCESSIBLE, isAccessible,
            'Field permissions should be correctly retrieved');
    }
    static testmethod void testIsAccessible_FieldExpression_Builder()
    {
        FieldExpression expression = new FieldExpression(new Builder(SOBJECT_TYPE));
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(IS_OBJECT_ACCESSIBLE, isAccessible,
            'Object permissions should be correctly retrieved');
    }
    
    static testmethod void testIsAccessible_FieldOrder_Null()
    {
        FieldOrder ordering;
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, ordering);
        Test.stopTest();
        
        system.assertEquals(false, isAccessible,
            'A FieldOrder which is null should not be accessible');
    }
    static testmethod void testIsAccessible_FieldOrder()
    {
        FieldOrder ordering = new FieldOrder(FIELD).descending().nullsLast();
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, ordering);
        Test.stopTest();
        
        system.assertEquals(IS_FIELD_ACCESSIBLE, isAccessible,
            'Field permissions should be correctly retrieved');
    }
    
    static testmethod void testIsAccessible_Expression_Null()
    {
        Predicate.Expression expression;
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(false, isAccessible,
            'A FieldOrder which is null should not be accessible');
    }
    static testmethod void testIsAccessible_Expression_DataCategory()
    {
        Predicate.Expression expression = new DataCategory('SomeCategoryGroup__c');
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(true, isAccessible,
            'Every DataCategory should be accessible');
    }
    static testmethod void testIsAccessible_Expression_Filter()
    {
        Predicate.Expression expression = new Filter(FIELD).doesNotEqual(null);
        
        Test.startTest();
            Boolean isAccessible = Permissions.isAccessible(SOBJECT_TYPE, expression);
        Test.stopTest();
        
        system.assertEquals(true, isAccessible,
            'Field permissions should be correctly retrieved');
    }
}
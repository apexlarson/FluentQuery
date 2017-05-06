@IsTest
class DataCategoryTests
{
    static final String CATEGORY = 'Some_Category__c';
    static final String VALUE = 'Some_Value__c';
    
    static testmethod void testFieldPath()
    {
        Test.startTest();
            String fieldPath = new DataCategory(CATEGORY).getFieldPath();
        Test.stopTest();
        
        system.assertEquals(null, fieldPath,
            'A Data Category should not have a field path');
    }
    static testmethod void testAt()
    {
        Test.startTest();
            String clause = new DataCategory(CATEGORY).at(VALUE).toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(CATEGORY),
            'The clause should begin with the category group name');
        system.assert(clause.contains(String.valueOf(DataCategory.Selector.AT)),
            'The clause should contain the filtering selector');
        system.assert(clause.endsWith(VALUE),
            'The clause should end with the category name');
    }
    static testmethod void testAbove()
    {
        Test.startTest();
            String clause = new DataCategory(CATEGORY).above(VALUE).toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(CATEGORY),
            'The clause should begin with the category group name');
        system.assert(clause.contains(String.valueOf(DataCategory.Selector.ABOVE)),
            'The clause should contain the filtering selector');
        system.assert(clause.endsWith(VALUE),
            'The clause should end with the category name');
    }
    static testmethod void testBelow()
    {
        Test.startTest();
            String clause = new DataCategory(CATEGORY).below(VALUE).toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(CATEGORY),
            'The clause should begin with the category group name');
        system.assert(clause.contains(String.valueOf(DataCategory.Selector.BELOW)),
            'The clause should contain the filtering selector');
        system.assert(clause.endsWith(VALUE),
            'The clause should end with the category name');
    }
    static testmethod void testAboveOrBelow()
    {
        Test.startTest();
            String clause = new DataCategory(CATEGORY).aboveOrBelow(VALUE).toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(CATEGORY),
            'The clause should begin with the category group name');
        system.assert(clause.contains(String.valueOf(DataCategory.Selector.ABOVE_OR_BELOW)),
            'The clause should contain the filtering selector');
        system.assert(clause.endsWith(VALUE),
            'The clause should end with the category name');
    }
}
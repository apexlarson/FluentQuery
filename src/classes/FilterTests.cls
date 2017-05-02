@IsTest
class FilterTests
{
    static final SObjectField FIELD = Account.Id;
    static final String FIELD_NAME = String.valueOf(FIELD);
    static final String FORMATTED_VALUE = 'null';
    static final ID VALUE;
    
    static testmethod void testDoesNotEqual()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .doesNotEqual(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + '!=' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testEquals()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .equals(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + '=' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testExcludes()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .excludes(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + ' EXCLUDES ' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIncludes()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .includes(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + ' INCLUDES ' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsGreaterThan()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isGreaterThan(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + '>' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsGreaterThanOrEqualTo()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isGreaterThanOrEqualTo(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + '>=' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsIn()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isIn(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + ' IN ' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsLessThan()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isLessThan(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + '<' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsLessThanOrEqualTo()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isLessThanOrEqualTo(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + '<=' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsLike()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isLike(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + ' LIKE ' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
    static testmethod void testIsNotIn()
    {
        Test.startTest();
            String clause = new Filter(FIELD)
                .isNotIn(VALUE).toString();
        Test.stopTest();
        
        String expected = FIELD_NAME + ' NOT IN ' + FORMATTED_VALUE;
        system.assertEquals(expected, clause,
            'The proper clause should be generated');
    }
}
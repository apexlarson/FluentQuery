@IsTest
class FieldOrderTests
{
    static final String NAME = 'Name';
    
    static testmethod void testSObjectField()
    {
        final SObjectField field = Account.Id;
        
        Test.startTest();
            String clause = new FieldOrder(field).toString();
        Test.stopTest();
        
        system.assertEquals(String.valueOf(field), clause,
            'The clause should contain only the field name');
    }
    static testmethod void testString()
    {
        final String field = 'Name';
        
        Test.startTest();
            String clause = new FieldOrder(field).toString();
        Test.stopTest();
        
        system.assertEquals(field, clause,
            'The clause should contain only the field name');
    }
    static testmethod void testFieldExpression()
    {
        final FieldExpression field = new FieldExpression('CreatedById');
        
        Test.startTest();
            String clause = new FieldOrder(field).toString();
        Test.stopTest();
        
        system.assertEquals(field.toString(), clause,
            'The clause should contain only the field name');
    }
    
    static testmethod void testAscending()
    {
        Test.startTest();
            String clause = new FieldOrder(NAME).ascending().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(NAME),
            'The clause should begin with the field');
        system.assert(clause.endsWith(' ASC'),
            'The order should be ascending');
    }
    static testmethod void testDescending()
    {
        Test.startTest();
            String clause = new FieldOrder(NAME).descending().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(NAME),
            'The clause should begin with the field');
        system.assert(clause.endsWith(' DESC'),
            'The order should be ascending');
    }
    
    static testmethod void testNullsFirst()
    {
        Test.startTest();
            String clause = new FieldOrder(NAME).nullsFirst().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(NAME),
            'The clause should begin with the field');
        system.assert(clause.endsWith(' NULLS FIRST'),
            'The order should be ascending');
    }
    static testmethod void testNullsLast()
    {
        Test.startTest();
            String clause = new FieldOrder(NAME).nullsLast().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(NAME),
            'The clause should begin with the field');
        system.assert(clause.endsWith(' NULLS LAST'),
            'The order should be ascending');
    }
    
    static testmethod void testOrderComposition()
    {
        Test.startTest();
            String clause = new FieldOrder(NAME)
                .ascending().nullsLast().toString();
        Test.stopTest();
        
        system.assertNotEquals(null, clause,
            'A clause should be generated');
        system.assert(clause.startsWith(NAME),
            'The clause should begin with the field');
        system.assert(clause.contains(' ASC '),
            'The order should be ascending');
        system.assert(clause.endsWith(' NULLS LAST'),
            'The order should be ascending');
    }
}
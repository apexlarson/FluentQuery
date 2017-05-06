@IsTest
class PredicateTests
{
    static Integer clauseNumber = 1;
    class Expression implements Predicate.Expression
    {
        public override String toString()
        {
            return String.valueOf(clauseNumber++);
        }
        public String getFieldPath() { return null; }
    }
    
    static testmethod void smokeTestVirtualProperties()
    {
        Predicate p = new Predicate(new Expression());
        
        Exception unexpectedException;
        Test.startTest();
            try
            {
                p.getDelimiter();
                p.sharesType(p);
            }
            catch (Exception smoke)
            {
                unexpectedException = smoke;
            }
        Test.stopTest();
    }
    
    static testmethod void testSingleExpression()
    {
        Test.startTest();
            String clause = new Predicate(new Expression()).toString();
        Test.stopTest();
        
        system.assertEquals('1', clause,
            'The clause should contain only the expression');
    }
    static testmethod void testAndExpression()
    {
        Expression a = new Expression(), b = new Expression();
        
        Test.startTest();
            String clause = new Predicate(a).andX(b).toString();
        Test.stopTest();
        
        system.assertEquals('1 AND 2', clause,
            'The clause should contain the expression joined by AND');
    }
    static testmethod void testOrExpression()
    {
        Expression a = new Expression(), b = new Expression();
        
        Test.startTest();
            String clause = new Predicate(a).orX(b).toString();
        Test.stopTest();
        
        system.assertEquals('1 OR 2', clause,
            'The clause should contain the expressions joined by OR');
    }
    
    static testmethod void testComposition_AndAnd()
    {
        Expression a = new Expression(),
            b = new Expression(),
            c = new Expression();
        
        Test.startTest();
            String clause = new Predicate(a).andX(b).andX(c).toString();
        Test.stopTest();
        
        system.assertEquals('1 AND 2 AND 3', clause,
            'The clause should contain the expressions joined appropriately');
    }
    static testmethod void testComposition_AndOr()
    {
        Expression a = new Expression(),
            b = new Expression(),
            c = new Expression();
        
        Test.startTest();
            String clause = new Predicate(a).andX(b).orX(c).toString();
        Test.stopTest();
        
        system.assertEquals('(1 AND 2) OR 3', clause,
            'The clause should contain the expressions joined appropriately');
    }
    static testmethod void testComposition_OrAnd()
    {
        Expression a = new Expression(),
            b = new Expression(),
            c = new Expression();
        
        Test.startTest();
            String clause = new Predicate(a).orX(b).andX(c).toString();
        Test.stopTest();
        
        system.assertEquals('(1 OR 2) AND 3', clause,
            'The clause should contain the expressions joined appropriately');
    }
    static testmethod void testComposition_OrOr()
    {
        Expression a = new Expression(),
            b = new Expression(),
            c = new Expression();
        
        Test.startTest();
            String clause = new Predicate(a).orX(b).orX(c).toString();
        Test.stopTest();
        
        system.assertEquals('1 OR 2 OR 3', clause,
            'The clause should contain the expressions joined appropriately');
    }
    
    static testmethod void testComposition_PredicateAndPredicate()
    {
        Expression a = new Expression(),
            b = new Expression(),
            c = new Expression(),
            d = new Expression();
        Predicate p1 = new Predicate(a).andX(b),
            p2 = new Predicate(c).andX(d);
        
        Test.startTest();
            String clause = p1.andX(p2).toString();
        Test.stopTest();
        
        system.assertEquals('1 AND 2 AND 3 AND 4', clause,
            'The clause should contain the expressions joined appropriately');
    }
    
    static testmethod void testRespectPermissions_SingleExpression()
    {
        Filter filter = new Filter('Id').doesNotEqual(null);
        
        Test.startTest();
            Permissions.setMock(new PermissionsMock.None());
            Predicate predicate = new Predicate(filter).respectPermissions(User.sObjectType);
        Test.stopTest();
        
        system.assertEquals(null, predicate,
            'Each expression should be removed if it expresses a field path which is not accessible');
    }
    static testmethod void testRespectPermissions_Composition()
    {
        Filter a = new Filter('CreatedDate').isGreaterThan(DateLiteral.today());
        Filter b = new Filter('CreatedDate').isLessThan(DateLiteral.today());
        
        Test.startTest();
            Permissions.setMock(new PermissionsMock.None());
            Predicate predicate = new Predicate(a).orX(b).respectPermissions(User.sObjectType);
        Test.stopTest();
        
        system.assertEquals(null, predicate,
            'Each expression should be removed if it expresses a field path which is not accessible');
    }
}
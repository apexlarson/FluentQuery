@IsTest
class PredicateTests
{
    static final String DELIMITER = ' ||| ';
    
    static Integer clauseNumber = 1;
    class Expression implements Predicate.Expression
    {
        public override String toString()
        {
            return String.valueOf(clauseNumber++);
        }
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
}
@IsTest
class ValueFormatterTests
{
    class CustomType { }
    
    static testmethod void testFormat_Null()
    {
        Test.startTest();
            String formatted = ValueFormatter.format((String)null);
        Test.stopTest();
        
        system.assertEquals('null', formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_Builder()
    {
        Builder b = new Builder(Account.sObjectType);
        
        Test.startTest();
            String formatted = ValueFormatter.format(b);
        Test.stopTest();
        
        system.assertEquals('(' + b.toString() + ')', formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_DateLiteral()
    {
        Test.startTest();
            String formatted = ValueFormatter.format(DateLiteral.today());
        Test.stopTest();
        
        system.assertEquals(String.valueOf(DateLiteral.Expression.TODAY), formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_Boolean()
    {
        Test.startTest();
            String formatted = ValueFormatter.format(true);
        Test.stopTest();
        
        system.assertEquals('true', formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_Double()
    {
        Test.startTest();
            String formatted = ValueFormatter.format(1);
        Test.stopTest();
        
        system.assertEquals('1', formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_String()
    {
        Test.startTest();
            String formatted = ValueFormatter.format('\'injection!\'');
        Test.stopTest();
        
        system.assertEquals('\'\\\'injection!\\\'\'', formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_Date()
    {
        Date input = Date.today();
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        Integer y = input.year(), m = input.month(), d = input.day();
        String yyyy = String.valueOf(y),
            mm = String.valueOf(m).leftPad(2, '0'),
            dd = String.valueOf(d).leftPad(2, '0');
        system.assertEquals(yyyy + '-' + mm + '-' + dd, formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormat_Datetime()
    {
        Datetime input = Datetime.now();
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals(input.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\''), formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormat_CustomType()
    {
        CustomType input = new CustomType();
        
        ValueFormatter.FormattingException expectedException;
        Test.startTest();
            try
            {
                ValueFormatter.format(input);
            }
            catch (ValueFormatter.FormattingException f)
            {
                expectedException = f;
            }
        Test.stopTest();
        
        system.assertNotEquals(null, expectedException,
            'Formatting unsupported types should throw an exception');
    }
    static testMethod void testFormatCollection_String()
    {
        Set<String> input = new Set<String> { 'a', 'b', 'c' };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals('(\'a\',\'b\',\'c\')', formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormatCollection_Integer()
    {
        Set<Integer> input = new Set<Integer> { 1, 2, 3 };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals('(1,2,3)', formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormatCollection_Decimal()
    {
        Set<Decimal> input = new Set<Decimal> { 10.0, 22.2, 30.3 };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals('(10.0,22.2,30.3)', formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormatCollection_Double()
    {
        Set<Double> input = new Set<Double> { 3.1, 3.14, 3.141 };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals('(3.1,3.14,3.141)', formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormatCollection_Long()
    {
        Set<Long> input = new Set<Long> { 5, 4, 3 };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals('(5,4,3)', formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormatCollection_Date()
    {
        Date today = Date.today();
        Set<Date> input = new Set<Date> { Date.today() };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        Integer y = today.year(), m = today.month(), d = today.day();
        String yyyy = String.valueOf(y),
            mm = String.valueOf(m).leftPad(2, '0'),
            dd = String.valueOf(d).leftPad(2, '0');
        system.assertEquals('(' + yyyy + '-' + mm + '-' + dd + ')', formatted,
            'The input should be properly formatted');
    }
    static testmethod void testFormatCollection_Datetime()
    {
        Datetime now = Datetime.now();
        Set<Datetime> input = new Set<Datetime> { now };
        
        Test.startTest();
            String formatted = ValueFormatter.format(input);
        Test.stopTest();
        
        system.assertEquals('(' + now.format('yyyy-MM-dd\'T\'HH:mm:ss\'Z\'') + ')', formatted,
            'The input should be properly formatted');
    }
    static testMethod void testFormatCollection_CustomType()
    {
        List<CustomType> input = new List<CustomType> { new CustomType() };
        
        ValueFormatter.FormattingException expectedException;
        Test.startTest();
            try
            {
                ValueFormatter.format(input);
            }
            catch (ValueFormatter.FormattingException f)
            {
                expectedException = f;
            }
        Test.stopTest();
        
        system.assertNotEquals(null, expectedException,
            'Formatting unsupported types should throw an exception');
    }
}
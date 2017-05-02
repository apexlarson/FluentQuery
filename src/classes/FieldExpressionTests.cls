@IsTest
class FieldExpressionTests
{
    static final SObjectField FIELD = Account.CreatedDate;
    static final SObjectField FIELD2 = Account.Id;
    
    static testmethod void testField()
    {
        String name = String.valueOf(FIELD);
        
        Test.startTest();
            FieldExpression expression = new FieldExpression(name);
        Test.stopTest();
        
        system.assertEquals(name, expression.toString(),
            'The proper function should wrap the field');
    }
    static testMethod void testAlias()
    {
        String name = String.valueOf(FIELD), alias='something';
        
        Test.startTest();
            FieldExpression expression = new FieldExpression(name).alias(alias);
        Test.stopTest();
        
        system.assertEquals(name + ' ' + alias, expression.toString(),
            'The proper function should wrap the field');
    }
    static testMethod void testAlias_ContainsSpace()
    {
        String name = String.valueOf(FIELD), alias='something else';
        
        InvalidAliasException expectedException;
        Test.startTest();
            try { new FieldExpression(name).alias(alias).toString(); }
            catch (InvalidAliasException e) { expectedException = e; }
        Test.stopTest();
        
        system.assertNotEquals(null, expectedException,
            'An alias with spaces should not be allowed');
    }
    static testmethod void testCalendarMonth()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.calendarMonth(FIELD);
            FieldExpression wrapped = FieldExpression.calendarMonth(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.CALENDAR_MONTH);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testCalendarQuarter()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.calendarQuarter(FIELD);
            FieldExpression wrapped = FieldExpression.calendarQuarter(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.CALENDAR_QUARTER);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testCalendarYear()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.calendarYear(FIELD);
            FieldExpression wrapped = FieldExpression.calendarYear(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.CALENDAR_YEAR);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testDayInMonth()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.dayInMonth(FIELD);
            FieldExpression wrapped = FieldExpression.dayInMonth(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.DAY_IN_MONTH);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testDayInWeek()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.dayInWeek(FIELD);
            FieldExpression wrapped = FieldExpression.dayInWeek(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.DAY_IN_WEEK);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testDayInYear()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.dayInYear(FIELD);
            FieldExpression wrapped = FieldExpression.dayInYear(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.DAY_IN_YEAR);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testDayOnly()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.dayOnly(FIELD);
            FieldExpression wrapped = FieldExpression.dayOnly(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.DAY_ONLY);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testFiscalMonth()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.fiscalMonth(FIELD);
            FieldExpression wrapped = FieldExpression.fiscalMonth(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.FISCAL_MONTH);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testFiscalQuarter()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.fiscalQuarter(FIELD);
            FieldExpression wrapped = FieldExpression.fiscalQuarter(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.FISCAL_QUARTER);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testFiscalYear()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.fiscalYear(FIELD);
            FieldExpression wrapped = FieldExpression.fiscalYear(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.FISCAL_YEAR);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testHourInDay()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.hourInDay(FIELD);
            FieldExpression wrapped = FieldExpression.hourInDay(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.HOUR_IN_DAY);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testWeekInMonth()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.weekInMonth(FIELD);
            FieldExpression wrapped = FieldExpression.weekInMonth(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.WEEK_IN_MONTH);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testWeekInYear()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.weekInYear(FIELD);
            FieldExpression wrapped = FieldExpression.weekInYear(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.WEEK_IN_YEAR);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testAvg()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.avg(FIELD);
            FieldExpression wrapped = FieldExpression.avg(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.AVG);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testCount()
    {
        Test.startTest();
            FieldExpression countExpression = FieldExpression.count();
            FieldExpression expression = FieldExpression.count(FIELD);
            FieldExpression wrapped = FieldExpression.count(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.COUNT);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
        system.assertEquals('COUNT()', countExpression.toString(),
            'The countQuery expression should be properly generated');
    }
    static testmethod void testCountDistinct()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.countDistinct(FIELD);
            FieldExpression wrapped = FieldExpression.countDistinct(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.COUNT_DISTINCT);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testMin()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.min(FIELD);
            FieldExpression wrapped = FieldExpression.min(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.MIN);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testMax()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.max(FIELD);
            FieldExpression wrapped = FieldExpression.max(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.MAX);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testSum()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.sum(FIELD);
            FieldExpression wrapped = FieldExpression.sum(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.SUM);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testConvertCurrency()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.convertCurrency(FIELD);
            FieldExpression wrapped = FieldExpression.convertCurrency(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.convertCurrency);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testConvertTimezone()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.convertTimezone(FIELD);
            FieldExpression wrapped = FieldExpression.convertTimezone(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.convertTimezone);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testFormat()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.format(FIELD);
            FieldExpression wrapped = FieldExpression.format(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.FORMAT);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testToLabel()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.toLabel(FIELD);
            FieldExpression wrapped = FieldExpression.toLabel(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.toLabel);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testRollup()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.rollup(FIELD);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.ROLLUP);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testRollup_Multiple()
    {
        List<SObjectField> fields = new List<SObjectField> { FIELD, FIELD2 };
        
        Test.startTest();
            FieldExpression expression = FieldExpression.rollup(fields);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.ROLLUP);
        system.assertEquals(function + '(' + FIELD + ',' + FIELD2 + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testCube()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.cube(FIELD);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.CUBE);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testCube_Multiple()
    {
        List<SObjectField> fields = new List<SObjectField> { FIELD, FIELD2 };
        
        Test.startTest();
            FieldExpression expression = FieldExpression.cube(fields);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.CUBE);
        system.assertEquals(function + '(' + FIELD + ',' + FIELD2 + ')', expression.toString(),
            'The proper function should wrap the field');
    }
    static testmethod void testGrouping()
    {
        Test.startTest();
            FieldExpression expression = FieldExpression.grouping(FIELD);
            FieldExpression wrapped = FieldExpression.grouping(expression);
        Test.stopTest();
        
        String function = String.valueOf(FieldExpression.Function.GROUPING);
        system.assertEquals(function + '(' + FIELD + ')', expression.toString(),
            'The proper function should wrap the field');
    }
}
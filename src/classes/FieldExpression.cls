global virtual class FieldExpression
{
    global Enum Function
    {
        CALENDAR_MONTH, CALENDAR_QUARTER, CALENDAR_YEAR,
        DAY_IN_MONTH, DAY_IN_WEEK, DAY_IN_YEAR, DAY_ONLY,
        FISCAL_MONTH, FISCAL_QUARTER, FISCAL_YEAR,
        HOUR_IN_DAY, WEEK_IN_MONTH, WEEK_IN_YEAR,
        AVG, COUNT, COUNT_DISTINCT, MIN, MAX, SUM,
        convertCurrency, convertTimezone, FORMAT, toLabel,
        ROLLUP, CUBE, GROUPING
    }
    
    public final SObjectType sObjectType;
    public final String expression, fieldPath;
    public final Function function;
    String alias;
    
    global FieldExpression(Builder builder)
    {
        this.expression = builder.toString();
        this.sObjectType = builder.sObjectType;
    }
    global FieldExpression(String field)
    {
        expression = fieldPath = field;
    }
    
    FieldExpression(String field, Function function)
    {
        this(field);
        this.function = function;
    }
    FieldExpression(FieldExpression that, Function function)
    {
        this.expression = that.toString();
        this.fieldPath = that.fieldPath;
        this.function = function;
    }
    global FieldExpression alias(String alias)
    {
        this.alias = alias;
        return this;
    }
    global override String toString()
    {
        if (sObjectType != null) return '(' + expression + ')';
        if (expression == null) return String.valueOf(function) + '()';
        String output = (function == null) ? expression :
            String.valueOf(function) + '(' + expression + ')';
        return applyAlias(output);
    }
    String applyAlias(String input)
    {
        if (alias == null) return input;
        if (alias.contains(' '))
            throw new InvalidAliasException(alias);
        return input + ' ' + alias;
    }
    
    global static FieldExpression calendarMonth(String field)
    {
        return new FieldExpression(field, Function.CALENDAR_MONTH);
    }
    global static FieldExpression calendarMonth(SObjectField field)
    {
        return calendarMonth(String.valueOf(field));
    }
    global static FieldExpression calendarMonth(FieldExpression field)
    {
        return new FieldExpression(field, Function.CALENDAR_MONTH);
    }
    
    global static FieldExpression calendarQuarter(String field)
    {
        return new FieldExpression(field, Function.CALENDAR_QUARTER);
    }
    global static FieldExpression calendarQuarter(SObjectField field)
    {
        return calendarQuarter(String.valueOf(field));
    }
    global static FieldExpression calendarQuarter(FieldExpression field)
    {
        return new FieldExpression(field, Function.CALENDAR_QUARTER);
    }
    
    global static FieldExpression calendarYear(String field)
    {
        return new FieldExpression(field, Function.CALENDAR_YEAR);
    }
    global static FieldExpression calendarYear(SObjectField field)
    {
        return calendarYear(String.valueOf(field));
    }
    global static FieldExpression calendarYear(FieldExpression field)
    {
        return new FieldExpression(field, Function.CALENDAR_YEAR);
    }
    
    global static FieldExpression dayInMonth(String field)
    {
        return new FieldExpression(field, Function.DAY_IN_MONTH);
    }
    global static FieldExpression dayInMonth(SObjectField field)
    {
        return dayInMonth(String.valueOf(field));
    }
    global static FieldExpression dayInMonth(FieldExpression field)
    {
        return new FieldExpression(field, Function.DAY_IN_MONTH);
    }
    
    global static FieldExpression dayInWeek(String field)
    {
        return new FieldExpression(field, Function.DAY_IN_WEEK);
    }
    global static FieldExpression dayInWeek(SObjectField field)
    {
        return dayInWeek(String.valueOf(field));
    }
    global static FieldExpression dayInWeek(FieldExpression field)
    {
        return new FieldExpression(field, Function.DAY_IN_WEEK);
    }
    
    global static FieldExpression dayInYear(String field)
    {
        return new FieldExpression(field, Function.DAY_IN_YEAR);
    }
    global static FieldExpression dayInYear(SObjectField field)
    {
        return dayInYear(String.valueOf(field));
    }
    global static FieldExpression dayInYear(FieldExpression field)
    {
        return new FieldExpression(field, Function.DAY_IN_YEAR);
    }
    
    global static FieldExpression dayOnly(String field)
    {
        return new FieldExpression(field, Function.DAY_ONLY);
    }
    global static FieldExpression dayOnly(SObjectField field)
    {
        return dayOnly(String.valueOf(field));
    }
    global static FieldExpression dayOnly(FieldExpression field)
    {
        return new FieldExpression(field, Function.DAY_ONLY);
    }
    
    global static FieldExpression fiscalMonth(String field)
    {
        return new FieldExpression(field, Function.FISCAL_MONTH);
    }
    global static FieldExpression fiscalMonth(SObjectField field)
    {
        return fiscalMonth(String.valueOf(field));
    }
    global static FieldExpression fiscalMonth(FieldExpression field)
    {
        return new FieldExpression(field, Function.FISCAL_MONTH);
    }
    
    global static FieldExpression fiscalQuarter(String field)
    {
        return new FieldExpression(field, Function.FISCAL_QUARTER);
    }
    global static FieldExpression fiscalQuarter(SObjectField field)
    {
        return fiscalQuarter(String.valueOf(field));
    }
    global static FieldExpression fiscalQuarter(FieldExpression field)
    {
        return new FieldExpression(field, Function.FISCAL_QUARTER);
    }
    
    global static FieldExpression fiscalYear(String field)
    {
        return new FieldExpression(field, Function.FISCAL_YEAR);
    }
    global static FieldExpression fiscalYear(SObjectField field)
    {
        return fiscalYear(String.valueOf(field));
    }
    global static FieldExpression fiscalYear(FieldExpression field)
    {
        return new FieldExpression(field, Function.FISCAL_YEAR);
    }
    
    global static FieldExpression hourInDay(String field)
    {
        return new FieldExpression(field, Function.HOUR_IN_DAY);
    }
    global static FieldExpression hourInDay(SObjectField field)
    {
        return hourInDay(String.valueOf(field));
    }
    global static FieldExpression hourInDay(FieldExpression field)
    {
        return new FieldExpression(field, Function.HOUR_IN_DAY);
    }
    
    global static FieldExpression weekInMonth(String field)
    {
        return new FieldExpression(field, Function.WEEK_IN_MONTH);
    }
    global static FieldExpression weekInMonth(SObjectField field)
    {
        return weekInMonth(String.valueOf(field));
    }
    global static FieldExpression weekInMonth(FieldExpression field)
    {
        return new FieldExpression(field, Function.WEEK_IN_MONTH);
    }
    
    global static FieldExpression weekInYear(String field)
    {
        return new FieldExpression(field, Function.WEEK_IN_YEAR);
    }
    global static FieldExpression weekInYear(SObjectField field)
    {
        return weekInYear(String.valueOf(field));
    }
    global static FieldExpression weekInYear(FieldExpression field)
    {
        return new FieldExpression(field, Function.WEEK_IN_YEAR);
    }
    
    global static FieldExpression avg(String field)
    {
        return new FieldExpression(field, Function.AVG);
    }
    global static FieldExpression avg(SObjectField field)
    {
        return avg(String.valueOf(field));
    }
    global static FieldExpression avg(FieldExpression field)
    {
        return new FieldExpression(field, Function.AVG);
    }
    
    global static FieldExpression count() { return count((String)null); }
    global static FieldExpression count(String field)
    {
        return new FieldExpression(field, Function.COUNT);
    }
    global static FieldExpression count(SObjectField field)
    {
        return count(String.valueOf(field));
    }
    global static FieldExpression count(FieldExpression field)
    {
        return new FieldExpression(field, Function.COUNT);
    }
    
    global static FieldExpression countDistinct(String field)
    {
        return new FieldExpression(field, Function.COUNT_DISTINCT);
    }
    global static FieldExpression countDistinct(SObjectField field)
    {
        return countDistinct(String.valueOf(field));
    }
    global static FieldExpression countDistinct(FieldExpression field)
    {
        return new FieldExpression(field, Function.COUNT_DISTINCT);
    }
    
    global static FieldExpression min(String field)
    {
        return new FieldExpression(field, Function.MIN);
    }
    global static FieldExpression min(SObjectField field)
    {
        return min(String.valueOf(field));
    }
    global static FieldExpression min(FieldExpression field)
    {
        return new FieldExpression(field, Function.MIN);
    }
    
    global static FieldExpression max(String field)
    {
        return new FieldExpression(field, Function.MAX);
    }
    global static FieldExpression max(SObjectField field)
    {
        return max(String.valueOf(field));
    }
    global static FieldExpression max(FieldExpression field)
    {
        return new FieldExpression(field, Function.MAX);
    }
    
    global static FieldExpression sum(String field)
    {
        return new FieldExpression(field, Function.SUM);
    }
    global static FieldExpression sum(SObjectField field)
    {
        return sum(String.valueOf(field));
    }
    global static FieldExpression sum(FieldExpression field)
    {
        return new FieldExpression(field, Function.SUM);
    }
    
    global static FieldExpression convertCurrency(String field)
    {
        return new FieldExpression(field, Function.convertCurrency);
    }
    global static FieldExpression convertCurrency(SObjectField field)
    {
        return convertCurrency(String.valueOf(field));
    }
    global static FieldExpression convertCurrency(FieldExpression field)
    {
        return new FieldExpression(field, Function.convertCurrency);
    }
    
    global static FieldExpression convertTimezone(String field)
    {
        return new FieldExpression(field, Function.convertTimezone);
    }
    global static FieldExpression convertTimezone(SObjectField field)
    {
        return convertTimezone(String.valueOf(field));
    }
    global static FieldExpression convertTimezone(FieldExpression field)
    {
        return new FieldExpression(field, Function.convertTimezone);
    }
    
    global static FieldExpression format(String field)
    {
        return new FieldExpression(field, Function.FORMAT);
    }
    global static FieldExpression format(SObjectField field)
    {
        return format(String.valueOf(field));
    }
    global static FieldExpression format(FieldExpression field)
    {
        return new FieldExpression(field, Function.FORMAT);
    }
    
    global static FieldExpression toLabel(String field)
    {
        return new FieldExpression(field, Function.toLabel);
    }
    global static FieldExpression toLabel(SObjectField field)
    {
        return toLabel(String.valueOf(field));
    }
    global static FieldExpression toLabel(FieldExpression field)
    {
        return new FieldExpression(field, Function.toLabel);
    }
    
    global static FieldExpression rollup(String field)
    {
        return new FieldExpression(field, Function.ROLLUP);
    }
    global static FieldExpression rollup(SObjectField field)
    {
        return rollup(String.valueOf(field));
    }
    global static FieldExpression rollup(List<String> fields)
    {
        return new FieldExpression(String.join(fields, ','), Function.ROLLUP);
    }
    global static FieldExpression rollup(List<SObjectField> fields)
    {
        List<String> fieldPaths = new List<String>();
        for (SObjectField field : fields)
            fieldPaths.add(String.valueOf(field));
        return rollup(fieldPaths);
    }
    
    global static FieldExpression cube(String field)
    {
        return new FieldExpression(field, Function.CUBE);
    }
    global static FieldExpression cube(SObjectField field)
    {
        return cube(String.valueOf(field));
    }
    global static FieldExpression cube(List<String> fields)
    {
        return new FieldExpression(String.join(fields, ','), Function.CUBE);
    }
    global static FieldExpression cube(List<SObjectField> fields)
    {
        List<String> fieldPaths = new List<String>();
        for (SObjectField field : fields)
            fieldPaths.add(String.valueOf(field));
        return cube(fieldPaths);
    }
    
    global static FieldExpression grouping(String field)
    {
        return new FieldExpression(field, Function.GROUPING);
    }
    global static FieldExpression grouping(SObjectField field)
    {
        return grouping(String.valueOf(field));
    }
    global static FieldExpression grouping(FieldExpression field)
    {
        return new FieldExpression(field, Function.GROUPING);
    }
}
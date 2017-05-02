global class DateLiteral
{
    global Enum Expression
    {
        YESTERDAY, TODAY, TOMORROW,
        LAST_WEEK, THIS_WEEK, NEXT_WEEK,
        LAST_MONTH, THIS_MONTH, NEXT_MONTH,
        LAST_QUARTER, THIS_QUARTER, NEXT_QUARTER,
        LAST_FISCAL_QUARTER, THIS_FISCAL_QUARTER, NEXT_FISCAL_QUARTER,
        LAST_FISCAL_YEAR, THIS_FISCAL_YEAR, NEXT_FISCAL_YEAR,
        LAST_YEAR, THIS_YEAR, NEXT_YEAR,
        LAST_90_DAYS, NEXT_90_DAYS,
        LAST_N_DAYS, NEXT_N_DAYS,
        LAST_N_WEEKS, NEXT_N_WEEKS,
        LAST_N_MONTHS, NEXT_N_MONTHS,
        LAST_N_QUARTERS, NEXT_N_QUARTERS,
        LAST_N_FISCAL_QUARTERS, NEXT_N_FISCAL_QUARTERS,
        LAST_N_FISCAL_YEARS, NEXT_N_FISCAL_YEARS,
        LAST_N_YEARS, NEXT_N_YEARS
    }
    
    final Expression expression;
    final Integer modifier;
    DateLiteral(Expression expression) { this(expression, null); }
    DateLiteral(Expression expression, Integer modifier)
    {
        this.expression = expression;
        this.modifier = modifier;
    }
    global override String toString()
    {
        String base = String.valueOf(expression);
        return (modifier == null) ? base : base + ':' + modifier;
    }
    
    global static DateLiteral yesterday() { return new DateLiteral(Expression.YESTERDAY); }
    global static DateLiteral today() { return new DateLiteral(Expression.TODAY); }
    global static DateLiteral tomorrow() { return new DateLiteral(Expression.TOMORROW); }
    
    global static DateLiteral lastWeek() { return new DateLiteral(Expression.LAST_WEEK); }
    global static DateLiteral thisWeek() { return new DateLiteral(Expression.THIS_WEEK); }
    global static DateLiteral nextWeek() { return new DateLiteral(Expression.NEXT_WEEK); }
    
    global static DateLiteral lastMonth() { return new DateLiteral(Expression.LAST_MONTH); }
    global static DateLiteral thisMonth() { return new DateLiteral(Expression.THIS_MONTH); }
    global static DateLiteral nextMonth() { return new DateLiteral(Expression.NEXT_MONTH); }
    
    global static DateLiteral lastQuarter() { return new DateLiteral(Expression.LAST_QUARTER); }
    global static DateLiteral thisQuarter() { return new DateLiteral(Expression.THIS_QUARTER); }
    global static DateLiteral nextQuarter() { return new DateLiteral(Expression.NEXT_QUARTER); }
    
    global static DateLiteral lastFiscalQuarter() { return new DateLiteral(Expression.LAST_FISCAL_QUARTER); }
    global static DateLiteral thisFiscalQuarter() { return new DateLiteral(Expression.THIS_FISCAL_QUARTER); }
    global static DateLiteral nextFiscalQuarter() { return new DateLiteral(Expression.NEXT_FISCAL_QUARTER); }
    
    global static DateLiteral lastFiscalYear() { return new DateLiteral(Expression.LAST_FISCAL_YEAR); }
    global static DateLiteral thisFiscalYear() { return new DateLiteral(Expression.THIS_FISCAL_YEAR); }
    global static DateLiteral nextFiscalYear() { return new DateLiteral(Expression.NEXT_FISCAL_YEAR); }
    
    global static DateLiteral lastYear() { return new DateLiteral(Expression.LAST_YEAR); }
    global static DateLiteral thisYear() { return new DateLiteral(Expression.THIS_YEAR); }
    global static DateLiteral nextYear() { return new DateLiteral(Expression.NEXT_YEAR); }
    
    global static DateLiteral last90Days() { return new DateLiteral(Expression.LAST_90_DAYS); }
    global static DateLiteral next90Days() { return new DateLiteral(Expression.NEXT_90_DAYS); }
    
    global static DateLiteral lastNDays(Integer n) { return new DateLiteral(Expression.LAST_N_DAYS, n); }
    global static DateLiteral nextNDays(Integer n) { return new DateLiteral(Expression.NEXT_N_DAYS, n); }
    
    global static DateLiteral lastNWeeks(Integer n) { return new DateLiteral(Expression.LAST_N_WEEKS, n); }
    global static DateLiteral nextNWeeks(Integer n) { return new DateLiteral(Expression.NEXT_N_WEEKS, n); }
    
    global static DateLiteral lastNMonths(Integer n) { return new DateLiteral(Expression.LAST_N_MONTHS, n); }
    global static DateLiteral nextNMonths(Integer n) { return new DateLiteral(Expression.NEXT_N_MONTHS, n); }
    
    global static DateLiteral lastNQuarters(Integer n) { return new DateLiteral(Expression.LAST_N_QUARTERS, n); }
    global static DateLiteral nextNQuarters(Integer n) { return new DateLiteral(Expression.NEXT_N_QUARTERS, n); }
    
    global static DateLiteral lastNFiscalQuarters(Integer n) { return new DateLiteral(Expression.LAST_N_FISCAL_QUARTERS, n); }
    global static DateLiteral nextNFiscalQuarters(Integer n) { return new DateLiteral(Expression.NEXT_N_FISCAL_QUARTERS, n); }
    
    global static DateLiteral lastNFiscalYears(Integer n) { return new DateLiteral(Expression.LAST_N_FISCAL_YEARS, n); }
    global static DateLiteral nextNFiscalYears(Integer n) { return new DateLiteral(Expression.NEXT_N_FISCAL_YEARS, n); }
    
    global static DateLiteral lastNYears(Integer n) { return new DateLiteral(Expression.LAST_N_YEARS, n); }
    global static DateLiteral nextNYears(Integer n) { return new DateLiteral(Expression.NEXT_N_YEARS, n); }
}
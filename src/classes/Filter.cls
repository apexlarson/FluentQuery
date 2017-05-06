global class Filter implements Predicate.Expression
{
    final FieldExpression field;
    String operator;
    Object value;
    
    global Filter(FieldExpression field) { this.field = field; }
    global Filter(String field) { this(new FieldExpression(field)); }
    global Filter(SObjectField field) { this(String.valueOf(field)); }
    
    global Filter doesNotEqual(Object value) { return compare('!=', value); }
    global Filter equals(Object value) { return compare('=', value); }
    global Filter excludes(Object value) { return compare(' EXCLUDES ', value); }
    global Filter includes(Object value) { return compare(' INCLUDES ', value); }
    global Filter isGreaterThan(Object value) { return compare('>', value); }
    global Filter isGreaterThanOrEqualTo(Object Value) { return compare('>=', value); }
    global Filter isIn(Object value) { return compare(' IN ', value); }
    global Filter isLessThan(Object value) { return compare('<', value); }
    global Filter isLessThanOrEqualTo(Object value) { return compare('<=', value); }
    global Filter isLike(Object value) { return compare(' LIKE ', value); }
    global Filter isNotIn(Object value) { return compare(' NOT IN ', value); }
    Filter compare(String operator, Object value)
    {
        this.operator = operator;
        this.value = value;
        return this;
    }
    
    global override String toString()
    {
        return field.toString() + operator + ValueFormatter.format(value);
    }
    public String getFieldPath() { return field.fieldPath; }
}